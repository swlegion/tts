#!/usr/bin/env python3
"""Installe les bundles GREFFES (orphelins) dans le cache TTS local.

Pourquoi pas install_dual_to_cache.py : celui-ci ne prend que les bundles dont
un rebuild existe (colonne rebuild_dispo du CSV), ce qui exclut par construction
les 8 orphelins — ils n'ont pas de sources, c'est toute la raison de la greffe.

Sauvegarde dans un dossier DISTINCT de cache-avant-dual, pour ne pas melanger
les deux campagnes et pour qu'une restauration de l'une ne defasse pas l'autre.

Garde-fou : on refuse d'ecraser un fichier du cache qui contient DEJA une
variante Metal — ce serait le signe qu'on repasse sur notre propre travail et
qu'on sauvegarderait une copie greffee comme si c'etait l'original.

Usage:
    install_grafted_to_cache.py --dry-run
    install_grafted_to_cache.py --install    # TTS doit etre ferme
    install_grafted_to_cache.py --restore
"""

import argparse
import csv
import hashlib
import os
import re
import shutil
import sys

import UnityPy

CSV = os.environ.get("INVENTAIRE", "inventaire-bundles.csv")
GRAFTED = os.environ.get("GRAFTED_DIR", "tts-assets/grafted")
CACHE = os.path.expanduser("~/Library/Tabletop Simulator/Mods/Assetbundles")
BACKUP = "bundle_backups/cache-avant-greffe"
METAL = 14


def cache_filename(url):
    """Nom sous lequel TTS met ce bundle en cache (meme regle que l'autre installeur)."""
    akamai = re.sub(r"^https?://[^/]+", "https://steamusercontent-a.akamaihd.net", url)
    return re.sub(r"[^a-zA-Z0-9]", "", akamai) + ".unity3d"


def has_metal(path):
    for obj in UnityPy.load(path).objects:
        if obj.type.name == "Shader" and METAL in obj.read_typetree()["platforms"]:
            return True
    return False


def targets():
    """[(nom, source_greffee, chemin_cache, url)] pour les bundles greffes disponibles."""
    out, seen = [], set()
    with open(CSV, encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            name = row["bundle"]
            if name in seen:
                continue
            source = os.path.join(GRAFTED, name + ".unity3d")
            if not os.path.exists(source):
                continue
            seen.add(name)
            out.append((name, source, os.path.join(CACHE, cache_filename(row["url"])), row["url"]))
    return out


def main():
    ap = argparse.ArgumentParser()
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--dry-run", action="store_true")
    g.add_argument("--install", action="store_true")
    g.add_argument("--restore", action="store_true")
    args = ap.parse_args()

    if args.restore:
        if not os.path.isdir(BACKUP):
            sys.exit(f"pas de sauvegarde dans {BACKUP}")
        n = 0
        for f in sorted(os.listdir(BACKUP)):
            shutil.copy2(os.path.join(BACKUP, f), os.path.join(CACHE, f))
            n += 1
        print(f"{n} fichiers restaures depuis {BACKUP}")
        return

    rows = targets()
    if not rows:
        sys.exit(f"aucun bundle greffe dans {GRAFTED}")

    todo, skipped = [], []
    for name, source, dest, url in rows:
        # Absent du cache = unite jamais posee sur la table par ce joueur. On
        # depose quand meme : TTS lit son cache avant de telecharger, donc le
        # fichier sera servi tel quel au premier spawn. Rien a sauvegarder,
        # il n'y a rien a ecraser.
        if not os.path.exists(dest):
            todo.append((name, source, dest, "depose"))
            continue
        # Aucun bundle PUBLIE ne porte de Metal — c'est tout le probleme qu'on
        # repare. Donc un fichier de cache qui en porte est forcement l'un des
        # notres : on le remplace sans le sauvegarder, sinon la sauvegarde
        # finirait par contenir notre propre travail au lieu de l'original.
        if has_metal(dest):
            todo.append((name, source, dest, "rejoue"))
            continue
        todo.append((name, source, dest, "remplace"))

    for name, source, dest, action in todo:
        print(f"  {action:9s} {name:45s} -> {os.path.basename(dest)[:40]}...")
    for name, why in skipped:
        print(f"  ⊘ {name:45s} {why}")
    print(f"\n{len(todo)} a installer, {len(skipped)} ecartes")

    if not args.install:
        return

    os.makedirs(BACKUP, exist_ok=True)
    for name, source, dest, action in todo:
        if action == "remplace":
            keep = os.path.join(BACKUP, os.path.basename(dest))
            if not os.path.exists(keep):
                shutil.copy2(dest, keep)
        shutil.copy2(source, dest)
    print(f"installe {len(todo)} bundles, originaux ecrases sauvegardes dans {BACKUP}")


if __name__ == "__main__":
    main()

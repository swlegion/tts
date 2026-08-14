#!/usr/bin/env python3
"""Installe les bundles bi-plateforme dans le cache TTS local, pour une repetition generale.

Permet d'essayer le fix a l'echelle du mod entier, en jeu, sans rien heberger ni
pousser : TTS lit son cache avant de telecharger, donc un fichier depose au bon
nom est servi tel quel.

Nom de cache : TTS reecrit l'URL du mod (cloud-3.steamusercontent.com) vers
l'hote Akamai, puis aplatit l'URL en ne gardant que l'alphanumerique. Verifie
contre les fichiers deja presents dans le cache de Martin.

Ne touche qu'aux bundles qui embarquent un shader custom ET dont un rebuild
existe (colonnes du CSV d'inventaire). Sauvegarde systematique avant ecriture.

Usage:
    install_dual_to_cache.py --dry-run     # montre ce qui serait fait
    install_dual_to_cache.py --install     # installe (TTS doit etre ferme)
    install_dual_to_cache.py --restore     # remet les originaux
"""

import argparse
import csv
import os
import re
import shutil
import sys

CSV = os.environ.get("INVENTAIRE", "inventaire-bundles.csv")
DUAL = os.environ.get("DUAL_DIR", "UnityProject-U6/AssetBundles-dual")
CACHE = os.path.expanduser("~/Library/Tabletop Simulator/Mods/Assetbundles")
BACKUP = "bundle_backups/cache-avant-dual"

# Bundles dont le rebuild a DERIVE du publie (cf compare_published_vs_rebuild.py
# et memoire registre-valide-invalide V15) : les installer introduirait une
# regression visible, sur Mac comme sur Windows. Ils restent donc cassés sur Mac
# tant qu'on ne les repare pas autrement (greffe dans le bundle publie).
DERIVES = {
    "stunt_double_bot_1",  # le rebuild ajoute un socle base_small + Default-Material absents du publie
}


METAL = 14


def is_ours(path):
    """Vrai si ce bundle porte une variante Metal, donc s'il sort de chez nous."""
    try:
        import UnityPy
    except ImportError:
        return False  # sans UnityPy on garde l'ancien comportement
    try:
        for obj in UnityPy.load(path).objects:
            if obj.type.name == "Shader" and METAL in obj.read_typetree()["platforms"]:
                return True
    except Exception:
        return False
    return False


def cache_filename(url):
    """Nom sous lequel TTS met ce bundle en cache."""
    akamai = re.sub(r"^https?://[^/]+", "https://steamusercontent-a.akamaihd.net", url)
    return re.sub(r"[^a-zA-Z0-9]", "", akamai) + ".unity3d"


def targets():
    """[(nom_bundle, chemin_source, chemin_cache)] pour les bundles a remplacer."""
    out = []
    with open(CSV, encoding="utf-8") as fh:
        for row in csv.DictReader(fh):
            if row["besoin_fix"] != "oui" or row["rebuild_dispo"] != "oui":
                continue
            if row["bundle"] in DERIVES:
                print(f"  ⊘ {row['bundle']} : rebuild derive du publie, ecarte")
                continue
            source = os.path.join(DUAL, row["bundle"])
            if not os.path.exists(source):
                print(f"  ⚠ {row['bundle']} : fusion absente de {DUAL}, ignore")
                continue
            out.append((row["bundle"], source, os.path.join(CACHE, cache_filename(row["url"]))))
    return out


def install(rows, dry_run):
    os.makedirs(BACKUP, exist_ok=True)
    installed = saved = 0

    for name, source, dest in rows:
        if dry_run:
            state = "remplace" if os.path.exists(dest) else "depose"
            print(f"  {state:9s} {name:38s} -> {os.path.basename(dest)[:52]}")
            continue

        # Sauvegarde de l'original AVANT toute ecriture, une seule fois :
        # relancer l'installation ne doit pas ecraser la sauvegarde par un fichier deja modifie.
        #
        # ⚠ "une seule fois" ne suffit PAS, et ca s'est produit le 12/08 : un
        # bundle DEPOSE au premier passage (absent du cache, donc rien a
        # sauvegarder) existe au second, et se fait sauvegarder alors que c'est
        # deja le notre. 60 des 114 entrees etaient dans ce cas. Comme aucun
        # bundle publie ne porte de variante Metal, en trouver une est la preuve
        # qu'on a affaire a notre propre travail : on ne sauvegarde pas.
        if os.path.exists(dest):
            keep = os.path.join(BACKUP, os.path.basename(dest))
            if not os.path.exists(keep) and not is_ours(dest):
                shutil.copy2(dest, keep)
                saved += 1

        shutil.copy2(source, dest)
        installed += 1

    if dry_run:
        print(f"\n{len(rows)} bundles seraient installes (aucune ecriture faite)")
    else:
        print(f"\n{installed} bundles installes, {saved} originaux sauvegardes dans {BACKUP}")


def restore():
    if not os.path.isdir(BACKUP):
        print(f"aucune sauvegarde dans {BACKUP}")
        return 1
    count = 0
    for entry in os.listdir(BACKUP):
        shutil.copy2(os.path.join(BACKUP, entry), os.path.join(CACHE, entry))
        count += 1
    print(f"{count} bundles d'origine restaures dans le cache")
    # Les bundles qui n'etaient pas en cache avant restent en place : ils ne
    # remplacent rien, TTS les aurait telecharges de toute facon.
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--dry-run", action="store_true", help="montre sans rien ecrire")
    group.add_argument("--install", action="store_true", help="installe dans le cache TTS")
    group.add_argument("--restore", action="store_true", help="remet les originaux")
    args = parser.parse_args()

    if args.restore:
        return restore()

    rows = targets()
    if not rows:
        print("rien a installer")
        return 1

    print(f"{len(rows)} bundles a shader custom, fusion disponible\n")
    install(rows, args.dry_run)
    return 0


if __name__ == "__main__":
    sys.exit(main())

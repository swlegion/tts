#!/usr/bin/env python3
"""Inventorie les bundles reellement references par le mod et dit lesquels ont besoin du fix Metal.

Le mod ne liste pas ses assets dans sa save : les figurines sont spawnees
dynamiquement depuis mod/src/includes/generated/cards.ttslua, ou chaque mini
porte un `bundle` (maillage) et parfois un `secondary` (materiaux partages, donc
la teinte et le shader Color Replacer). Cf memoire registre-valide-invalide V17.

Pour chaque URL : on prend le fichier dans le cache TTS local s'il y est, sinon
on le telecharge. On lit ensuite son nom d'AssetBundle interne, ses shaders
embarques, et on regarde si un rebuild du meme nom existe.

Sortie : un CSV inventaire-bundles.csv exploitable pour la suite.
"""

import csv
import glob
import hashlib
import os
import re
import sys
import time
import urllib.request

import UnityPy

REPO = "swlegion-tts/mod/src/includes/generated/cards.ttslua"
CACHE = os.path.expanduser("~/Library/Tabletop Simulator/Mods/Assetbundles")
DOWNLOADS = "tts-assets/published-bundles"
REBUILD_WIN = "UnityProject-U6/AssetBundles-win"
OUT = "inventaire-bundles.csv"


def urls_from_mod():
    """Renvoie {url: role} ou role vaut 'principal' ou 'secondaire'."""
    raw = open(REPO, encoding="utf-8").read()
    out = {}
    for u in re.findall(r'bundle\s*=\s*"([^"]+)"', raw):
        out.setdefault(u, "principal")
    for u in re.findall(r'secondary\s*=\s*"([^"]+)"', raw):
        out[u] = "secondaire"  # prime sur principal : c'est le role qui porte les materiaux
    return out


def cache_index():
    """{identifiant ugc: chemin} du cache TTS local.

    On n'apparie PAS sur l'URL aplatie : le mod reference `cloud-3.steamusercontent.com`
    alors que TTS met en cache sous le nom de l'URL Akamai. Seul l'identifiant
    numerique `ugc/<id>` est commun aux deux.
    """
    index = {}
    for path in glob.glob(CACHE + "/*.unity3d"):
        for ugc_id in re.findall(r"ugc(\d{6,})", os.path.basename(path)):
            index[ugc_id] = path
    return index


def downloadable(url):
    """`cloud-3.steamusercontent.com` repond 403 : l'hote Akamai en https sert le meme contenu."""
    url = re.sub(r"^https?://[^/]+", "https://steamusercontent-a.akamaihd.net", url)
    return url


def local_copy(url, index):
    """Chemin local du bundle : cache TTS si present, sinon telechargement. Renvoie (chemin, origine)."""
    match = re.search(r"/ugc/(\d+)", url)
    if match and match.group(1) in index:
        return index[match.group(1)], "cache"

    dest = os.path.join(DOWNLOADS, hashlib.sha1(url.encode()).hexdigest()[:16] + ".unity3d")
    if os.path.exists(dest):
        return dest, "telecharge"

    os.makedirs(DOWNLOADS, exist_ok=True)
    req = urllib.request.Request(downloadable(url), headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=180) as resp:
        data = resp.read()
    if not data.startswith(b"UnityFS"):
        raise ValueError(f"reponse non-bundle ({len(data)} o)")
    with open(dest, "wb") as fh:
        fh.write(data)
    return dest, "telecharge"


def inspect(path):
    """(nom_du_bundle, [shaders embarques])"""
    env = UnityPy.load(path)
    name, shaders = None, []
    for obj in env.objects:
        if obj.type.name == "AssetBundle" and name is None:
            try:
                name = obj.read_typetree().get("m_Name")
            except Exception:
                pass
        elif obj.type.name == "Shader":
            try:
                shaders.append(obj.read_typetree()["m_ParsedForm"]["m_Name"])
            except Exception:
                shaders.append("?")
    return name, shaders


def main():
    urls = urls_from_mod()
    rebuilt = {
        os.path.basename(f)
        for f in glob.glob(REBUILD_WIN + "/*")
        if not f.endswith(".manifest") and os.path.basename(f) != "AssetBundles"
    }
    print(f"{len(urls)} URL de bundles referencees par le mod, {len(rebuilt)} bundles rebuildes disponibles")

    index = cache_index()
    print(f"{len(index)} bundles dans le cache TTS local, indexes par identifiant ugc")

    rows = []
    started = time.time()
    for i, (url, role) in enumerate(sorted(urls.items()), 1):
        try:
            path, origin = local_copy(url, index)
        except Exception as exc:
            rows.append({"url": url, "role": role, "origine": "ECHEC", "bundle": "",
                         "shaders": "", "besoin_fix": "", "rebuild_dispo": "", "note": str(exc)[:80]})
            print(f"  ✗ telechargement {url} — {exc}")
            continue

        try:
            name, shaders = inspect(path)
        except Exception as exc:
            rows.append({"url": url, "role": role, "origine": origin, "bundle": "",
                         "shaders": "", "besoin_fix": "", "rebuild_dispo": "", "note": f"illisible: {exc}"[:80]})
            continue

        rows.append({
            "url": url,
            "role": role,
            "origine": origin,
            "bundle": name or "",
            "shaders": " | ".join(sorted(set(shaders))),
            "besoin_fix": "oui" if shaders else "non",
            "rebuild_dispo": "oui" if name in rebuilt else "non",
            "note": "",
        })

        if i % 20 == 0 or i == len(urls):
            print(f"  {i}/{len(urls)} ({time.time() - started:.0f} s)")

    with open(OUT, "w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)

    besoin = [r for r in rows if r["besoin_fix"] == "oui"]
    pret = [r for r in besoin if r["rebuild_dispo"] == "oui"]
    print(f"\n{len(rows)} bundles inventories")
    print(f"  ont besoin du fix (shader embarque)     : {len(besoin)}")
    print(f"     dont un rebuild existe deja          : {len(pret)}")
    print(f"     SANS rebuild (absents du projet)     : {len(besoin) - len(pret)}")
    for r in besoin:
        if r["rebuild_dispo"] == "non":
            print(f"       ⚠ {r['bundle'] or '<sans nom>'} ({r['role']}) — {r['shaders'][:60]}")
    print(f"  ecrit {OUT}")


if __name__ == "__main__":
    sys.exit(main())

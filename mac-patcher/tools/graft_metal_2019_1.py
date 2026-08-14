#!/usr/bin/env python3
"""Greffe un SubShader Metal dans un bundle PUBLIE serialise par Unity 2019.1.

Pourquoi un second script a cote de merge_subshader_platforms.py : celui-ci a
ete ecrit pour des bundles produits par Unity 6, ou les tables du blob sont des
listes DE LISTES (un tableau par plateforme, un element par sous-programme) et
ou il existe un champ stageCounts. En 2019.1 ces tables sont PLATES, un entier
par plateforme, et stageCounts n'existe pas — d'ou le KeyError qu'on obtient en
lui donnant un bundle publie.

Le principe reste le meme et il est explique en detail dans l'autre script : on
n'essaie pas de faire cohabiter Metal et DirectX dans la MEME passe, parce que
les tables de liaison de parametres y sont partagees et que Metal eclate les
globals en VGlobals/FGlobals. On empile un SubShader entier, qui arrive avec ses
propres tables.

Interet ici : le bundle publie garde ses maillages, ses textures et ses
materiaux bit pour bit. C'est la seule voie pour les 8 orphelins, dont on n'a
pas les sources.

Usage:
    graft_metal_2019_1.py <publie.unity3d> <greffon.unity3d> <sortie.unity3d>
"""

import sys

import UnityPy

GPU = {4: "d3d11", 9: "gles3", 14: "metal", 15: "glcore", 18: "vulkan"}
FLAT_TABLES = ("offsets", "compressedLengths", "decompressedLengths")


def shaders_by_name(env):
    out = {}
    for obj in env.objects:
        if obj.type.name != "Shader":
            continue
        tree = obj.read_typetree()
        out[tree["m_ParsedForm"]["m_Name"]] = tree
    return out


def check_flat(tree, label):
    """Garde-fou : refuser un bundle qui n'est pas au format plat 2019.1."""
    if "stageCounts" in tree:
        raise SystemExit(f"{label}: format Unity 6 (stageCounts present), utiliser merge_subshader_platforms.py")
    for key in FLAT_TABLES:
        if tree[key] and isinstance(tree[key][0], list):
            raise SystemExit(f"{label}: table '{key}' imbriquee, ce bundle n'est pas en 2019.1")


def graft(base_tree, donor_tree):
    """Ajoute les plateformes du donneur absentes de la base. Renvoie leurs noms."""
    added = []
    blob = bytes(base_tree["compressedBlob"])

    for i, platform in enumerate(donor_tree["platforms"]):
        if platform in base_tree["platforms"]:
            continue
        shift = len(blob)
        base_tree["platforms"].append(platform)
        base_tree["offsets"].append(donor_tree["offsets"][i] + shift)
        base_tree["compressedLengths"].append(donor_tree["compressedLengths"][i])
        base_tree["decompressedLengths"].append(donor_tree["decompressedLengths"][i])
        blob += bytes(donor_tree["compressedBlob"])
        added.append(GPU.get(platform, platform))

    if added:
        base_tree["compressedBlob"] = list(blob)
        base_tree["m_ParsedForm"]["m_SubShaders"].extend(donor_tree["m_ParsedForm"]["m_SubShaders"])

    return added


def main(base_path, donor_path, out_path):
    base_env = UnityPy.load(base_path)
    donors = shaders_by_name(UnityPy.load(donor_path))
    for name, tree in donors.items():
        check_flat(tree, f"greffon/{name}")

    total = 0
    for obj in base_env.objects:
        if obj.type.name != "Shader":
            continue
        tree = obj.read_typetree()
        name = tree["m_ParsedForm"]["m_Name"]
        if name not in donors:
            print(f"  {name}: absent du greffon, laisse tel quel")
            continue

        check_flat(tree, f"publie/{name}")
        before = [GPU.get(p, p) for p in tree["platforms"]]
        nsub_before = len(tree["m_ParsedForm"]["m_SubShaders"])
        added = graft(tree, donors[name])
        after = [GPU.get(p, p) for p in tree["platforms"]]
        nsub = len(tree["m_ParsedForm"]["m_SubShaders"])

        if added:
            obj.save_typetree(tree)
            total += len(added)
        print(f"  {name}: {before} -> {after}, SubShaders {nsub_before} -> {nsub}")

    if not total:
        print("  rien a greffer")
        return 1

    with open(out_path, "wb") as fh:
        fh.write(base_env.file.save(packer="lzma"))
    print(f"  ecrit {out_path}")
    return 0


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print(__doc__)
        sys.exit(1)
    sys.exit(main(sys.argv[1], sys.argv[2], sys.argv[3]))

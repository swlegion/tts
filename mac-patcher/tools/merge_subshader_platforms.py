#!/usr/bin/env python3
"""Fusionne deux bundles en donnant a chaque plateforme SON PROPRE SubShader.

Pourquoi pas merge_shader_platforms.py : les tables de liaison de parametres
(m_NameIndices, m_CommonParameters, m_ConstantBufferBindings) sont stockees UNE
FOIS PAR PASSE et partagees par toutes les plateformes. DirectX et OpenGLCore
peuvent cohabiter parce qu'ils partagent cette disposition ($Globals, memes
offsets) — c'est ce que font les bundles publies du mod. Metal, lui, eclate les
globals en VGlobals/FGlobals et remet les offsets a zero : greffer un programme
Metal dans une passe DirectX lui donne les mauvaises liaisons, et il rend faux
sans aucun message d'erreur (verifie le 12/08/2026).

Un shader peut en revanche declarer plusieurs SubShaders, et chacun porte ses
propres passes donc ses propres tables. On empile donc le SubShader du bundle
macOS derriere celui du bundle Windows, en esperant qu'Unity descende au suivant
quand le premier n'a pas de variante pour l'API courante.

Usage:
    merge_subshader_platforms.py <base.unity3d> <apport.unity3d> <sortie.unity3d>
"""

import sys

import UnityPy

GPU = {4: "d3d11", 9: "gles3", 14: "metal", 15: "glcore", 18: "vulkan"}


def shaders_by_name(env):
    out = {}
    for obj in env.objects:
        if obj.type.name != "Shader":
            continue
        tree = obj.read_typetree()
        out[tree["m_ParsedForm"]["m_Name"]] = tree
    return out


def merge(base_tree, donor_tree):
    """Concatene les blobs, puis ajoute les SubShaders du donneur. Renvoie le nb de plateformes ajoutees."""
    added = 0
    blob = bytes(base_tree["compressedBlob"])

    for i, platform in enumerate(donor_tree["platforms"]):
        if platform in base_tree["platforms"]:
            continue
        shift = len(blob)
        base_tree["platforms"].append(platform)
        base_tree["offsets"].append([o + shift for o in donor_tree["offsets"][i]])
        base_tree["compressedLengths"].append(list(donor_tree["compressedLengths"][i]))
        base_tree["decompressedLengths"].append(list(donor_tree["decompressedLengths"][i]))
        base_tree["stageCounts"].append(donor_tree["stageCounts"][i])
        blob += bytes(donor_tree["compressedBlob"])
        added += 1

    if added:
        base_tree["compressedBlob"] = list(blob)
        # Le SubShader du donneur arrive AVEC ses tables de parametres : c'est
        # tout l'interet de la manoeuvre.
        base_tree["m_ParsedForm"]["m_SubShaders"].extend(donor_tree["m_ParsedForm"]["m_SubShaders"])

    return added


def main(base_path, donor_path, out_path):
    base_env = UnityPy.load(base_path)
    donors = shaders_by_name(UnityPy.load(donor_path))
    total = 0

    for obj in base_env.objects:
        if obj.type.name != "Shader":
            continue
        tree = obj.read_typetree()
        name = tree["m_ParsedForm"]["m_Name"]
        if name not in donors:
            print(f"  {name}: absent du bundle d'apport, laisse tel quel")
            continue

        before = [GPU.get(p, p) for p in tree["platforms"]]
        nsub_before = len(tree["m_ParsedForm"]["m_SubShaders"])
        added = merge(tree, donors[name])
        after = [GPU.get(p, p) for p in tree["platforms"]]
        nsub = len(tree["m_ParsedForm"]["m_SubShaders"])

        if added:
            obj.save_typetree(tree)
            total += added
        print(f"  {name}: {before} -> {after}, SubShaders {nsub_before} -> {nsub}")

    if not total:
        print("  rien a fusionner")

    with open(out_path, "wb") as fh:
        fh.write(base_env.file.save(packer="lzma"))
    print(f"  ecrit {out_path}")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print(__doc__)
        sys.exit(1)
    main(sys.argv[1], sys.argv[2], sys.argv[3])

#!/usr/bin/env python3
"""Merge a Windows and a macOS AssetBundle into one file that renders on both.

Why this exists
---------------
AssetBundle shader variants are compiled per graphics API, decided by the build
target. A StandaloneWindows64 build carries DirectX (and OpenGL) variants only; a
StandaloneOSX build carries Metal only. Since TTS v14 the Mac player runs Metal
and has no usable OpenGL path left, so bundles built for Windows cannot load
their custom shaders there: TTS falls back to Standard where it can, and renders
magenta where it cannot.

Unity cannot produce one bundle covering both platforms: it silently drops any
graphics API that is foreign to the build target. But a Shader object can declare
several SubShaders, and Unity falls through to the next one when the first has no
variant for the current graphics API. So we build twice and stack the macOS
SubShader behind the Windows one.

The Windows SubShader stays first and byte-identical, so Windows players get
exactly what they get today. The extra SubShader is inert for them.

⚠ Do NOT try to merge the variants inside a single pass. The parameter binding
tables (m_NameIndices, m_CommonParameters, m_ConstantBufferBindings) are stored
once per pass and shared by every platform in it, and Metal lays them out
differently from DirectX (VGlobals/FGlobals instead of $Globals, offsets reset to
zero). The result loads, logs nothing, and renders wrong. A SubShader carries its
own tables, which is why this works. It is also why d3d11 and glcore coexist
happily in the current bundles: those two share the layout.

Requirements: pip install UnityPy

Usage:
    merge_subshader_bundles.py <windows_bundle> <macos_bundle> <output_bundle>

Both bundles must come from the same prefab, built twice with only the target
changed. Shaders are matched by name.
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
    """Concatenate the blobs, then append the donor's SubShaders. Returns platforms added."""
    added = 0
    blob = bytes(base_tree["compressedBlob"])

    for i, platform in enumerate(donor_tree["platforms"]):
        if platform in base_tree["platforms"]:
            continue
        # The donor's offsets are relative to its own blob, so rebase them.
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
        # The donor's SubShader arrives with its own parameter tables. That is the
        # whole point of doing it this way.
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
            print(f"  {name}: not in the macOS bundle, left as is")
            continue

        before = [GPU.get(p, p) for p in tree["platforms"]]
        subshaders_before = len(tree["m_ParsedForm"]["m_SubShaders"])
        added = merge(tree, donors[name])
        after = [GPU.get(p, p) for p in tree["platforms"]]

        if added:
            obj.save_typetree(tree)
            total += added
        print(f"  {name}: {before} -> {after}, "
              f"SubShaders {subshaders_before} -> {len(tree['m_ParsedForm']['m_SubShaders'])}")

    if not total:
        print("  nothing to merge (no shared shader between the two bundles)")

    with open(out_path, "wb") as fh:
        fh.write(base_env.file.save(packer="lzma"))
    print(f"  wrote {out_path}")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print(__doc__)
        sys.exit(1)
    main(sys.argv[1], sys.argv[2], sys.argv[3])

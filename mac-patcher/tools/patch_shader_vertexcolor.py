#!/usr/bin/env python3
"""Neutralise la lecture de la couleur de sommet, le temps d'un build macOS.

Pourquoi : les shaders d'effets lumineux lisent `v.color`, un canal de sommet
que AUCUN mesh du mod ne possede. Quand le canal manque, DirectX et OpenGL
fournissent du blanc (1,1,1,1) et l'effet s'allume ; Metal fournit du noir
(0,0,0,0). Les passes concernees sont en `Blend One One`, donc multipliees par
zero elles n'ajoutent rien : la lame de Yoda rend, mais ne brille pas. Constate
en jeu le 12/08/2026, puis demontre.

Dans GlowGeometry.shader l'extinction est double :

    o.v.x = min(1.0f, viewSat * v.color.a);                       // le fonduanguleux -> 0
    float4 lerpColor = _FarColor * pow(...) * i.col.r * _Contrast; // l'intensite  -> 0

On remplace donc `v.color` par du blanc, ce qui reproduit exactement ce que
Windows recoit. C'est sur : sur les 408 meshes des 248 bundles publies, UN SEUL
porte un canal Color (`del_meeko`), et il n'utilise aucun shader custom — il
fait partie des bundles qu'on ne touche jamais.

Comme on ne greffe QUE le SubShader macOS, le rendu Windows n'est pas altere.

⚠ Se combine avec patch_shader_precision.py : les deux scripts sauvegardent en
`.orig` sans jamais ecraser une sauvegarde existante, donc appliquer les deux a
la suite conserve le vrai original, et le `--restore` de l'un remet tout en
place.

Usage :
    patch_shader_vertexcolor.py --apply     # patche les .shader (sauvegarde en .orig)
    patch_shader_vertexcolor.py --restore   # remet les sources d'origine
"""

import argparse
import os
import re
import shutil
import sys

ROOT = "UnityProject-U6/Assets"

# Liste explicite plutot qu'un balayage : le remplacement n'est legitime que
# pour NOS shaders, sur des meshes dont on a verifie l'absence du canal. Les
# shaders tiers (SineVFX) travaillent sur leurs propres geometries.
TARGETS = [
    "Units/_Shaders/GlowGeometry.shader",
    "Units/_Shaders/RimGlowGeometry.shader",
    "Units/_Shaders/RimGlowGeometry_Shield.shader",
    "Units/_Shaders/BlasterBolt_1Pass.shader",
    "Shaders/BB_Sprite_BillboardY.shader",
]

VERTEX_COLOR = re.compile(r"\bv\.color\b")
WHITE = "float4(1,1,1,1)"


def apply():
    touched = 0
    for rel in TARGETS:
        path = os.path.join(ROOT, rel)
        if not os.path.exists(path):
            print(f"  ⚠ absent, ignore : {rel}")
            continue

        # Certains shaders sont en latin-1 (le "© Allen White" de l'en-tete) :
        # lire en binaire et ne pas reencoder, pour ne rien alterer d'autre.
        with open(path, "rb") as fh:
            raw = fh.read()
        encoding = "utf-8-sig"
        try:
            src = raw.decode(encoding)
        except UnicodeDecodeError:
            encoding = "latin-1"
            src = raw.decode(encoding)

        out, n = VERTEX_COLOR.subn(WHITE, src)
        if not n:
            print(f"  ⚠ aucune occurrence de v.color dans {rel}")
            continue

        backup = path + ".orig"
        if not os.path.exists(backup):  # ne jamais ecraser une sauvegarde par du deja patche
            shutil.copy2(path, backup)
        with open(path, "w", encoding=encoding) as fh:
            fh.write(out)
        touched += 1
        print(f"  patche {rel} ({n} occurrence{'s' if n > 1 else ''})")

    print(f"{touched} shaders sur {len(TARGETS)} neutralises")
    return 0 if touched == len(TARGETS) else 1


def restore():
    count = 0
    for base, dirs, files in os.walk(ROOT):
        for name in files:
            if not name.endswith(".orig"):
                continue
            backup = os.path.join(base, name)
            shutil.move(backup, backup[:-5])
            count += 1
    print(f"{count} shaders restaures")
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--apply", action="store_true")
    group.add_argument("--restore", action="store_true")
    args = parser.parse_args()
    return apply() if args.apply else restore()


if __name__ == "__main__":
    sys.exit(main())

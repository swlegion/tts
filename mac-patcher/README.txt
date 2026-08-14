mac-patcher
===========

A Python patcher that injects the Iron Squadron overlay module into a SWL TTS
save file. It is optional, it sits behind a single table-wide button that is off
by default, and with the button off the mod behaves exactly as it does today.

It has nothing to do with the magenta bug any more. That one is fixed in the
bundles themselves, which is the mergeable part of this branch; see
mac-support-package/ and mac-patcher/tools/. This module is the separate offer
described in proposals-upstream.txt, kept here so you can look at it before
deciding whether you want any of it.


WHAT IT ADDS

  Cohesion on the five base sizes the mod does not cover. getCohesionLinks()
  ships 27, 50 and 70 mm, so on 100, 120 and 150 mm bases and on the two oblong
  ones, spawnCohesionRuler returns early and nothing appears. 35 units are in
  that case.

  Cohesion that follows a model while it is being dragged, instead of
  disappearing on pickup and coming back stale on drop.

  Deterministic toggles. The vanilla range and cohesion buttons respawn their
  Projector rather than toggling it, so a double click leaves two of them.

  A maximum-move template anchored where the move started, rather than one that
  follows the model as it goes.

  A white cohesion band at range 0.5 on the eight unit-leader range templates,
  and matching rings on objective and condition tokens.

Rendering goes through real Projectors, in bundles built the same way as the
repaired ones. Nothing is drawn in Lua.


USAGE

    # Setup once
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt

    # Patch a save
    python3 patch_save_for_mac.py <vanilla_save.json> <output_path.json> [--reload]

The patcher writes only to <output_path.json>. Point that at a slot under
~/Library/Tabletop Simulator/Saves/ if you want TTS to pick it up in
Games -> Save & Load.

--reload hot-pushes the patched scripts to a running TTS instance via the
External Editor API, so there is no need to restart TTS.


IDEMPOTENCE

All patches are idempotent. A re-run on an already patched save strips the
previous block from Global via a marker regex and re-injects a fresh one.
Per-object wrappers are stripped before re-injection too.


ONE KNOWN STOPGAP

The Order Token's ATTACK chain is routed through this module so that it does not
leave two overlapping rulers on screen. The feature itself dates from V1 and its
measurements are not accurate under V2 rules, so treat it as a stopgap to be
replaced or removed, not as a design.


FILES

  patch_save_for_mac.py    the patcher
  proposals-upstream.txt   what we are offering to build, for the maintainers
  tools/                   the bundle repair chain, documented in tools/README.txt:
                           build, merge the per-platform SubShaders, graft a Metal
                           SubShader into a 2019.1 bundle, inventory the mod's
                           bundles, install the result into the local TTS cache

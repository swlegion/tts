#!/usr/bin/env python3
"""
Inject the optional Iron Squadron overlay module into a SWL TTS save JSON.

It sits behind a single table-wide button, off by default, and adds what the
vanilla mod does not have: cohesion on the five base sizes it skips, cohesion
that follows a model while it is dragged, deterministic toggles instead of
respawns, a maximum-move template anchored where the move started, and a range
0.5 band on the range templates. Rendering goes through real Projectors, in
bundles built like the repaired ones, so nothing is drawn in Lua.

Not to be confused with the magenta fix: that one lives in the bundles, and is
this branch's mergeable content. This module is the separate offer described in
proposals-upstream.txt. The names below still say "mac" for historical reasons
and because the injected markers are matched by regex on re-runs.

Two-part patch:
1. Append manager + event handlers to the Global LuaScript.
2. Replace the inline Cohesion block in Unit_Leader (99f1c8) and Order_Token
   (a57c41) with delegated stubs that call the Global manager via Global.call.

Usage:
    python3 patch_save_for_mac.py <input.json> <output.json>
"""
import json
import re
import socket
import sys
from pathlib import Path

# ------------------------------------------------------------
# 1) Code appended to Global LuaScript (manager + event handlers)
# ------------------------------------------------------------
GLOBAL_PATCH_LUA = r"""

-- ============================================
-- MAC COHESION FALLBACK (auto-injected for TTS U6 magenta bug)
-- Manager Global + event handlers + vector-lines rendering.
-- Called by Unit_Leader / Order_Token via Global.call from their patched
-- Cohesion functions.
-- ============================================

-- Capture the ORIGINAL Global functions loaded by !/RangeRulers and
-- !/Cohesion BEFORE we overwrite them below. We also capture the inner
-- spawn/clear pair because the toggle wrapper resolves them by NAME at
-- call time  -  without aliasing those too, the original toggle would route
-- back into our Mac versions, defeating Windows mode entirely.
spawnRangeRulerOriginalGlobal     = spawnRangeRuler
clearRangeRulersOriginalGlobal    = clearRangeRulers
spawnCohesionRulerOriginalGlobal  = spawnCohesionRuler
clearCohesionRulerOriginalGlobal  = clearCohesionRuler

activeOverlays = activeOverlays or {}

-- ============================================
-- RENDERER: one real Unity Projector per active overlay.
--
-- Replaces the flat-decal renderer. A Projector drapes over table relief and
-- tracks its figure natively, so the ground raycasts, the hand-built
-- ring/rect/stadium geometry, the per-entry geometry cache, the coalesced
-- redraw signature and the PNG preload all went away with it.
--
-- What this layer still owns, and the vanilla mod does not:
--   * cohesion stays visible and FOLLOWS the figure during a drag;
--   * toggles are deterministic (see gRangeTrigger / gCohesionTrigger);
--   * MaxMove is anchored where the move STARTED and never follows.
-- Spec: the Iron Squadron overlay spec (kept internal, ask us for it).
-- ============================================

-- Resolve baseSize for a fig. The mod stores it as a script-local Var on the
-- fig itself (set at spawn from the unit's container). unitData.baseSize is
-- only populated on the Unit Leader, not on minis/vehicles, so getVar is the
-- canonical read with unitData as a fallback.
local function macGetBaseSize(fig)
    if not fig then return nil end
    local ok, bs = pcall(function() return fig.getVar("baseSize") end)
    if ok and bs then return bs end
    local data = fig.getTable("unitData")
    if data and data.baseSize then return data.baseSize end
    return nil
end

-- A token has no baseSize of its own. When the hover hotkey asks for the full
-- fig-leader bands on a token, size them with the closest equivalent
-- footprint. The token's own R button keeps its single-ring bundle.
local TOKEN_TO_BASESIZE = {
    smokeToken    = "small",
    token         = "small",
    tokenRangeTwo = "small",
    poi           = "medium",
    bombCart      = "medium",
}

-- The Iron Squadron range rulers. Same Projector, same geometry, same colours
-- as the mod's, with one thing added: the range 0.5 band, white, from the base
-- edge out to 3in, with range 1's orange starting at 3in instead of at the
-- base. Built from the mod's own prefabs (see make_isq_range_prefabs.py), so
-- they are bi-platform like everything else we rebuild.
--
-- These are NEW assets: they have no Steam UGC entry, so they cannot be served
-- from the TTS cache like the 143 repaired bundles. They are served from the
-- fork instead. That separation is the point: the repaired bundles sit under
-- the mod's own URLs, so anything added to them would show in the mod's
-- original mode too, and the toggle would stop meaning anything for Range.
--
-- Only the hover hotkey reaches this table (forceFigMode). A token's own R
-- button keeps the mod's single-ring bundle, deliberately.
local ISQ_ASSETS = "__ISQ_ASSETS_BASE__"
local ISQ_RANGE_BUNDLES = {
    small  = ISQ_ASSETS .. "projector_27mm_isq_v6.unity3d",
    medium = ISQ_ASSETS .. "projector_50mm_isq_v6.unity3d",
    large  = ISQ_ASSETS .. "projector_70mm_isq_v6.unity3d",
    huge   = ISQ_ASSETS .. "projector_100mm_isq_v6.unity3d",
    laat   = ISQ_ASSETS .. "projector_120mm_isq_v6.unity3d",
    epic   = ISQ_ASSETS .. "projector_150mm_isq_v6.unity3d",
    long   = ISQ_ASSETS .. "projector_100mm_oblong_isq_v6.unity3d",
    snail  = ISQ_ASSETS .. "projector_200mm_oblong_isq_v6.unity3d",
}

-- Cohesion rings for the base sizes the mod has none for. getCohesionLinks()
-- only knows small (27mm), medium (50mm) and large (70mm); on anything else
-- vanilla spawnCohesionRuler returns without drawing. These fill the gap.
--
-- Nothing was invented: BB_CohesionProjector draws its ring at the projector's
-- outer edge and reads nothing else, so the whole geometry is one number,
-- ortho = half the base + 3in, which is what the mod's own three carry
-- (27mm -> 3.531496 = 0.53150 + 3, and so on). 3in is range 1/2, the distance
-- cohesion is measured at -- the same one the white band marks on the rulers.
--
-- long and snail go through BB_OblongCohesionProjector, written for them: the
-- mod's cohesion shader computes its gradient with Circle() and can only draw
-- a disc. Their base geometry is not invented either -- it is read back out of
-- the oblong RANGE materials, the only place in the project where those
-- dimensions are written down.
local ISQ_COHESION_BUNDLES = {
    huge  = ISQ_ASSETS .. "halfcohesion_100mm_isq_v2.unity3d",
    laat  = ISQ_ASSETS .. "halfcohesion_120mm_isq_v2.unity3d",
    epic  = ISQ_ASSETS .. "halfcohesion_150mm_isq_v2.unity3d",
    long  = ISQ_ASSETS .. "halfcohesion_long_isq_v3.unity3d",
    snail = ISQ_ASSETS .. "halfcohesion_snail_isq_v3.unity3d",
}

-- Range 1/2 rings for the tokens whose own R button should show range 1/2
-- rather than the range 1 the mod gives them. Keyed by the object's name,
-- because rangeKey cannot separate them: "token" is shared by Objective,
-- Condition, Cad Bane, Proton Charge and Complete the Mission alike.
--
-- The mod already had exactly this object, and it is not a range ruler: the
-- POI's 3in ring is BB_CohesionProjector with its orthographic size at 4,
-- one inch of base radius plus three. Ours is the same build at the token's
-- own base, and it keeps the ring's current amber so only the SIZE changes.
--
-- The hover hotkey is untouched: it still draws the fig-leader bands.
-- Objective and Condition share the base and the colour, so one ring serves
-- both. Condition is what the game calls the Advantage token (Martin, 14 Aug).
local ISQ_TOKEN_RINGS = {
    ["Objective Token"] = ISQ_ASSETS .. "token05_27mm_isq_v1.unity3d",
    ["Condition Token"] = ISQ_ASSETS .. "token05_27mm_isq_v1.unity3d",
}

-- Per family: the name TTS gives the spawned object, whether it tracks its
-- figure, and the pitch the vanilla spawn uses.
--
-- The names are deliberately the vanilla ones. standbyTokens (Global) and
-- removeLockedRulers (GAME_CONTROLLER) sweep by name, so our Projectors
-- inherit the mod's own cleanup; the decal renderer had no objects at all and
-- was invisible to both.
local PROJECTOR_SPEC = {
    range      = {name = "Range Ruler",         follows = true,  pitch = 90},
    cohesion   = {name = "Cohesion Ruler",      follows = true,  pitch = 0},
    maxmove    = {name = "Maximum Move",        follows = false, pitch = 0},
}

-- Vanilla injects this into its Range ruler so it tracks the figure. Reusing
-- it for cohesion is what makes cohesion follow during a drag. Guarded
-- against a destroyed target, which the vanilla one is not.
local function macFollowScript(targetGUID)
    return "targetGUID = '" .. targetGUID .. "'\n"
        .. "function onFixedUpdate()\n"
        .. "  local t = getObjectFromGUID(targetGUID)\n"
        .. "  if t == nil then return end\n"
        .. "  local p = t.getPosition()\n"
        .. "  self.setPosition({p.x, p.y + 20, p.z})\n"
        .. "  self.setRotation({0, t.getRotation().y, 0})\n"
        .. "end"
end

local function macIsLive(obj)
    if obj == nil then return false end
    local ok, dead = pcall(function() return obj.isDestroyed() end)
    return ok and not dead
end

-- Which bundle this overlay shows. MaxMove carries its own in params:
-- getMovementLinks lives in the Order Token's scope, not reachable from
-- Global.
local function macResolveBundle(kind, fig, params)
    params = params or {}
    if params.bundle then return params.bundle end

    if kind == "cohesion" then
        local bs = macGetBaseSize(fig)
        if not bs then return nil end
        -- Ours first, for the base sizes the mod has no ring for at all.
        if ISQ_COHESION_BUNDLES[bs] then return ISQ_COHESION_BUNDLES[bs] end
        if not getCohesionLinks then return nil end
        local links = getCohesionLinks()
        return links and links[bs] or nil
    end

    if kind == "range" then
        if not getRangeRulerLinks then return nil end
        local links = getRangeRulerLinks()
        if not links then return nil end

        local key = params.rangeKey
        if not key and fig then
            local ok, v = pcall(function() return fig.getVar("rangeKey") end)
            if ok then key = v end
        end
        -- Token R button: its own single-ring bundle. Hover hotkey
        -- (forceFigMode): the full fig-leader bands instead.
        if key and not params.forceFigMode then
            local ok, nm = pcall(function() return fig.getName() end)
            if ok and nm and ISQ_TOKEN_RINGS[nm] then return ISQ_TOKEN_RINGS[nm] end
            if links[key] then return links[key] end
        end
        local bs = macGetBaseSize(fig) or (key and TOKEN_TO_BASESIZE[key])
        if not bs then return nil end
        -- Iron Squadron rulers first: same geometry as the mod's, plus the
        -- white range 0.5 band. Fall back to the mod's own bundle if a base
        -- size ever appears that we have no ruler for.
        return ISQ_RANGE_BUNDLES[bs] or links[bs]
    end

    return nil
end

local function macSpawnProjector(kind, fig, params)
    local spec = PROJECTOR_SPEC[kind]
    if not spec then return nil end
    local bundle = macResolveBundle(kind, fig, params)
    if not bundle then return nil end
    params = params or {}

    local pos, yaw
    if kind == "maxmove" then
        -- Anchored: position and yaw captured when the move STARTED, so the
        -- template stays where it was while the figure slides away from it.
        local a = params.anchorPos
        if not a then return nil end
        pos = {a.x, a.y + 20, a.z}
        yaw = params.anchorRot or 0
    else
        if not fig then return nil end
        local p = fig.getPosition()
        pos = {p.x, p.y + 20, p.z}
        yaw = fig.getRotation().y
    end
    if not pos then return nil end

    local obj = spawnObject({
        type     = "Custom_AssetBundle",
        position = pos,
        rotation = {spec.pitch, yaw, 0},
        -- Scale 0 hides the TTS placeholder box without touching the
        -- Projector itself, exactly as the vanilla spawns do.
        scale    = {0, 0, 0},
    })
    obj.setCustomObject({type = 0, assetbundle = bundle})
    obj.setLock(true)
    obj.use_gravity = false
    obj.setName(spec.name)
    if spec.follows and fig then
        obj.setLuaScript(macFollowScript(fig.getGUID()))
    end
    return obj
end

-- Destroy the Projector an entry owns, then forget the entry. EVERY removal
-- must go through here: dropping the entry alone leaks the object.
function macRemove(key)
    local entry = activeOverlays[key]
    if entry == nil then return end
    if macIsLive(entry.obj) then
        pcall(function() entry.obj.destruct() end)
    end
    activeOverlays[key] = nil
end

function macRemoveAllOfType(kind)
    local keys = {}
    for key, entry in pairs(activeOverlays) do
        if entry.type == kind then keys[#keys + 1] = key end
    end
    for _, key in ipairs(keys) do macRemove(key) end
end

-- Reconcile the scene with the registry: give a Projector to every entry that
-- has never had one, and drop entries that lost theirs.
function macRedrawNow()
    local stale = {}
    for key, entry in pairs(activeOverlays) do
        if not entry.fig or type(entry.fig.getPosition) ~= "function" then
            stale[#stale + 1] = key
        elseif entry.objGUID == nil then
            local ok, obj = pcall(macSpawnProjector, entry.type, entry.fig, entry.params)
            if ok and obj then
                entry.obj     = obj
                entry.objGUID = obj.getGUID()
            else
                stale[#stale + 1] = key
            end
        elseif not macIsLive(entry.obj) then
            -- The Projector is gone and we did not remove it, so a sweeper
            -- did: standbyTokens, removeLockedRulers or Clear Map. Those are
            -- explicit "wipe the table" commands, so treat it as the overlay
            -- having been switched off rather than respawn behind them.
            stale[#stale + 1] = key
        end
    end
    for _, k in ipairs(stale) do macRemove(k) end
end

-- Deferred by one frame so a single click touching several entries
-- reconciles once.
function macRedrawAll()
    if macRedrawPending then return end
    macRedrawPending = true
    Wait.frames(function()
        macRedrawPending = false
        pcall(macRedrawNow)
    end, 1)
end

function gSpawnCohesion(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    -- macRemove first: re-spawning over a live entry would orphan its
    -- Projector, which nothing would ever destroy.
    local key = fig.getGUID() .. ":cohesion"
    macRemove(key)
    activeOverlays[key] = {
        type = "cohesion", fig = fig, params = params or {}
    }
    macRedrawAll()
end

function gClearCohesion(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    -- Vanilla fig scripts clear cohesion from onPickedUp. Design choice
    -- (11 aug): our cohesion stays visible and FOLLOWS the fig during the
    -- drag, like Range does, so clears on a held fig are ignored (the
    -- vanilla onPickedUp clear is the only caller in that state).
    if fig.held_by_color then return end
    macRemove(fig.getGUID() .. ":cohesion")
end

function gToggleCohesion(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    local key = fig.getGUID() .. ":cohesion"
    if activeOverlays[key] then
        gClearCohesion(params)
    else
        gSpawnCohesion(params)
    end
end

function gSpawnRange(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    local key = fig.getGUID() .. ":range"
    macRemove(key)
    activeOverlays[key] = {
        type = "range", fig = fig, params = params or {}
    }
    macRedrawAll()
end

function gClearRange(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    macRemove(fig.getGUID() .. ":range")
    -- Windows mode: also destroy the vanilla bundle this fig owns. It was
    -- spawned in the Global scope by gRangeTrigger, so the token's own
    -- exitTargetingMode/clearRangeRulers cannot reach it.
    if macWinRangeGUID == params.figGUID then
        pcall(clearRangeRulersOriginalGlobal)
        macWinRangeGUID = nil
    end
end

function gToggleRange(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    local key = fig.getGUID() .. ":range"
    if activeOverlays[key] then
        gClearRange(params)
    else
        gSpawnRange(params)
    end
end

function gSpawnMaxMove(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    -- Capture the spawn-time position and yaw. MaxMove is anchored to where
    -- the move STARTED: it must not follow the fig as it slides toward the
    -- destination. A Projector tracks its target by default, so this one is
    -- deliberately spawned with no follow script (see PROJECTOR_SPEC).
    local p = (params and params.params) or params or {}
    p.anchorPos = fig.getPosition()
    p.anchorRot = fig.getRotation().y
    local key = fig.getGUID() .. ":maxmove"
    macRemove(key)
    activeOverlays[key] = {
        type = "maxmove", fig = fig, params = p
    }
    macRedrawAll()
end

function gClearMaxMove(params)
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    macRemove(fig.getGUID() .. ":maxmove")
end

-- Note: no onObjectPickUp/onObjectDrop handlers (the vanilla Global defines
-- none either). Cohesion, like Range, stays visible during a drag and follows
-- because its Projector carries the tracking script; the vanilla onPickedUp
-- clear is neutralized in gClearCohesion while the fig is held.

function onObjectDestroy(obj)
    if not obj or not obj.getGUID then return end
    local guid = obj.getGUID()
    local prefix = guid .. ":"
    local plen = #prefix
    local doomed = {}
    for key, entry in pairs(activeOverlays) do
        -- The destroyed object is either the figure an overlay belongs to,
        -- or the overlay's own Projector (a sweeper, or a player deleting it
        -- by hand).
        if key:sub(1, plen) == prefix or entry.objGUID == guid then
            doomed[#doomed + 1] = key
        end
    end
    for _, key in ipairs(doomed) do macRemove(key) end
end

-- ============================================
-- TABLE-WIDE OVERLAY TOGGLE (Range + Cohesion + MaxMove)
-- One switch for the whole table: "windows" (the mod's original Projectors)
-- or "mac" (the Iron Squadron overlays). Per-seat modes were dropped on
-- purpose: any rendered overlay is visible to every player (TTS engine
-- limitation), so one player triggering an original Projector shows it to
-- the whole table anyway. The switch is the Iron Squadron button in the
-- bottom-right menu: default grey = off (originals, untouched), green = on.
-- ============================================

overlayMode = overlayMode or "windows"  -- "windows" | "mac", table-wide

function gGetMode(_) return overlayMode end

function gCohesionTrigger(params)
    if not params or not params.figGUID then return end
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    if overlayMode ~= "windows" then
        gToggleCohesion({figGUID = params.figGUID})
        return
    end
    -- Windows mode: the vanilla Projector lives in the FIG scope (every fig
    -- requires !/Cohesion), so read and clear it there. Vanilla
    -- spawnCohesionRuler RESPAWNS instead of toggling, so without this a
    -- second click just redrew the ruler and it could never be turned off.
    -- pcall guards objects that carry no such function (e.g. a hovered
    -- non-fig object), which fall back to the Mac renderer.
    local ok, isOn = pcall(function() return fig.getVar("cohesionRuler") ~= nil end)
    if not ok then
        gToggleCohesion({figGUID = params.figGUID})
        return
    end
    if isOn then
        pcall(function() fig.call("clearCohesionRulerOriginal", fig) end)
    elseif not pcall(function() fig.call("spawnCohesionRulerOriginal", fig) end) then
        gToggleCohesion({figGUID = params.figGUID})
    end
end

-- Which fig currently owns the vanilla (Windows-mode) Range bundle, so a
-- second trigger on the same fig turns it off like vanilla
-- showRangeOnHoveredModel does.
macWinRangeGUID = macWinRangeGUID or nil

function gRangeTrigger(params)
    if not params or not params.figGUID then return end
    local fig = getObjectFromGUID(params.figGUID)
    if not fig then return end
    if overlayMode ~= "windows" then
        -- Forward the WHOLE params table. Rebuilding it with figGUID alone
        -- dropped forceFigMode, which the hover hotkey sets and
        -- macResolveBundle reads: the fig-leader bands documented for a
        -- hovered token never rendered, its own single ring did instead.
        -- showRangeOnHoveredModel already forwards it, so the same gesture
        -- gave two different results depending on which path it took.
        gToggleRange(params)
        return
    end
    -- The vanilla bundle Range lives in the GLOBAL scope: !/RangeRulers is
    -- required by Global, while figs only require !/Cohesion. Calling
    -- fig.call("spawnRangeRulerOriginal", fig) therefore ALWAYS raised
    -- "no such function"; the pcall swallowed it and we fell through to the
    -- Mac renderer, so Windows mode silently drew Mac overlays instead of
    -- the original Projector. Route through the Global aliases captured at
    -- the top of this block instead.
    local wasOn = (macWinRangeGUID == params.figGUID)
    pcall(clearRangeRulersOriginalGlobal)
    macWinRangeGUID = nil
    if not wasOn then
        if pcall(function() spawnRangeRulerOriginalGlobal(fig) end) then
            macWinRangeGUID = params.figGUID
        else
            gToggleRange(params)
        end
    end
end

function macModeToggle(_, _, _)
    overlayMode = (overlayMode == "mac") and "windows" or "mac"
    -- Wipe both renderers' overlays so stale visuals don't linger after the
    -- toggle; each player just re-triggers their hotkey.
    macRemoveAllOfType("cohesion")
    macRemoveAllOfType("range")
    macRemoveAllOfType("maxmove")
    for _, obj in ipairs(getAllObjects()) do
        if obj.getVar and obj.getVar("cohesionRuler") then
            pcall(function() obj.call("clearCohesionRulerOriginal", obj) end)
        end
        if obj.getVar and obj.getVar("rangeRuler") then
            pcall(function() obj.call("clearRangeRulersOriginal", obj) end)
        end
    end
    -- The Windows-mode Range bundle is spawned from the Global scope, which
    -- getAllObjects() above does not cover.
    pcall(clearRangeRulersOriginalGlobal)
    macWinRangeGUID = nil
    broadcastToAll(
        (overlayMode == "mac") and "Iron Squadron overlays ON for the whole table."
                                or "Iron Squadron overlays OFF: the mod's original overlays are back.",
        (overlayMode == "mac") and {0.55, 0.9, 0.6} or {0.9, 0.75, 0.55})
    macDeferRefresh()
end

local function macFindNodeById(tree, id)
    for _, node in ipairs(tree) do
        if node.attributes and node.attributes.id == id then return node, tree end
        if node.children then
            local found, parent = macFindNodeById(node.children, id)
            if found then return found, parent end
        end
    end
    return nil, nil
end

-- UI: single Iron Squadron toggle button in the bottom-right
-- legionFloatingMenu.
function macRefreshModeUI()
    local tree = UI.getXmlTable() or {}
    -- Drop the legacy mode-picker panel if this save still carries one.
    for i = #tree, 1, -1 do
        if tree[i].attributes and tree[i].attributes.id == "macModePanel" then
            table.remove(tree, i)
        end
    end
    local menu = macFindNodeById(tree, "legionFloatingMenu")
    if menu and menu.children then
        local isMac = (overlayMode == "mac")
        local attrs = {
            id = "macModeMenuButton",
            onClick = "macModeToggle",
            tooltip = isMac
                and "Iron Squadron overlays: ON for the whole table. Click to go back to the mod's original overlays."
                or  "Iron Squadron overlays: OFF, the mod's original overlays are in use. Click to turn them on for the whole table.",
        }
        -- OFF keeps the sibling buttons' default light-grey look (Welcome,
        -- Chess Clocks); ON switches to green.
        if isMac then attrs.color = "#1e7a3a" end
        local button = {
            tag = "Button",
            attributes = attrs,
            children = {{
                -- White PNG sprite (CustomUIAssets "isqLogo"), tinted per
                -- state: dark on the grey button, white on green. The shape
                -- lives in the alpha channel, which is what makes the tint
                -- work.
                tag = "Image",
                attributes = {
                    image = "isqLogo",
                    color = isMac and "#FFFFFF" or "#2b2b2b",
                    preserveAspect = "true",
                    raycastTarget = "false",
                },
            }},
        }
        local placed = false
        for i, c in ipairs(menu.children) do
            if c.attributes and c.attributes.id == "macModeMenuButton" then
                menu.children[i] = button
                placed = true
                break
            end
        end
        if not placed then
            for i, c in ipairs(menu.children) do
                if c.attributes and c.attributes.interactable == "false" then
                    menu.children[i] = button
                    placed = true
                    break
                end
            end
        end
    end
    UI.setXmlTable(tree)
end

-- Defer one frame: TTS throws a UTF-8 byte-buffer encoding error if we
-- rebuild the UI XML synchronously inside a click handler. pcall guards
-- against any residual race.
function macDeferRefresh()
    Wait.frames(function() pcall(macRefreshModeUI) end, 1)
end

-- Initial UI build, deferred + pcalled like the rest.
Wait.time(function() pcall(macRefreshModeUI) end, 2)

-- Override hotkey init functions to capture playerColor and route through
-- the mode router. Defining initCohesionHotkeys/initRangebandHotkeys
-- here SHADOWS the originals  -  when the original onLoad runs init*(), our
-- versions register the hotkey instead.

function initCohesionHotkeys()
    addHotkey("Show Cohesion On Hovered Model",
        function(playerColor, hoverObject, _)
            if not hoverObject or not hoverObject.interactable then return end
            gCohesionTrigger({
                figGUID     = hoverObject.getGUID(),
                playerColor = playerColor,
            })
        end)
end

function initRangebandHotkeys()
    addHotkey("Show Range On Hovered Model",
        function(playerColor, hoverObject, _)
            if not hoverObject or not hoverObject.interactable then return end
            gRangeTrigger({
                figGUID      = hoverObject.getGUID(),
                playerColor  = playerColor,
                forceFigMode = true,  -- hotkey always shows 6-band fig overlay
            })
        end)
end

-- The vanilla showRangeOnHoveredModel calls spawnRangeRuler(fig) which spawns
-- the Range AssetBundle directly. On Mac, the "Oblong Range" shader used by
-- long/snail bundles isn't supported (magenta). Override the global function
-- to route through gToggleRange so our stadium overlay renders instead.
-- Vanilla Range bundle still works for round bases via gWindowsRangeToggle
-- when the player explicitly chose Windows mode.
function showRangeOnHoveredModel(hoverObject)
    if not hoverObject or not hoverObject.interactable then return end
    gToggleRange({figGUID = hoverObject.getGUID(), forceFigMode = true})
end

-- Note: we deliberately do NOT override the global spawnRangeRuler /
-- clearRangeRulers / showRangeOnHoveredModel chain at the Lua scope where
-- the vanilla mod defines it. Overriding spawnRangeRuler from a token
-- script reproducibly SIGSEGV'd TTS on Mac in May 2026 (Mono GC stack
-- corruption). Mac routing happens via the g* functions called from our
-- own hotkey/button wrappers; the originals stay reachable for
-- Windows-mode players via spawnRangeRulerOriginalGlobal aliases above.

-- END MAC COHESION FALLBACK
"""


# ------------------------------------------------------------
# 2) Wrapper appended AFTER the original Cohesion include (per-seat router)
# ------------------------------------------------------------
# Strategy: keep the ORIGINAL Cohesion/RangeRulers expansion intact, then
# append wrappers that alias originals + route through the Global router.
# This preserves the original Custom_AssetBundle Projector spawn for
# Windows-mode players (called back as spawnCohesionRulerOriginal).

COHESION_WRAPPER = r"""
-- MAC PATCH per-seat router (Cohesion)
-- Aliases the original spawn so Windows-mode players still get their bundle.
spawnCohesionRulerOriginal = spawnCohesionRuler
clearCohesionRulerOriginal = clearCohesionRuler

function spawnCohesionRuler(cohesionSourceObject)
    if not cohesionSourceObject then return end
    Global.call("gCohesionTrigger", {
        figGUID     = cohesionSourceObject.getGUID(),
        playerColor = nil,
    })
end

function clearCohesionRuler()
    if self and self.getGUID and self.getGUID() ~= "-1" then
        Global.call("gClearCohesion", { figGUID = self.getGUID() })
    end
    if cohesionRuler ~= nil then
        pcall(clearCohesionRulerOriginal)
    end
end

-- Vanilla Order Token's clearTemplates() calls clearCohesionRulers (plural),
-- but the save was built from an older mod version that ships only the
-- singular clearCohesionRuler. Provide the plural as a delegating stub so
-- standby/clearTemplates/etc. don't nil-error on click.
function clearCohesionRulers()
    if selectedUnitObj then
        pcall(function() selectedUnitObj.setVar("moveState", false) end)
        pcall(function() selectedUnitObj.call("clearCohesionRuler") end)
    end
end

-- Same root cause as clearCohesionRulers: newer Order Token code paths in
-- the live save (e.g. moveUnit -> stopAttack) call helpers the older bundled
-- script doesn't ship. Stub them so MOVE/AIM/etc don't nil-error. The bodies
-- mirror the current vanilla source but pcall every dependency so we don't
-- chain-error if anything else is also missing.
function clearAttackLine()
    if attackLine then
        for k, v in pairs(attackLine) do
            pcall(destroyObject, v)
        end
        attackLine = nil
    end
end

function exitTargetingMode()
    enemyHighlighted = false
    attackModeOn = false
    pcall(clearRangeRulers)
    pcall(unhighlightEnemies)
    pcall(clearAttackLine)
end

function exitAttackMode()
    enemyHighlighted = false
    attackModeOn = false
    pcall(clearRangeRulers)
    pcall(unhighlightEnemies)
end
-- END MAC PATCH per-seat router (Cohesion)
"""


COHESION_BLOCK_RE = re.compile(
    r"----#include !/Cohesion\r?\n.*?----#include !/Cohesion\r?\n",
    re.DOTALL
)

RANGE_BLOCK_RE = re.compile(
    r"----#include !/RangeRulers\r?\n.*?----#include !/RangeRulers\r?\n",
    re.DOTALL
)

# Maximum Move spawn block in Order_Token (a57c41), inline (not an include).
# Captures from `local maxMoveBundles = getMovementLinks()` up to and
# including the two closing ends of the original `if isDeploy / if ... ~= nil`
# scaffold. The replacement is self-contained (opens 3 ifs, closes all 3),
# so re-applying yields the same canonical block  -  idempotent. (Earlier
# versions only matched up to setName("Maximum Move") and re-matched their
# own output, accumulating orphan else/end copies on each re-run.)
MAXMOVE_SPAWN_RE = re.compile(
    r"local maxMoveBundles = getMovementLinks\(\).*?"
    r"\r?\n        end\r?\n    end\r?\n",
    re.DOTALL
)

MAXMOVE_SPAWN_REPLACEMENT = r"""local maxMoveBundles = getMovementLinks()
    local baseSizeMoveBundles = maxMoveBundles[unitData.baseSize]
    local maxMoveTemplateBundleToSpawn = baseSizeMoveBundles and baseSizeMoveBundles[unitData.selectedSpeed]

    -- MAC PATCH: permissive condition (covers nil + false) so the overlay
    -- also fires when changeSpeed2/3 calls moveUnit() with no isDeploy arg.
    if isDeploy ~= true then
        if maxMoveTemplateBundleToSpawn ~= nil then
            local _macMode = Global.call("gGetMode", {})
            if _macMode == "windows" then
                -- WINDOWS ORIGINAL: spawn Custom_AssetBundle Projector
                maxMoveTemplate = spawnObject({
                    type = "Custom_AssetBundle",
                    position = {basePos.x, basePos.y + 20, basePos.z},
                    rotation = {0, basePos.y, 0},
                    scale = {0,0,0}
                })
                maxMoveTemplate.setCustomObject({
                    type = 0,
                    assetbundle = maxMoveTemplateBundleToSpawn
                })
                maxMoveTemplate.setLock(true)
                maxMoveTemplate.use_gravity = false
                maxMoveTemplate.setName("Maximum Move")
            else
                -- IRON SQUADRON: route through the Global Overlays manager.
                -- The bundle travels with the call: getMovementLinks() is
                -- required by this object, not by Global.
                Global.call("gSpawnMaxMove", {
                    figGUID  = selectedUnitObj.getGUID(),
                    baseSize = unitData.baseSize,
                    speed    = unitData.selectedSpeed,
                    bundle   = maxMoveTemplateBundleToSpawn,
                })
                maxMoveTemplate = nil
            end
        end
    end
"""

# clearMovementTemplates function: needs to also clear our managed maxmove
# overlay. We replace the whole function body.
# Match up to the first un-indented `end` (= the function's closing end), so
# the regex is idempotent  -  it matches both the vanilla body and any
# previously patched body shape (which has extra lines past the inner `end`).
CLEAR_MOVEMENT_RE = re.compile(
    r"function clearMovementTemplates\(\).*?\r?\nend\b",
    re.DOTALL
)

CLEAR_MOVEMENT_REPLACEMENT = r"""function clearMovementTemplates()
    if templateA ~= nil then
        destroyObject(templateA)
    end
    if templateB ~= nil then
        destroyObject(templateB)
    end
    -- MAC PATCH per-seat: destroy bundle Object if present (Windows-mode
    -- spawn) AND clear the manager entry (Mac fallback). Either may be set.
    if maxMoveTemplate ~= nil then
        pcall(destroyObject, maxMoveTemplate)
    end
    -- Clear only THIS token's MaxMove (keyed by the attached unit), not
    -- everyone's  -  gClearAllMaxMove was killing other tokens' rings when
    -- two players had MOVE open at the same time.
    if selectedUnitObj then
        Global.call("gClearMaxMove", { figGUID = selectedUnitObj.getGUID() })
    end
    maxMoveTemplate = nil
end"""


# SIL/LCK button placement on oblong bases (upstream bug, both OSes): the
# vanilla offset is baseRadius/2 + 0.1 with a single per-size radius and no
# axis handling, so on long/snail bases the buttons land on top of the
# model. Raise the offset to the model's actual half-depth when bigger.
BUTTON_OFFSET_RE = re.compile(
    r"(local buttonOffset = calculateButtonZOffset\(templateInfo\.baseRadius\[unitData\.baseSize\]\))"
    r"(?! -- MAC PATCH)"
)
BUTTON_OFFSET_REPLACEMENT = r"""\1 -- MAC PATCH oblong
  -- Deferred: at onLoad the custom mesh is not loaded yet, so bounds read
  -- as zero. Re-place SIL/LCK once the model is in, oblong bases only.
  if unitData and (unitData.baseSize == "long" or unitData.baseSize == "snail") then
    Wait.time(function()
      if self == nil then return end
      local okB, b = pcall(function() return self.getBoundsNormalized() end)
      local okS, sc = pcall(function() return self.getScale() end)
      if not (okB and okS and b and sc and sc.z ~= 0) then return end
      local half = (b.size.z / sc.z) * 0.5 + 0.15
      for _, btn in ipairs(self.getButtons() or {}) do
        if (btn.label == "SIL" or btn.label == "LCK")
           and (btn.position.z or 0) < half then
          self.editButton({index = btn.index,
            position = {btn.position.x, btn.position.y, half}})
        end
      end
    end, 3)
  end"""



# Silhouette state-desync fix (upstream bug).
#
# Upstream clearSilhouette assumes removeAttachments()[1] always returns an
# object, but the state variable `silhouetteState` is persisted across saves
# while the physical attachments are not  -  so a save made with silhouettes
# visible reloads with state=true but no attachments. First SIL click then
# calls clearSilhouette which dereferences nil and crashes.
#
# Two-part patch:
#   (1) clearSilhouette: guard the nil case (skip the destruct if no
#       attachment), so re-clicks don't crash.
#   (2) onload: force silhouetteState=false on every load, since the load
#       cannot restore the physical silhouettes anyway.
#
# Also fixes the "two silhouettes stacked" symptom: that happens when
# showSilhouette runs while state is desynced, spawning a second set on top
# of one whose handles have been forgotten.
CLEAR_SILHOUETTE_RE = re.compile(
    r"function clearSilhouette\(\).*?silhouetteState = false\r?\nend",
    re.DOTALL
)
CLEAR_SILHOUETTE_REPLACEMENT = r"""function clearSilhouette()
  -- MAC PATCH: guard nil silToDestroy. silhouetteState can be persisted as
  -- true across saves while the physical attachments are not, so a load
  -- with state=true + no attachments would otherwise crash here.
  for k, guid in pairs(miniGUIDs or {}) do
    local obj = getObjectFromGUID(guid)
    if obj then
      local silToDestroy = obj.removeAttachments()[1]
      if silToDestroy then silToDestroy.destruct() end
    end
  end
  silhouetteState = false
end"""

# Match the existing `function onload()` body (one-line empty or actual
# code). Idempotent: re-runs detect the marker `MAC PATCH: silhouette reset`
# and skip.
SIL_ONLOAD_RESET_LINE = (
    '    -- MAC PATCH: silhouette reset on load (attachments lost across saves)\n'
    '    silhouetteState = false\n'
)
ONLOAD_OPEN_RE = re.compile(r"function onload\(\)\r?\n")


# SIL button rename. On macOS the click_function name "toggleSilhouettes"
# was silently swallowed by TTS: the button played its sound and animation
# but the function was never called, while LCK and R (different names) kept
# working. Renaming it + forwarding unblocked it, confirmed empirically on
# 17 may 2026.
#
# KEPT even though silhouettes left the toggle's scope (12 aug). Reverting
# our silhouette code to vanilla back then did NOT lift the mute, so the
# leading suspect is a side effect of the Global patch itself, which we do
# still inject. Behaviour is unchanged either way: the button calls the
# untouched vanilla toggleSilhouettes through a one-line forwarder. Worth a
# single in-game click to find out whether it can go: patch a save without
# it and press SIL on a Unit Leader.
# Idempotent: re-runs detect both markers and skip.
SIL_BUTTON_CLICKFN_OLD = 'click_function = "toggleSilhouettes"'
SIL_BUTTON_CLICKFN_NEW = 'click_function = "macToggleSil"'
SIL_FORWARDER = '''
-- MAC PATCH: rebuilt SIL button click handler. On macOS the original
-- click_function name "toggleSilhouettes" is silently intercepted by TTS
-- (the SIL button plays its click sound and animation but the function is
-- never called). Renaming the click_function on the button definition and
-- adding this forwarder restores the routing. The silhouette code itself is
-- vanilla.
function macToggleSil()
  toggleSilhouettes()
end
-- END MAC PATCH SIL forwarder
'''
SIL_FORWARDER_MARKER = 'function macToggleSil()'


RANGE_WRAPPER = r"""
-- MAC PATCH per-seat router (Range)  -  ALIAS ONLY.
--
-- HISTORY (do not re-introduce): we previously overrode spawnRangeRuler /
-- clearRangeRulers / clearRangeRuler on the ~20 token scripts. That
-- reproducibly SIGSEGV'd TTS Mac (Mono GC_clear_stack_inner) when a fig
-- hotkey spawned the vanilla Range bundle. Overrides REMOVED  -  per-seat
-- Range routing for fig hotkey lives in Global (gRangeTrigger via our
-- initRangebandHotkeys shadow). Tokens' R buttons keep vanilla behavior
-- (magenta on Mac, native on Windows) until a per-token Mac fallback
-- ships  -  see TOKEN_BUTTON_WRAPPER for the per-token override path.
--
-- The single alias below is REQUIRED: Global macModeToggle calls
-- obj.call("clearRangeRulersOriginal", obj) on every object holding a
-- rangeRuler state, to wipe the vanilla ruler when toggling modes.
clearRangeRulersOriginal = clearRangeRulers
-- END MAC PATCH per-seat router (Range)
"""

# Order_Token-only overrides: intercept the UI button click handlers
# (toggleCohesionRuler, targetingMode, changeSpeedN, moveX) to capture
# playerColor passed by TTS for per-seat routing.
ORDER_TOKEN_BUTTON_OVERRIDES = r"""
-- MAC PATCH per-seat router (Order_Token button click overrides)
function toggleCohesionRuler(_, playerColor)
    if not selectedUnitObj then return end
    if not rulerOn then
        -- Deterministic ON: gCohesionTrigger toggles by GUID, so clear any
        -- stale Mac overlay first (e.g., drawn via the hover hotkey).
        Global.call("gClearCohesion", { figGUID = selectedUnitObj.getGUID() })
        Global.call("gCohesionTrigger", {
            figGUID     = selectedUnitObj.getGUID(),
            playerColor = playerColor,
        })
        rulerOn = true
    else
        selectedUnitObj.call("clearCohesionRuler")
        rulerOn = false
    end
end

-- ⏳ CORRECTIF D'ATTENTE, 14 aout. La chaine d'attaque n'a jamais ete routee :
-- attackMode() appelle le spawnRangeRuler vanilla du scope de l'Order Token,
-- donc le mode Iron Squadron recevait quand meme la regle du mod, et aucune des
-- sorties de ce chemin ne touchait activeOverlays -- RANGE puis ATTACK laissait
-- deux regles a l'ecran.
--
-- Arbitrage Martin : la fonctionnalite date de la V1 du jeu et n'est plus juste
-- en V2. Ceci la branche en attendant qu'un outil V2 la remplace ; ce n'est pas
-- une conception, c'est un bouchon. Le garder ennuyeux.
-- Spec : section "Chaine d'attaque" du cahier des charges Iron Squadron.
--
-- Defini ici et pas dans le bloc Cohesion parce que ce bloc-ci est ajoute EN
-- DERNIER, donc c'est lui qui gagne. Le local vient avant les fonctions qui le
-- capturent.
local function macClearSelectedRange()
    if selectedUnitObj then
        Global.call("gClearRange", { figGUID = selectedUnitObj.getGUID() })
    end
end

function attackMode()
    if not attackModeOn then
        exitTargetingMode()
        highlightEnemies()
        if selectedUnitObj then
            Global.call("gClearRange", { figGUID = selectedUnitObj.getGUID() })
            Global.call("gRangeTrigger", { figGUID = selectedUnitObj.getGUID() })
        end
        attackModeOn = true
        resetTargetingButtons()
    else
        exitTargetingMode()
    end
end

function exitTargetingMode()
    enemyHighlighted = false
    attackModeOn = false
    macClearSelectedRange()
    pcall(clearRangeRulers)
    pcall(unhighlightEnemies)
    pcall(clearAttackLine)
end

function exitAttackMode()
    enemyHighlighted = false
    attackModeOn = false
    macClearSelectedRange()
    pcall(clearRangeRulers)
    pcall(unhighlightEnemies)
end

function clearTemplates()
    pcall(clearMovementTemplates)
    macClearSelectedRange()
    pcall(clearRangeRulers)
    pcall(clearCohesionRulers)
end

function targetingMode(_, playerColor)
    if not selectedUnitObj then return end
    if not enemyHighlighted then
        exitAttackMode()
        highlightEnemies()
        -- Deterministic ON: gRangeTrigger toggles by GUID, so clear any
        -- stale Mac overlay first to guarantee this click draws.
        Global.call("gClearRange", { figGUID = selectedUnitObj.getGUID() })
        Global.call("gRangeTrigger", {
            figGUID     = selectedUnitObj.getGUID(),
            playerColor = playerColor,
        })
        enemyHighlighted = true
        resetRangeButtons()
    else
        -- exitTargetingMode/clearRangeRulers only clears the vanilla bundle
        -- ruler; clear the Mac overlay too so OFF really hides the rings.
        Global.call("gClearRange", { figGUID = selectedUnitObj.getGUID() })
        exitTargetingMode()
    end
end

-- initMove / initDeploy: redefine the body INLINE rather than wrap, because
-- wrapping (capturing the original via a local + calling it) reproducibly
-- broke every Order Token button click in testing (root cause unknown;
-- suspected Lua chunk-level upvalue interaction with TTS engine click
-- dispatch). The inline body mirrors the vanilla logic + the playerColor
-- capture so the MAXMOVE_SPAWN block can route to Mac/Windows per seat.
function initMove(obj, playerColor)
    if not selectedUnitObj then return end
    initPos = selectedUnitObj.getPosition()
    initRot = selectedUnitObj.getRotation()
    selectedUnitObj.call("setStartPos")
    moveUnit(false)
end
function initDeploy(obj, playerColor)
    if not selectedUnitObj then return end
    initPos = selectedUnitObj.getPosition()
    initRot = selectedUnitObj.getRotation()
    selectedUnitObj.call("setStartPos")
    moveUnit(true)
end

-- INLINE the vanilla bodies (mirror Order_Token.a57c41.lua) rather than
-- wrap. The List Builder copies this block to Command Token Custom_Models
-- which DO NOT carry the vanilla Order_Token function bodies  -  so a
-- wrap-then-call pattern hits `_macOrigChangeSpeed1 = nil` and crashes the
-- moment a Speed/Move button is pressed. Inlining keeps the behavior
-- identical on both Order Tokens (vanilla body re-defined) and Command
-- Tokens (helper fns setTemplateVariables/clearTemplates/moveUnit exist
-- on both because they're part of the include set the List Builder emits).
function changeSpeed1(_, playerColor)
    unitData.selectedSpeed = 1
    setTemplateVariables()
    clearTemplates()
    moveUnit()
end
function changeSpeed2(_, playerColor)
    unitData.selectedSpeed = 2
    setTemplateVariables()
    clearTemplates()
    moveUnit()
end
function changeSpeed3(_, playerColor)
    unitData.selectedSpeed = 3
    setTemplateVariables()
    clearTemplates()
    moveUnit()
end
function moveForward(_, playerColor)
    self.editButton({
        index = 11, click_function = "moveBackwards",
        label = "B", tooltip = "Move Backwards"
    })
    moveDirection = "forward"
    moveUnit()
end
function moveBackwards(_, playerColor)
    self.editButton({
        index = 11, click_function = "moveForward",
        label = "F", tooltip = "Move Forward"
    })
    moveDirection = "backwards"
    moveUnit()
end
function moveLeft(_, playerColor)
    moveDirection = "left"
    moveUnit()
end
function moveRight(_, playerColor)
    moveDirection = "right"
    moveUnit()
end
-- END MAC PATCH per-seat router (Order_Token button click overrides)
"""

# Wrapper appended to objects that have `function toggleRangeRuler()`  -
# the R button on tokens (POI, Smoke, Bomb Cart, Objective). Per-seat
# routing: Mac players get our vector bands (TOKEN-spec via rangeKey),
# Windows players get the vanilla token bundle (spawnTokenRangeRuler).
# The vanilla function is aliased BEFORE override so Windows-mode clicks
# can fall through to it.
TOKEN_BUTTON_WRAPPER = r"""
-- MAC PATCH per-seat router (token R button)
-- Aliases the vanilla toggleRangeRuler before overriding so Windows-mode
-- players keep spawning the token-specific Range bundle (POI / Smoke /
-- bomb_cart / objective). Mac-mode players get our vector overlay via
-- gRangeTrigger which dispatches to macBuilders.range with the token's
-- rangeKey var.
local _macToggleRangeRulerOriginal = toggleRangeRuler
function toggleRangeRuler(_, playerColor)
    local mode = Global.call("gGetMode", { color = playerColor })
    if mode == "windows" then
        if _macToggleRangeRulerOriginal then
            return _macToggleRangeRulerOriginal()
        end
        return
    end
    if rangeOn then
        Global.call("gClearRange", { figGUID = self.getGUID() })
        rangeOn = false
    else
        -- Clear BEFORE triggering, same rule as the Order Token's COHESION
        -- and RANGE buttons. gRangeTrigger toggles by GUID, and the hover
        -- hotkey writes to the very same key on this token, so without this
        -- the first click on R would turn that overlay OFF while we set
        -- rangeOn = true, leaving the button inverted from then on.
        Global.call("gClearRange", { figGUID = self.getGUID() })
        Global.call("gRangeTrigger", {
            figGUID     = self.getGUID(),
            playerColor = playerColor,
        })
        rangeOn = true
    end
end
-- END MAC PATCH per-seat router (token R button)
"""

TOKEN_BUTTON_WRAPPER_RE = re.compile(
    r"\r?\n-- MAC PATCH per-seat router \(token R button\).*?"
    r"-- END MAC PATCH per-seat router \(token R button\)\r?\n",
    re.DOTALL
)

# List Builder _loadArmyFromJson nil-guard. Stock SWL never nil-checks the
# result of JSON.decode(text) inside importFromText, so any blur of the
# import InputField with empty/invalid text crashes _loadArmyFromJson at
# `data.armyFaction`. The guard is upstream-able. Idempotent via the
# negative lookahead on the marker comment.
LIST_BUILDER_GUARD_RE = re.compile(
    r"(function _loadArmyFromJson\(data\)\r?\n)(?!  -- MAC PATCH: guard )"
)
LIST_BUILDER_GUARD_REPLACEMENT = (
    r"\1"
    "  -- MAC PATCH: guard nil/invalid JSON from onEndEdit blur (upstream bug)\r\n"
    "  if not data then return end\r\n"
)

# Idempotent marker  -  used to detect and remove an existing Mac patch in the
# Global LuaScript before applying a fresh one.
GLOBAL_PATCH_MARKER_RE = re.compile(
    r"\r?\n-- ={5,}\r?\n-- MAC COHESION FALLBACK.*?-- END MAC COHESION FALLBACK\r?\n",
    re.DOTALL
)

# Idempotent markers for the per-seat wrappers added to object scripts.
# Strip these before re-applying to avoid double-wrapping.
COHESION_WRAPPER_RE = re.compile(
    r"\r?\n-- MAC PATCH per-seat router \(Cohesion\).*?"
    r"-- END MAC PATCH per-seat router \(Cohesion\)\r?\n",
    re.DOTALL
)
RANGE_WRAPPER_RE = re.compile(
    r"\r?\n-- MAC PATCH per-seat router \(Range\).*?"
    r"-- END MAC PATCH per-seat router \(Range\)\r?\n",
    re.DOTALL
)
ORDER_TOKEN_OVERRIDES_RE = re.compile(
    r"\r?\n-- MAC PATCH per-seat router \(Order_Token button click overrides\).*?"
    r"-- END MAC PATCH per-seat router \(Order_Token button click overrides\)\r?\n",
    re.DOTALL
)


TARGET_GUIDS = {"99f1c8", "a57c41"}  # Objects with the Cohesion block to replace


def collect_patched_scripts(data: dict) -> list:
    """Return script_states for the TTS External Editor API (Save & Play).

    Includes the Global script and any object script we patched (matching
    TARGET_GUIDS). Format: list of dicts with name, guid, script.
    """
    states = [
        {"name": "Global", "guid": "-1", "script": data.get("LuaScript", "")}
    ]

    def walk(o):
        if isinstance(o, dict):
            guid = o.get("GUID", "").lower()
            if guid in TARGET_GUIDS and "LuaScript" in o:
                states.append({
                    "name":   o.get("Name", guid),
                    "guid":   guid,
                    "script": o["LuaScript"],
                })
            for v in o.values():
                walk(v)
        elif isinstance(o, list):
            for x in o:
                walk(x)

    walk(data)
    return states


def send_to_tts(script_states: list) -> bool:
    """Send a Save & Play (messageID 1) to TTS via the External Editor API.

    Returns True on success, False if TTS isn't listening (likely the API
    is disabled in TTS Configuration).
    """
    msg = {"messageID": 1, "scriptStates": script_states}
    payload = json.dumps(msg).encode("utf-8")
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(3)
        s.connect(("127.0.0.1", 39999))
        s.sendall(payload)
        s.close()
        return True
    except (ConnectionRefusedError, socket.timeout, OSError) as e:
        print(f"  WARN: could not connect to TTS on port 39999 ({e}).")
        print(f"  -> Enable Configuration -> Game Tweaks -> 'External Editor API' in TTS.")
        return False


def patch_object_scripts(data: dict) -> tuple:
    """Walk the JSON tree, replace Cohesion and Range blocks in object scripts.

    Cohesion block: only on TARGET_GUIDS (Unit_Leader, Order_Token).
    Range block: on every object containing the !/RangeRulers include
    (Order_Token, Tokens, POI, bomb_cart, etc.  -  ~20 objects).

    Returns (n_cohesion_patched, n_range_patched).
    """
    n_coh, n_rng = 0, 0

    def walk(o):
        nonlocal n_coh, n_rng
        if isinstance(o, dict):
            guid = o.get("GUID", "").lower()
            if "LuaScript" in o:
                ls = o["LuaScript"]
                changed = False

                # Strip any previous per-seat wrappers so re-runs are idempotent.
                for rx in (COHESION_WRAPPER_RE, RANGE_WRAPPER_RE,
                           ORDER_TOKEN_OVERRIDES_RE, TOKEN_BUTTON_WRAPPER_RE):
                    new_ls, n = rx.subn("", ls)
                    if n > 0:
                        ls = new_ls
                        changed = True

                # Silhouettes are OUT of the toggle's scope (12 aug): their
                # bundles are repaired, so vanilla renders them correctly on
                # both platforms and the Lua fallback is gone. What stays
                # below are fixes to upstream bugs that happen to live on the
                # same objects, none of which branch on the mode.
                new_ls, n = BUTTON_OFFSET_RE.subn(BUTTON_OFFSET_REPLACEMENT, ls)
                if n > 0:
                    ls = new_ls
                    changed = True

                # SIL button rename + forwarder. Bypasses the TTS engine bug
                # where the click_function name "toggleSilhouettes" is
                # silently muted on macOS. Idempotent: replace() is no-op
                # once swap is done, marker check prevents double-injection.
                if SIL_BUTTON_CLICKFN_OLD in ls:
                    ls = ls.replace(SIL_BUTTON_CLICKFN_OLD, SIL_BUTTON_CLICKFN_NEW)
                    changed = True
                if SIL_BUTTON_CLICKFN_NEW in ls and SIL_FORWARDER_MARKER not in ls:
                    ls = ls.rstrip() + '\n' + SIL_FORWARDER
                    changed = True

                # Cohesion: KEEP the original include block, append per-seat
                # wrapper after it. Only Unit_Leader / Order_Token have it.
                if guid in TARGET_GUIDS:
                    def coh_repl(m):
                        return m.group(0) + COHESION_WRAPPER
                    new_ls, n = COHESION_BLOCK_RE.subn(coh_repl, ls, count=1)
                    if n > 0:
                        ls = new_ls
                        n_coh += 1
                        changed = True

                # Silhouette desync fix (any object with clearSilhouette).
                # Guard the nil-attachment case and reset silhouetteState in
                # onload. Idempotent: the regex matches both the vanilla
                # body and our previously-patched body (same shape).
                if "function clearSilhouette()" in ls:
                    new_ls, n = CLEAR_SILHOUETTE_RE.subn(CLEAR_SILHOUETTE_REPLACEMENT, ls, count=1)
                    if n > 0:
                        ls = new_ls
                        changed = True
                    # Inject the state reset at the top of onload.
                    if "MAC PATCH: silhouette reset on load" not in ls:
                        new_ls, n = ONLOAD_OPEN_RE.subn(
                            "function onload()\n" + SIL_ONLOAD_RESET_LINE,
                            ls, count=1,
                        )
                        if n > 0:
                            ls = new_ls
                            changed = True

                # Range: KEEP block, append wrapper. ~21 objects.
                def rng_repl(m):
                    return m.group(0) + RANGE_WRAPPER
                new_ls, n = RANGE_BLOCK_RE.subn(rng_repl, ls, count=1)
                if n > 0:
                    ls = new_ls
                    n_rng += 1
                    changed = True

                # List Builder import guard. Applies to BLUE/RED LIST
                # BUILDER (any object that defines _loadArmyFromJson).
                # Fixes a pre-existing upstream crash where blurring the
                # import InputField with empty/invalid text fires
                # onEndEdit -> importFromText -> JSON.decode("") -> nil ->
                # data.armyFaction crash. Idempotent.
                if "function _loadArmyFromJson(data)" in ls:
                    new_ls, n = LIST_BUILDER_GUARD_RE.subn(
                        LIST_BUILDER_GUARD_REPLACEMENT, ls, count=1
                    )
                    if n > 0:
                        ls = new_ls
                        changed = True

                # Maximum Move spawn (only in Order_Token a57c41)  -  Mac only
                if guid == "a57c41":
                    new_ls, n = MAXMOVE_SPAWN_RE.subn(MAXMOVE_SPAWN_REPLACEMENT, ls, count=1)
                    if n > 0:
                        ls = new_ls
                        changed = True
                    new_ls, n = CLEAR_MOVEMENT_RE.subn(CLEAR_MOVEMENT_REPLACEMENT, ls, count=1)
                    if n > 0:
                        ls = new_ls
                        changed = True
                    # Button click overrides (per-seat capture of playerColor)
                    ls = ls + ORDER_TOKEN_BUTTON_OVERRIDES
                    changed = True

                # Token R button: append toggleRangeRuler override on any
                # object that defines that function (POI, Smoke, BombCart,
                # Objective, etc.). Routes the click to the Mac fallback
                # Range overlay sized via TOKEN_BASE_RADIUS. (Already-applied
                # case is handled by the strip loop above.)
                if "function toggleRangeRuler()" in ls:
                    ls = ls + TOKEN_BUTTON_WRAPPER
                    changed = True

                if changed:
                    o["LuaScript"] = ls

            for v in o.values():
                walk(v)
        elif isinstance(o, list):
            for x in o:
                walk(x)

    walk(data)
    return n_coh, n_rng


ASSETS_BASE_URL = ("https://raw.githubusercontent.com/ironsquadronfr-hub/tts/"
                   "mac-projector-fallback/mod/data/mac-fallback-assets/")
# Flip to https://raw.githubusercontent.com/swlegion/tts/main/mod/data/
# mac-fallback-assets/ right before upstream merge, together with the Lua
# ASSETS_BASE copies (Overlays.ttslua + the inline copy in this file).


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    flags = [a for a in sys.argv[1:] if a.startswith("--")]
    if len(args) != 2:
        print(f"Usage: {sys.argv[0]} <input.json> <output.json> [--reload]")
        sys.exit(1)
    src = Path(args[0])
    dst = Path(args[1])
    reload_tts = "--reload" in flags

    with src.open("r") as f:
        data = json.load(f)

    # Leave SaveName alone: the working save is regenerated from its clean
    # backup on every iteration, and a "[MAC PATCH]" suffix reappeared in the
    # TTS load list each time. Strip a suffix left by an earlier run.
    name = data.get("SaveName") or ""
    if name.endswith("[MAC PATCH]"):
        data["SaveName"] = name[: -len("[MAC PATCH]")].rstrip()

    # Register the Iron Squadron UI sprite for the toggle button (idempotent
    # by Name; macAppleLogo is the retired name and is dropped on the way).
    assets = [a for a in (data.get("CustomUIAssets") or [])
              if a.get("Name") not in ("isqLogo", "macAppleLogo")]
    assets.append({"Type": 0, "Name": "isqLogo",
                   "URL": ASSETS_BASE_URL + "iron_squadron_logo_v2.png"})
    data["CustomUIAssets"] = assets

    # 1. Append manager + handlers to Global LuaScript (idempotent: remove
    # any previous Mac patch block first, then append fresh).
    original_global_len = len(data.get("LuaScript", ""))
    existing = data.get("LuaScript", "")
    cleaned, n_removed = GLOBAL_PATCH_MARKER_RE.subn("", existing)
    # One source of truth for where our own assets live: the Lua block carries
    # a placeholder, filled here from ASSETS_BASE_URL. Flipping to upstream
    # before merge is then a one-line change.
    global_block = GLOBAL_PATCH_LUA.replace("__ISQ_ASSETS_BASE__", ASSETS_BASE_URL)
    if "__ISQ_ASSETS_BASE__" in global_block:
        sys.exit("ASSETS_BASE placeholder left unfilled in the Global block")
    data["LuaScript"] = cleaned + global_block
    new_global_len = len(data["LuaScript"])
    note = " (replaced existing patch)" if n_removed else ""
    print(f"Global LuaScript: {original_global_len} -> {new_global_len} bytes{note}")
    print()

    # 2. Replace Cohesion + Range + Deployment blocks in object scripts.
    print("Object script patches:")
    n_coh, n_rng = patch_object_scripts(data)
    print(f"  Cohesion blocks replaced:   {n_coh}")
    print(f"  Range blocks replaced:      {n_rng}")
    print()

    dst.parent.mkdir(parents=True, exist_ok=True)
    with dst.open("w") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

    print(f"Written: {dst}")
    print(f"  Save Name: {data.get('SaveName', '?').strip()}")
    print(f"  Version: {data.get('VersionNumber', '?')}")


    if reload_tts:
        print()
        print("Hot-reloading into TTS via External Editor API...")
        states = collect_patched_scripts(data)
        print(f"  Sending {len(states)} script(s): "
              + ", ".join(f"{s['name']}({s['guid']})" for s in states))
        if send_to_tts(states):
            print("  OK Sent. TTS should restart Lua with the new code "
                  "(table/objects state preserved).")


if __name__ == "__main__":
    main()

-- Bomb Cart Token
-- It acts both as a miniature *and* a command token (for itself).

function onLoad()
  clearRangeRuler()
  hideUI()
end

function onPickedUp()
  clearRangeRuler()
end

function onDropped()
  
end

function hideUI()
  self.clearButtons()
  clearRangeRuler()
  menuOpen = false
  self.createButton({
      click_function = "toggleMenu",
      function_owner = self,
      label = "Interact",
      position = {0, 0.1, 1.5},
      scale = {0.5, 0.5, 0.5},
      width = 800, height = 300,
      font_size = 200, color = {0, 0, 0, 0.8},
      font_color = {0.1212, 0.8127, 0, 1},
      tooltip = "Move the cart or show range rulers."
  })
end

function showUI()
  menuOpen = true
  self.clearButtons()
  self.createButton({
      click_function = "closeMenu",
      function_owner = self,
      label = "X            ",
      position = {-1.6, 0.2, -1.2},
      width = 850,
      height = 350,
      font_size = 150,
      color = {0, 0, 0, 1},
      font_color = {1, 0.9135, 0, 1},
      tooltip = "Cancel",
  })
  self.createButton({
      click_function = "spawnMoveTemplate",
      function_owner = self,
      label = "  MOVE",
      position = {1.7, 0.2, 0.4},
      width = 750,
      height = 350,
      font_size = 150,
      color = {0, 0, 0, 1},
      font_color = {0.9167, 0.9167, 0.9167, 1},
      tooltip = "Spawn movement template."
  })
  self.createButton({
      click_function = "toggleRangeRuler",
      function_owner = self,
      label = "  RANGE",
      position = {1.7, 0.2, -0.4},
      width = 750,
      height = 350,
      font_size = 150,
      color = {0, 0, 0, 1},
      font_color = {0.4709, 0.9759, 0.9162, 1},
      tooltip = "Spawn Range Ruler"
  })
end

function toggleMenu()
  if menuOpen then
    hideUI()
  else
    showUI()
  end
end

function closeMenu()
  hideUI()
end

function toggleRangeRuler()
  if rangeRuler == nil then
    spawnRangeRuler()
  else
    clearRangeRuler()
  end
end

function spawnMoveTemplate()
end

function spawnRangeRuler()
    clearRangeRuler()
    local basePos = self.getPosition()
    local baseRot = self.getRotation()

    -- Medium base.
    local baseSize = 1.9685 / 2
    rangeRuler = {}

    for i = 1, 2, 1 do
      rangeRuler[i] = spawnObject({
          type = "Custom_Model",
          position = basePos,
          rotation = {0, baseRot.y, 0},
          scale = {i * 6 + baseSize, 3, i * 6 + baseSize}
      })
      rangeRuler[i].setCustomObject({
          type = 0,
          mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862835239/0858A62DF9F9E7DCB49B641E4938111697E4F3D4/",
          collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
          material = 1,
      })
      rangeRuler[i].setLock(true)
      rangeRuler[i].setName("Range Ruler")
      rangeRuler[i].setColorTint({0.7, 0.7, 0.7})
    end
end

function clearRangeRuler()
  if rangeRuler != nil then
    for i = 1, 2, 1 do
      destroyObject(rangeRuler[i])
    end
  end
  rangeRuler = nil
end


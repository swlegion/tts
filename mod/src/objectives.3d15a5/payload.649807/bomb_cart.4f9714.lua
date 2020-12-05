-- RED BOMB CART

-- Used when spawned by the define battlefield workflow.
position = {48.97, 0.95, 15.19}
rotation = {0.00, 270.03, 0.00}

scripted = true

-- Bomb Cart Token
-- It acts both as a miniature *and* a command token (for itself).
function onLoad()
  -- Medium base and movement states.
  moveState = false
  baseSize = "medium"
  selectedSpeed = 2

  -- Initial setup.
  templateInfo = Global.getTable("templateInfo")
  clearRangeRuler()
  hideUI()
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
      click_function = "finishInteraction",
      function_owner = self,
      label = "X            ",
      position = {-1.6, 0.2, -1.2},
      width = 850,
      height = 350,
      font_size = 150,
      color = {0, 0, 0, 1},
      font_color = {1, 0.9135, 0, 1},
      tooltip = "Close",
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
    moveForward = true
    showUI()
  end
end

function finishInteraction()
  if moveState then
    hideMoveTemplate()
  end
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
  -- Setup
  self.editButton({
      index = 1,
      click_function = "hideMoveTemplate",
      label = "  DONE",
      color = {0.7, 0.03, 0.03},
      font_color = {1, 1, 1}
  })

  initPos = self.getPosition()
  initRot = self.getRotation()
  moveState = true

  local basePos = self.getPosition()
  basePos.y = basePos.y + 0.05
  local baseRot = self.getRotation()

  -- Spawn template A and B.
  local modelTemplateA = getObjectFromGUID(templateInfo.modelTemplateAGUID)
  local luaScript = [[
    unitInfo = {
      baseSize = '%s',
      selectedSpeed = %s
    }
    %s
  ]]

  local aStart = templateInfo.aStart[baseSize][selectedSpeed]
  local bStart = templateInfo.bStart[baseSize][selectedSpeed]

  local q = math.rad(baseRot.y)
  local a = aStart * math.cos(q)
  local b = aStart * math.sin(q)
  local aEx = bStart * math.cos(q)
  local bEx = bStart * math.sin(q)

  templateA = spawnObject({
      type = "Custom_Model",
      position = {basePos.x - b, basePos.y, basePos.z - a},
      rotation = {0, baseRot.y + 180, 0},
      scale = {1,1,1}
  })
  templateA.setCustomObject({
      type = 0,
      mesh = templateInfo.moveTemplate[selectedSpeed].mesh[baseSize],
      diffuse = templateInfo.moveTemplate[selectedSpeed].diffuse,
      collider = templateInfo.moveTemplate[selectedSpeed].longCollider,
      material = 1,
  })

  templateA.setPosition({basePos.x - b, basePos.y, basePos.z - a})
  templateA.setRotation({0, baseRot.y + 180, 0})
  templateA.setLuaScript(string.format(
    luaScript,
    baseSize, selectedSpeed, modelTemplateA.getLuaScript()
  ))
  templateA.sticky = false
  templateA.setName("Movement Template")
  templateA.setColorTint(templateInfo.moveTemplate[selectedSpeed].colorTint)

  local modelTemplateB = getObjectFromGUID(templateInfo.modelTemplateBGUID)

  templateB = spawnObject({
      type = "Custom_Model",
      position = {basePos.x - bEx, basePos.y, basePos.z - aEx},
      rotation = {0, baseRot.y, 0},
      scale = {1,1,1}
  })
  templateB.setCustomObject({
      type = 0,
      mesh = templateInfo.moveTemplate[selectedSpeed].mesh[baseSize],
      diffuse = templateInfo.moveTemplate[selectedSpeed].diffuse,
      collider = templateInfo.moveTemplate[selectedSpeed].shortCollider,
      material = 1,
  })

  templateB.setPosition({basePos.x - bEx, basePos.y, basePos.z - aEx})
  templateB.setRotation({0, baseRot.y, 0})
  templateB.setLuaScript(string.format(
    luaScript,
    baseSize, selectedSpeed, modelTemplateB.getLuaScript()
  ))
  templateB.sticky = false
  templateB.setName("Movement Template")
  templateB.setColorTint(templateInfo.moveTemplate[selectedSpeed].colorTint)

  -- Configure spawned templates.
  templateA.setTable("basePos", basePos)
  templateA.setTable("baseRot", baseRot)
  templateA.setVar("templateB", templateB)
  templateA.setLock(true) -- Fixed arc.

  templateB.setTable("basePos", basePos)
  templateB.setTable("baseRot", baseRot)
  templateB.setVar("templateA", templateA)
  templateB.setLock(false)

  -- TODO: Finish.
  self.createButton({
      click_function = "moveFull",
      function_owner = self,
      label = "FULL",
      position = {4.2, 0.2, 1.2}, width = 700, height = 350, font_size = 200, color = {0, 0, 0, 1}, font_color = {0.0551, 0.9312, 0, 1},
      tooltip = "Execute Full Move"
  })
  self.createButton({
      click_function = "moveStart",
      function_owner = self,
      label = "START",
      position = {4.2, 0.2, 0.4}, width = 700, height = 350, font_size = 200, color = {0, 0, 0, 1}, font_color = {0, 0.9294, 0.8752, 1},
      tooltip = "Move back to start position"
  })
end

function moveFull()
  if templateB != nil then
      local startPos = templateB.getPosition()
      local startRot = templateB.getRotation()
      local aStart = templateInfo.aStart[baseSize][selectedSpeed]
      local endPos = translatePos(startPos, startRot, aStart, 0)
      endPos.y = endPos.y + 2
      local endRot = startRot

      self.setPositionSmooth(endPos, false, false)
      self.setRotationSmooth(startRot, false, false)
  end
end

function moveStart()
  local endPos = initPos
  endPos.y = initPos.y + 2
  self.setPositionSmooth(endPos, false, false)
  self.setRotationSmooth(initRot, false, false)
end

function hideMoveTemplate()
  if templateA != nil then
    destroyObject(templateA)
    templateA = nil
  end
  if templateB != nil then
    destroyObject(templateB)
    templateB = nil
  end
  moveState = false
  showUI()
end

function spawnRangeRuler()
    clearRangeRuler()
    local basePos = self.getPosition()
    local baseRot = self.getRotation()
    local mediumBase = 1.9685 / 2
    rangeRuler = {}

    for i = 1, 2, 1 do
      rangeRuler[i] = spawnObject({
          type = "Custom_Model",
          position = basePos,
          rotation = {0, baseRot.y, 0},
          scale = {i * 6 + mediumBase, 3, i * 6 + mediumBase}
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

    rangeRuler[1].setColorTint({0.7, 0.7, 0.7})
    rangeRuler[2].setColorTint({0.1, 0.1, 0.1})
end

function clearRangeRuler()
  if rangeRuler != nil then
    for i = 1, 2, 1 do
      destroyObject(rangeRuler[i])
    end
  end
  rangeRuler = nil
end

function translatePos(originPos,originRot,distance, angle)
    local pos = originPos
    local rot = originRot

    local a = distance * math.cos(math.rad(angle + rot.y))
    local b = distance * math.sin(math.rad(angle + rot.y))

    pos.x = pos.x - b
    pos.z = pos.z - a

    return pos
end




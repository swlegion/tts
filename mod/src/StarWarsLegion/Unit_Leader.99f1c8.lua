require('!/Cohesion')

-- Model mini
function onload()
    if self.getName() ~= "Unit Leader" then
        isAMini = true
        setUp()
    end
end

function setUp()
    templateInfo = Global.getTable("templateInfo")

    moveState = false
    silhouetteState = false
    locks = {}
    lockState = false
    startPosition = nil
    startRotation = nil

    lockBtnGreen = {0.2, 0.9, 0.05, 0.7}
    lockBtnRed = {0.9, 0.1, 0.05, 0.7}

    if unitName and colorSide then
        unitData = {}
        unitData.commandType = commandType
        unitData.baseSize = baseSize
        unitData.selectedSpeed = selectedSpeed

        local unitCountPos = {}
        unitCountPos.small = {-0.3, 0.2, 0.2}
        unitCountPos.medium = {-0.4, 0.2, 0.5}
        unitCountPos.large = {0,0.2,1}
        unitCountPos.laat = {0,0.2,1.4}
        unitCountPos.huge = {0,0.2,1.6}
        unitCountPos.long = {0,0.2,3}
        unitIDButtonPos = unitCountPos[unitData.baseSize]

        resetUnitButtons()
    end
end

function resetUnitButtons()
    self.clearButtons()
    data = {click_function = "clearCohesionRuler", function_owner = self, label = unitID, position = unitIDButtonPos , scale = {0.5, 0.5, 0.5}, width = 1, height = 1, font_size = 300, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {1, 1, 1, 100}}

    addLockButton()
    self.createButton(data)
    addSilhouetteButton()
end

function calculateButtonZOffset(baseDiameter)
   return ((baseDiameter * 0.5) + 0.1)
end

function addSilhouetteButton()
  local gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
  local btnTint = gameData.getTable("battlefieldTint")
  local buttonOffset = calculateButtonZOffset(templateInfo.baseRadius[unitData.baseSize])
  btnData = {
    click_function = "toggleSilhouettes",
    function_owner = self,
    label = "SIL",
    tooltip = "Toggle silhouettes on this unit",
    position = {-0.225,0.25, buttonOffset},
    width = 230,
    height = 180,
    font_size = 100,
    color= {btnTint["r"], btnTint["g"], btnTint["b"], 0.7},
    font_color= {1, 1, 1, 100}
  }
  self.createButton(btnData)
end

function addLockButton()
    local gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
    local btnTint = gameData.getTable("battlefieldTint")
    local templateInfo = Global.getTable("templateInfo")
    local buttonOffset = calculateButtonZOffset(templateInfo.baseRadius[unitData.baseSize])
    lockBtnData = {
        click_function = "toggleLockButton",
        function_owner = self,
        label = "LCK",
        tooltip = "Toggle Physics Lock on this unit",
        position = {0.225, 0.25, buttonOffset},
        width = 230,
        height = 180,
        font_size = 100,
        color = lockBtnGreen,
        font_color= {1, 1, 1, 100}
    }
    self.createButton(lockBtnData)
end

function updateLockBtnColor()
    if isLocked() then
        self.editButton({
            index = 0,
            color = lockBtnRed
        })
    else
        self.editButton({
            index = 0,
            color = lockBtnGreen
        })
    end
end

function toggleLockButton()
   if not isLocked() then
      toggleLock("UnitLockButton")
   else
      removeAllLocks()
   end
end

function evaluateLocks()
   local newValue = isLocked()
   
   for k, guid in pairs(miniGUIDs) do
        local obj = getObjectFromGUID(guid)
        if obj ~= nil then
            obj.locked = newValue
        end
   end
   updateLockBtnColor()
end

function isLocked()
   if locks ~= nil then
      for i, value in pairs(locks) do
         if value == true then
            return true
         end
      end
   end
   return false
end

function tryAddLock(lockName)
   locks[lockName] = true
   evaluateLocks()
end  

function tryRemoveLock(lockName)
   locks[lockName] = false
   evaluateLocks()
end  

function removeAllLocks(lockName)
   if locks ~= nil then
      for key, value in pairs(locks) do
         locks[key] = false
      end
   end
   evaluateLocks()
end

function toggleLock(lockName)
   local hasLock = locks[lockName] ~= nil
   if hasLock then
      local currentValue = locks[lockName]
      if currentValue == true then
         locks[lockName] = false
      else
         locks[lockName] = true
      end
   else
      locks[lockName] = true
   end
   evaluateLocks()
end

function toggleSilhouettes()
  if silhouetteState then
    clearSilhouette()
  else
    showSilhouette()
  end
end

-- Loops through all minis in the unit
-- Removes all attachments and destroys the first one
-- The silhouette should be the only attachment, so this should be safe to do
function clearSilhouette()
  for k, guid in pairs(miniGUIDs) do
    local obj = getObjectFromGUID(guid)

    -- Guard against players who delete their minis!
    if obj then
      local silToDestroy = obj.removeAttachments()[1]
      silToDestroy.destruct()
    end
  end
  silhouetteState = false
end

-- Loops through all minis in the unit
-- Spawns a silhouette at the pos and rot of each one
-- and attaches them using the new attachment feature
function showSilhouette()
  for k, guid in pairs(miniGUIDs) do
    local obj = getObjectFromGUID(guid)

    -- Guard against players who delete their minis!
    if obj then
      local pos = obj.getPosition()
      local rot = obj.getRotation()
      local newSilhouette = spawnSilhouette(obj, pos, rot)
    end
  end
  silhouetteState = true
end

function spawnSilhouette(obj, pos, rot)
  local globals = Global.getTable("templateInfo")
  local scale = globals.baseRadius[unitData.baseSize]
  local height = 1.0
  local offset = 0.0
  local silhouetteData = "http://cloud-3.steamusercontent.com/ugc/5063766435505471684/D97103C9FFB76016DDF9CE66A7622BDB3E810160/"
  if silhType == "custom" then
    height = silhHeight
    offset = silhOffset
    if unitData.baseSize == "snail" then
      silhouetteData = "http://cloud-3.steamusercontent.com/ugc/5063766435505471854/AE2D411CFBF4D88321CAD0D75961CBF0512D62E4/"
      scale = 1.0
    end
    if unitData.baseSize == "long" then
      silhouetteData = "http://cloud-3.steamusercontent.com/ugc/5063766435505471800/DF511A83E913EBA164F74E20BA239AE286458D91/"
      scale = 1.0
    end
  else    
    if unitData.baseSize == "small" then
      height = globals.silhouetteHeight["small"]
    else
      height = globals.silhouetteHeight["notched"]
    end
  end
  if obj ~= nil then
    local objUp = obj.getTransformUp()
    local offsetVector = Vector.new(objUp.x * offset, objUp.y * offset, objUp.z * offset)
    pos = { pos.x + offsetVector.x, pos.y + offsetVector.y, pos.z + offsetVector.z }
  end
  

  local silhouette = spawnObject({
    type = "Custom_AssetBundle",
    position = pos,
    rotation = rot,
    scale = {scale,height,scale}
  })
  silhouette.setCustomObject({
      assetbundle = silhouetteData,
      material = 3
  })
  silhouette.setColorTint({0.47,0.76,0.8,0.3})
  if obj ~= nil then
    obj.addAttachment(silhouette)
  end
  return silhouette
end

function onDropped(player_color)
    checkVelocity()
end

function checkVelocity()
    local hasNonLeaderMinis = #miniGUIDs > 1
    if moveState == true and hasNonLeaderMinis then
        startLuaCoroutine(self, "dropCoroutine")
    end
end

function onPickedUp(player_color)
    clearCohesionRuler()
end

function dropCoroutine()
    while self.getVelocity().y ~= 0 do
        coroutine.yield(0)
    end
    if moveState == true then
        spawnCohesionRuler(self)
    end
    return 1
end


function setStartPos()
  startPosition = self.getPosition()
  startRotation = self.getRotation()
end

function printMovement()
  if startPosition == self.getPosition() and startRotation == self.getRotation() then
    return
  end
  if startPosition ~= nil then
    print(colorSide .. " " .. unitName .. " Moved From")
    print("Position " .. coordToString(startPosition) .. " to " .. coordToString(self.getPosition()))
    print("Rotation " .. coordToString(startRotation) .. " to " .. coordToString(self.getRotation()))
  end
end

function coordToString(coord, rotation)
  return "(X:" .. round(coord[1], 2) .. ", Y:" .. round(coord[2], 2) .. ", Z:" .. round(coord[3], 2) .. ")"
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


#include !/data/CohesionLinks

-- Model mini
function onLoad()
    if self.getName() != "Unit Leader" then
        isAMini = true
        setUp()
    end
end

function setUp()
    templateInfo = Global.getTable("templateInfo")
    cardInfo = Global.getTable("cardInfo").unitCards

    moveState = false
    silhouetteState = false

    if unitName != nil and colorSide != nil then
        local baseSize = cardInfo[unitName].baseSize
        local fixed = baseSize != 'small'

        unitData = {}
        unitData.commandType = cardInfo[unitName].commandType
        unitData.baseSize = baseSize
        unitData.fixedMove = fixed
        unitData.fixedArc = fixed
        unitData.selectedSpeed = cardInfo[unitName].selectedSpeed

        if cardInfo[unitName].strafeMove != nil then
              unitData.strafeMove = true
        else
              unitData.strafeMove = false
        end

        -- set info
        unitData.aStart = templateInfo.aStart[unitData.baseSize][unitData.selectedSpeed]
        unitData.bStart = templateInfo.bStart[unitData.baseSize][unitData.selectedSpeed]

        unitData.templateMesh = templateInfo[unitData.selectedSpeed]
        unitData.templateCollider = templateInfo.templateCollider
        unitData.tint = templateInfo.tint[unitData.selectedSpeed]
        unitData.buttonPosition = templateInfo.buttonPosition[unitData.selectedSpeed]
        unitData.buttonColor = templateInfo.buttonColor[unitData.selectedSpeed]
        unitData.fontColor = templateInfo.fontColor[unitData.selectedSpeed]
        unitData.cohesionRadius = templateInfo.cohesionRadius[unitData.baseSize]

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

    self.createButton(data)
    if unitData.baseSize == "small" then
      addSilhouetteButton()
    end
end

function addSilhouetteButton()
  local gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
  local btnTint = gameData.getTable("battlefieldTint")
  btnData = {
    click_function = "toggleSilhouettes",
    function_owner = self,
    label = "SIL",
    tooltip = "Toggle silhouettes on this unit",
    position = {0,0.25,0.6},
    width = 230,
    height = 180,
    font_size = 100,
    color= {btnTint["r"], btnTint["g"], btnTint["b"], 0.7},
    font_color= {1, 1, 1, 100}
  }
  self.createButton(btnData)
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
      local newSilhouette = spawnSilhouette(pos, rot)

      obj.addAttachment(newSilhouette)
    end
  end
  silhouetteState = true
end

function spawnSilhouette(pos, rot)
  local silhouetteData = {
    mesh = "http://cloud-3.steamusercontent.com/ugc/1002556771691273590/F435C238FB9E1E49963B2AA00E09DF9C711DA4A0/",
    diffuse = "http://cloud-3.steamusercontent.com/ugc/1003681898505462981/13937CB26573918BDCBDE2A13CCDEF3C966172D7/",
    collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/"
  }
  local silhouette = spawnObject({
    type = "Custom_Model",
    position = pos,
    rotation = rot,
    scale = {1,1,1}
  })
  silhouette.setCustomObject({
      mesh = silhouetteData.mesh,
      collider = silhouetteData.collider,
      type = 1,
      material = 3
  })
  silhouette.setColorTint({121/255,194/255,205/255,100/255})

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
    while self.getVelocity().y != 0 do
        coroutine.yield(0)
    end
    if moveState == true then
        spawnCohesionRuler()
    end
    return 1
end

function spawnCohesionRuler()
    if cohesionRuler ~= nil then
        clearCohesionRuler()
    end

    local cohesionBundlesTable = getCohesionLinks()
    local baseSize = unitData.baseSize
    local cohesionBundleToSpawn = cohesionBundlesTable[baseSize]

    if cohesionBundleToSpawn == nil then return end

    local basePos = self.getPosition()
    local baseRot = self.getRotation()

    cohesionRuler = spawnObject({
        type="Custom_AssetBundle",
        position = {basePos.x, basePos.y + 20, basePos.z},
        rotation = {0, baseRot.y, 0},
        scale = {0,0,0} -- 0 scale will hide TTS default box and won't impact projector
    })

    cohesionRuler.setCustomObject({
        type = 0,
        assetbundle = cohesionBundleToSpawn
    })

    cohesionRuler.setLock(true)
    cohesionRuler.use_gravity = false
    cohesionRuler.setName("Cohesion Ruler")
end

function clearCohesionRuler()
    if cohesionRuler ~= nil then
        cohesionRuler.destruct()
        cohesionRuler = nil
    end
end

-- Model mini
function onLoad()
    if self.getName() != " " then
        isAMini = true
        local timerCounter = Global.getVar("timerCounter")
        timerCounter = timerCounter + 1
        Global.setVar("timerCounter", timerCounter)

        Timer.create({
            identifier     = "ModelMini".. math.random().. timerCounter.. self.getGUID(),
            function_name  = "setUp",
            function_owner = self,
            delay          = 2
        })
    end
end

function setUp()

    templateInfo = {}
    templateInfo = Global.getTable("templateInfo")

    unitInfo = {}
    unitInfo = Global.getTable("unitInfo")

    moveState = false
    silhouetteState = false


    if unitName != nil and colorSide != nil then

        unitData = {}
        unitData.commandType = unitInfo[unitName].commandType
        unitData.baseSize = unitInfo[unitName].baseSize
        unitData.fixedMove = unitInfo[unitName].fixedMove
        unitData.selectedSpeed = unitInfo[unitName].selectedSpeed
        unitData.fixedArc = unitInfo[unitName].fixedArc
        unitData.squadStatus = unitInfo[unitName].squadStatus
        if unitInfo[unitName].strafeMove != nil then
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
        unitData.buttonHeight = templateInfo.buttonHeight[unitData.selectedSpeed]
        unitData.cohesionRadius = templateInfo.cohesionRadius[unitData.baseSize]

        unitIDButtonPos = unitInfo.unitCountPos[unitData.baseSize]

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
    if moveState == true and unitData.squadStatus == true then
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
    if cohesionRuler == nil then
        cohesionRuler = spawnObject({
            type="Custom_Model",
            position = self.getPosition(),
            scale={unitData.cohesionRadius,3,unitData.cohesionRadius}
        })
        cohesionRuler.setCustomObject({
            type=0,
            mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862867182/0858A62DF9F9E7DCB49B641E4938111697E4F3D4/",
            collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
            material=1,
        })
        cohesionRuler.setLock(true)
        cohesionRuler.setColorTint({0.5,0.5,0.5})
        cohesionRuler.setName("Cohesion Ruler")

    end

end

function clearCohesionRuler()
    if cohesionRuler != nil then
        destroyObject(cohesionRuler)
    end
end

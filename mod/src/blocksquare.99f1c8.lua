-- Model mini
function onLoad()
    if self.getName() != " " then
        isAMini = true
        local timerCounter = Global.getVar("timerCounter")
        timerCounter = timerCounter + 1
        Global.setVar("timerCounter", timerCounter)
        silhouetteModelGUID = Global.getVar("silhouetteModelGUID")

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
        addSilhouetteButton()
        silhouette = nil
    end
end

function resetUnitButtons()
    self.clearButtons()
    data = {click_function = "clearCohesionRuler", function_owner = self, label = unitID, position = unitIDButtonPos , scale = {0.5, 0.5, 0.5}, width = 1, height = 1, font_size = 300, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {1, 1, 1, 100}}

    self.createButton(data)
end

function addSilhouetteButton()
  local buttonPos = {0, -0.1, 0}
  local silhouetteButtonData = {
    click_function = "toggleSilhouette",
    function_owner = self,
    label = "Sil",
    position = buttonPos,
    scale = {0.5, 0.5, 0.5},
    rotation = {0, 0, 180},
    width = 600,
    height = 500,
    font_size = 300,
    color = {0, 0, 1, 1},
    font_color = {1, 1, 1, 1}
  }
  self.createButton(silhouetteButtonData)
end

function toggleSilhouette()
  local pastePosition = self.getPosition()
  -- if silhouette exists
  if silhouette then
    -- destroy it
    silhouette.destruct()
    -- set silhouette to nil
    silhouette = nil
  else
    -- if it doesn't exists
    -- copy the original
    copy({getObjectFromGUID(silhouetteModelGUID)})
    -- paste and set silhouette to the new object
    silhouette = paste({position = pastePosition})[1]
    silhouette.interactable = false
    silhouette.setLock(false)
  end
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

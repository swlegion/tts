position = {x = 6.14904069900513, y = 1.25186347961426, z = 12.6362247467041}
rotation = {x = 0.827183246612549, y = 0.00316227856092155, z = 358.138641357422}

scripted = true
colorSide = 'blue'
miniName = 'Rebel Trooper Leader'
miniGUIDs = {}
miniGUIDs[1] = 'dc5330'
miniGUIDs[2] = 'c16de7'
miniGUIDs[3] = '36bbad'
miniGUIDs[4] = '7d47a0'
miniGUIDs[5] = '1a817d'
cardGUID = '385586'
unitName = 'rebelTrooper'
unitID = 1
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



    if unitName != nil and colorSide != nil then

        unitData = {}
        unitData.commandType = unitInfo[unitName].commandType
        unitData.baseSize = unitInfo[unitName].baseSize
        unitData.fixedMove = unitInfo[unitName].fixedMove
        unitData.selectedSpeed = unitInfo[unitName].selectedSpeed
        unitData.fixedArc = unitInfo[unitName].fixedArc
        unitData.squadStatus = unitInfo[unitName].squadStatus

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
    spawnCohesionRuler()
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










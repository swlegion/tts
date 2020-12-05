position = {x = 8.43317890167236, y = 0.986534774303436, z = -24.7742557525635}
rotation = {x = 2.43992308242014E-05, y = 179.982406616211, z = 1.55240104504628E-05}

scripted = true
unitName = 'darthVader'
commandType = 'imperialCommander'
colorSide = 'red'
-- Model Token

function onLoad()

    -- LOAD VALUES
    battlefieldTint = Global.getTable("battlefieldTint")
    existingTint = battlefieldTint
    battlefieldZone = getObjectFromGUID(Global.getVar("battlefieldZoneGUID"))
    unitInfo = Global.getTable("unitInfo")
    templateInfo = Global.getTable("templateInfo")
    dieRollerInfo = Global.getTable("dieRollerInfo")
    tintedRed = false
    highlightTints = Global.getTable("highlightTints")

    -- set info
    inBattlefield = false
    dieNumber = 1
    defenceDieNumber = 1
    atkDieNumber = 1
    dieObjs = nil
    selectedUnit = nil
    activated = false


    moveStatus = true

    -- setUp

    unitData = {}
    if self.getName() != " " then
        isAToken = true
        unitData.unitName = unitName
        unitData.tokenCommandType = unitInfo[unitData.unitName].commandType

        unitData.baseSize = unitInfo[unitData.unitName].baseSize
        unitData.fixedMove = unitInfo[unitData.unitName].fixedMove
        unitData.selectedSpeed = unitInfo[unitData.unitName].selectedSpeed
        unitData.fixedArc = unitInfo[unitData.unitName].fixedArc
        unitData.squadStatus = unitInfo[unitData.unitName].squadStatus

        dieRoller = getObjectFromGUID(dieRollerInfo[colorSide.."DieRollerGUID"])

        setTemplateVariables()
        initialize()
    end

end


function waitToStandby(waitTime)
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier = "timerStandby"..timerCounter,
        function_name = "standby",
        function_owner = self,
        delay = waitTime
    })

end

--
function setTemplateVariables()
    unitData.aStart = templateInfo.aStart[unitData.baseSize][unitData.selectedSpeed]
    unitData.bStart = templateInfo.bStart[unitData.baseSize][unitData.selectedSpeed]

    unitData.templateMesh = templateInfo.templateMesh[unitData.selectedSpeed]
    unitData.templateBallCollider = templateInfo.templateBallCollider
    unitData.tint = templateInfo.tint[unitData.selectedSpeed]
    unitData.buttonPosition = templateInfo.buttonPosition[unitData.selectedSpeed]
    unitData.buttonColor = templateInfo.buttonColor[unitData.selectedSpeed]
    unitData.fontColor = templateInfo.fontColor[unitData.selectedSpeed]
    unitData.buttonHeight = templateInfo.buttonHeight[unitData.selectedSpeed]
end
------------------------------------------------- MATH FIND PROXIMITY------------------------------------------------------------
function findProximity(targetObj, object)
    local objectPos = object.getPosition()
    local targetPos = targetObj.getPosition()

    local xDistance = math.abs(targetPos.x - objectPos.x)
    local zDistance = math.abs(targetPos.z - objectPos.z)
    local distance = xDistance^2 + zDistance^2
    return math.sqrt(distance)
end




------------------------------------------------- getSelectedUnit() ------------------------------------------------------------
function getEligibleUnit()
    eligibleUnits = nil
    eligibleUnits = {}
    eligibleUnitsNumber = 0
    selectedUnitObj = nil

    local allUnits = nil
    local allUnits = battlefieldZone.getObjects()


    if allUnits != nil then
        local closestDistance = 9999999999999

        -- check all units
        for i, unit in pairs(allUnits) do
            -- check eligibility

            if unit.getTable("unitData") != nil then

                if unit.getTable("unitData").commandType == unitData.tokenCommandType and unit.getVar("colorSide") == colorSide then


                    -- add to eligible units
                    eligibleUnitsNumber = eligibleUnitsNumber + 1
                    eligibleUnits[eligibleUnitsNumber] = unit

                    -- find distance
                    local distance = findProximity(self, unit)


                    if distance < closestDistance then
                        selectedUnitObj = unit
                        selectedUnitNumber = eligibleUnitsNumber
                        closestDistance = distance

                    end
                end
            end

        end
        -- if success
        if selectedUnitObj != nil then

            getSelectedUnitObjVariables()
            setTemplateVariables()

        end
    end
end

function highlightUnit(selectedMiniGUIDs, highlightColor)
    for k, guidEntry in pairs(selectedMiniGUIDs) do
        obj = getObjectFromGUID(guidEntry)
        if obj != nil then
            obj.highlightOn(highlightColor)
        end
    end
end

function unhighlightUnit(selectedMiniGUIDs)
    if selectedMiniGUIDs != nil then
        for k, guidEntry in pairs(selectedMiniGUIDs) do
            obj = getObjectFromGUID(guidEntry)
            if obj != nil then
                obj.highlightOff()
            end
        end
    end
end

function highlightCard(selectedUnitCard)
    if selectedUnitCard != nil then
        selectedUnitCard.highlightOn({0,1,0})
    end
end

function forceUnhighlight()
    local allObjs = getAllObjects()
    for _, obj in pairs(allObjs) do
        obj.highlightOff()
    end
end


function unHighlightCard(selectedUnitCard)
    if selectedUnitCard != nil then
        selectedUnitCard.highlightOff()
    end
end

function getSelectedUnitObjVariables()
    if selectedUnitObj != nil then
        newUnitData = selectedUnitObj.getTable("unitData")

        unitData.baseSize = newUnitData.baseSize
        unitData.fixedMove = newUnitData.fixedMove
        unitData.selectedSpeed = newUnitData.selectedSpeed
        unitData.fixedArc = newUnitData.fixedArc
        unitData.squadStatus = newUnitData.squadStatus
    end
end



------------------------------------------------- ON ENTER/LEAVE BATTLEFIELD ------------------------------------------------------------
function onObjectEnterScriptingZone(zone, enter_object)
    if self.getName() != "" then
        if enter_object != nil and zone == battlefieldZone and enter_object.getTable("unitData") != nil then
            if enter_object.getTable("unitData").commandType == unitData.tokenCommandType and enter_object.getVar("colorSide") == colorSide then
                waitToStandby(0.1)
            end
        end
    end

end

function onObjectLeaveScriptingZone(zone, leave_object)
    if self.getName() != "" then
        if leave_object != nil and zone == battlefieldZone and leave_object.getTable("unitData") != nil then
            if leave_object.getTable("unitData").commandType == unitData.tokenCommandType and leave_object.getVar("colorSide") == colorSide then
                waitToStandby(0.1)
            end
        end
    end
end


------------------------------------------------- STANDBY ------------------------------------------------------------
function initialize()

    activated = false
    getEligibleUnit()

    createStandbyButtons()

end

function createStandbyButtons()
    if selectedUnitObj != nil then
        self.createButton({
            click_function = "activate",
            function_owner = self,
            label = "ACT", position = {0, 0.05, 0.4}, width = 350, height = 250, font_size = 120, color = {0.03, 0.6, 0.03, 1}, font_color = {1, 1, 1, 1},
            tooltip = "Activate nearest " .. unitData.tokenCommandType .. " unit",
            color = {0.03, 0.6, 0.03}
        })
    else

        self.createButton({
            click_function = "standby",
            function_owner = self,
            label = "",
            position = {0, 0.05, 0.4}, width = 350, height = 250,
            font_size = 150,
            tooltip = "No unit of this type left on board",
            color = {0.6, 0.03, 0.03},
            font_color = {1, 1, 1}
        })
    end
end

function standby()

    activated = false
    self.clearButtons()
    clearTemplates()
    forceUnhighlight()

    getEligibleUnit()

    createStandbyButtons()
end
------------------------------------------------- ACTIVATE ------------------------------------------------------------
function activate()
    getEligibleUnit()
    if selectedUnitObj != nil then
        moveDirection = "forward"
        activated = true
        self.clearButtons()
        getSelectedUnitObjVariables()
        setTemplateVariables()

        highlightUnit(selectedUnitObj.getTable("miniGUIDs"),{0,1,0})
        highlightCard(getObjectFromGUID(selectedUnitObj.getVar("cardGUID")))

        resetButtons()
    else
        standby()
    end

end
------------------------------------------------- ResetButtons------------------------------------------------------------
function resetButtons()
    self.clearButtons()
    if selectedUnitObj != nil then

        self.createButton({
            click_function = "nextUnit",
            function_owner = self,
            label = "NEXT",
            position = {0, 0.2, -1.2},
            width = 550,
            height = 350,
            font_size = 150,
            tooltip = "Toggle between " .. selectedUnitObj.getName() .. " Units",
            font_color = {0,0,0},
            color = {1, 0.9946, 0, 1}
        })

        self.createButton({
            click_function = "moveUnit",
            function_owner = self,
            label = "  MOVE",
            position = {1.7, 0.2, 0.4},
            width = 750,
            height = 350,
            font_size = 150,
            color = {0, 0, 0, 1},
            font_color = {0.9167, 0.9167, 0.9167, 1},
            tooltip = "Spawn movement templates. Unit leader spawns cohesion rulers when moved"
        })

        self.createButton({
            click_function = "aim",
            function_owner = self,
            label = "AIM      ",
            position = {-1.7, 0.2, -0.4},
            width = 750,
            height = 350,
            font_size = 150,
            color = {0, 0, 0, 1},
            font_color = {0, 0.8705, 0.0941, 1},
            tooltip = "Take an Aim token",
            alignment = 2
        })

        self.createButton({
            click_function = "attack",
            function_owner = self,
            label = "  ATTACK",
            position = {1.6, 0.2, 1.2},
            width = 850,
            height = 350,
            font_size = 150,
            color = {0, 0, 0, 1},
            font_color = {1, 0, 0, 1},
            tooltip = "Draw Attack Die or Spawn Range Rulers"
        })

        self.createButton({
            click_function = "dodge",
            function_owner = self,
            label = "DODGE ",
            position = {-1.7, 0.2, 0.4},
            width = 750,
            height = 350,
            font_size = 150,
            color = {0, 0, 0, 1},
            font_color = {0, 0.8705, 0.0941, 1},
            tooltip = "Take a Dodge token"
        })

        self.createButton({
            click_function = "overwatch",
            function_owner = self,
            label = "STANDBY",
            position = {-1.6, 0.2, 1.2},
            width = 850,
            height = 350,
            font_size = 150,
            color = {0, 0, 0, 1},
            font_color = {0, 0.8705, 0.0941, 1},
            tooltip = "Take an Standby token"
        })

        self.createButton({
            click_function = "resetActivation",
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
            click_function = "endActivation",
            function_owner = self,
            label = "END",
            position = {0, 0.2, 1.2},
            width = 550,
            height = 350,
            font_size = 150,
            color = {0.7, 0.03, 0.03, 1},
            font_color = {1, 1, 1, 1},
            tooltip = "End your Activation",
        })

        self.createButton({
            click_function = "spawnCohesionRuler",
            function_owner = self,
            label = "COHESION", position = {1.6, 0.2, -1.2}, width = 850, height = 350, font_size = 150, color = {0, 0, 0, 1}, font_color = {0.4709, 0.9759, 0.9162, 1},
            tooltip = "Spawn Cohesion Rulers"
        })

        self.createButton({
            click_function = "targetingMode",
            function_owner = self,
            label = "  RANGE",
            position = {1.7, 0.2, -0.4},
            width = 750,
            height = 350,
            font_size = 150,
            color = {0, 0, 0, 1},
            font_color = {0.4709, 0.9759, 0.9162, 1},
            tooltip = "Spawn Range Rulers"
        })
    end
end

function spawnCohesionRuler()
    if rulerOn != true then
        selectedUnitObj.call("spawnCohesionRuler")
        rulerOn = true
    else
        selectedUnitObj.call("clearCohesionRuler")
        rulerOn = false
    end

end

------------------------------------------------- NEXTUNIT ------------------------------------------------------------
function nextUnit()

    local out = false
    local originalUnitNumber = selectedUnitNumber
    while out == false do
        -- ++ selection
        selectedUnitNumber = selectedUnitNumber + 1
        -- loop selection
        if selectedUnitNumber > eligibleUnitsNumber then
            selectedUnitNumber = 1
        end
        -- check if back to originalUnitNumber
        if selectedUnitNumber == originalUnitNumber then
            out = true
            if selectedUnitObj == nil then
                standby()
            end
        else
            -- examine nil status
            if eligibleUnits[selectedUnitNumber] != nil then
                clearTint()
                stopUnit()
                stopAttack()
                selectedUnitObj = eligibleUnits[selectedUnitNumber]

                highlightUnit(selectedUnitObj.getTable("miniGUIDs"),{0,1,0})
                highlightCard(getObjectFromGUID(selectedUnitObj.getVar("cardGUID")))
                out = true
            end
        end


    end

end

function clearTint()
    unhighlightEnemies()

    if selectedUnitObj != nil then
        unhighlightUnit(selectedUnitObj.getTable("miniGUIDs"))
        unHighlightCard(getObjectFromGUID(selectedUnitObj.getVar("cardGUID")))
    end
end
------------------------------------------------- MOVE UNIT ------------------------------------------------------------

function moveUnit()
    stopAttack()
    resetButtons()
    clearTemplates()
    selectedUnitObj.setVar("moveState", true)
    self.editButton({
        index = 1,
        click_function = "stopUnit",
        label = "  DONE",
        color = {0.7, 0.03, 0.03},
        font_color = {1, 1, 1}
    })

    ------------------------------------------- PLACEMENT MATH -------------------------------------------
    basePos = selectedUnitObj.getPosition()
    basePos.y = basePos.y+0.05
    baseRot = selectedUnitObj.getRotation()

    if moveDirection == "backward" then
        baseRot.y = baseRot.y + 180
    end

    local q = math.rad(baseRot.y)
    local a = unitData.aStart * math.cos(q)
    local b = unitData.aStart * math.sin(q)
    local aEx = unitData.bStart * math.cos(q)
    local bEx = unitData.bStart * math.sin(q)

    ------------------------------------------- SPAWN TEMPLATES -------------------------------------------


    local modelTemplateA = getObjectFromGUID(templateInfo.modelTemplateAGUID)

    templateA = spawnObject({
        type = "Custom_Model",
        position = {basePos.x - b, basePos.y, basePos.z - a},
        rotation = {0, baseRot.y + 180, 0},
        scale = {1,1,1}
    })
    templateA.setCustomObject({
        type = 0,
        mesh = templateInfo.moveTemplate[unitData.selectedSpeed].mesh[unitData.baseSize],
        diffuse = templateInfo.moveTemplate[unitData.selectedSpeed].diffuse,
        collider = templateInfo.moveTemplate[unitData.selectedSpeed].longCollider,
        material = 1,
    })

    templateA.setPosition({basePos.x - b, basePos.y, basePos.z - a})
    templateA.setRotation({0, baseRot.y + 180, 0})

    local templateLuaScriptA = "unitInfo = {}\nunitInfo.baseSize = '"..unitData.baseSize.."'\nunitInfo.selectedSpeed = "..unitData.selectedSpeed.."\n"..modelTemplateA.getLuaScript()

    templateA.setLuaScript(templateLuaScriptA)
    templateA.sticky = false
    templateA.setName("Movement Template")
    templateA.setColorTint(templateInfo.moveTemplate[unitData.selectedSpeed].colorTint)



    --templateB = getObjectFromGUID(unitData.templateBGUID)
    local modelTemplateB = getObjectFromGUID(templateInfo.modelTemplateBGUID)

    templateB = spawnObject({
        type = "Custom_Model",
        position = {basePos.x - bEx, basePos.y, basePos.z - aEx},
        rotation = {0, baseRot.y, 0},
        scale = {1,1,1}
    })
    templateB.setCustomObject({
        type = 0,
        mesh = templateInfo.moveTemplate[unitData.selectedSpeed].mesh[unitData.baseSize],
        diffuse = templateInfo.moveTemplate[unitData.selectedSpeed].diffuse,
        collider = templateInfo.moveTemplate[unitData.selectedSpeed].shortCollider,
        material = 1,
    })

    templateB.setPosition({basePos.x - bEx, basePos.y, basePos.z - aEx})
    templateB.setRotation({0, baseRot.y, 0})
    local templateLuaScriptB = "unitInfo = {}\nunitInfo.baseSize = '"..unitData.baseSize.."'\nunitInfo.selectedSpeed = "..unitData.selectedSpeed.."\n"..modelTemplateB.getLuaScript()

    templateB.setLuaScript(templateLuaScriptB)
    templateB.sticky = false
    templateB.setName("Movement Template")
    templateB.setColorTint(templateInfo.moveTemplate[unitData.selectedSpeed].colorTint)
    --Global.setVar("templateAMoving", templateA)
    --Global.setVar("templateBMoving", templateB)

    --templateB.setLock(true)

    -- SET VALUES


    templateA.setTable("basePos", basePos)
    templateA.setTable("baseRot", baseRot)
    templateA.setVar("templateB", templateB)

    templateA.setLock(unitData.fixedMove)

    templateB.setTable("basePos", basePos)
    templateB.setTable("baseRot", baseRot)
    templateB.setVar("templateA", templateA)
    templateB.setLock(false)

    ------------------------------------------- SPAWN BUTTON -------------------------------------------


    local data = {click_function = "INSERT_FUNCTION", function_owner = self, label = "1", position = {3, 0.2, -0.4}, width = 300, height = 350, font_size = 200, tooltip = "1"}

    self.createButton({
        click_function = "changeSpeed1",
        function_owner = self,
        label = "1", position = {3, 0.2, -0.4}, width = 300, height = 350, font_size = 200,
        tooltip = "Move Speed 1",
        color = {1, 1, 1},
        font_color = {0, 0, 0}
    })

    self.createButton({
        click_function = "changeSpeed2",
        function_owner = self,
        label = "2", position = {3, 0.2, 0.4}, width = 300, height = 350, font_size = 200, color = {0, 0, 0, 1}, font_color = {1, 1, 1, 1},
        tooltip = "Move Speed 2"
    })
    self.createButton({
        click_function = "changeSpeed3",
        function_owner = self,
        label = "3",
        position = {3, 0.2, 1.2}, width = 300, height = 350, font_size = 200, color = {0.8103, 0.0857, 0.0857, 1}, font_color = {1, 1, 1, 1},
        tooltip = "Move Speed 3"
    })
    if unitData.fixedMove then

        self.createButton({
            click_function = "moveBackwards",
            function_owner = self,
            label = "B",
            position = {3, 0.200000002980232, -1.2}, width = 300, height = 350, font_size = 200,
            tooltip = "Move Backwards",
            color = {1, 1, 0},
            font_color = {0, 0, 0}
        })

        if moveDirection == "backward" then
            self.editButton({
                index = 13,
                click_function = "moveForward",
                label = "F",
                tooltip = "Move Forwards"
            })
        end
    end

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
------------------------------------------------- MOVE BACK------------------------------------------------------------

function moveFull()
    if templateB != nil then
        local startPos = templateB.getPosition()
        local startRot = templateB.getRotation()
        local endPos = translatePos(startPos, startRot, unitData.aStart, 0)
        endPos.y = endPos.y + 2

        local endRot = startRot
        if moveDirection == "backward" then
            endRot.y = endRot.y + 180
        end

        selectedUnitObj.setPositionSmooth(endPos, false, false)
        selectedUnitObj.setRotationSmooth(startRot, false, false)
        refreshTimer()
        Timer.create({
            identifier     = "checkVelocity"..timerCounter,
            function_name  = "checkVelocity",
            function_owner = selectedUnitObj,
            delay          = 0.5
        })
    end

end


function moveStart()
    local endPos = basePos
    endPos.y = endPos.y + 2
    selectedUnitObj.setPositionSmooth(endPos, false, false)
    selectedUnitObj.setRotationSmooth(baseRot, false, false)
end

function moveBackwards()
    self.editButton({
        index = 11,
        click_function = "moveForward",
        label = "F",
        tooltip = "Move Forwards"
    })
    moveDirection = "backward"
    moveUnit()
end

function moveForward()
    self.editButton({
        index = 11,
        click_function = "moveBackwards",
        label = "B",
        tooltip = "Move Backwards"
    })
    moveDirection = "forward"
    moveUnit()
end

------------------------------------------------- stop UNIT ------------------------------------------------------------
function stopUnit()
    -- destroy templates

    self.clearButtons()
    clearTemplates()
    resetButtons()
    unhighlightEnemies()

end

------------------------------------------------- Clear templates------------------------------------------------------------
function clearTemplates()
    clearMovementTemplates()
    clearRangeRulers()
    clearCohesionRulers()
end

function clearMovementTemplates()
    if templateA != nil then
        destroyObject(templateA)
    end
    if templateB!= nil then
        destroyObject(templateB)
    end
end

function clearCohesionRulers()
    if selectedUnitObj != nil then
        selectedUnitObj.setVar("moveState", false)
        selectedUnitObj.call("clearCohesionRuler")
    end
end

function clearRangeRulers()
    if rangeRuler != nil then
        for i = 1,4,1 do
            destroyObject(rangeRuler[i])
        end
        rangeRuler = nil
    end
    if frontArc != nil then
        destroyObject(frontArc)
    end
    if backArc != nil then
        destroyObject(backArc)
    end
    clearAttackLine()
    noRulers = true
end

function clearAttackLine()
    if attackLine != nil then
        for k, attackLineObj in pairs(attackLine) do
            destroyObject(attackLine[k])
        end
        attackLine = nil
    end
end


------------------------------------------------- CHANGESPEED------------------------------------------------------------
function changeSpeed1()
    unitData.selectedSpeed = 1
    setTemplateVariables()
    clearTemplates()
    moveUnit()
end

function changeSpeed2()
    unitData.selectedSpeed = 2
    setTemplateVariables()
    clearTemplates()
    moveUnit()
end

function changeSpeed3()
    unitData.selectedSpeed = 3
    setTemplateVariables()
    clearTemplates()
    moveUnit()
end
------------------------------------------------- AIM------------------------------------------------------------
function aim()
    basePos = selectedUnitObj.getPosition()
    baseRot = selectedUnitObj.getRotation()

    local q = math.rad(baseRot.y)
    local a = 1 * math.cos(q)
    local b = 1 * math.sin(q)

    local tokenPosition = {basePos.x + b, basePos.y + 1, basePos.z + a}
    local tokenRotation = {0, baseRot.y, 0}

    aimBag = getObjectFromGUID(Global.getVar("aimBagGUID"))
    aimBag.takeObject({
        position = tokenPosition,
        rotation = tokenRotation
    })

end

------------------------------------------------- dodge------------------------------------------------------------
function dodge()
    basePos = selectedUnitObj.getPosition()
    baseRot = selectedUnitObj.getRotation()

    local q = math.rad(baseRot.y + 50)
    local a = 1 * math.cos(q)
    local b = 1 * math.sin(q)

    local tokenPosition = {basePos.x + b, basePos.y + 1, basePos.z + a}
    local tokenRotation = {0, baseRot.y - 30, 0}

    aimBag = getObjectFromGUID(Global.getVar("dodgeBagGUID"))
    aimBag.takeObject({
        position = tokenPosition,
        rotation = tokenRotation
    })

end

------------------------------------------------- overwatch------------------------------------------------------------
function overwatch()
    basePos = selectedUnitObj.getPosition()
    baseRot = selectedUnitObj.getRotation()

    local q = math.rad(baseRot.y - 50)
    local a = 1 * math.cos(q)
    local b = 1 * math.sin(q)

    local tokenPosition = {basePos.x + b, basePos.y + 1, basePos.z + a}
    local tokenRotation = {0, baseRot.y, 0}

    aimBag = getObjectFromGUID(Global.getVar("standbyBagGUID"))
    aimBag.takeObject({
        position = tokenPosition,
        rotation = tokenRotation
    })

end


------------------------------------------------- attack------------------------------------------------------------
function attack()
    clearTemplates()
    resetButtons()
    self.editButton({
        index = 3,
        click_function = "stopAttack",
        function_owner = self,
        label = "     DONE",
        color = {0.7, 0.03, 0.03},
        font_color = {1, 2, 1}
    })
    attackMode()

end

function targetingMode()

    if enemyHighlighted != true then
        exitAttackMode()

        highlightEnemies()
        spawnRangeRuler()
        enemyHighlighted = true
        resetRangeButtons()
    else
        exitTargetingMode()
    end

end

function attackMode()
    if attackModeOn != true then
        exitTargetingMode()

        highlightEnemies()
        spawnRangeRuler()
        attackModeOn = true
        resetTargetingButtons()
    else
        exitTargetingMode()
    end
end

function exitTargetingMode()
    enemyHighlighted = false
    attackModeOn = false
    clearRangeRulers()
    unhighlightEnemies()
end

function exitAttackMode()
    enemyHighlighted = false
    attackModeOn = false
    clearRangeRulers()
    unhighlightEnemies()
end

function resetRangeButtons()
    enemyLeaders = getEnemyUnits()

    for _, leader in pairs(enemyLeaders) do
        createRangeButton(leader)
    end
end

function resetTargetingButtons()
    enemyLeaders = getEnemyUnits()

    for _, leader in pairs(enemyLeaders) do
        createAttackButton(leader)
        createRangeButton(leader)
    end
end

function attackMenu(attackTargetObj)
    unhighlightEnemies()

    highlightEnemy(attackTargetObj)

    clearRangeRulers()

    -- attack menu buttons
    local leaderUnitName = attackTargetObj.getVar("unitName")
    local buttonHeight = unitInfo[leaderUnitName].buttonHeight

    refreshTimer()
    _G["addIon"..timerCounter] = function() addIon(attackTargetObj) end
    _G["addWound"..timerCounter] = function() addWound(attackTargetObj) end
    _G["addSuppression"..timerCounter] = function() addSuppression(attackTargetObj) end

    attackTargetObj.createButton({
        click_function = "addIon"..timerCounter, function_owner = self, label = "I", position = {-0.9, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 700, height = 700, font_size = 500, color = {0, 0.1711, 1, 1}, tooltip = "I"
    })
    attackTargetObj.createButton({
        click_function = "addWound"..timerCounter, function_owner = self, label = "W", position = {0.9, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 700, height = 700, font_size = 500, color = {1, 0, 0, 1}, tooltip = "W"
    })
    attackTargetObj.createButton({
        click_function = "addSuppression"..timerCounter, function_owner = self, label = "S", position = {0, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 700, height = 700, font_size = 500, color = {1, 0.8723, 0, 1}, tooltip = "S"
    })

    -- create attack lines
    local enemyMinis = attackTargetObj.getTable("miniGUIDs")

    attackLine = {}
    n = 1

    for k, guidEntry in pairs(enemyMinis) do
        local obj = getObjectFromGUID(guidEntry)

        if obj != nil then
            if obj.getPosition().z <18.1 and obj.getPosition().z > -18.1 and obj.getPosition().x < 44.1 and obj.getPosition().x > -28.1 then
                attackLine[n] = spawnAttackLine(selectedUnitObj, obj)
                n = n + 1
            end
        end
    end

end

function addSuppression(selectedSuppressionObj)
    local suppressionPos = selectedSuppressionObj.getPosition()
    suppressionPos.y = suppressionPos.y + 1
    suppressionBag = getObjectFromGUID(Global.getVar("suppressionBagGUID"))
    suppressionBag.takeObject({
        position = suppressionPos,
        rotation = selectedSuppressionObj.getRotation()
    })
end

function addWound(selectedWoundObj)
    local woundPos = selectedWoundObj.getPosition()
    woundPos.y = woundPos.y + 1
    woundBag = getObjectFromGUID(Global.getVar("woundBagGUID"))

    woundPos = translatePos(woundPos,selectedWoundObj.getRotation(),1, 0)

    woundBag.takeObject({
        position = woundPos,
        rotation = selectedWoundObj.getRotation()
    })
end

function addIon(selectedIonObj)
    local ionPos = selectedIonObj.getPosition()
    ionPos.y = ionPos.y + 1
    ionBag = getObjectFromGUID(Global.getVar("ionBagGUID"))

    ionPos = translatePos(ionPos,selectedIonObj.getRotation(),1, 180)

    ionBag.takeObject({
        position = ionPos,
        rotation = selectedIonObj.getRotation()
    })
end

function spawnAttackLine(aOriginObj,aTargetObj)

        distance = getDistance(aOriginObj,aTargetObj)

        local spawnPos = aOriginObj.getPosition()
        spawnPos.y = spawnPos.y+0.22
        local spawnRot = getAngle(aOriginObj,aTargetObj)
        spawnRot.y = spawnRot.y + aOriginObj.getRotation().y - 180

        attackLineObj = spawnObject({
            type = "Custom_Model",
            position = spawnPos,
            rotation = spawnRot,
            scale = {1,1,distance}
        })
        attackLineObj.setCustomObject({
            type = 0,
            mesh = templateInfo.attackLineMesh,
            collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
            material = 1,
        })
        attackLineObj.setLock(true)
        attackLineObj.setColorTint({1,0,0})
        attackLineObj.setName("Range Ruler")

        attackLineObj.setRotation(spawnRot)
        attackLineObj.setPosition(spawnPos)

        Wait.frames(function() attackLineObj.setRotation(spawnRot) attackLineObj.setPosition(spawnPos) end, 10)

        return attackLineObj
end

function getAngle(originObj, angleTargetObj)
    local localVector = originObj.positionToLocal(angleTargetObj.getPosition())

    local q = math.deg(math.atan2(localVector.x, localVector.z))

    local c = math.sqrt((localVector.x * localVector.x) + (localVector.z * localVector.z))

    local q2 = math.deg(math.atan2(localVector.y, c))

    -- set rotation and rotation
    return {x=q2,y=q,z=0}
end

function createAttackButton(leaderObj)
    local leaderUnitName = leaderObj.getVar("unitName")
    local buttonHeight = unitInfo[leaderUnitName].buttonHeight

    refreshTimer()
    _G["attackMenu"..timerCounter] = function() attackMenu(leaderObj) end

    local data = {click_function = "attackMenu"..timerCounter, function_owner = self, label = "ATTACK", position = {0, buttonHeight, -0.9}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 1800, height = 700, font_size = 400, color = {1, 0, 0, 1}, font_color = {0, 0, 0, 1}}

    leaderObj.createButton(data)
end

function createRangeButton(leaderObj)
    local selectedUnitObjUnitName = selectedUnitObj.getVar("unitName")
    local enemyLeaderUnitName = leaderObj.getVar("unitName")
    local enemyMinis = leaderObj.getTable("miniGUIDs")
    local lowestDistance = 99
    for k, guidEntry in pairs(enemyMinis) do
        local obj = getObjectFromGUID(guidEntry)

        if obj != nil then
            distance = getDistance(selectedUnitObj, obj)
            if distance < lowestDistance then
                lowestDistance = distance
            end
        end
    end

    lowestDistance = lowestDistance - templateInfo.baseRadius[unitInfo[enemyLeaderUnitName].baseSize]/2 - templateInfo.baseRadius[unitInfo[selectedUnitObjUnitName].baseSize]/2

    finalRange = math.ceil(lowestDistance/6)
    if finalRange > 4 then
        finalRange = ">4"
    end

    local buttonHeight = unitInfo[enemyLeaderUnitName].buttonHeight
    local data = {click_function = "dud", function_owner = self, label = finalRange, position = {0, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 900, height = 700, font_size = 500, color = {1, 1, 0, 1}, font_color = {0, 0, 0, 1}}

    leaderObj.createButton(data)
end

function dud()
end

function highlightEnemies()
    enemyLeaders = getEnemyUnits()

    for _, leader in pairs(enemyLeaders) do
        local enemyID = leader.getVar("unitID")
        local enemyMinis = leader.getTable("miniGUIDs")
        highlightUnit(enemyMinis,highlightTints[enemyID])
    end
end

function highlightEnemy(leader)
    local enemyID = leader.getVar("unitID")
    local enemyMinis = leader.getTable("miniGUIDs")
    highlightUnit(enemyMinis, highlightTints[enemyID])
end

function unhighlightEnemies()
    enemyLeaders = getEnemyUnits()

    for _, leader in pairs(enemyLeaders) do
        local enemyID = leader.getVar("unitID")
        local enemyMinis = leader.getTable("miniGUIDs")
        unhighlightUnit(enemyMinis)
        leader.call("resetUnitButtons")
    end
end

function getEnemyUnits()
    -- tableObj
    local miniObjs = {}

    local allUnits = battlefieldZone.getObjects()
    for _, obj in pairs(allUnits) do
        if obj.getVar("isAMini") == true and obj.getVar("colorSide") != colorSide then
            table.insert(miniObjs, obj)
        end
    end

    return miniObjs
end

function spawnRangeRuler()

    basePos = selectedUnitObj.getPosition()
    baseRot = selectedUnitObj.getRotation()

    rangeRuler = {}

    baseAddition = {}
    baseAddition.small = 1.06299 / 2
    baseAddition.medium = 1.9685 / 2
    baseAddition.big = 2.75591 / 2
    baseAddition.huge = 3.93701 / 2
    baseAddition.long = 3.525856871366164 / 2

    longMesh = {}
    longMesh[1] = "http://cloud-3.steamusercontent.com/ugc/785234780861489665/6C93696005D62FDD38A344398E06D9AD8753141C/"
    longMesh[2] = "http://cloud-3.steamusercontent.com/ugc/785234780861491012/E6A15521D46FD2CE19CE547612DC2050DC916603/"
    longMesh[3] = "http://cloud-3.steamusercontent.com/ugc/785234780861491929/4AD760438DD5333AD61144E3256533ACC85E08E4/"
    longMesh[4] = "http://cloud-3.steamusercontent.com/ugc/785234780861492649/CFB2183925F6DF41E80A0B2BBB59EB6908DFB103/"
    for i = 1, 4, 1 do

        if unitData.baseSize != "long" then
            rangeRuler[i] = spawnObject({
                type = "Custom_Model",
                position = basePos,
                rotation = {0, baseRot.y, 0},
                scale = {i * 6 + baseAddition[unitData.baseSize], 3, i * 6 + baseAddition[unitData.baseSize]}
            })
            rangeRuler[i].setCustomObject({
                type = 0,
                mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862835239/0858A62DF9F9E7DCB49B641E4938111697E4F3D4/",
                collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
                material = 1,
            })
        else
            rangeRuler[i] = spawnObject({
                type = "Custom_Model",
                position = basePos,
                rotation = {0, baseRot.y, 0},
                scale = {1,4,1}
            })
            rangeRuler[i].setCustomObject({
                type = 0,
                mesh = longMesh[i],
                collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
                material = 1,
            })
        end

        rangeRuler[i].setLock(true)
        rangeRuler[i].setName("Range Ruler")
    end

    rangeRuler[1].setColorTint({0.7, 0.7, 0.7})
    rangeRuler[2].setColorTint({0.1, 0.1, 0.1})
    rangeRuler[3].setColorTint({0.6, 0, 0})
    rangeRuler[4].setColorTint({0.4, 0.4, 0.0})

    fixedArcScale = (4 * 6) + baseAddition[unitData.baseSize]
    if unitData.fixedArc then
        if unitData.baseSize != "long" then
            frontArc = spawnObject({
                type = "Custom_Model",
                position = basePos,
                rotation = {0, baseRot.y - 45, 0},
                scale = {fixedArcScale, 3, fixedArcScale}
            })
            frontArc.setCustomObject({
                type = 0,
                mesh = "http://cloud-3.steamusercontent.com/ugc/785234780861496438/BBC5E1730F64EBC971AA582ABF23E3E00246795D/",
                collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
                material = 1,
            })

            backArc = spawnObject({
                type = "Custom_Model",
                position = basePos,
                rotation = {0, baseRot.y - 45 + 180, 0},
                scale = {fixedArcScale, 3, fixedArcScale}
            })
            backArc.setCustomObject({
                type = 0,
                mesh = "http://cloud-3.steamusercontent.com/ugc/785234780861496438/BBC5E1730F64EBC971AA582ABF23E3E00246795D/",
                collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
                material = 1,
            })
            backArc.setLock(true)
            backArc.setColorTint({0.1, 0.1, 0.1})
            backArc.setName("Range Ruler")
        else
            frontArc = spawnObject({
                type = "Custom_Model",
                position = basePos,
                rotation = {0, baseRot.y, 0},
                scale = {1,4,1}
            })
            frontArc.setCustomObject({
                type = 0,
                mesh = "http://cloud-3.steamusercontent.com/ugc/785234780861494592/5DBA9C27E7656BB5863144D00E4B9B8F8F5E2A70/",
                collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
                material = 1,
            })
        end
        frontArc.setLock(true)
        frontArc.setColorTint({0.1, 0.1, 0.1})
        frontArc.setName("Range Ruler")

    end
end




function stopAttack()
    exitTargetingMode()
    stopUnit()
end


------------------------------------------------- end UNIT ------------------------------------------------------------

function endActivation()

    resetActivation()
    self.flip()
end

function resetActivation()
    stopUnit()
    stopAttack()
    standby()
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

function getDistance(originObj, targetObj)
    local localVector = originObj.positionToLocal(targetObj.getPosition())
    local c = math.sqrt((localVector.x * localVector.x) + (localVector.z * localVector.z))
    --local finalDistance = math.sqrt((c * c) + (localVector.y * localVector.y))
    return c
end

function refreshTimer()
    timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
end










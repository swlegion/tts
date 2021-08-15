#include !/common/Math
#include !/data/CardInfo_new
#include !/data/MiniInfo

-- Model Token

function onLoad()

    -- LOAD VALUES
    battlefieldTint = Global.getTable("battlefieldTint")
    baseAddition = Global.getTable("baseAddition")
    existingTint = battlefieldTint
    battlefieldZone = getObjectFromGUID(Global.getVar("battlefieldZoneGUID"))
    cardInfo = CardInfoClass:buildCardInfo()
    unitInfo = cardInfo.unitCards
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
    if unitName != nil then
        local unitObj = cardInfo:getUnitByName(unitName, faction)
        isAToken = true
        unitData.unitName = unitName
        unitData.faction = faction

        -- TODO: This is used as a hack for "promote"/"covert ops" currently.
        if commandType == nil then
          commandType = unitObj.commandType
        end
        unitData.tokenCommandType = commandType
        
        unitData.baseSize = unitObj.baseSize
        unitData.fixedMove = unitObj.fixedMove
        unitData.strafeMove = unitObj.strafeMove
        unitData.selectedSpeed = unitObj.selectedSpeed
        unitData.fixedArc = unitObj.fixedArc

        dieRoller = getObjectFromGUID(dieRollerInfo[colorSide.."DieRollerGUID"])

        setTemplateVariables()
        initialize()
    end

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

            local miniData = unit.getTable("unitData")
            if miniData != nil and miniData.commandType != nil then
                if unitData.tokenCommandType == miniData.commandType and unit.getVar("colorSide") == colorSide then
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
        unitData.strafeMove = newUnitData.strafeMove
        unitData.selectedSpeed = newUnitData.selectedSpeed
        unitData.fixedArc = newUnitData.fixedArc

    end
end

------------------------------------------------- STANDBY ------------------------------------------------------------
function initialize()

    activated = false
    --getEligibleUnit()

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
            click_function = "initMove",
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
                getSelectedUnitObjVariables()
                setTemplateVariables()
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
function initMove()
    initPos = selectedUnitObj.getPosition()
    initRot = selectedUnitObj.getRotation()
    moveUnit()
end
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

    elseif moveDirection == "left" then
        baseRot.y = baseRot.y - 90
    elseif moveDirection == "right" then
        baseRot.y = baseRot.y + 90
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
        mesh = templateInfo.moveTemplate[unitData.selectedSpeed].mesh,
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
        mesh = templateInfo.moveTemplate[unitData.selectedSpeed].mesh,
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

        if unitData.strafeMove then

              self.createButton({
                  click_function = "moveForward",
                  function_owner = self,
                  label = "F",
                  position = {3, 0.200000002980232, -1.2}, width = 300, height = 350, font_size = 200,
                  tooltip = "Move Forwards",
                  color = {1, 1, 0},
                  font_color = {0, 0, 0}
              })
              self.createButton({
                  click_function = "moveBackwards",
                  function_owner = self,
                  label = "B",
                  position = {3.8, 0.2, -1.2}, width = 300, height = 350, font_size = 200,
                  tooltip = "Move Backwards",
                  color = {1, 1, 0},
                  font_color = {0, 0, 0}
              })
              self.createButton({
                  click_function = "moveLeft",
                  function_owner = self,
                  label = "L",
                  position = {4.6, 0.2, -1.2}, width = 300, height = 350, font_size = 200,
                  tooltip = "Strafe Left",
                  color = {1, 1, 0},
                  font_color = {0, 0, 0}
              })
              self.createButton({
                  click_function = "moveRight",
                  function_owner = self,
                  label = "R",
                  position = {5.4, 0.2, -1.2}, width = 300, height = 350, font_size = 200,
                  tooltip = "Strafe Right",
                  color = {1, 1, 0},
                  font_color = {0, 0, 0}
              })

        else
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
        elseif moveDirection == "left" then
            endRot.y = endRot.y + 90
        elseif moveDirection == "right" then
            endRot.y = endRot.y - 90
        end

        selectedUnitObj.setPositionSmooth(endPos, false, false)
        selectedUnitObj.setRotationSmooth(startRot, false, false)
        Wait.frames(function()
          selectedUnitObj.call("checkVelocity")
        end)
    end
end


function moveStart()
    local endPos = initPos
    endPos.y = initPos.y + 2
    selectedUnitObj.setPositionSmooth(endPos, false, false)
    selectedUnitObj.setRotationSmooth(initRot, false, false)
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

function moveLeft()
    moveDirection = "left"
    moveUnit()
end

function moveRight()
    moveDirection = "right"
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
        for i = 1,5,1 do
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

    -- this used to be configurable per unit type, which meant that we made the
    -- ion/wound/suppression buttons vertically higher to make up for variable
    -- height minis.
    --
    -- it's possible we can use the actual collider height of the mini in the
    -- future in order to tune this.
    local buttonHeight = unitInfo[leaderUnitName].buttonHeight


    _G["addIon"..self.getGUID()] = function() addIon(attackTargetObj) end
    _G["addWound"..self.getGUID()] = function() addWound(attackTargetObj) end
    _G["addSuppression"..self.getGUID()] = function() addSuppression(attackTargetObj) end

    attackTargetObj.createButton({
        click_function = "addIon"..self.getGUID(), function_owner = self, label = "I", position = {-0.9, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 700, height = 700, font_size = 500, color = {0, 0.1711, 1, 1}, tooltip = "I"
    })
    attackTargetObj.createButton({
        click_function = "addWound"..self.getGUID(), function_owner = self, label = "W", position = {0.9, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 700, height = 700, font_size = 500, color = {1, 0, 0, 1}, tooltip = "W"
    })
    attackTargetObj.createButton({
        click_function = "addSuppression"..self.getGUID(), function_owner = self, label = "S", position = {0, buttonHeight, 0}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 700, height = 700, font_size = 500, color = {1, 0.8723, 0, 1}, tooltip = "S"
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
        spawnRot.y = spawnRot.y +180
        spawnRot.x = spawnRot.x
        spawnRot.z = spawnRot.z

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
    --local localVector = originObj.positionToLocal(angleTargetObj.getPosition())
    local aTargetPos = angleTargetObj.getPosition()
    local originPos = originObj.getPosition()

    local localVector = {
          x = aTargetPos.x - originPos.x,
          y = aTargetPos.y - originPos.y,
          z = aTargetPos.z - originPos.z}


    local q = math.deg(math.atan2(localVector.x, localVector.z))

    local c = math.sqrt((localVector.x * localVector.x) + (localVector.z * localVector.z))

    local q2 = math.deg(math.atan2(localVector.y, c))

    -- set rotation and rotation
    return {x=q2,y=q,z=0}
end

function createAttackButton(leaderObj)
    local leaderUnitName = leaderObj.getVar("unitName")
    local buttonHeight = unitInfo[leaderUnitName].buttonHeight

    _G["attackMenu"..leaderObj.getGUID()] = function() attackMenu(leaderObj) end

    local data = {click_function = "attackMenu"..leaderObj.getGUID(), function_owner = self, label = "ATTACK", position = {0, buttonHeight, -0.9}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 1800, height = 700, font_size = 400, color = {1, 0, 0, 1}, font_color = {0, 0, 0, 1}}

    leaderObj.createButton(data)
end

function isMiniOnTable(mini, allUnits)
    for _, check in pairs(allUnits) do
      if check == mini then
        return true
      end
    end
    return false
  end

function createRangeButton(leaderObj)
    local selectedUnitObjUnitName = selectedUnitObj.getVar("unitName")
    local allUnitsOnTable = battlefieldZone.getObjects()
    local enemyLeaderUnitName = leaderObj.getVar("unitName")
    local enemyMinis = leaderObj.getTable("miniGUIDs")
    local lowestDistance = 99
    for k, guidEntry in pairs(enemyMinis) do
        local obj = getObjectFromGUID(guidEntry)

        if obj != nil and isMiniOnTable(obj, allUnitsOnTable) then
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

    longMesh = {}
    longMesh[1] = "http://cloud-3.steamusercontent.com/ugc/785234780861489665/6C93696005D62FDD38A344398E06D9AD8753141C/"
    longMesh[2] = "http://cloud-3.steamusercontent.com/ugc/785234780861491012/E6A15521D46FD2CE19CE547612DC2050DC916603/"
    longMesh[3] = "http://cloud-3.steamusercontent.com/ugc/785234780861491929/4AD760438DD5333AD61144E3256533ACC85E08E4/"
    longMesh[4] = "http://cloud-3.steamusercontent.com/ugc/785234780861492649/CFB2183925F6DF41E80A0B2BBB59EB6908DFB103/"
    longMesh[5] = "http://cloud-3.steamusercontent.com/ugc/785234780861492649/CFB2183925F6DF41E80A0B2BBB59EB6908DFB103/"
    for i = 1, 5, 1 do

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
        luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID != nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y,0})\nend\nend"
        rangeRuler[i].setLuaScript(luaScript)
    end

    rangeRuler[1].setColorTint({0.7, 0.7, 0.7})
    rangeRuler[2].setColorTint({0.1, 0.1, 0.1})
    rangeRuler[3].setColorTint({0.6, 0, 0})
    rangeRuler[4].setColorTint({209/255, 143/255, 30/255})
    rangeRuler[5].setColorTint({231/255, 229/255, 44/255})


    fixedArcScale = (5 * 6) + baseAddition[unitData.baseSize]
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
            luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID != nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y+135,0})\nend\nend"
            backArc.setLuaScript(luaScript)

            luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID != nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y-45,0})\nend\nend"
            frontArc.setLuaScript(luaScript)
        else
            frontArc = spawnObject({
                type = "Custom_Model",
                position = basePos,
                rotation = {0, baseRot.y, 0},
                scale = {1,4,1}
            })
            frontArc.setCustomObject({
                type = 0,
                mesh = "http://cloud-3.steamusercontent.com/ugc/770611292008692712/70F8B26BCD51CE4C069E7E3933ED01AC53E76E82/",
                collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
                material = 1,
            })
            luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID != nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y,0})\nend\nend"
            frontArc.setLuaScript(luaScript)
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

function getDistance(originObj, targetObj)
  local originPos = originObj.getPosition()
  local targetPos = targetObj.getPosition()

  -- set the y-value for each position to 0 to ignore height differences
  originPos:set(nil, 0, nil)
  targetPos:set(nil, 0, nil)
  
  return Vector.distance(originPos, targetPos)
end

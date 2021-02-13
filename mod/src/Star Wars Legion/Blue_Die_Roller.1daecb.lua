function onLoad(save_state)
    self.interactable = false
    colorSide = "blue"
    dieRollerInfo = Global.getTable("dieRollerInfo")
    dieRollerZone = getObjectFromGUID(dieRollerInfo.dieRollerZone[colorSide])
    mode = nil
    selectedMode = "attack"
    dieCount = 0

    -- dieValues
    dieIndex = {}
    dieIndex.crit = 0
    dieIndex.hit = 1
    dieIndex.oSurge = 2
    dieIndex.block = 3
    dieIndex.dSurge = 4

    dieNames = {"crit","hit","oSurge","block","dSurge"}

    self.createButton({
        click_function = "dud", function_owner = self, label = "", position = {-3.12, 0.52, 1.62}, rotation = {0, -90, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 400, font_size = 450, color = {1, 1, 1, 0.01}, font_color = {1, 0, 0, 100}, tooltip = "1", alignment = 3})

    self.createButton({
        click_function = "dud", function_owner = self, label = "", position = {-3.12, 0.52, 0.75}, rotation = {0, -90, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 400, font_size = 450, color = {1, 1, 1, 0.01}, font_color = {1, 0, 0, 100}, tooltip = "2", alignment = 3})

    self.createButton({
        click_function = "dud", function_owner = self, label = "", position = {-3.12, 0.52, -0.12}, rotation = {0, -90, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 400, font_size = 450, color = {1, 1, 1, 0.01}, font_color = {1, 0, 0, 100}, tooltip = "3", alignment = 3})

    self.createButton({
        click_function = "dud", function_owner = self, label = "", position = {-3.12, 0.52, -1}, rotation = {0, -90, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 400, font_size = 450, color = {1, 1, 1, 0.01}, font_color = {1, 0, 0, 100}, tooltip = "4", alignment = 3})

    self.createButton({
        click_function = "dud", function_owner = self, label = "", position = {-3.12, 0.52, -1.88}, rotation = {0, -90, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 400, font_size = 450, color = {1, 1, 1, 0.01}, font_color = {1, 0, 0, 100}, tooltip = "5", alignment = 3})

    createDieTimer(0.5)
end

function dud()
end

function rollDie()
    if dieObjs != nil then
        for i, obj in pairs(dieObjs) do
            if obj != nil then
                obj.roll()
            end
        end
    end
end

function createDieTimer(timerDelay)
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
    Timer.create({
        identifier     = "rollDie".. timerCounter,
        function_name  = "printDieValues",
        function_owner = self,
        delay          = timerDelay,
        repetitions    = 0
    })

end

function printDieValues()
    local dieRecord = {}
    dieRecord.crit = 0
    dieRecord.hit = 0
    dieRecord.oSurge = 0
    dieRecord.block = 0
    dieRecord.dSurge = 0
    dieRecord.blank = 0
    if dieObjs != nil then
        for i, obj in pairs(dieObjs) do
            if obj != nil then
                local sDieValue = obj.getValue()
                local sDieColor = obj.getVar("dieColor")
                local sDieType = obj.getVar("dieType")

                local sDieResult = dieRollerInfo.dieValues[sDieType][sDieColor][sDieValue]

                dieRecord[sDieResult] = dieRecord[sDieResult] + 1


            end
        end
    end

    for i, v in pairs(dieNames) do
        if dieRecord[v] == 0 then
            d = ""
        else
            d = dieRecord[v]
        end


        self.editButton({
            index          = dieIndex[v],
            label          = d
        })

    end

end

function spawnWhiteAttackDice()
    mode = "attack"
    spawnDie("white", "D8")
end

function spawnBlackAttackDice()
    mode = "attack"
    spawnDie("black", "D8")
end

function spawnRedAttackDice()
    mode = "attack"
    spawnDie("red", "D8")
end

function spawnWhiteDefenseDice()
    mode = "defend"
    spawnDie("white", "D6")
end
function spawnRedDefenseDice()
    mode = "defend"
    spawnDie("red", "D6")
end


function spawnDie(dieColor,dieType)
    if selectedMode != mode then
        clearDie()
        selectedMode = mode
    end

    if dieObjs == nil then
        dieObjs = {}
    else
        for i, obj in pairs(dieObjs) do
            dieCount = i
            if obj == nil then
                dieCount = i - 1
                break
            end
        end
    end

    if dieCount < 25 then
        dieCount = dieCount + 1

        local rot = self.getRotation()
        local pos = self.getPosition()

        local c = dieRollerInfo.diePos[dieCount].c
        local q = dieRollerInfo.diePos[dieCount].q

        local a = c * math.cos(math.rad(q + rot.y))
        local b = c * math.sin(math.rad(q + rot.y))

        pos.x = pos.x + a
        pos.z = pos.z - b
        pos.y = 3

        local dieBag = getObjectFromGUID(Global.getVar(dieColor .. dieType .."BagGUID"))

        if mode == "attack" then
            diceRot = {326.26, 1.20, 89.99}
        else
            diceRot = {270.00, 358.92, 0.00}
        end

        dieObjs[dieCount] = dieBag.takeObject({
            position = pos,
            rotation = diceRot
        })

        dieObjs[dieCount].setPosition(pos)
        dieObjs[dieCount].setLuaScript("function onDestroy() dieRollerInfo = Global.getTable('dieRollerInfo') dieRoller = getObjectFromGUID(dieRollerInfo."..colorSide.."DieRollerGUID) dieRoller.call('waitToUpdate') end")

        dieObjs[dieCount].setVar("dieColor", dieColor)
        dieObjs[dieCount].setVar("dieType", mode)

        updateDieCountDisplay()
    end
end

function clearDie()
    if dieObjs != nil then
        for i, obj in pairs(dieObjs) do
            if obj != nil then
                destroyObject(obj)
            end
        end
        dieObjs = nil
        dieCount = 0
    end

    local zoneObjs = dieRollerZone.getObjects()

    for _,obj in pairs(zoneObjs) do
        if obj != self then
            destroyObject(obj)
        end
    end
end

function updateDieCountDisplay()
    dieColorCount = {}
    dieColorCount.white = 0
    dieColorCount.black = 0
    dieColorCount.red = 0

    if dieObjs != nil then
        for i, obj in pairs(dieObjs) do
            if obj != nil then
                local selectedColor = obj.getVar("dieColor")
                dieColorCount[selectedColor] = dieColorCount[selectedColor] + 1
            end
        end
    end


    if mode == "attack" then
        clearButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].whiteDefenseButtonGUID,"white")
        clearButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].redDefenseButtonGUID,"red")

        updateButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].whiteAttackButtonGUID,"white")
        updateButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].blackAttackButtonGUID,"black")
        updateButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].redAttackButtonGUID,"red")
    else
        clearButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].whiteAttackButtonGUID,"white")
        clearButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].blackAttackButtonGUID,"black")
        clearButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].redAttackButtonGUID,"red")

        updateButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].whiteDefenseButtonGUID,"white")
        updateButtonDisplay(dieRollerInfo.buttonInfo[colorSide.."Player"].redDefenseButtonGUID,"red")
    end

end

function waitToUpdate()
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "DieRoller"..timerCounter,
        function_name  = "updateDieCountDisplay",
        function_owner = self,
        delay          = 0.1
    })
end

function updateButtonDisplay(buttonGUID,diceColor)
    buttonObj = getObjectFromGUID(buttonGUID)

    local data = buttonObj.getTable("data")
    if dieColorCount[diceColor] != 0 then
        data.label = dieColorCount[diceColor]
    else
        data.label = ""
    end

    buttonObj.clearButtons()
    buttonObj.createButton(data)
end

function clearButtonDisplay(buttonGUID,diceColor)
    buttonObj = getObjectFromGUID(buttonGUID)

    local data = buttonObj.getTable("data")
    data.label = ""

    buttonObj.clearButtons()
    buttonObj.createButton(data)
end

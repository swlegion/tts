function onLoad(save_state)
    self.interactable = false
    -- intialize
    setUpCards = Global.getTable("setUpCards")
    setUpData = Global.getTable("setUpData")
    deploymentCartridge = getObjectFromGUID(setUpData.deploymentCartridgeGUID)
    conditionsCartridge = getObjectFromGUID(setUpData.conditionsCartridgeGUID)
    objectiveCartridge = getObjectFromGUID(setUpData.objectiveCartridgeGUID)
    battlefieldZone = getObjectFromGUID(Global.getVar("battlefieldZoneGUID"))
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    battlefieldTint = gameData.getTable("battlefieldTint")

    -- buttonObjs
    optionObjs = {}
    optionObjs.objective = getObjectFromGUID("9480a7")
    optionObjs.deployment = getObjectFromGUID("538f4d")
    optionObjs.conditions = getObjectFromGUID("c6b3a9")

    optionButtons = {}
    optionButtons.objective = getObjectFromGUID("10483c")
    optionButtons.deployment = getObjectFromGUID("1e6398")
    optionButtons.conditions = getObjectFromGUID("337dc3")

    optionZones = {}
    optionZones.objective = getObjectFromGUID("d0ca46")
    optionZones.deployment = getObjectFromGUID("b74727")
    optionZones.conditions = getObjectFromGUID("ec8c41")

    objectiveMenu()
    deploymentMenu()
    conditionsMenu()
end

function objectiveMenu()
    clearButton("objective")
    createOptionButton("objective", "checkObjective", "Objective", "Spawn Relevant Objective Tokens", {0,0.913,1})
end

function deploymentMenu()
    clearDeploymentBoundary()
    clearButton("deployment")
    createOptionButton("deployment", "checkDeployment", "Deployment", "Create Deployment overlay", {0,0.913,1})
end


function conditionsMenu()
    clearButton("conditions")
    createOptionButton("conditions", "checkConditions", "Conditions", "Spawn Relevant Conditions Tokens", {0,0.913,1})
end

function checkCardCall(cardTable)
    checkCard(cardTable[1])
end

function checkCard(cardType)
    setUpCardData = nil
    zoneObj = nil
    zoneObj = getObjectFromZone(cardType)

    if zoneObj != nil then
        for i, entry in pairs(setUpCards[cardType]) do
            if entry.name == zoneObj.getName() then
                setUpCardData = entry
            end
        end

        if setUpCardData != nil then
            self.call("activate"..cardType, setUpCardData)
        else
            self.call("wrong".. cardType)
        end
    else
        self.call("no".. cardType)
    end
end

function getObjectFromZone(selectedZone)
    local zoneObjs = nil
    local selectedObj =  nil
    local zoneObjs = optionZones[selectedZone].getObjects()
    for i, obj in pairs(zoneObjs) do
        if obj != optionObjs[selectedZone] then
            selectedObj = obj
            break
        end
    end
    if selectedObj != nil then
        return selectedObj
    else
        return nil
    end
end


function spawnObjs(selection,selectedCartridgeObj)

    -- clone cartridge
    local selectedCartridgeObjClone = selectedCartridgeObj.clone({
        position     = {0,-10,0}
    })

    -- get guid
    local selectedCartridgeTable = selectedCartridgeObj.getObjects()

    for i, entry in pairs(selectedCartridgeTable) do
        if entry.name == selection then
            selectedGUID = entry.guid
            break
        end
    end

    selectedCartridgeObjClone.takeObject({
        position       = {0,-10,3},
        callback       = "spawnFromCartridgeDelay",
        callback_owner = self,
        smooth         = false,
        guid           = selectedGUID
    })

    -- delete clone
    destroyObject(selectedCartridgeObjClone)

end



function spawnFromCartridgeDelay(spawnFromCartridgeObj)

    spawnFromCartridgeObj.setLock(true)

    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "spawnObjsFromCartridgeDelay"..timerCounter,
        function_name  = "spawnObjsFromCartridge",
        function_owner = self,
        parameters     = {spawnFromCartridgeObj},
        delay          = 0.1
    })
end

function spawnObjsFromCartridge(selectedCartridgeTable)
    local cartridgeObj = selectedCartridgeTable[1]

    local cartridgeObjs = cartridgeObj.getObjects()

    for i, loadedObj in pairs(cartridgeObjs) do
        takenObj = cartridgeObj.takeObject({
            position       = {-10+(i*0.5),-10,0},
            callback       = "placeObjectDelay",
            callback_owner = self,
            smooth         = false
        })
    end

    destroyObject(cartridgeObj)
end

function placeObjectDelay(passedObj)
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "placeObjectDelay"..timerCounter,
        function_name  = "placeObject",
        function_owner = self,
        parameters     = {passedObj},
        delay          = 0.1
    })
end


function placeObject(pObj)
    local paObj = pObj[1]

    spawnPos = paObj.getTable("position")
    paObj.setPosition(spawnPos)

    spawnRot = paObj.getTable("rotation")
    paObj.setRotation(spawnRot)

    if paObj.getName() == "Deployment Boundary" then
        paObj.setLuaScript("interactable = false")
    else
        paObj.setLuaScript("")
    end

    if paObj.getCustomObject().type == 1 then
        --paObj.setColorTint(gameData.getTable("battlefieldTint"))
    end

    refreshTimer()
    Timer.create({
        identifier     = "spawnObjDebug"..timerCounter,
        function_name  = "spawnObjDebug",
        function_owner = self,
        parameters     = {paObj},
        delay          = 2
    })


end

function spawnObjDebug(objTable)
    --objTable[1].reload()
end

function refreshTimer()
    timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
end

function clearDeploymentBoundary()
    local battlefieldObjs = battlefieldZone.getObjects()
    for _, obj in pairs(battlefieldObjs) do
        if obj.getName() == "Deployment Boundary" then
            destroyObject(obj)
        end
    end
end

function activateobjective(passedData)
    if passedData.tokens == true then
        spawnObjs(passedData.name, objectiveCartridge)
        objectiveMenu()
    else
        noObjectiveTokensMenu()
        resetTimer("objective")
    end
end

function resetTimer(setUpType)
    Timer.destroy(setUpType.."ResetTimer")
    Timer.create({
        identifier     = setUpType.."ResetTimer",
        function_name  = setUpType.."Menu",
        function_owner = self,
        delay          = 4,
        repetitions    = 1
    })
end

function noObjectiveTokensMenu()
    clearButton("objective")
    createOptionButton("objective", "checkObjective", "No Tokens", "No relevant Objective tokens needed", {0.7,0,0})
    resetTimer("objective")
end

function noConditionsTokensMenu()
    clearButton("conditions")
    createOptionButton("conditions", "checkConditions", "No Tokens", "No relevant Conditions tokens needed", {0.7,0,0})
    resetTimer("conditions")
end

function noDeploymentTokensMenu()
    clearButton("deployment")
    createOptionButton("deployment", "checkdDeployment", "No Tokens", "No relevant Objective tokens needed", {0.7,0,0})
    resetTimer("objective")
end

function noDeploymentMenu()
    clearButton("deployment")
    createOptionButton("deployment", "checkDeployment", "No Tokens", "No relevant Objective tokens needed", {0.7,0,0})
    resetTimer("deployment")
end

function activatedeployment(passedData)
    clearDeploymentBoundary()
    spawnObjs(passedData.name, deploymentCartridge)
    deactivateDeploymentMenu()
end

function deactivateDeploymentMenu()
    clearButton("deployment")
    createOptionButton("deployment", "deploymentMenu", "Remove Overlay", "Remove Deployment Overlay", {0.7,0,0})
end

function activateconditions(passedData)
    if passedData.tokens == true then
        spawnObjs(passedData.name, conditionsCartridge)
        objectiveMenu()
    else
        noConditionsTokensMenu()
        resetTimer("conditions")
    end
end

function checkObjective()
    checkCard("objective")
end
function checkDeployment()
    checkCard("deployment")
end
function checkConditions()
    checkCard("conditions")
end

function noobjective()
    clearButton("objective")
    createOptionButton("objective", "checkObjective", "Mount Objective", "No Objective selected, mount objective card below", {0.7,0,0})
    resetTimer("objective")
end

function wrongobjective()
    clearButton("objective")
    createOptionButton("objective", "checkObjective", "Wrong Card", "Wrong Card mounted, mount objective card below", {0.7,0,0})
    resetTimer("objective")
end

function nodeployment()
    clearButton("deployment")
    createOptionButton("deployment", "checkDeployment", "Mount Deployment", "No Deployment selected, mount deployment card below", {0.7,0,0})
    resetTimer("deployment")
end

function wrongdeployment()
    clearButton("deployment")
    createOptionButton("deployment", "checkDeployment", "Wrong Card", "Wrong Card mounted, mount deployment card below", {0.7,0,0})
    resetTimer("deployment")
end

function noconditions()
    clearButton("conditions")
    createOptionButton("conditions", "checkConditions", "Mount Conditions", "No Conditions selected, mount conditions card below", {0.7,0,0})
    resetTimer("conditions")
end

function wrongconditions()
    clearButton("conditions")
    createOptionButton("conditions", "checkConditions", "Wrong Card", "Wrong Card mounted, mount conditions card below", {0.7,0,0})
    resetTimer("conditions")
end


function clearButton(optionSelection)

    optionObjs[optionSelection].clearButtons()

    optionButtons[optionSelection].clearButtons()
    optionButtons[optionSelection].setColorTint({0,0,0})
end

function createOptionButton(optionType, optionClickFunction, optionLabel, optionToolTip, tint)
    optionObj = optionObjs[optionType]
    optionButton = optionButtons[optionType]

    _G["setupControllerOptionFunction"..optionType] = function()
        optionButtons[optionType].AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end
    optionObj.createButton({
        click_function = "setupControllerOptionFunction"..optionType, function_owner = self, label = optionLabel, position = {-0.5, 0.3, -1.95}, scale = {0.5, 0.5, 0.5}, width = 2500, height = 600, font_size = 300, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100},tooltip = optionToolTip
    })

    optionButton.createButton({
        click_function = "setupControllerOptionFunction"..optionType, function_owner = self, label = "", position = {0, 0.65, 0}, width = 1400, height = 1400, font_size = 1100, color = {1,1,1,0.01},font_color = {1,1,1,100}, tooltip = optionToolTip, alignment = 3
    })

    optionButton.setColorTint(tint)
end

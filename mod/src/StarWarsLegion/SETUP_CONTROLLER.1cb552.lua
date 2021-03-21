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

    -- token stacks
    getTokenScripts()

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

function getTokenScripts()
    local conditionTokens = getObjectFromGUID("4d25eb")
    local objectiveTokens = getObjectFromGUID("094239")

    conditionTokens.takeObject({
      callback_function = function(token)
        conditionTokenScript = token.getLuaScript()
        destroyObject(token)
      end
    })
    
    objectiveTokens.takeObject({
      callback_function = function(token)
        objectiveTokenScript = token.getLuaScript()
        destroyObject(token)
      end
    })
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
        callback       = "spawnObjsFromCartridge",
        callback_owner = self,
        smooth         = false,
        guid           = selectedGUID
    })

    -- delete clone
    destroyObject(selectedCartridgeObjClone)

end

function spawnObjsFromCartridge(cartridgeObj)
    Wait.frames(function()
      local cartridgeObjs = cartridgeObj.getObjects()

      for i, loadedObj in pairs(cartridgeObjs) do
          takenObj = cartridgeObj.takeObject({
              position       = {-10+(i*0.5),-10,0},
              callback       = "placeObjectDelay",
              callback_owner = self,
              smooth         = false
          })
      end
      
      local deploymentZone = cartridgeObj.getTable("deploymentZone")
      if deploymentZone != nil then
          spawnDeploymentBoundary(deploymentZone)
      end

      destroyObject(cartridgeObj)
    end)
end

function placeObjectDelay(passedObj)
  Wait.frames(function()
    placeObject(passedObj)
  end)
end

function placeObject(paObj)
    spawnPos = paObj.getTable("position")
    paObj.setPosition(spawnPos)

    spawnRot = paObj.getTable("rotation")
    paObj.setRotation(spawnRot)

    if paObj.getName() == "Deployment Boundary" then
        paObj.setLuaScript("function onLoad() self.interactable = false end")
    elseif paObj.getName() == "Condition Token" then
        paObj.setLuaScript(conditionTokenScript)
    elseif paObj.getName() == "Objective Token" then
        paObj.setLuaScript(objectiveTokenScript)
    elseif paObj.getVar("scripted") != true then
        paObj.setLuaScript("")
    end

    paObj.reload()
end

function spawnDeploymentBoundary(matrix)
    local bAsset = "http://cloud-3.steamusercontent.com/ugc/1738926104368207752/531BBEE87D18C75A19503307A1A07EA9D0E0438A/"
    local rAsset = "http://cloud-3.steamusercontent.com/ugc/1738926104368206955/F087A123F300047E9737292752DE512E10641E3B/"
    local xStart = -25
    local zStart = 15
    local yValue = 20
    -- matrix is in the format of
    -- { x, x, x, x, x, x, x, x, x, x, x, x }
    -- { x, x, x, x, x, x, x, x, x, x, x, x }
    -- { x, x, x, x, x, x, x, x, x, x, x, x }
    -- { x, x, x, x, x, x, x, x, x, x, x, x }
    -- { x, x, x, x, x, x, x, x, x, x, x, x }
    -- { x, x, x, x, x, x, x, x, x, x, x, x }
    -- ... where "x" can either be:
    -- "r" :  red deployment zone
    -- "b" :  blue deployment zone
    -- ""  :  ignore
    for z, row in pairs(matrix) do
      for x, cell in pairs(row) do
        if cell == "r" or cell == "b" then
          local projector = spawnObject({
            type        = "Custom_AssetBundle",
            position    = {
              xStart + (6 * (x - 1)),
              yValue,
              zStart - (6 * (z - 1)),
            },
            scale       = {0, 0, 0},
          })
          local asset = rAsset
          if cell == "b" then
            asset = bAsset
          end
          projector.setName("Deployment Boundary")
          projector.setLock(true)
          projector.setCustomObject({
            assetbundle = asset,
          })
        end
      end
    end
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

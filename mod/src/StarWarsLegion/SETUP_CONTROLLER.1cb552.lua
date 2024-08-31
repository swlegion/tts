require('!/Deck')
require('!/Shelf')

function onload(save_state)
    _G.Deck = Deck:create()
    _G.Shelf = Shelf:create()
    self.interactable = false

    -- intialize
    setUpCards = Global.getTable("setUpCards")
    setUpData = Global.getTable("setUpData")
    battlefieldZone = getObjectFromGUID(Global.getVar("battlefieldZoneGUID"))
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
    battlefieldTint = gameData.getTable("battlefieldTint")

    -- token scripts
    _G.scriptRange1Token = nil
    _G.scriptBombCart = nil
    _G.scriptPOIToken = nil
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

    _G.selectedScenario = "standard"
    drawInput()
end

function drawInput()
  self.clearInputs()
  self.createInput({
    input_function = "scenarioChanged",
    function_owner = self,
    label          = "Scenario",
    alignment      = 3,
    position       = {x = -3.0, y = 0.2, z = 0},
    rotation       = {x = 0, y = 180, z = 0},
    width          = 2000,
    height         = 350,
    font_size      = 323,
    validation     = 4,
    value          = _G.selectedScenario,
    tooltip        = "Battlefield Deck Type",
  })
end

function scenarioChanged(_, _, input, editing)
  if input and not editing then
    _G.selectedScenario = input
  end
end

function changeScenario(params)
  _G.selectedScenario = params[1]
  drawInput()
end

function getTokenScripts()
  getObjectFromGUID("4d25eb").takeObject({
    callback_function = function(token)
      _G.scriptRange1Token = token.getLuaScript()
      destroyObject(token)
    end
  })
  _G.scriptBombCart = getObjectFromGUID("b497e1").getLuaScript()
  getObjectFromGUID("094230").takeObject({
    callback_function = function(poi)
      _G.scriptPOIToken = poi.getLuaScript()
      destroyObject(poi)
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
  return checkCard(cardTable[1])
end

function checkCard(cardType)
  local battleDeckScenario = _G.selectedScenario
  setUpCardData = nil
  zoneObj = nil
  zoneObj = getObjectFromZone(cardType)

  if zoneObj then
    local name = zoneObj.getName()
    local type = Deck:getBattleCardType(name, battleDeckScenario)
    -- TODO: Clean up once there is a better mechanism for these types of cards.
    if not type then
      return false
    end
    if type == "condition" then
      type = "conditions"
    end
    if type:upper() == cardType:upper() then
      self.call("activate"..type, name)
    else
      self.call("wrong".. type)
    end
  else
    self.call("no".. cardType)
  end
  return true
end

function getObjectFromZone(selectedZone)
    local zoneObjs = nil
    local selectedObj =  nil
    local zoneObjs = optionZones[selectedZone].getObjects()
    for i, obj in pairs(zoneObjs) do
        if obj ~= optionObjs[selectedZone] then
            selectedObj = obj
            break
        end
    end
    if selectedObj ~= nil then
        return selectedObj
    else
        return nil
    end
end


function spawnObjs(cardType, selectedBattleCardName)
  local objects = Deck:getBattleCardObjects(
    selectedBattleCardName,
    cardType,
    _G.selectedScenario
  )
  if #objects == 0 then
    return
  end
  local position = ({
    objective  = {49, 1, 16},
    deployment = {49, 1, 12},
    condition  = {49, 1, 08}, 
  })[cardType:lower()]
  Shelf:spawnAdditionalObjects({
    name     = selectedBattleCardName .. "'s Objects",
    position = position,
    objects  = objects,
    -- TODO: Make this global somehow instead.
    scripts  = {
      ["toggle-range-1"] = _G.scriptRange1Token,
      ["bomb-cart"]      = _G.scriptBombCart,
      ["poi-token"]      = _G.scriptPOIToken
    }
  })
end

local xStart = -25
local zStart = 15
local yValue = 20

local deployLinks = {}
  deployLinks.r = "http://cloud-3.steamusercontent.com/ugc/1738944060882006204/75F636F4133C5F85682ECDEBBECB9F6CD821315F/"
  deployLinks.rh = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708249497/CC08277B7D876CF1FFCEDD3FC499AC38034B36D8/"
  deployLinks.rs = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708249497/CC08277B7D876CF1FFCEDD3FC499AC38034B36D8/"
  deployLinks.rss = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708249497/CC08277B7D876CF1FFCEDD3FC499AC38034B36D8/"
  deployLinks.rl = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708336160/21601D81F35521B72E015AA6316913521943E73F/"
  deployLinks.rc = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708336119/D74B484417970BC524ED4624932102C6BF956E91/"
  deployLinks.rcc = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708336119/D74B484417970BC524ED4624932102C6BF956E91/"
  deployLinks.b = "http://cloud-3.steamusercontent.com/ugc/1738944060882006162/077B3B0AE278E39363F5BD3AE070B5AE36F025FA/"
  deployLinks.bh = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708249441/767C99D0983A24618F97511192498FBEED1557F2/"
  deployLinks.bs = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708249441/767C99D0983A24618F97511192498FBEED1557F2/"
  deployLinks.bss = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708249441/767C99D0983A24618F97511192498FBEED1557F2/"
  deployLinks.bl = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708335699/9EF627695432090869A748114A0ED41B262FAE46/"
  deployLinks.bc = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708335638/DB6B86B4DA42884BDF3D899DD66AF5DBD94263B8/"
  deployLinks.bcc = "https://steamusercontent-a.akamaihd.net/ugc/2491139050708335638/DB6B86B4DA42884BDF3D899DD66AF5DBD94263B8/"

local deployRotations = {}
  deployRotations.r = 0 
  deployRotations.rh = 0
  deployRotations.rs = 90
  deployRotations.rss = 90
  deployRotations.rl = 0
  deployRotations.rc = 0
  deployRotations.rcc = 0
  deployRotations.b = 0
  deployRotations.bh = 0
  deployRotations.bs = 90
  deployRotations.bss = 90
  deployRotations.bl = 0
  deployRotations.bc = 0
  deployRotations.bcc = 0

local deployOffset = {}
  deployOffset.r = {0, 0, 0}
  deployOffset.rh = {0, 0, -1.5}
  deployOffset.rs = {1.5, 0, 0}
  deployOffset.rss = {-1.5, 0, 0}
  deployOffset.rl = {0, 0, 0}
  deployOffset.rc = {1.5, 0, -1.5}
  deployOffset.rcc = {-1.5, 0, -1.5}
  deployOffset.b = {0, 0, 0}
  deployOffset.bh = {0, 0, 1.5}
  deployOffset.bs = {-1.5, 0, 0}
  deployOffset.bss = {1.5, 0, 0}
  deployOffset.bl = {0, 0, 0}
  deployOffset.bc = {-1.5, 0, 1.5}
  deployOffset.bcc = {1.5, 0, 1.5}

function AddVectors(vectorA, vectorB)
  vectorA[1] = vectorA[1] + vectorB[1]
  vectorA[2] = vectorA[2] + vectorB[2]
  vectorA[3] = vectorA[3] + vectorB[3]
  return vectorA  
end

function spawnBoundaryCell(cell, x, z)
  local asset = deployLinks[cell]
  local offset = deployOffset[cell]
  local pos = {
    xStart + (6 * (x - 1)),
    yValue,
    zStart - (6 * (z - 1)),
  }

  pos = AddVectors(pos, offset)

  local projector = spawnObject({
    type        = "Custom_AssetBundle",
    position    = pos,
    scale       = {0, 0, 0},
    rotation    = {0, deployRotations[cell], 0}
  })
  projector.setName("Deployment Boundary")
  projector.setLock(true)
  projector.setCustomObject({
    assetbundle = asset,
  })
end

function spawnDeploymentBoundary(matrix)
    local function invertMatrix(input)
      -- See https://github.com/swlegion/tts/issues/275.
      local output = {}
      local height = #input
      local width  = #input[1]
      for y = 1, height, 1 do
        output[y] = {}
        for x = 1, width, 1 do
          output[y][x] = " "
        end
      end
      for y = 1, height, 1 do
        for x = 1, width, 1 do
          output[y][x] = input[height + 1 - y][width + 1 - x]
        end
      end
      return output
    end
    
    matrix = invertMatrix(matrix)
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
        if cell == " " then
          -- skip the blank cells
        elseif cell == "bl" then
          spawnBoundaryCell("bs", x, z)
          spawnBoundaryCell("bcc", x, z)
        elseif cell == "rl" then
          spawnBoundaryCell("rs", x, z)
          spawnBoundaryCell("rcc", x, z)
        else
          spawnBoundaryCell(cell, x, z)
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

function activateobjective(name)
  spawnObjs("objective", name)
  objectiveMenu()
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

function activatedeployment(name)
    clearDeploymentBoundary()
    local zone = Deck:getDeploymentBoundary(name, _G.selectedScenario)
    if zone and #zone > 0 then
      spawnDeploymentBoundary(zone)
    end
    deactivateDeploymentMenu()
    spawnObjs("deployment", name)
end

function deactivateDeploymentMenu()
    clearButton("deployment")
    createOptionButton("deployment", "deploymentMenu", "Remove Overlay", "Remove Deployment Overlay", {0.7,0,0})
end

function activateconditions(name)
  spawnObjs("condition", name)
  objectiveMenu()
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

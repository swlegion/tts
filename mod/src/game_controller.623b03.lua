function onLoad(save_state)
    -- init values
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
    battlefieldTint = gameData.getTable("battlefieldTint")

    gameController = Global.getTable("gameController")
    mountZone = getObjectFromGUID(gameController.mountZoneGUID)
    battlefieldZone = getObjectFromGUID(Global.getVar("battlefieldZoneGUID"))
    competitiveTerrainZone = getObjectFromGUID(Global.getVar("competitiveTerrainZoneGUID"))
    battlefieldTable = getObjectFromGUID(Global.getVar("battlefieldTable"))
    standardMapsCartridge = getObjectFromGUID(gameController.standardMapsGUID)
    battleLinesCompetitiveMapsCartridge = getObjectFromGUID(gameController.battleLinesCompetitiveMapsGUID)
    battleLinesCreativeMapsCartridge = getObjectFromGUID(gameController.battleLinesCreativeMapsGUID)
    customMapsCartridge = getObjectFromGUID(gameController.customMapsGUID)
    competitiveTerrainCartridge = getObjectFromGUID(gameController.competitiveTerrainCartridgeGUID)
    deploymentOverlays = getObjectFromGUID(gameController.deploymentOverlaysGUID)
    tournamentMapsCartridge = getObjectFromGUID(gameController.tournamentMapsGUID)
    learningGameCartridge = getObjectFromGUID(gameController.learningGameCartridgeGUID)
    userMapsCartridge = getObjectFromGUID(gameController.userMapsGUID)
    gatheringLegionsMapsCartridge = getObjectFromGUID(gameController.gatheringLegionsMapsGUID)
    listBuilder = Global.getTable("listBuilder")
    redZone = getObjectFromGUID(listBuilder.redZoneGUID)
    blueZone = getObjectFromGUID(listBuilder.blueZoneGUID)
    unitInfo = Global.getTable("unitInfo")
    miniInfo = Global.getTable("miniInfo")
    cardInfo = Global.getTable("cardInfo")
    screen = getObjectFromGUID(Global.getVar("screenGUID"))
    objectiveCards = getObjectFromGUID(gameController.objectiveCardsGUID)
    deploymentCards = getObjectFromGUID(gameController.deploymentCardsGUID)
    conditionsCards = getObjectFromGUID(gameController.conditionsCardsGUID)
    setUpData = Global.getTable("setUpData")
    setUpData.deploymentMount = getObjectFromGUID(setUpData.deploymentMountGUID)
    setUpData.conditionsMount = getObjectFromGUID(setUpData.conditionsMountGUID)
    setUpData.objectiveMount = getObjectFromGUID(setUpData.objectiveMountGUID)
    commandTokenTrayData = Global.getTable("commandTokenTrayData")
    commandTokenData = Global.getTable("commandTokenData")
    zonesGUIDs = Global.getTable("zonesGUIDs")

    setUpController = getObjectFromGUID(Global.getVar("setUpControllerGUID"))
    setUpCards = Global.getTable("setUpCards")
    battleDeckTypes = {"deployment", "objective", "conditions"}

    blueDeckMount = getObjectFromGUID(listBuilder.blueDeckMountGUID)
    redDeckMount = getObjectFromGUID(listBuilder.redDeckMountGUID)
    blueDeckZone = getObjectFromGUID(listBuilder.blueDeckZoneGUID)
    redDeckZone = getObjectFromGUID(listBuilder.redDeckZoneGUID)


    -- button Models
    dataDiskMount = getObjectFromGUID("a44dcb")

    optionObjs = {}

    optionObjs.gameControllerOption1 = getObjectFromGUID("9200f4")
    optionObjs.gameControllerOption2 = getObjectFromGUID("de5eb8")
    optionObjs.gameControllerOption3 = getObjectFromGUID("44c5b4")
    optionObjs.gameControllerOption4 = getObjectFromGUID("a4448e")
    optionObjs.gameControllerOption5 = getObjectFromGUID("971605")

    optionButtons = {}

    optionButtons.gameControllerOption1Button = getObjectFromGUID("4663eb")
    optionButtons.gameControllerOption2Button = getObjectFromGUID("3c301d")
    optionButtons.gameControllerOption3Button = getObjectFromGUID("05d327")
    optionButtons.gameControllerOption4Button = getObjectFromGUID("6cfaf1")
    optionButtons.gameControllerOption5Button = getObjectFromGUID("3cd1bf")

    backButton = getObjectFromGUID("ae44c9")
    prevButton = getObjectFromGUID("f563ce")
    nextButton = getObjectFromGUID("d81a06")

    homeScreen()
    mainMenu()
end

function homeScreen()
    screen.createButton({click_function = "dud", function_owner = self, label = "", position = {0.9, 0.25, 0}, rotation = {0, -90, 90}, scale = {0.5, 0.5, 0.5}, width = 0, height = 0, font_size = 100, font_color = {0.8867, 0.7804, 0, 1}, alignment = 1})
    printToScreen("STAR WARS LEGION TTS MOD\n by Tieren\n\nSelect an option below to start", 80, 3)
end


-- MENU

function mainMenu()
    timerScreen = false

    printToScreen("STAR WARS LEGION TTS MOD\n by Tieren\n\nSelect an option below to start", 80, 3)

    clearAllButtons()
    local menuEntries = {}
    menuEntries[1] = {functionName = "learningGameMenu", label = "Learning Game", tooltip = "Play a Learning Game", buttonTint = {0,0.913,1}}
    --menuEntries[2] = {functionName = "setUpMenu", label = "Guided Setup", tooltip = "Guided Setup of a Legion game", buttonTint = {0,0.913,1}}
    menuEntries[2] = {functionName = "mapMenu", label = "Maps", tooltip = "Map Menu", buttonTint = {0,0.913,1}}
    menuEntries[3] = {functionName = "gameOptionsMenu", label = "Set Up", tooltip = "Set Up options menu", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)

end

function defineBattlefieldMenuBlue()
    blueDeckMount.call("checkDeck")
end

function enterTintData(obj, dataString, tintTable)
    local tintString =  "{r = "..tintTable.r..", g = "..tintTable.g..", b = "..tintTable.b.."}"
    enterData(obj, dataString, tintString)
    obj.setTable(dataString, tintTable)
end

function enterData(obj, dataString, newValue)
    dataScript = obj.getLuaScript()
    dataString = dataString .. " = "
    local stringStart = 0
    local valueStart = 0
    stringStart, valueStart = string.find(dataScript, dataString)
    valueStart = valueStart

    local valueEnd = 0
    local valueNil = 0
    valueEnd, valueNil = string.find(dataScript, "\n", valueStart)
    valueEnd = valueEnd

    local newDataScript = string.sub(dataScript, 1, valueStart).. newValue .. string.sub(dataScript, valueEnd)

    obj.setLuaScript(newDataScript)
end

function reset()
    clearSetUpCards("all")
    mainMenu()
end



function debug()
    local battlefieldObjs = battlefieldZone.getObjects()
    local competitiveObjs = competitiveTerrainZone.getObjects()
    local redObjs = redZone.getObjects()
    local blueObjs = blueZone.getObjects()
    removeLockedRulers()
    reloadObj(battlefieldObjs)
    reloadObj(competitiveObjs)
    reloadObj(redObjs)
    reloadObj(blueObjs)
end

function reloadObj(selectedObjs)
    for _, obj in pairs(selectedObjs) do
        if obj.getName() == "Movement Template" then
            destroyObject(obj)
        else
            obj.reload()
        end

    end
end

function removeLockedRulers()
    local allObjs = getAllObjects()
    for _, obj in pairs(allObjs) do
        if obj.getName() == "Cohesion Ruler" or obj.getName() == "Range Ruler" then
            destroyObject(obj)
        end
    end
end

function learningGameMenu()
    clearPlayerZones()
    clearZones()
    learningGameCartridgeClone = learningGameCartridge.clone({position = {0,-20,0}})

    spawnFromCartridgeDelay(learningGameCartridgeClone)

    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "standbyTokens"..timerCounter,
        function_name  = "standbyTokens",
        function_owner = self,
        delay          = 5
    })

end

function standbyTokens()
    local allObjs = getAllObjects()
    for i, obj in pairs(allObjs) do
        if obj.getVar("isAToken") == true then
            obj.call("standby")
        end
    end
end

function clearPlayerZones()
    local redZoneObjs = redZone.getObjects()
    local blueZoneObjs = blueZone.getObjects()

    for i, obj in pairs(redZoneObjs) do
        if obj != battlefieldTable then
            destroyObject(obj)
        end
    end
    for i, obj in pairs(blueZoneObjs) do
        if obj != battlefieldTable then
            destroyObject(obj)
        end
    end
end

function defineBattlefieldMenu(selectedDeck)
    clearAllButtons()
    changeBackButton("reset", "Go back to Main Menu")
    local menuEntries = {}
    menuEntries[1] = {functionName = "finishDefineBattlefieldMenu", label = "NEXT", tooltip = "NEXT", buttonTint = {0,0.913,1}}
    createMenu(menuEntries, 1)
    revealBattleCards(selectedDeck)
    printToScreen("DEFINE BATTLEFIELD\nStarting with Blue player, players eliminate left most card.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 60, 2)
end

function finishDefineBattlefieldMenu()
    defineBattlefield()
    spawnObjectiveConditionsDelay()
    mainMenu()
end

function gameOptionsMenu()
    clearAllButtons()
    changeBackButton("mainMenu", "Go back to Main Menu")
    local menuEntries = {}
    menuEntries[1] = {functionName = "switchPlayerColor", label = "Switch Player Colors", tooltip = "Switch Player Colors", buttonTint = {0,0.913,1}}
    menuEntries[2] = {functionName = "flipMap", label = "Flip Map", tooltip = "Flip the map to the other side", buttonTint = {0,0.913,1}}
    menuEntries[3] = {functionName = "defineBattlefieldMenuBlue", label = "Blue Player: Define Battlefield", tooltip = "Spawn Battlefield Objective, Deployment and Condition cards from Blue Deck", buttonTint = {0,0.913,1}}
    menuEntries[4] = {functionName = "debug", label = "Debug Objects", tooltip = "Corrects terrain that is spawned incorrectly or removes stuck rulers or movement templates", buttonTint = {0,0.913,1}}
    --menuEntries[5] = {functionName = "defineBattlefieldMenu", label = "Define Battlefield from all cards", tooltip = "Spawn Battlefield Objective, Deployment and Condition cards from every available card", buttonTint = {0,0.913,1}}
    createMenu(menuEntries, 1)
end

function mapMenu()
    printToScreen("MAP MENU", 80, 3)

    clearAllButtons()
    changeBackButton("mainMenu", "Go back to Main Menu")

    callBackMapMenu = "mapMenu"

    local menuEntries = {}
    menuEntries[1] = {functionName = "premadeMapsMenu", label = "Pre-made Maps", tooltip = "Spawn a Pre-made Map", buttonTint = {0,0.913,1}}
    menuEntries[2] = {functionName = "competitiveTerrainMapMenu", label = "Competitive Terrain Map", tooltip = "Create a Competitive Terrain Map", buttonTint = {0,0.913,1}}
    menuEntries[3] = {functionName = "loadMap", label = "Load Map", tooltip = "Load Map from Data Cartridge", buttonTint = {0,0.913,1}}
    menuEntries[4] = {functionName = "saveMap", label = "Save Map", tooltip = "Save Map to a Data Cartridge", buttonTint = {0,0.913,1}}
    menuEntries[5] = {functionName = "flipMap", label = "Flip Map", tooltip = "Flip the map to the other side", buttonTint = {0,0.913,1}}
    menuEntries[6] = {functionName = "customMapMenu", label = "Custom Maps", tooltip = "Create a Custom Map", buttonTint = {0,0.913,1}}
    menuEntries[7] = {functionName = "clearZones", label = "Clear Map", tooltip = "Clears everything from current Battlefield area", buttonTint = {0,0.913,1}}
    createMenu(menuEntries, 1)
end

function deploymentMenu()
    clearAllButtons()

    changeBackButton("mainMenu", "Go back to Main Menu")
    createMapMenu(deploymentOverlays)
end

function premadeMapsMenu(callBackMapMenu)
    printToScreen("PREMADE MAPS", 80, 3)
    if callBackMapMenu == "mapMenu" or callBackMapMenu == nil then
        clearAllButtons()
        changeBackButton("mapMenu", "Go back to Maps Menu")
        callBackSelection = "mapMenu"
    else
        callBackSelection = callBackMapMenu
    end

    local menuEntries = {}
    menuEntries[1] = {functionName = "standardMapsMenu", label = "Standard Maps", tooltip = "Choose a standard map", buttonTint = {0,0.913,1}}
    menuEntries[2] = {functionName = "tournamentMapsMenu", label = "Tournament Maps", tooltip = "Choose a tournament Map", buttonTint = {0,0.913,1}}
    menuEntries[3] = {functionName = "randomTournamentMapsMenu", label = "Random Tournament Map", tooltip = "Spawn a random tournament map", buttonTint = {0,0.913,1}}
    menuEntries[4] = {functionName = "gatheringLegionsMapsMenu", label = "Gathering Legions Maps", tooltip = "Choose a Gathering Legions map", buttonTint = {0,0.913,1}}
    menuEntries[5] = {functionName = "battleLinesMapsMenu", label = "Battle Lines Maps", tooltip = "Choose a Battle lines map", buttonTint = {0,0.913,1}}
    menuEntries[6] = {functionName = "userMapsMenu", label = "User Made Maps", tooltip = "Choose an user submitted map", buttonTint = {0,0.913,1}}
    createMenu(menuEntries, 1)
end

function standardMapsMenu()
    printToScreen("STANDARD MAPS", 80, 3)
    clearAllButtons()

    changeBackButton("premadeMapsMenu", "Go back to Pre-made Maps Menu")
    createMapMenu(standardMapsCartridge, callBackSelection)
end

function userMapsMenu()
    printToScreen("USER SUBMITTED MAPS\n\nChoose a user made map from below\n\nIf you would like to submit your map, pm \nTieren on Steam.\nOr, submit the map to your own workshop!", 70, 3)

    clearAllButtons()

    changeBackButton("premadeMapsMenu", "Go back to Pre-made Maps Menu")
    createMapMenu(userMapsCartridge, callBackSelection)
end

function gatheringLegionsMapsMenu()
    printToScreen("GATHERING LEGIONS MAPS\n\nChoose a user made map from below\n\nIf you would like to submit your map, pm \nTieren on Steam.\nOr, submit the map to your own workshop!", 70, 3)

    clearAllButtons()

    changeBackButton("premadeMapsMenu", "Go back to Pre-made Maps Menu")
    createMapMenu(gatheringLegionsMapsCartridge, callBackSelection)
end

function battleLinesMapsMenu()
    changeBackButton("premadeMapsMenu", "Go back to Pre-made Maps Menu")

    local menuEntries = {}
    menuEntries[1] = {functionName = "battleLinesCompetitiveMapsMenu", label = "Competitive Maps", tooltip = "Choose a competitive map", buttonTint = {0,0.913,1}}
    menuEntries[2] = {functionName = "battleLinesCreativeMapsMenu", label = "Creative Maps", tooltip = "Choose a Creative Map", buttonTint = {0,0.913,1}}
    createMenu(menuEntries, 1)
end

function battleLinesCompetitiveMapsMenu()
    printToScreen("BATTLE LINES MAPS\n\nChoose a user made map from below\n\nIf you would like to submit your map, pm \nTieren on Steam.\nOr, submit the map to your own workshop!", 70, 3)

    clearAllButtons()

    changeBackButton("battleLinesMapsMenu", "Go back to Battle Lines Maps Menu")
    createMapMenu(battleLinesCompetitiveMapsCartridge, callBackSelection)
end

function battleLinesCreativeMapsMenu()
    printToScreen("BATTLE LINES MAPS\n\nChoose a user made map from below\n\nIf you would like to submit your map, pm \nTieren on Steam.\nOr, submit the map to your own workshop!", 70, 3)

    clearAllButtons()

    changeBackButton("battleLinesMapsMenu", "Go back to Battle Lines Maps Menu")
    createMapMenu(battleLinesCreativeMapsCartridge, callBackSelection)
end

function tournamentMapsMenu()
    printToScreen("INVADER LEAGUE TOURNAMENT MAPS", 80, 3)
    clearAllButtons()

    changeBackButton("premadeMapsMenu", "Go back to Pre-made Maps Menu")
    createMapMenu(tournamentMapsCartridge, callBackSelection)
end

function randomTournamentMapsMenu()
  tournamentMapsCartridge.shuffle()
  local tournamentMapObjs = tournamentMapsCartridge.getObjects()

    -- Bag or Deck returns {{string name, string description, string guid, int index, string lua_script, string lust_script_state}, ...}
  spawnPremadeMap(tournamentMapObjs[1].name, tournamentMapsCartridge, "mainMenu")
end

function createMapMenu(selectedCartridge, mapMenuCallback)

    local selectedMapsTable = selectedCartridge.getObjects()

    local menuEntries = {}

    for iM, entry in pairs(selectedMapsTable) do
        _G["spawnCustomMap"..entry.name] = function() spawnPremadeMap(entry.name, selectedCartridge, mapMenuCallback) end

        table.insert(menuEntries, {functionName = "spawnCustomMap"..entry.name, label = entry.name, tooltip = "Load ".. entry.name .." map", buttonTint = {0,0.913,1}})
    end

    createMenu(menuEntries, 1)
end

function createCompetitiveTerrainMapMenuback(selectedCartridge, mapMenuCallback)

    local selectedMapsTable = competitiveTerrainCartridge.getObjects()

    local menuEntries = {}

    for iM, entry in pairs(selectedMapsTable) do
        _G["spawnCustomMap"..entry.name] = function() spawnPremadeMap(entry.name, selectedCartridge, mapMenuCallback) spawnPremadeMap(entry.name, competitiveTerrainCartridge, nil, false) end

        table.insert(menuEntries, {functionName = "spawnCustomMap"..entry.name, label = entry.name, tooltip = "Load ".. entry.name .." map", buttonTint = {0,0.913,1}})
    end

    createMenu(menuEntries, 1)
end

function customMapMenu()
    clearAllButtons()
    changeBackButton("mapMenu", "Go back to Maps Menu")
    createMapMenu(customMapsCartridge, "mapMenu")

end

function competitiveTerrainMapMenu()
    clearAllButtons()
    changeBackButton("mapMenu", "Go back to Maps Menu")

    createMapMenu(competitiveTerrainCartridge, "mapMenu")
end

-- SETUP Menu
function setUpMenu()
    clearAllButtons()
    local menuEntries = {}
    menuEntries[1] = {functionName = "tournamentSetUp", label = "Tournament Game", tooltip = "Guided setup for a Tournament game", buttonTint = {0,0.913,1}}
    menuEntries[2] = {functionName = "standardSetUp", label = "Standard Game", tooltip = "Guided setup for a Standard game", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("mainMenu", "Go back to Main Menu")

    printToScreen("Choose Game Type", 80, 3)
end

function tournamentSetUp()
    gameMode = "tournament"
    setUp1AEstablishBattlefieldMenu()
end
function standardSetUp()
    gameMode = "standard"
    setUp1AEstablishBattlefieldMenu()
end

function setUp1AEstablishBattlefieldMenu()
    clearAllButtons()
    local menuEntries = {}
    menuEntries[5] = {functionName = "setUp1BEstablishBattlefieldMenu", label = "NEXT", tooltip = "Next", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUpMenu", "Go back to game type selection")

    if gameMode == "tournament" then
        printToScreen("1A. ESTABLISH BATTLEFIELD AND GATHER COMPONENTS.\n\n\nBoth Players insert Army Data Disk and load their armies.\n\nUI Menu > Objects > Saved Objects > Your Army list\nInsert disk into disk mount and select 'Load Army'", 60, 2)
    elseif gameMode == "standard" then
        printToScreen("1A. ESTABLISH BATTLEFIELD AND GATHER COMPONENTS.\n\n\nBoth Players insert Army Data Disk and load their armies.\nUI Menu > Objects > Saved Objects > Your Army list\nInsert disk into disk mount and select 'Load Army'\n\nOR\n\nPlayers create their army lists and Spawn Minis\nSelect 'Create Army' then 'Spawn Minis'", 60, 2)
    end
end

function setUp1BEstablishBattlefieldMenu()
    clearAllButtons()
    local menuEntries = {}
    menuEntries[5] = {functionName = "setUp1CMapType", label = "NEXT", tooltip = "Next", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp1AEstablishBattlefieldMenu", "Go back to Step 1A")

    if gameMode == "tournament" then
        printToScreen("1B. ESTABLISH BATTLEFIELD AND GATHER COMPONENTS.\n\n\nBoth Players make sure opponent's lists are legal.\n\nIf an opponent list is illegal, the opponent recieves an\nimmediate Match Loss with 0 Victory Points while the\nother player recieves a Match Win with 1 Victory Point.\nIf both players agree, a player with an illegal list can\nremake his list.\n\nLegal Force Chart:\nCommander: 1-2\nCorp: 3-6\nSpecial Forces: No current legal units\nSupport: 0-3\nHeavy: 0-2", 60, 2)
    elseif gameMode == "standard" then
        setUp1CMapType()
    end
end

function setUp1CMapType()
    clearAllButtons()
    local menuEntries = {}


    if gameMode == "tournament" then
        setUp1CMapTypeCompetitive()
    elseif gameMode == "standard" then
        menuEntries[1] = {functionName = "setUp1CMapTypePremade", label = "Premade Map", tooltip = "Next", buttonTint = {0,0.913,1}}
        menuEntries[2] = {functionName = "setUp1CMapTypeCompetitive", label = "Competitive Placement", tooltip = "Next", buttonTint = {0,0.913,1}}

        createMenu(menuEntries, 1)
        changeBackButton("setUp1AEstablishBattlefieldMenu", "Go back to Step 1A")

        printToScreen("CHOOSE MAP TYPE", 60, 2)
    end
end

function setUp1CMapTypePremade()
    mapType = "premade"
    setUp3APlaceTerrain()
end

function setUp1CMapTypeCompetitive()
    mapType = "competitive"
    setUp1DMapTypeBoard()
end

function setUp1DMapTypeBoard()
    clearAllButtons()
    changeBackButton("setUp1AEstablishBattlefieldMenu", "Go back to Step 1C")
    printToScreen("Choose Custom Map Board", 60, 2)
    if gameMode == "standard" then
        createMapMenu(competitiveTerrainCartridge, "setUp2ADeclareTerrain", true)
    else
        competitiveTerrainCartridge.shuffle()
        local availableCompetitiveMaps = competitiveTerrainCartridge.getObjects()

        spawnPremadeMap(availableCompetitiveMaps[1].name, competitiveTerrainCartridge, "setUp2ADeclareTerrain", true)

    end


end

function setUp2ADeclareTerrain()

    clearAllButtons()
    local menuEntries = {}
    menuEntries[5] = {functionName = "setUp3APlaceTerrain", label = "NEXT", tooltip = "Next", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp1AEstablishBattlefieldMenu", "Go back to Step 1C")

    if gameMode == "tournament" and mapType == "premade" then
        printToScreen("1B. ESTABLISH BATTLEFIELD AND GATHER COMPONENTS.\n\n\nBoth Players make sure opponent's lists are legal.\n\nIf an opponent list is illegal, the opponent recieves an\nimmediate Match Loss with 0 Victory Points while the\nother player recieves a Match Win with 1 Victory Point.\nIf both players agree, a player with an illegal list can\nremake his list.\n\nLegal Force Chart:\nCommander: 1-2\nCorp: 3-6\nSpecial Forces: No current legal units\nSupport: 0-3\nHeavy: 0-2", 60, 2)
    elseif gameMode == "standard" and mapType == "competitive" then
        printToScreen("2A. DECLARE TERRAIN\n\nBoth players mutually agree on each terrain cover and\nmovement restrictions.\n\nAll terrain cover and movement info are in their model's\ndescriptions.\nMouse over terrain and hold to see descriptions.", 60, 2)
    elseif gameMode == "tournament" and mapType == "competitive" then
        printToScreen("2A. DECLARE TERRAIN\n\nBoth players mutually agree on each terrain cover and\nmovement restrictions.\n\nAll terrain cover and movement info are in their model's\ndescriptions.\nMouse over terrain and hold to see descriptions.", 60, 2)
    end
end

function setUp3APlaceTerrain()
    clearAllButtons()

    if mapType == "premade" and gameMode == "tournament" then
        changeBackButton("setUp1CMapType", "Go back to Step 1C")
        createMapMenu(tournamentMapsCartridge,"setUp3BPlaceTerrain")

        printToScreen("3A. PLACE TERRAIN.\n\n\nSelect map assigned to players in brackets", 60, 2)
    elseif mapType == "premade" and gameMode == "standard" then
        changeBackButton("setUp1CMapType", "Go back to Step 1C")
        premadeMapsMenu("setUp3BPlaceTerrain")
        printToScreen("3A. PLACE TERRAIN.\n\n\nSelect one of the premade maps to play on", 60, 2)
    elseif mapType == "competitive" and gameMode == "standard" then
        unlockBoard()

        changeBackButton("setUp2ADeclareTerrain", "Go back to Step 2A")
        local menuEntries = {}
        menuEntries[1] = {functionName = "lockBoard", label = "Lock Board", tooltip = "Lock all terrain pieces on board", buttonTint = {0,0.913,1}}
        menuEntries[2] = {functionName = "unlockBoard", label = "Unlock Board", tooltip = "Unlock all terrain pieces on board", buttonTint = {0,0.913,1}}
        menuEntries[5] = {functionName = "setUp3BPlaceTerrain", label = "NEXT", tooltip = "Next", buttonTint = {0,0.913,1}}

        createMenu(menuEntries, 1)

        printToScreen("3A. PLACE TERRAIN.\n\n\n 1.Both Players players set aside an even number of\nterrain pieces that cover a quarter of the battlefield\n\n2.Starting with the player with lowest points, players\ntake turn placing terrain range 1 away from each other.\nIf terrain cannot be placed beyond range 1, then terrain\ncan be placed anywhere.", 60, 2)
    elseif mapType == "competitive" and gameMode == "tournament" then
        unlockBoard()

        changeBackButton("setUp2ADeclareTerrain", "Go back to Step 2A")
        local menuEntries = {}
        menuEntries[1] = {functionName = "lockBoard", label = "Lock Board", tooltip = "Lock all terrain pieces on board", buttonTint = {0,0.913,1}}
        menuEntries[2] = {functionName = "unlockBoard", label = "Unlock Board", tooltip = "Unlock all terrain pieces on board", buttonTint = {0,0.913,1}}
        menuEntries[5] = {functionName = "setUp3BPlaceTerrain", label = "NEXT", tooltip = "Next", buttonTint = {0,0.913,1}}

        createMenu(menuEntries, 1)

        printToScreen("3A. PLACE TERRAIN.\n\n\n 1.Both Players players set aside an even number of\nterrain pieces that cover a quarter of the battlefield\n\n2.Starting with the player with lowest points, players\ntake turn placing terrain range 1 away from each other.\nIf terrain cannot be placed beyond range 1, then terrain\ncan be placed anywhere.", 60, 2)
    end
end

function setUp3BPlaceTerrain()

    if mapType == "premade" then
        clearAllButtons()
        local menuEntries = {}
        menuEntries[5] = {functionName = "setUp4ASelectPlayerColorAndSides", label = "NEXT", tooltip = "Next", buttonTint = {0,0.913,1}}

        createMenu(menuEntries, 1)
        changeBackButton("setUp3APlaceTerrain", "Go back to Step 3A")

        printToScreen("3B. DECLARE TERRAIN\n\nBoth players mutually agree on each terrain cover and\nmovement restrictions.\n\nAll terrain cover and movement info are in their model's\ndescriptions.\nMouse over terrain and hold to see descriptions.", 60, 2)
    elseif mapType == "competitive" then
        lockBoard()
        setUp4ASelectPlayerColorAndSides()
    end
end

function lockBoard()
    local allObjs = battlefieldZone.getObjects()
    for _, obj in pairs(allObjs) do
        if obj.getCustomObject().type != 1 then
            obj.setLock(true)
        end
    end
end

function unlockBoard()
    local allObjs = battlefieldZone.getObjects()
    for _, obj in pairs(allObjs) do
        if obj != battlefieldTable then
            obj.setLock(false)
        end

    end
end

function setUp4ASelectPlayerColorAndSides()
    clearAllButtons()
    local menuEntries = {}
    menuEntries[1] = {functionName = "switchPlayerColor", label = "Switch Player Colors", tooltip = "Switch Player Colors", buttonTint = {0,0.913,1}}
    menuEntries[5] = {functionName = "setUp4BSelectPlayerColorAndSides", label = "NEXT", tooltip = "NEXT", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp3APlaceTerrain", "Go back to Step 3A")

    printToScreen("4A. SELECT PLAYER COLOR AND SIDES\n\nPlayer with lowest point total chooses to be Blue or Red\nPlayer.\n\nIf both players have the same point total, roll a red\ndefence die and call block or miss\n\nSelect 'Switch Player Color' to change player colors", 60, 2)
end

function setUp4BSelectPlayerColorAndSides()
    clearSetUpCards("all")
    clearAllButtons()
    local menuEntries = {}
    menuEntries[1] = {functionName = "flipMap", label = "Flip Map", tooltip = "Flip Map", buttonTint = {0,0.913,1}}
    menuEntries[5] = {functionName = "setUp5ARevealBattleCards", label = "NEXT", tooltip = "NEXT", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp4ASelectPlayerColorAndSides", "Go back to Step 4A")

    printToScreen("4B. SELECT PLAYER COLOR AND SIDES\n\nBlue Player selects map orientation.\n\nSelect 'Flip Map' to rotate map.", 60, 2)
end

function setUp5ARevealBattleCards()
    revealBattleCards()

    setUp6ADefineBattlefield()
end

function setBattleCardPos()
    for i, battleDeckType in pairs(battleDeckTypes) do
        for n=1,3,1 do
            local setUpCardPos = gameController.setUpCardsPos[battleDeckType][n]
            local spawnPos = {}
            spawnPos.x = screen.getPosition().x - setUpCardPos[1]
            spawnPos.y = screen.getPosition().y - setUpCardPos[2]
            spawnPos.z = screen.getPosition().z - setUpCardPos[3]

            local spawnRot = {55.91, 270.00, 0.00}
            local spawnedCardObj = setUp5Data.spawnedCards[battleDeckType][n]

            spawnedCardObj.setLock(true)
            spawnedCardObj.setScale({0.57,1,0.57})
            spawnedCardObj.setRotation(spawnRot)
            spawnedCardObj.setPosition(spawnPos)

            refreshTimer()
            Timer.create({
                identifier     = "debugSpawn"..timerCounter,
                function_name  = "debugSpawnSetupCard",
                function_owner = self,
                parameters     = {spawnedCardObj},
                delay          = 1
            })

        end
    end
end

function createMatrixFromDeck(battleDeckInserted)
    -- CLONE DECK
    local battleDeckClone = battleDeckInserted.clone({
        position     = {0,-10,0}
    })
    battleDeckClone.setPosition({0,-10,0})
    battleDeckClone.setRotation({55.91, 270.00, 0.00})
    battleDeckClone.shuffle()
    local battleDeckTable = battleDeckClone.getObjects()

    -- for each card

    local cardMatrixSelected = {}
    cardMatrixSelected.deployment = {}
    cardMatrixSelected.objective = {}
    cardMatrixSelected.conditions = {}

    for m, cardData in pairs(battleDeckTable) do
        local drawCardGUID = nil
        -- compare to find type

        for i, battleType in pairs(battleDeckTypes) do
            for k, compareCardData in pairs(setUpCards[battleType]) do
                if compareCardData.name == cardData.nickname then
                    -- found match
                    drawCardGUID = cardData.guid
                    break
                end
            end
            -- check if found card
            if drawCardGUID != nil then
                -- draw card and add to matrix table

                if #cardMatrixSelected[battleType] < 3 then
                    local battleDeckDrawnCard = battleDeckClone.takeObject({
                        position = {i*5,-10,#cardMatrixSelected[battleType]*5},
                        guid = drawCardGUID
                    })
                    table.insert(cardMatrixSelected[battleType], battleDeckDrawnCard)
                end
                break
            end
        end
    end

    destroyObject(battleDeckClone)

    return cardMatrixSelected.objective , cardMatrixSelected.deployment, cardMatrixSelected.conditions
end

function revealBattleCards(insertedDeck)

    clearSetUpCards("all")
    setUp5Data = {}
    setUp5Data.objectiveCards = objectiveCards
    setUp5Data.deploymentCards = deploymentCards
    setUp5Data.conditionsCards = conditionsCards

    setUp5Data.spawnedCards = {}
    if insertedDeck == nil then
        setUp5Data.spawnedCards.objective = spawnSetupCards("objective")
        setUp5Data.spawnedCards.deployment = spawnSetupCards("deployment")
        setUp5Data.spawnedCards.conditions = spawnSetupCards("conditions")
    else
        objectiveCardMatrix, deploymentCardMatrix, conditionsCardMatrix = createMatrixFromDeck(insertedDeck)
        setUp5Data.spawnedCards.objective = objectiveCardMatrix
        setUp5Data.spawnedCards.deployment = deploymentCardMatrix
        setUp5Data.spawnedCards.conditions = conditionsCardMatrix
        setBattleCardPos()
    end

    setUp5Data.cardSelection = {objective = 1, deployment = 1, conditions = 1}

    createButtonSetUpCard("objective", 1)
    createButtonSetUpCard("deployment", 1)
    createButtonSetUpCard("conditions", 1)

    refreshTimer()
    Timer.create({
        identifier     = "debugSetupCards"..timerCounter,
        function_name  = "debugSetupCards",
        function_owner = self,
        delay          = 0.5
    })
end

function debugSetupCards()
    for i = 1, 3, 1 do
        if setUp5Data.spawnedCards.objective[i]!= nil then
            setUp5Data.spawnedCards.objective[i].setRotation({55.91, 270.00, 0.00})
        end

        if setUp5Data.spawnedCards.deployment[i] != nil then
            setUp5Data.spawnedCards.deployment[i].setRotation({55.91, 270.00, 0.00})
        end
        if setUp5Data.spawnedCards.conditions[i] != nil then
            setUp5Data.spawnedCards.conditions[i].setRotation({55.91, 270.00, 0.00})
        end
    end
end

function clearSetUpCards(clearedCards)
    if setUp5Data != nil then
        for i = 1, 3, 1 do
            if setUp5Data.cardSelection.objective == i and clearedCards == "eliminate" then
            else
                if setUp5Data.spawnedCards.objective[i]!= nil then
                    destroyObject(setUp5Data.spawnedCards.objective[i])
                end
            end

            if setUp5Data.cardSelection.deployment == i and clearedCards == "eliminate" then
            else
                if setUp5Data.spawnedCards.deployment[i] != nil then
                    destroyObject(setUp5Data.spawnedCards.deployment[i])
                end
            end

            if setUp5Data.cardSelection.conditions == i and clearedCards == "eliminate" then
            else
                if setUp5Data.spawnedCards.conditions[i] != nil then
                    destroyObject(setUp5Data.spawnedCards.conditions[i])
                end
            end
        end
    end

    if clearedCards == "all" then
        setUp5Data = nil
    end

end

function setUp6ADefineBattlefield()
    clearAllButtons()
    local menuEntries = {}

    menuEntries[5] = {functionName = "setUp6BDefineBattlefield", label = "NEXT", tooltip = "NEXT", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp4BSelectPlayerColorAndSides", "Go back to Step 4B")

    printToScreen("6. DEFINE BATTLEFIELD\nStarting with Blue player, players eliminate left most card.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 60, 2)
end

function defineBattlefield()
    clearSetUpCards("eliminate")
    insertSetUpCard("objective")
    insertSetUpCard("deployment")
    insertSetUpCard("conditions")
end

function setUp6BDefineBattlefield()
    defineBattlefield()
    setUp7AResolveObjectiveConditions()
end

function insertSetUpCard(cardType)
    local mount = setUpData[cardType.."Mount"]
    local finalPos = {mount.getPosition().x, mount.getPosition().y+0.23, mount.getPosition().z}
    local finalCard = setUp5Data.spawnedCards[cardType][setUp5Data.cardSelection[cardType]]
    finalCard.setScale({0.83,1,0.83})
    finalCard.setLock(false)
    finalCard.setPosition(finalPos)
    finalCard.setRotation(mount.getRotation())
    finalCard.clearButtons()
end

function setUp7AResolveObjectiveConditions()
    clearAllButtons()
    setUpController.call("clearDeploymentBoundary")
    local menuEntries = {}

    menuEntries[5] = {functionName = "setUp8DeployUnits", label = "NEXT", tooltip = "NEXT", buttonTint = {0,0.913,1}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp4BSelectPlayerColorAndSides", "Go back to Step 5A")

    printToScreen("7. Resolve Objective and Condition Cards\n\n Resolve setup instructions on Objective and Condition Cards", 60, 2)
    spawnObjectiveConditionsDelay()


end

function setUp8DeployUnits()
    clearAllButtons()
    local menuEntries = {}

    menuEntries[5] = {functionName = "finishSetUp", label = "START GAME", tooltip = "START GAME", buttonTint = {0.7,0,0}}

    createMenu(menuEntries, 1)
    changeBackButton("setUp7AResolveObjectiveConditions", "Go back to Step 7A")

    printToScreen("8. Deploy Units\n\n Resolve setup instructions on Deployment Cards\n\nThen, starting with the Blue Player, Players take turns\ndeploying units in the deployment zone", 60, 2)

    setUpController.call("checkCardCall", {"deployment"})
end

function finishSetUp()
    setUpController.call("deploymentMenu")
    clearAllButtons()

    if gameMode == "tournament" then
        printToScreen("START GAME!\n\n3 hour time limit starts now!\n\nGL HF :)", 90, 2)
    else
        printToScreen("START GAME!\n\nGL HF :)", 90, 2)
    end
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "timerMenu"..timerCounter,
        function_name  = "mainMenu",
        function_owner = self,
        delay          = 5
    })


end
function spawnObjectiveConditionsDelay()
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "resolveObjectiveConditions"..timerCounter,
        function_name  = "spawnObjectiveConditions",
        function_owner = self,
        delay          = 1
    })
end

function spawnObjectiveConditions()
    setUpController.call("checkCardCall", {"deployment"})
    setUpController.call("checkCardCall", {"objective"})
    setUpController.call("checkCardCall", {"conditions"})
end


function eliminateCard(eliminatedCategory, eliminateNumber)
    local eliminiatedCard = setUp5Data.spawnedCards[eliminatedCategory][eliminateNumber]
    local cardRot = eliminiatedCard.getRotation()
    cardRot.x = cardRot.x + 180
    eliminiatedCard.setRotation(cardRot)
    eliminiatedCard.clearButtons()

    if eliminateNumber != 2 then
        createButtonSetUpCard(eliminatedCategory, eliminateNumber+1)
    end

    setUp5Data.cardSelection[eliminatedCategory] = eliminateNumber+1
end

function createButtonSetUpCard(cardType, selectedNumber)
    _G["eliminate"..cardType..selectedNumber] = function() eliminateCard(cardType, selectedNumber) end

    local data = {click_function = "eliminate"..cardType..selectedNumber, function_owner = self, label = "ELIMINATE", position = {-1, 1, 0}, rotation = {0, -90, 0}, scale = {0.7, 0.5, 0.5}, width = 2000, height = 400, font_size = 300, color = {1, 0, 0, 0.8}, font_color = {0,0,0, 1.25}}

    setUp5Data.spawnedCards[cardType][selectedNumber].createButton(data)
end

function spawnSetupCards(selection)
        setUp5Data[selection.."CardsClone"] = setUp5Data[selection .."Cards"].clone({
            position     = {0,-10,0}
        })

        setUp5Data[selection.."CardsClone"].shuffle()

        local spawnedCardTable = {}

        for n=1,3,1 do
            local setUpCardPos = gameController.setUpCardsPos[selection][n]

            local spawnPos = {}
            spawnPos.x = screen.getPosition().x - setUpCardPos[1]
            spawnPos.y = screen.getPosition().y - setUpCardPos[2]
            spawnPos.z = screen.getPosition().z - setUpCardPos[3]

            local spawnRot = {55.91, 270.00, 0.00}

            spawnedCard = setUp5Data[selection.."CardsClone"].takeObject({
                position       = spawnPos,
                rotation       = spawnRot,
                --callback       = "debugSpawnSetupCard",
                --callback_owner = self,
                --params         = {spawnRot},
                smooth         = false,
                top            = true
            })

            spawnedCard.setLock(true)
            spawnedCard.setScale({0.57,1,0.57})
            spawnedCard.setRotation(spawnRot)

            spawnedCardTable[n] = spawnedCard

            refreshTimer()
            Timer.create({
                identifier     = "debugSpawn"..timerCounter,
                function_name  = "debugSpawnSetupCard",
                function_owner = self,
                parameters     = {spawnedCard},
                delay          = 1
            })

        end

        destroyObject(setUp5Data[selection.."CardsClone"])

        return spawnedCardTable
end

function debugSpawnSetupCard(spawnedSetupCard)
    spawnedSetupCard[1].setRotation({55.91, 270.00, 0.00})
end

function switchPlayerColor()
    Player.Red.changeColor("Purple")
    Player.Blue.changeColor("Red")

    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "switchColorDelay"..timerCounter,
        function_name  = "switchColorDelay",
        function_owner = self,
        delay          = 0.1
    })


    -- flip stuff in player player area

    local redZoneObjs = redZone.getObjects()
    local blueZoneObjs = blueZone.getObjects()

    for i, obj in pairs(redZoneObjs) do
        if obj != battlefieldTable then
            flipObjPos(obj)
            flipObjColor(obj)
        end
    end
    for i, obj in pairs(blueZoneObjs) do
        if obj != battlefieldTable then
            flipObjPos(obj)
            flipObjColor(obj)
        end
    end

    -- change tokens and Minis
    local allObjs = battlefieldZone.getObjects()
    for i, obj in pairs(allObjs) do
        if obj != battlefieldTable then
            flipObjColor(obj)
        end
    end

    local blueTrayZone = getObjectFromGUID(commandTokenTrayData.blue.trayZoneGUID)
    local redTrayZone = getObjectFromGUID(commandTokenTrayData.red.trayZoneGUID)
    local blueCommandObjs = blueTrayZone.getObjects()
    local redCommandObjs = redTrayZone.getObjects()

    for i, obj in pairs(blueCommandObjs) do
        if obj.getVar("isAToken") then
            -- flip obj color and pos
            flipCommandTokenPos(obj, i)
            spawnNewCommandToken(obj,obj.getPosition(),obj.getRotation())
            destroyObject(obj)
        end
    end
    for i, obj in pairs(redCommandObjs) do
        if obj.getVar("isAToken") then
            -- flip obj color and pos
            flipCommandTokenPos(obj, i)
            spawnNewCommandToken(obj,obj.getPosition(),obj.getRotation())
            destroyObject(obj)
        end
    end


    -- red
    local redDeckObjs = redDeckZone.getObjects()
    local gotDeck = false
    for i, obj in pairs(redDeckObjs) do
        if obj != redDeckMount then
            redDeckObj = obj
            gotDeck = true
        end
    end

    if gotDeck == true then
        local deckPos = blueDeckMount.getPosition()
        deckPos.y = deckPos.y + 1
        redDeckObj.setPosition(deckPos)
        --redDeckObj.setRotation(blueDeckMount.getRotation())
    end

    -- blueZone

    local blueDeckObjs = blueDeckZone.getObjects()
    local gotDeck = false
    for i, obj in pairs(blueDeckObjs) do
        if obj != blueDeckMount then
            blueDeckObj = obj
            gotDeck = true
        end
    end

    if gotDeck == true then
        local deckPos = redDeckMount.getPosition()
        deckPos.y = deckPos.y + 1
        blueDeckObj.setPosition(deckPos)
        --redDeckObj.setRotation(blueDeckMount.getRotation())
    end
end


function flipCommandTokenPos(obj, index)
    local selectedColor = obj.getVar("colorSide")
    if selectedColor == "red" then
        selectedColor = "blue"
    else
        selectedColor = "red"
    end

    local commandType = obj.getVar("commandType")
    local commandTray = getObjectFromGUID(commandTokenTrayData[selectedColor][commandType])
    local pos = commandTray.getPosition()
    pos.y = pos.y + 0.5 +(0.2 * index)
    local rot = commandTray.getRotation()
    --rot.y = rot.y

    obj.setPosition(pos)
    obj.setRotation(rot)
end

function spawnMini(spawnPos, spawnRot, passedColor, passedTint, passedName)

    data = cardInfo.unitCards[passedName].miniInfo[1]

    local spawnedMini = spawnObject({
        type           = "Custom_Model",
        position       = spawnPos,
        rotation       = spawnRot,
        scale          = data.scale
    })
    spawnedMini.setCustomObject({
        mesh = data.mesh,
        collider = data.collider,
        diffuse = data[passedColor],
        type = 1,
        material = 3

    })
    spawnedMini.setColorTint(passedTint)

    local strColor = passedColor
    strColor = strColor:gsub("^%l", string.upper)

    spawnedMini.setName(strColor.. " ".. data.name)

    return spawnedMini
end

function initializeMini(pMiniTable)
    --print(pColorSide, pUpgrades, pMiniObjs, pUnitCardObj, pVarName)


    local strColor = pMiniTable.colorSide
    strColor = strColor:gsub("^%l", string.upper)

    for i, objEntry in pairs(pMiniTable.miniObjs) do
        -- init mini script
        local selectedMiniScript = ""

        -- SET NAME
        objEntry.obj.setName(strColor.. " "..objEntry.name)
        selectedMiniScript = selectedMiniScript .. "colorSide = '"..pMiniTable.colorSide.."'\nminiName = '"..objEntry.name.."'\n"


        if i == 1 then
            -- DESCRIPTION
            local description = ""

            for p, upgradeName in pairs(pMiniTable.upgrades) do
                description = description .. upgradeName .. "\n"
            end
            objEntry.obj.setDescription(description)

            -- miniGUIDs
            local miniGUIDsScript = "miniGUIDs = {}\n"
            for n, objEntry in pairs(pMiniTable.miniObjs) do
                miniGUIDsScript = miniGUIDsScript .. "miniGUIDs["..n.."] = '" .. objEntry.obj.getGUID() .. "'\n"
            end
            selectedMiniScript = selectedMiniScript .. miniGUIDsScript.."cardGUID = '"..pMiniTable.unitCardObj.getGUID().."'\nunitName = '"..pMiniTable.varName.."'\nunitID = "..pMiniTable.unitID.."\n"..listBuilder.modelMiniScript
        else
            objEntry.obj.use_snap_points = false
        end
        -- SET SCRIPT
        objEntry.obj.setLuaScript(selectedMiniScript)
    end

end

function flipObjColor(fObj)
    if fObj.getVar("isAMini") != nil then

        local spawnMiniTable = {}

        if fObj.getVar("colorSide") == "red" then
            spawnMiniTable.colorSide = "blue"
        else
            spawnMiniTable.colorSide = "red"
        end
        spawnMiniTable.upgrades = {fObj.getDescription()}

        spawnMiniTable.unitCardObj = getObjectFromGUID(fObj.getVar("cardGUID"))

        spawnMiniTable.varName = fObj.getVar("unitName")

        spawnMiniTable.unitID = fObj.getVar("unitID")

        local leaderMini = spawnMini(fObj.getPosition(),fObj.getRotation(), spawnMiniTable.colorSide, fObj.getColorTint(), spawnMiniTable.varName)

        spawnMiniTable.miniObjs = {}
        for i, miniGUID in pairs(fObj.getTable("miniGUIDs")) do

            local guidObj = getObjectFromGUID(miniGUID)
            local objName = guidObj.getVar("miniName")
            spawnMiniTable.miniObjs[i] = {}
            if i == 1 then
                spawnMiniTable.miniObjs[i].obj = leaderMini
            else
                spawnMiniTable.miniObjs[i].obj = guidObj
            end

            spawnMiniTable.miniObjs[i].name = objName
        end

        refreshTimer()
        Timer.create({
            identifier     = "initMinis"..timerCounter,
            function_name  = "initializeMini",
            function_owner = self,
            parameters     = spawnMiniTable,
            delay          = 2
        })

        destroyObject(fObj)

    elseif fObj.getVar("isAToken") != nil then
        spawnNewCommandToken(fObj,fObj.getPosition(), fObj.getRotation())

        destroyObject(fObj)
    end
end

function setUpDelay(setObjTable)
    setObjTable.obj.setVar("unitName", setObjTable.unitName)
    setObjTable.obj.setVar("colorSide", setObjTable.colorSide)
    setObjTable.obj.setVar("unitCount", setObjTable.unitCount)
    setObjTable.obj.setVar("cardGUID", setObjTable.cardGUID)
end

function spawnNewCommandToken(oldObj,spawnPos,spawnRot)
    ---
    if oldObj.getVar("colorSide") == "red" then
        newTokenColor = "blue"
    else
        newTokenColor = "red"
    end

    local commandType = oldObj.getVar("commandType")

    local tokenObj = spawnObject({
        type           = "Custom_Model",
        position       = spawnPos,
        rotation       = spawnRot,
        scale          = {1,1,1}
    })
    tokenObj.setCustomObject({
        mesh = commandTokenData.mesh,
        collider = commandTokenData.mesh,
        diffuse = commandTokenData[newTokenColor][commandType].diffuse,
        type = 0,
        material = 3
    })

    tokenObj.setPosition(spawnPos)
    tokenObj.setRotation(spawnRot)

    local strColor = newTokenColor

    strColor = strColor:gsub("^%l", string.upper)

    tokenObj.setName(strColor .. " " .. cardInfo.unitCards[oldObj.getVar("unitName")].tokenName)

    local luaScript = "unitName = '"..oldObj.getVar("unitName").."'\ncommandType = '"..commandType.."'\ncolorSide = '"..newTokenColor.."'\n"..listBuilder.tokenScript
    tokenObj.setLuaScript(luaScript)

end

function reloadToken(tokenTable)
    if tokenTable[1] != nil then
        tokenTable[1].reload()
    end

end

function flipObjPos(pObj)
    local objPos = pObj.getPosition()
    local newPos = objPos
    local objRot = pObj.getRotation()
    objRot.y = objRot.y+180
    newPos.x = 8-(objPos.x - 8)
    newPos.z = -objPos.z

    pObj.setPosition(newPos)
    pObj.setRotation(objRot)
end

function switchColorDelay()
    Player.Purple.changeColor("Blue")
end

function flipMap()
    --Get a list of any objects which are inside of the zone.
    local allObjs = battlefieldZone.getObjects()

    --Check if the table we made is empty due to the zone being empty
    if #allObjs == 0 then
    else
        for _, obj in ipairs(allObjs) do
            -- flip obj
            if obj != battlefieldTable then
                flipObjPos(obj)
            end
        end
    end
end

function spawnPremadeMap(selectedMap,selectedCartridgeObj, mapMenuCallback, clearZone)
    if mapMenuCallback != nil then
        self.call(mapMenuCallback)
    end

    if clearZone != false then
        clearZones()
    end

    -- clone cartridge
    local selectedCartridgeObjClone = selectedCartridgeObj.clone({
        position     = {0,-10,0}
    })


    -- get guid
    local selectedCartridgeTable = selectedCartridgeObj.getObjects()

    for i, entry in pairs(selectedCartridgeTable) do
        if entry.name == selectedMap then
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
        identifier     = "spawnMapFromCartridgeDelay"..timerCounter,
        function_name  = "spawnPremadeMapFromCartridge",
        function_owner = self,
        parameters     = {spawnFromCartridgeObj},
        delay          = 0.5
    })



end



function spawnPremadeMapFromCartridge(selectedPremadeMapCartridgeTable)
    local selectedPremadeMapCartridge = selectedPremadeMapCartridgeTable[1]
    spawnMapFromCartridge(selectedPremadeMapCartridge)

    destroyObject(selectedPremadeMapCartridge)
end



function spawnMapFromCartridge(selectedCartridge)
    changeBattlefieldTint(selectedCartridge.getTable("battlefieldTint"))

    local cartridgeObjs = selectedCartridge.getObjects()


    for i, loadedObj in pairs(cartridgeObjs) do
        takenObj = selectedCartridge.takeObject({
            position       = {0,-10-i,0},
            callback       = "placeTerrainDelay",
            callback_owner = self,
            smooth         = false
        })
    end
end

function clearZones()
    clearMap()
    clearCompetitiveTerrain()
end

function clearMap()

    --Get a list of any objects which are inside of the zone.
    local objectsInZone = battlefieldZone.getObjects()

    --Check if the table we made is empty due to the zone being empty
    if #objectsInZone == 0 then
    else
        --If it isn't empty, we use a for loop to look at each entry in the list
        for _, object in ipairs(objectsInZone) do
            -- destroy object
            if object != battlefieldTable then
                destroyObject(object)
            end
        end
    end
end

function clearCompetitiveTerrain()
    local objsInZone = competitiveTerrainZone.getObjects()

    if #objsInZone != 0 then
        for _, obj in ipairs(objsInZone) do
            destroyObject(obj)
        end
    end
end


function saveMap()
    -- delete cartridgeObjs
    local mountObjs = mountZone.getObjects()

    for i, obj in pairs(mountObjs) do
        if obj != dataDiskMount then
            destroyObject(obj)
        end
    end

    -- create data cartridge
    local spawnPos = dataDiskMount.getPosition()
    spawnPos.y = spawnPos.y + 1
    local dataCartridgeOriginal = getObjectFromGUID(gameController.dataCartridgeGUID)

    dataCartridge = dataCartridgeOriginal.clone({
        position     = spawnPos
    })

    dataCartridge.setLock(false)
    dataCartridge.setScale({1,1,1})

    battlefieldTint = gameData.getTable("battlefieldTint")

    local cartridgeScript = "battlefieldTint = {r = " .. battlefieldTint.r .. ", g = " .. battlefieldTint.g .. ", b = " .. battlefieldTint.b .. "}"
    dataCartridge.setLuaScript(cartridgeScript)

    -- save obj

    local zoneBox = getObjectFromGUID(zonesGUIDs.battlefield)
    local zoneObjs = zoneBox.getObjects()

    logObj(zoneObjs)

    --local zoneBox = getObjectFromGUID(zonesGUIDs.red)
    --local zoneObjs = zoneBox.getObjects()

    --logObj(zoneObjs)

    --local zoneBox = getObjectFromGUID(zonesGUIDs.blue)
    --local zoneObjs = zoneBox.getObjects()

    --logObj(zoneObjs)


end

function logObj(selectedObjs)
    for i, obj in pairs(selectedObjs) do
        if obj.getName() != "TABLE" then
            local objLuaScript = getLuaScriptData(obj)

            if string.len(obj.getLuaScript()) > 5 then
                finalScript = objLuaScript .. "\nscripted = true"
            else
                finalScript = objLuaScript
            end
            obj.setLuaScript(finalScript.."\n"..obj.getLuaScript())

            dataCartridge.putObject(obj)
        end
    end
end

function getLuaScriptData(targetObj)
    local returnString = ""

    local returnPos = targetObj.getPosition()
    returnString = returnString .. "position = {x = " .. returnPos.x .. ", y = " .. returnPos.y .. ", z = " .. returnPos.z .. "}\n"

    local returnRot = targetObj.getRotation()
    returnString = returnString .. "rotation = {x = " .. returnRot.x .. ", y = " .. returnRot.y .. ", z = " .. returnRot.z .. "}\n"

    return returnString
end

function loadMap()
    -- get cartridge
    local mountObjs = mountZone.getObjects()

    for i, obj in pairs(mountObjs) do
        if obj.getTable("battlefieldTint") != nil then
            loadedCartridge = obj
        end
    end

    -- spawn cartridge
    if loadedCartridge != nil then
        clearZones()
        spawnMapFromCartridge(loadedCartridge)
    else
    end
end


function placeTerrainDelay(passedObj)
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "placeTerrainDelay"..timerCounter,
        function_name  = "placeTerrain",
        function_owner = self,
        parameters     = {passedObj},
        delay          = 0.1
    })
end


function placeTerrain(pObj)
    local paObj = pObj[1]

    spawnPos = paObj.getTable("position")
    paObj.setPosition(spawnPos)

    spawnRot = paObj.getTable("rotation")
    paObj.setRotation(spawnRot)

    if paObj.getVar("scripted") == true then
    else
        paObj.setLuaScript("")
    end


    if paObj.getName() == "BATTLEFIELD" then
        paObj.interactable = false
        paObj.setLock(true)
        paObj.setLuaScript("function onLoad() self.interactable = false end")
    end

    refreshTimer()
    Timer.create({
        identifier     = "debugObj"..timerCounter,
        function_name  = "debugObj",
        function_owner = self,
        parameters     = {paObj},
        delay          = 10
    })

end

function debugObj(debuggedObj)
    debuggedObj[1].reload()
end

-- UTILITY FUNCTIONS

function dud()
end

function translatePos(originPos, originRot, distance, angle)
    local pos = originPos
    local rot = originRot

    local a = distance * math.cos(math.rad(angle + rot.y))
    local b = distance * math.sin(math.rad(angle + rot.y))

    pos.x = pos.x - b
    pos.z = pos.z - a

    return pos
end


function clearAllButtons(exception)
    for _, optionObjEntry in pairs(optionObjs) do
        optionObjEntry.clearButtons()
    end

    for _, optionButtonEntry in pairs(optionButtons) do
        optionButtonEntry.clearButtons()
        optionButtonEntry.setColorTint({0,0,0})
    end

    if exception != backButton then
        backButton.clearButtons()
        backButton.setColorTint({0,0,0})
    end

    prevButton.clearButtons()
    prevButton.setColorTint({0,0,0})
    nextButton.clearButtons()
    nextButton.setColorTint({0,0,0})
end

function printToScreen(screenText, fontSize, selectedAlignment)
    screen.editButton({
        int = 0, click_function = "dud", function_owner = self, label = screenText, position = {0.9, 0.25, 0}, rotation = {0, -90, 90}, scale = {0.5, 0.5, 0.5}, width = 0, height = 0, font_size = fontSize, font_color = {0.8867, 0.7804, 0, 1}, alignment = selectedAlignment
    })
end


function createOptionButton(optionNumber, optionClickFunction, optionLabel, optionToolTip,tint)
    optionObj = optionObjs["gameControllerOption"..optionNumber]
    optionButton = optionButtons["gameControllerOption"..optionNumber.."Button"]

    _G["gameControllerOptionFunction"..optionNumber] = function()
        optionButtons["gameControllerOption"..optionNumber.."Button"].AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end
    local stringLength = string.len(optionLabel)

    if stringLength < 24 then
        buttonFontSize = 400
    else
        local stringDif = stringLength - 22
        buttonFontSize = 400 - (stringDif * 8)
    end

    optionObj.createButton({
        click_function = "gameControllerOptionFunction"..optionNumber, function_owner = self, label = optionLabel, position = {-0.35, 0.3, 0}, scale = {0.5, 0.5, 0.5}, width = 4200, height = 600, font_size = buttonFontSize, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100},tooltip = optionToolTip
    })

    optionButton.createButton({
        click_function = "gameControllerOptionFunction"..optionNumber, function_owner = self, label = "", position = {0, 0.65, 0}, width = 1400, height = 1400, font_size = 1100, color = {1,1,1,0.01},font_color = {1,1,1,100}, tooltip = optionToolTip, alignment = 3
    })

    optionButton.setColorTint(tint)
end

function changeBackButton(optionClickFunction, optionToolTip)
    _G["gameControllerBackButtonFunction"] = function()
        backButton.AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end

    backButton.createButton({
        click_function = "gameControllerBackButtonFunction", function_owner = self, label = "BACK", position = {0, 0.65, 0}, scale = {1, 1, 1.4}, width = 1500, height = 2000, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = optionToolTip
    })
    backButton.setColorTint({1,0,0})
end

function changeNextButton(optionClickFunction, optionToolTip)
    _G["gameControllerNextButtonFunction"] = function()
        nextButton.AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end

    nextButton.createButton({
        click_function = "gameControllerNextButtonFunction", function_owner = self, label = "NEXT", position = {0, 0.65, 0}, scale = {1, 1, 0.7}, width = 1500, height = 2000, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = optionToolTip
    })
    nextButton.setColorTint({0.7,0.7,0})
end

function changePrevButton(optionClickFunction, optionToolTip)
    _G["gameControllerPrevButtonFunction"] = function()
        prevButton.AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end

    prevButton.createButton({
        click_function = "gameControllerPrevButtonFunction", function_owner = self, label = "PREV", position = {0, 0.65, 0}, scale = {1, 1, 0.7}, width = 1500, height = 2000, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = optionToolTip
    })
    prevButton.setColorTint({0.7,0.7,0})
end

function createMenu(optionTable, selectedIndex)
    clearAllButtons(backButton)

    if #optionTable > 5 then
        -- create prev and next buttons
        if selectedIndex-5 > 0 then
            _G["prevButtonFunction"] = function() createMenu(optionTable, selectedIndex-5) end
            changePrevButton("prevButtonFunction", "Previous Menu options")
        end
        if selectedIndex+4 < #optionTable then
            _G["nextButtonFunction"] = function() createMenu(optionTable,selectedIndex+5) end
            changeNextButton("nextButtonFunction", "More menu options")
        end
    end

    for oI=0,4,1 do
        if optionTable[selectedIndex+oI] != nil then
            createOptionButton(oI+1, optionTable[selectedIndex+oI].functionName, optionTable[selectedIndex+oI].label, optionTable[selectedIndex+oI].tooltip, optionTable[selectedIndex+oI].buttonTint)
        end
    end
end



function changeBattlefieldTint(tint)

    enterTintData(gameData, "battlefieldTint", tint)



    local allUnits = getAllObjects()
    for _,unit in pairs(allUnits) do
        if unit.getCustomObject().type == 1 then
            unit.setColorTint(tint)
            --unit.setTable("battlefieldTint", tint)
        end
    end
end

function onPlayerChangedColor(player_color)
    if player_color == "Red" or player_color == "Blue" then
        if Player[player_color].host == false and Player[player_color].promoted == false then
            Player[player_color].promote()
        end
    end
end

function refreshTimer()
    timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
end




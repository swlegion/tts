require('!/Analytics')
require('!/CardSchema')
require('!/common/SHA256')
require('!/data/ListBuilder')
require('!/generated/cards')
require('!/UI')
require('!/RangeRulers')
require('!/Cohesion')

function onsave()
  local chessClocksActive = UI.getAttribute("floatingChessClockUI", "active") == "true"
  return JSON.encode({
    clocks = chessClocksActive,
  })
end

function onload(saveData)
    VERSION = "v5.0.0-beta"
    CCID = sha256(tostring(Time.time))
    UUID = sha256(Player.getPlayers()[1].steam_id)
    initUI()

    local loadData = {
      clocks = false,
    }
    if saveData ~= "" then
      loadData = JSON.decode(saveData)
    end

    initCardsSchema()
    ga_event("Global", "onLoad")

    gameDataGUID = "6bb850"
    battlefieldZoneGUID = "cbc575" -- real
    conditionsZoneGUID = "c49089" -- conditions
    competitiveTerrainZoneGUID = "92b9be"

    zonesGUIDs = {}
    zonesGUIDs.battlefield = battlefieldZoneGUID
    zonesGUIDs.conditions = conditionsZoneGUID
    zonesGUIDs.competitive = competitiveTerrainZoneGUID
    zonesGUIDs.red = "2c09a9"
    zonesGUIDs.blue = "818608"

    clockGUIDs = {}
    clockGUIDs.blue = "4f823a"
    clockGUIDs.red = "6ce1bb"
    initChessClocks(clockGUIDs, loadData.clocks)

    battlefieldTable = "3a3ed9"

    templateInfo = {}

    templateInfo.templateAGUID = {
        small = {"15849b", "f8f24c", "7568b1"}, medium = {"e20bd9", "9ab5d8", "ea3b10"}, large = {"28e15d", "2b6fd5", "62e790"}, huge = {"d80f36", "819324", "28a694"}
    }
    templateInfo.templateBGUID = {
        small = {"b35f7f", "4536a9", "c6150a"}, medium = {"46d669", "7c0b7a", "a99aaa"}, large = {"53689b", "93219f", "62d768"}, huge = {"0975c7", "968781", "f80c9d"}
    }
    templateInfo.templateCollider = {
        "http://cloud-3.steamusercontent.com/ugc/874120727305531901/BA0C6DDDC393B87EEBC53774FD23812CC1F6740A/",
        "http://cloud-3.steamusercontent.com/ugc/874120727305503775/8D94FFCC0574D5F4F41D85E3D08DDE6214DA33C3/",
        "http://cloud-3.steamusercontent.com/ugc/874120727305374487/9F2189A39695F8B9D09A3A84EB718CA9486D6AB6/"
    }
    for _,objSet in pairs(templateInfo.templateAGUID) do
        for i, objGUID in ipairs(objSet) do
            local obj = getObjectFromGUID(objGUID)
        end
    end

    for _,objSet in pairs(templateInfo.templateBGUID) do
        for i, objGUID in ipairs(objSet) do
            local obj = getObjectFromGUID(objGUID)
        end
    end

    -- math available here: https://docs.google.com/spreadsheets/d/1LD6spROJFw29c5L-lN1RJwqk7XplQShOj1Z8QQkBGf4/edit?usp=sharing
    -- formula is: ((tool - notch + base) * 0.5) /25.4
    templateInfo.aStart = {}
    -- base size             =      {speed1,      speed2,      speed3}
    templateInfo.aStart.small = 	   {2.007874016, 2.992125984, 3.976377953}
    templateInfo.aStart.medium = 	{2.342519685, 3.326771654, 4.311023622}
    templateInfo.aStart.large =		{2.736220472, 3.720472441, 4.704724409}
    templateInfo.aStart.huge =		{3.326771654, 4.311023622, 5.295275591}
    templateInfo.aStart.laat =      {3.720472441, 4.704724409, 5.688976378}
    templateInfo.aStart.long =		{4.803149606, 5.787401575, 6.771653543}
    templateInfo.aStart.epic =		{4.311023622, 5.295275591, 6.279527559}
    templateInfo.aStart.snail = {5.295275591, 6.279527559, 7.263779528}

    templateInfo.templateMesh = {"http://cloud-3.steamusercontent.com/ugc/874120727305531585/FD6D4B079FC24EE1CE4F034B1C1E0F6B665D45E6/", "http://cloud-3.steamusercontent.com/ugc/874120727305502854/B063611E236ACAD8060A08A63EDB0EE9D91919AA/","http://cloud-3.steamusercontent.com/ugc/874120727305373581/A5E705982C2AE4B89756EF5A5BAC10DEDA9881B4/"}
    templateInfo.templateBallCollider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/"

    templateInfo.tint = {{0.9,0.9,0.9}, {0.1,0.1,0.1},{0.4,0.03,0.03}}
    templateInfo.buttonPosition = {{0,0.02,-1.2},{0,0.02,-1.9},{0,0.02,-2.7}}
    templateInfo.buttonColor = {{0.8,0.8,0.8},{0.15,0.15,0.15},{0.4,0.03,0.03}}
    templateInfo.fontColor = {{0,0,0},{1,1,1},{1,1,1}}
    templateInfo.buttonHeight = {750,1400,2000}

    templateInfo.modelTemplateAGUID = "1f03c9"
    templateInfo.modelTemplateBGUID = "a486ae"

    modelA = getObjectFromGUID(templateInfo.modelTemplateAGUID)
    modelB = getObjectFromGUID(templateInfo.modelTemplateBGUID)


    templateInfo.templateNameToData = {}
    templateInfo.templateNameToData.whiteTemplateASnap25mm = {baseSize = "small", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateASnap40mm = {baseSize = "medium", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateASnap60mm = {baseSize = "large", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateASnap90mm = {baseSize = "huge", selectedSpeed = 1}

    templateInfo.templateNameToData.blackTemplateASnap25mm = {baseSize = "small", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateASnap40mm = {baseSize = "medium", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateASnap60mm = {baseSize = "large", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateASnap90mm = {baseSize = "huge", selectedSpeed = 2}

    templateInfo.templateNameToData.redTemplateASnap25mm = {baseSize = "small", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateASnap40mm = {baseSize = "medium", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateASnap60mm = {baseSize = "large", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateASnap90mm = {baseSize = "huge", selectedSpeed = 3}

    templateInfo.templateNameToData.whiteTemplateBSnap25mm = {baseSize = "small", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateBSnap40mm = {baseSize = "medium", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateBSnap60mm = {baseSize = "large", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateBSnap90mm = {baseSize = "huge", selectedSpeed = 1}

    templateInfo.templateNameToData.blackTemplateBSnap25mm = {baseSize = "small", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateBSnap40mm = {baseSize = "medium", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateBSnap60mm = {baseSize = "large", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateBSnap90mm = {baseSize = "huge", selectedSpeed = 2}

    templateInfo.templateNameToData.redTemplateBSnap25mm = {baseSize = "small", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateBSnap40mm = {baseSize = "medium", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateBSnap60mm = {baseSize = "large", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateBSnap90mm = {baseSize = "huge", selectedSpeed = 3}
    templateInfo.diceTrayGUID = "3d3ac4"

    templateInfo.moveTemplate = {}
    templateInfo.moveTemplate[1] = {}
    templateInfo.moveTemplate[1].colorTint = {1,1,1}
    templateInfo.moveTemplate[1].shortBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778007615968/4EE8D2332DCB6F4837551255CE5B1F240937BBE5/"
    templateInfo.moveTemplate[1].longBundle = "http://cloud-3.steamusercontent.com/ugc/1848161512056297932/A762E187E43177F01CD89D1348F51B1E3C1C744D/"
    templateInfo.moveTemplate[1].sharedBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009533333/AD7C02CEE53FB4B2EA823B3DFE570674F8998019/"


    templateInfo.moveTemplate[2] = {}
    templateInfo.moveTemplate[2].colorTint = {0.5,0.5,0.5}
    templateInfo.moveTemplate[2].shortBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009510155/77119B471FE3C51B06443F8ABE1C1B522431DF9B/"
    templateInfo.moveTemplate[2].longBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009510102/15B368A8D753AB35E1D60F7A377AE273EBEC0145/"
    templateInfo.moveTemplate[2].sharedBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009533401/0FBA682D7D5AA7DA1A7EFC18B33C71EB1C0898E4/"

    templateInfo.moveTemplate[3] = {}
    templateInfo.moveTemplate[3].colorTint = {1,0.2,0.2}
    templateInfo.moveTemplate[3].shortBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009510243/26BA9DD7881AF63E1A19EB6BF9802630D792F836/"
    templateInfo.moveTemplate[3].longBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009510200/6723334F35444B547AA1382AE80F12E3FE9B72B1/"
    templateInfo.moveTemplate[3].sharedBundle = "http://cloud-3.steamusercontent.com/ugc/1761462778009533447/E5D1D5169F0DB6025808BEE8C9647B3E7057BDB9/"

    --This is actually diameter... just saying
    templateInfo.baseRadius = {
      -- Troopers
      small = 1.06299,
      -- Tauntauns, Droidekas, Speeder Bikes, Mortars
      medium = 1.9685,
      -- AT-RTs, eWebs
      large = 2.75591,
      -- Landspeeder, AT-ST
      huge = 3.93701,
      -- LAAT
      laat = 4.72440,
      -- Occupier Tank
      long = 3.93701,
      -- AAT, Saber Tank
      epic = 5.867,
      -- Snail
      snail = 3.93701
    }

    templateInfo.silhouetteHeight = {
      small = 1.65,
      notched = 2.707,
      custom = 1.0
    }

    templateInfo.cohesionRadius = {
      -- Troopers
      small = 4.494485,
      -- Tauntauns, Droidekas, Speeder Bikes, Mortars
      medium = 5.45275,
      -- AT-RTs, eWebs
      large = 7.133865,
      -- These are obviously incorrect, but currently cohesion does not matter for any of these units.
      -- Landspeeder, AT-ST
      huge = 8.622047244,
      -- LAAT
      laat = 9.803149606,
      -- Occupier Tank
      long = 13.0511811,
       -- AAT, Saber Tank
      epic = 11.57480315,
      -- Snail
      snail = 14.52755906
    }

    templateInfo.attackLineMesh = "http://cloud-3.steamusercontent.com/ugc/785234780861452902/76204298AA245698319FD2EA590160AFFE1B488C/"

    highestPoint = 0

    -- token Bags
    aimBagGUID = "beca0f"
    dodgeBagGUID = "4a352e"
    standbyBagGUID = "f103c2"
    surgeBagGUID = "f539b0"
    suppressionBagGUID = "a25e12"
    smokeBagGUID = "d03507"
    ionBagGUID = "799a75"
    woundBagGUID = "276535"
    observationBagGUID = "aac68d"

    whiteD8BagGUID = "014405"
    blackD8BagGUID = "79ead4"
    redD8BagGUID = "a0a037"

    whiteD6BagGUID = "7a88d3"
    redD6BagGUID = "22127e"

    unitIDTokenBagGUID = "21550f"

    Wait.time(initHotkeys, 1)
  
    -- LIST BUILDER info
    redSelectedArmyFaction = ""
    blueSelectedArmyFaction = ""
    listBuilder = buildListBuilder()

    dieRollerInfo = {}
    dieRollerInfo.diePos = {}
    dieRollerInfo.diePos[1] = {q = 0, c = 0.5}
    dieRollerInfo.diePos[2] = {q = 63.434948822922	, c = 1.1180339887499}
    dieRollerInfo.diePos[3] = {q = 33.69006752598, c = 1.802775637732}
    dieRollerInfo.diePos[4] = {q = 0, c = 1.5}
    dieRollerInfo.diePos[5] = {q = -33.69006752598	, c = 1.802775637732}
    dieRollerInfo.diePos[6] = {q = -63.434948822922, c = 1.1180339887499}
    dieRollerInfo.diePos[7] = {q = 63.434948822922	, c = -1.1180339887499}
    dieRollerInfo.diePos[8] = {q = 0, c = -0.5}
    dieRollerInfo.diePos[9] = {q = -63.434948822922, c = -1.1180339887499}
    dieRollerInfo.diePos[10] = {q = 75.963756532074, c = 2.0615528128088}
    dieRollerInfo.diePos[11] = {q = 53.130102354156, c = 2.5}
    dieRollerInfo.diePos[12] = {q = 38.65980825409, c = 3.2015621187164}
    dieRollerInfo.diePos[13] = {q = 21.801409486352, c = 2.6925824035673}
    dieRollerInfo.diePos[14] = {q = 0, c = 2.5}
    dieRollerInfo.diePos[15] = {q = -21.801409486352, c = 2.6925824035673}
    dieRollerInfo.diePos[16] = {q = -38.65980825409, c = 3.2015621187164}
    dieRollerInfo.diePos[17] = {q = -53.130102354156, c = 2.5}
    dieRollerInfo.diePos[18] = {q = -75.963756532074, c = 2.0615528128088}
    dieRollerInfo.diePos[19] = {q = 75.963756532074, c = -2.0615528128088}
    dieRollerInfo.diePos[20] = {q = 53.130102354156, c = -2.5}
    dieRollerInfo.diePos[21] = {q = 33.69006752598, c = -1.802775637732}
    dieRollerInfo.diePos[22] = {q = 0, c = -1.5}
    dieRollerInfo.diePos[23] = {q = -33.69006752598, c = -1.802775637732}
    dieRollerInfo.diePos[24] = {q = -53.130102354156, c = -2.5}
    dieRollerInfo.diePos[25] = {q = -75.963756532074, c = -2.0615528128088}

    dieRollerInfo.buttonInfo = {}
    dieRollerInfo.buttonInfo.redPlayer = {}
    dieRollerInfo.buttonInfo.redPlayer.whiteAttackButtonGUID = "64453f"
    dieRollerInfo.buttonInfo.redPlayer.blackAttackButtonGUID = "ada290"
    dieRollerInfo.buttonInfo.redPlayer.redAttackButtonGUID = "8bbca8"
    dieRollerInfo.buttonInfo.redPlayer.whiteDefenseButtonGUID = "647256"
    dieRollerInfo.buttonInfo.redPlayer.redDefenseButtonGUID = "2faf4c"

    dieRollerInfo.buttonInfo.bluePlayer = {}
    dieRollerInfo.buttonInfo.bluePlayer.whiteAttackButtonGUID = "da4a19"
    dieRollerInfo.buttonInfo.bluePlayer.blackAttackButtonGUID = "758849"
    dieRollerInfo.buttonInfo.bluePlayer.redAttackButtonGUID = "9c6dfc"
    dieRollerInfo.buttonInfo.bluePlayer.whiteDefenseButtonGUID = "2fc39a"
    dieRollerInfo.buttonInfo.bluePlayer.redDefenseButtonGUID = "b37fcb"


    dieRollerInfo.redDieRollerGUID = "9e1533"
    dieRollerInfo.blueDieRollerGUID = "1daecb"

    dieRollerInfo.dieRollerZone = {}
    dieRollerInfo.dieRollerZone.red = "424d2d"
    dieRollerInfo.dieRollerZone.blue = "39b5f1"


    dieRollerInfo.dieValues = {}
    dieRollerInfo.dieValues.attack = {}
    dieRollerInfo.dieValues.attack.red = {"crit", "hit", "hit", "hit", "hit", "hit", "blank", "oSurge"}
    dieRollerInfo.dieValues.attack.black = {"crit", "hit", "hit", "hit", "blank", "blank", "blank", "oSurge"}
    dieRollerInfo.dieValues.attack.white = {"crit", "hit", "blank", "blank", "blank", "blank", "blank", "oSurge"}

    dieRollerInfo.dieValues.defend = {}
    dieRollerInfo.dieValues.defend.white = {"block", "blank", "blank", "blank", "blank", "dSurge"}
    dieRollerInfo.dieValues.defend.red = {"block", "block", "block", "blank", "blank", "dSurge"}


    -- GAME CONTROLLER

    gameController = {}
    gameController.objGUID = "623b03"

    gameController.learningGameCartridgeGUID = "272d58"
    gameController.dataCartridgeGUID = "38fcd0"
    gameController.mountZoneGUID = "45d15b"
    gameController.standardMapsGUID = "e451ae"
    gameController.battleLinesCompetitiveMapsGUID = "e7b6f3"
    gameController.battleLinesCreativeMapsGUID = "90e744"

    gameController.customMapsGUID = "5f844e"
    gameController.competitiveTerrainCartridgeGUID = "cbd273"
    gameController.tournamentMapsGUID = "b0e1fc"
    gameController.userMapsGUID = "918e4e"
    gameController.gatheringLegionsMapsGUID = "b87979"
    gameController.deploymentOverlaysGUID = "208a88"
    gameController.objectiveCardsGUID = "8eea59"
    gameController.deploymentCardsGUID = "924285"
    gameController.conditionsCardsGUID = "3494a8"
    gameController.battlefieldCardsGUID = "9ef154"

    local z1 = -3.24
    local z2 = -1.03
    local z3 = 1.26
    local z4 = 3.53
    gameController.setUpCardsPos = {
      objective = {
        {0.18, -3.42, z1},
        {0.18, -3.42, z2},
        {0.18, -3.42, z3},
        {0.18, -3.42, z4},
      },
      deployment = {
        {1.23, -1.88, z1},
        {1.23, -1.88, z2}, 
        {1.23, -1.88, z3},
        {1.23, -1.88, z4},
      },
      conditions = {
        {2.27, -0.32, z1},
        {2.27, -0.32, z2},
        {2.27, -0.32, z3},
        {2.27, -0.32, z4},
      }
    }


    -- TV
    screenGUID = "33d1ed"

    -- setup data
    setUpData = {}
    setUpData.deploymentMountGUID = "538f4d"
    setUpData.objectiveMountGUID = "9480a7"
    setUpData.conditionsMountGUID = "c6b3a9"

    setUpControllerGUID = "1cb552"

    -- HIGHLIGHT TINTS
    highlightTints = {}
    highlightTints[1] = {1,0,0}
    highlightTints[2] = {86/255, 1, 181/255}
    highlightTints[3] = {1,0,157/255}
    highlightTints[4] = {233/255,1,0}
    highlightTints[5] = {0,159/255,1}
    highlightTints[6] = {1,122/255,0}
    highlightTints[7] = {0,1,235/255}
    highlightTints[8] = {1,119/255,107/255}
    highlightTints[9] = {151/255,0,1}
    highlightTints[10] = {251/255,1,164/255}
    highlightTints[11] = {1,0,0}
    highlightTints[12] = {86/255, 1, 181/255}
    highlightTints[13] = {1,0,157/255}
    highlightTints[14] = {233/255,1,0}
    highlightTints[15] = {0,159/255,1}
    highlightTints[16] = {1,122/255,0}
    highlightTints[17] = {0,1,235/255}
    highlightTints[18] = {1,119/255,107/255}
    highlightTints[19] = {151/255,0,1}
    highlightTints[20] = {251/255,1,164/255}

    -- command tokens
    commandTokenData = {}

    commandTokenData.mesh = "http://cloud-3.steamusercontent.com/ugc/786359883314446513/4DBBAC00ABA5EABE88C2A86C3311C3FB6645FF25/"
    commandTokenData.collider = "http://cloud-3.steamusercontent.com/ugc/785234780866339915/85F7E717B9EFBE0396126CA673DF17EAFEC7D451/"

    commandTokenData.red = {}

    commandTokenData.red.com = "http://cloud-3.steamusercontent.com/ugc/2425823802350223302/3D52D57D51D5F04872B4BF989A0A8B5DE507636C/"
    commandTokenData.red.op = "http://cloud-3.steamusercontent.com/ugc/2425823802350223750/C3C09D828436CE827D7B788509A5264430CDCCBD/"
    commandTokenData.red.corps = "http://cloud-3.steamusercontent.com/ugc/2425823802350223459/C482A32B2B1DF9A6CB62F01DC0138023D122E813/"
    commandTokenData.red.sf = "http://cloud-3.steamusercontent.com/ugc/2425823802350223881/5F93AC468782FF6B253528788AD43883D873D534/"
    commandTokenData.red.sup = "http://cloud-3.steamusercontent.com/ugc/2425823802350224054/3AC5129B9CFE85C357635FAA5A19395CE93BC5D4/"
    commandTokenData.red.heavy = "http://cloud-3.steamusercontent.com/ugc/2425823802350223589/13B60C1680CB40EA02470BFCF77C30DDE55B08CE/"

    commandTokenData.red.imperialCommander = commandTokenData.red.com
    commandTokenData.red.imperialOperative = commandTokenData.red.op
    commandTokenData.red.imperialCorps = commandTokenData.red.corps
    commandTokenData.red.imperialSpecialforces = commandTokenData.red.sf
    commandTokenData.red.imperialSupport = commandTokenData.red.sup
    commandTokenData.red.imperialHeavy = commandTokenData.red.heavy

    commandTokenData.red.rebelCommander = commandTokenData.red.com
    commandTokenData.red.rebelOperative = commandTokenData.red.op
    commandTokenData.red.rebelCorps = commandTokenData.red.corps
    commandTokenData.red.rebelSpecialforces = commandTokenData.red.sf
    commandTokenData.red.rebelSupport = commandTokenData.red.sup
    commandTokenData.red.rebelHeavy = commandTokenData.red.heavy

    commandTokenData.red.separatistCommander = commandTokenData.red.com
    commandTokenData.red.separatistOperative = commandTokenData.red.op
    commandTokenData.red.separatistCorps = commandTokenData.red.corps
    commandTokenData.red.separatistSpecialforces = commandTokenData.red.sf
    commandTokenData.red.separatistSupport = commandTokenData.red.sup
    commandTokenData.red.separatistHeavy = commandTokenData.red.heavy

    commandTokenData.red.republicCommander = commandTokenData.red.com
    commandTokenData.red.republicOperative = commandTokenData.red.op
    commandTokenData.red.republicCorps = commandTokenData.red.corps
    commandTokenData.red.republicSpecialforces = commandTokenData.red.sf
    commandTokenData.red.republicSupport = commandTokenData.red.sup
    commandTokenData.red.republicHeavy = commandTokenData.red.heavy

    commandTokenData.red.shadowcollectiveCommander = commandTokenData.red.com
    commandTokenData.red.shadowcollectiveOperative = commandTokenData.red.op
    commandTokenData.red.shadowcollectiveCorps = commandTokenData.red.corps
    commandTokenData.red.shadowcollectiveSpecialforces = commandTokenData.red.sf
    commandTokenData.red.shadowcollectiveSupport = commandTokenData.red.sup
    commandTokenData.red.shadowcollectiveHeavy = commandTokenData.red.heavy

    commandTokenData.blue = {}

    commandTokenData.blue.com = "http://cloud-3.steamusercontent.com/ugc/2425823802350222557/F54CD13B525EB1CBFB2952383CAEE124119D7C9F/"
    commandTokenData.blue.op = "http://cloud-3.steamusercontent.com/ugc/2425823802350222987/04E37D5634E5E00C70765CDAA5FBFBA5A3EF06E5/"
    commandTokenData.blue.corps = "http://cloud-3.steamusercontent.com/ugc/2425823802350222752/3A3519FB659AE4BCF8D84D4F33100C8162FDF0E4/"
    commandTokenData.blue.sf = "http://cloud-3.steamusercontent.com/ugc/2425823802350223089/89F5AA847DA71F3148E4A97B41489FC2B2DBB945/"
    commandTokenData.blue.sup = "http://cloud-3.steamusercontent.com/ugc/2425823802350223170/D9DE41DE504F73766E11F5DAD3B4DF005ED59ACC/"
    commandTokenData.blue.heavy = "http://cloud-3.steamusercontent.com/ugc/2425823802350222879/D84AE73FA68A8B02A8FBFE13FC6C3683964B124E/"

    commandTokenData.blue.imperialCommander = commandTokenData.blue.com
    commandTokenData.blue.imperialOperative = commandTokenData.blue.op
    commandTokenData.blue.imperialCorps = commandTokenData.blue.corps
    commandTokenData.blue.imperialSpecialforces = commandTokenData.blue.sf
    commandTokenData.blue.imperialSupport = commandTokenData.blue.sup
    commandTokenData.blue.imperialHeavy = commandTokenData.blue.heavy

    commandTokenData.blue.rebelCommander = commandTokenData.blue.com
    commandTokenData.blue.rebelOperative = commandTokenData.blue.op
    commandTokenData.blue.rebelCorps = commandTokenData.blue.corps
    commandTokenData.blue.rebelSpecialforces = commandTokenData.blue.sf
    commandTokenData.blue.rebelSupport = commandTokenData.blue.sup
    commandTokenData.blue.rebelHeavy = commandTokenData.blue.heavy

    commandTokenData.blue.separatistCommander = commandTokenData.blue.com
    commandTokenData.blue.separatistOperative = commandTokenData.blue.op
    commandTokenData.blue.separatistCorps = commandTokenData.blue.corps
    commandTokenData.blue.separatistSpecialforces = commandTokenData.blue.sf
    commandTokenData.blue.separatistSupport = commandTokenData.blue.sup
    commandTokenData.blue.separatistHeavy = commandTokenData.blue.heavy

    commandTokenData.blue.republicCommander = commandTokenData.blue.com
    commandTokenData.blue.republicOperative = commandTokenData.blue.op
    commandTokenData.blue.republicCorps = commandTokenData.blue.corps
    commandTokenData.blue.republicSpecialforces = commandTokenData.blue.sf
    commandTokenData.blue.republicSupport = commandTokenData.blue.sup
    commandTokenData.blue.republicHeavy = commandTokenData.blue.heavy

    commandTokenData.blue.shadowcollectiveCommander = commandTokenData.blue.com
    commandTokenData.blue.shadowcollectiveOperative = commandTokenData.blue.op
    commandTokenData.blue.shadowcollectiveCorps = commandTokenData.blue.corps
    commandTokenData.blue.shadowcollectiveSpecialforces = commandTokenData.blue.sf
    commandTokenData.blue.shadowcollectiveSupport = commandTokenData.blue.sup
    commandTokenData.blue.shadowcollectiveHeavy = commandTokenData.blue.heavy

    commandTokenTrayData = {}
    commandTokenTrayData.red = {}
    commandTokenTrayData.red.trayZoneGUID = "a74687"
    commandTokenTrayData.red.rebelCommander = "071592"
    commandTokenTrayData.red.rebelOperative = "369fa9"
    commandTokenTrayData.red.rebelCorps = "af4c28"
    commandTokenTrayData.red.rebelSpecialforces = "abb909"
    commandTokenTrayData.red.rebelSupport = "ce9be9"
    commandTokenTrayData.red.rebelHeavy = "f68963"
    commandTokenTrayData.red.imperialCommander = "071592"
    commandTokenTrayData.red.imperialOperative = "369fa9"
    commandTokenTrayData.red.imperialCorps = "af4c28"
    commandTokenTrayData.red.imperialSpecialforces = "abb909"
    commandTokenTrayData.red.imperialSupport = "ce9be9"
    commandTokenTrayData.red.imperialHeavy = "f68963"
    commandTokenTrayData.red.republicCommander = "071592"
    commandTokenTrayData.red.republicOperative = "369fa9"
    commandTokenTrayData.red.republicCorps = "af4c28"
    commandTokenTrayData.red.republicSpecialforces = "abb909"
    commandTokenTrayData.red.republicSupport = "ce9be9"
    commandTokenTrayData.red.republicHeavy = "f68963"
    commandTokenTrayData.red.separatistCommander = "071592"
    commandTokenTrayData.red.separatistOperative = "369fa9"
    commandTokenTrayData.red.separatistCorps = "af4c28"
    commandTokenTrayData.red.separatistSpecialforces = "abb909"
    commandTokenTrayData.red.separatistSupport = "ce9be9"
    commandTokenTrayData.red.separatistHeavy = "f68963"
    commandTokenTrayData.red.shadowcollectiveCommander = "071592"
    commandTokenTrayData.red.shadowcollectiveOperative = "369fa9"
    commandTokenTrayData.red.shadowcollectiveCorps = "af4c28"
    commandTokenTrayData.red.shadowcollectiveSpecialforces = "abb909"
    commandTokenTrayData.red.shadowcollectiveSupport = "ce9be9"
    commandTokenTrayData.red.shadowcollectiveHeavy = "f68963"
    commandTokenTrayData.red.stack = "e2202d"

    commandTokenTrayData.blue = {}
    commandTokenTrayData.blue.trayZoneGUID = "97b998"
    commandTokenTrayData.blue.rebelCommander = "57ab78"
    commandTokenTrayData.blue.rebelOperative = "b30914"
    commandTokenTrayData.blue.rebelCorps = "e5e8df"
    commandTokenTrayData.blue.rebelSpecialforces = "3832c6"
    commandTokenTrayData.blue.rebelSupport = "d2c857"
    commandTokenTrayData.blue.rebelHeavy = "6d221d"
    commandTokenTrayData.blue.imperialCommander = "57ab78"
    commandTokenTrayData.blue.imperialOperative = "b30914"
    commandTokenTrayData.blue.imperialCorps = "e5e8df"
    commandTokenTrayData.blue.imperialSpecialforces = "3832c6"
    commandTokenTrayData.blue.imperialSupport = "d2c857"
    commandTokenTrayData.blue.imperialHeavy = "6d221d"
    commandTokenTrayData.blue.republicCommander = "57ab78"
    commandTokenTrayData.blue.republicOperative = "b30914"
    commandTokenTrayData.blue.republicCorps = "e5e8df"
    commandTokenTrayData.blue.republicSpecialforces = "3832c6"
    commandTokenTrayData.blue.republicSupport = "d2c857"
    commandTokenTrayData.blue.republicHeavy = "6d221d"
    commandTokenTrayData.blue.separatistCommander = "57ab78"
    commandTokenTrayData.blue.separatistOperative = "b30914"
    commandTokenTrayData.blue.separatistCorps = "e5e8df"
    commandTokenTrayData.blue.separatistSpecialforces = "3832c6"
    commandTokenTrayData.blue.separatistSupport = "d2c857"
    commandTokenTrayData.blue.separatistHeavy = "6d221d"
    commandTokenTrayData.blue.shadowcollectiveCommander = "57ab78"
    commandTokenTrayData.blue.shadowcollectiveOperative = "b30914"
    commandTokenTrayData.blue.shadowcollectiveCorps = "e5e8df"
    commandTokenTrayData.blue.shadowcollectiveSpecialforces = "3832c6"
    commandTokenTrayData.blue.shadowcollectiveSupport = "d2c857"
    commandTokenTrayData.blue.shadowcollectiveHeavy = "6d221d"
    commandTokenTrayData.blue.stack = "c9f9d0"

    -- standby tokens
    standbyTokens()
end

function standbyTokens()
    local allObjs = getAllObjects()
    for i, obj in pairs(allObjs) do
        if obj.getVar("isAToken") == true then
            obj.call("standby")
        elseif obj.getName() == "Cohesion Ruler" or obj.getName() == "Movement Template" or obj.getName() == "Range Ruler" or obj.getName() == "Deployment Boundary" then
            destroyObject(obj)
        end
    end
end


function dummy() end

-- Initialize red and blue clocks at 01:30:00
function initChessClocks(guids, show)
  Wait.frames(function()
    if show then
      toggleChessClockUI()
    else
      for _, v in pairs(guids) do
        local obj = getObjectFromGUID(v)
        obj.setScale({0, 0, 0})
        obj.Clock.setValue(5400)
      end
    end
  end)
end

-- Builds all mod-specific hotkeys. Players can customize key bindings via in-game menus
-- addHotkey is preferred over onScriptingButton[Up|Down] due to customizability by players
function initHotkeys()
  initRangebandHotkeys()
  initCohesionHotkeys()
  initTokenHotkeys()
  initChessClockHotkeys()
end

-- Rangeband Hotkeys --
function initRangebandHotkeys()
  addHotkey(
    "Show Range On Hovered Model",
    function (playerColor, hoverObject, cursorPosition)
      showRangeOnHoveredModel(hoverObject)
    end
  )
end
-- END Rangeband Hotkeys --

-- Cohesion Hotkeys --
function initCohesionHotkeys()
   addHotkey(
      "Show Cohesion On Hovered Model",
      function (playerColor, hoverObject, cursorPosition)
         showCohesionOnHoveredModel(hoverObject)
      end
   )
end
-- END Cohesion Hotkeys --

-- Token Hotkeys --
function initTokenHotkeys()
  globalBagGUIDs = {
    Aim = aimBagGUID,
    Dodge = dodgeBagGUID,
    Standby = standbyBagGUID,
    Surge = surgeBagGUID,
    Suppression = suppressionBagGUID,
    Smoke = smokeBagGUID,
    Ion = ionBagGUID,
    Wound = woundBagGUID,
    -- add more key,value pairs in here once Global has more bagGUID vars added
  }

  for hotkeyName,bagGUID in pairs (globalBagGUIDs) do
    addHotkey(
      "Deliver "..hotkeyName.." to Cursor",
      function(playerColor, hoverObject, cursorPosition)
        -- local bagGUID = Global.getVar(varName)
        if bagGUID then
          local bag = getObjectFromGUID(bagGUID)
          if bag ~= nil then
            bag.takeObject({
              position = cursorPosition + Vector({0,1,0}),
              smooth = false, -- remove this if you want to keep the animation
            })
          end
        end
      end
    )
  end
end
-- END Token Hotkeys --

-- Chessclock Hotkeys --
function initChessClockHotkeys()
  clocks = {
    Blue = getObjectFromGUID(clockGUIDs.blue).Clock,
    Red = getObjectFromGUID(clockGUIDs.red).Clock
  }
  addHotkey("Toggle Chess Clocks", toggleChessClocks)
  addHotkey("Pause All Chess Clocks", pauseAllChessClocks)
end

function updateClockButton()
  if clocks.Blue.paused and clocks.Red.paused then
    UI.setValue("toggleClockText", "Chess Clocks Paused")
    UI.setAttribute("toggleClockButton", "colors", "#FFFFFF|#DFDFDF")
  elseif clocks.Blue.paused then
    UI.setValue("toggleClockText", "Red Player on Clock")
    UI.setAttribute("toggleClockButton", "colors", "#DF0000|#DF0000")
  else
    UI.setValue("toggleClockText", "Blue Player on Clock")
    UI.setAttribute("toggleClockButton", "colors", "#0000DF|#0000DF")
  end
end

function toggleClockButton(player, button)
  local color = tostring(player.color)
  if button == "-1" then
    toggleChessClocks(color)
  else
    pauseAllChessClocks(color)
  end
end

-- Toggles the active clock between Red and Blue
-- If neither clock is currently active, activates Blue
function toggleChessClocks(playerColor)
  if not clocks[playerColor] then
    broadcastToAll('Only players can toggle chess clocks')
    return
  end
  -- Returns the name of the player currently on the clock
  -- if steam_name is not available, returns player color
  local function getClockPlayerName()
    if clocks.Blue.paused then
      return Player.Red.steam_name or "Red"
    else
      return Player.Blue.steam_name or "Blue"
    end
  end
  -- Returns the player color currently on the clock
  local function getClockPlayerColor()
    return clocks.Blue.paused and "Red" or "Blue"
  end

  if clocks.Blue.paused and clocks.Red.paused then
    clocks.Blue.pauseStart()
  else
    clocks.Blue.pauseStart()
    clocks.Red.pauseStart()
  end

  local fontColors = {
    diffuse = {1,0,0},
  }
  broadcastToAll ("*** " .. getClockPlayerName() .. " is now on the clock ***", fontColors[getClockPlayerColor()])
  updateClockButton()
end

-- Calls pauseStart() for each clock that is not already paused
function pauseAllChessClocks(playerColor)
  for k, v in pairs(clocks) do
    if not v.paused then v.pauseStart() end
  end
  broadcastToAll('All chess clocks paused')
  updateClockButton()
end
-- END Chessclock Hotkeys --

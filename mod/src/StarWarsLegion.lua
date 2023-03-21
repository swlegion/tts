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
    commandTokenData.red.imperialCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181599643/538FA3C32413306DE7F650F9A0B1B19BB68FDE59/ "
    commandTokenData.red.imperialOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181602271/BAA5A49CC32D2F30D5F3519D3B8A11C0B91E4938/"
    commandTokenData.red.imperialCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181601340/9C023439BD650520C6260EE49AE23C619AD3A3E2/"
    commandTokenData.red.imperialSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181602934/38C669F790A0932DFB092B5A6DDC10F3017CB9AA/"
    commandTokenData.red.imperialSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181603317/6299EEDC4EAC45EB5C6CE9DD1451C49012C42A56/"
    commandTokenData.red.imperialHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181601845/B2E886C7B7639C491D0B7A5F369E9DACDE31A8FF/"

    commandTokenData.red.rebelCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181606961/B11A9AB1E8860F6E1EA263150C5608580522773C/"
    commandTokenData.red.rebelOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181607788/309F540CF290A636E47BCEC08509BF049EA2C96C/"
    commandTokenData.red.rebelCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181607230/299FF1E61697FFCBB40A74AAC189D11B4EAFBA3B/"
    commandTokenData.red.rebelSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181608049/93F9E0FA9F969438FC7F0A2508739CBE55119089/"
    commandTokenData.red.rebelSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181608299/117B4BBD9BFCA743B24FA873529080F60D127376/"
    commandTokenData.red.rebelHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181607465/424CED4049BE2724595B4D8DCA61034090D2F163/"

    commandTokenData.red.separatistCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181506935/F326233CD49B1CB2CE69DEFE791B37BD56B7BD25/"
    commandTokenData.red.separatistOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181507250/B6874C9325A8638EF87FC5C6BA68CF2629A84E45/"
    commandTokenData.red.separatistCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181507051/6C46619634312333ECE65818274D508912E18C39/"
    commandTokenData.red.separatistSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181507369/C0070810C0D058539BEDDE5B6893E6EAAB2798AD/"
    commandTokenData.red.separatistSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181507457/78724FE17CEC857896F886FBF5A4F6698502AB3C/"
    commandTokenData.red.separatistHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181507153/50D4D88CB44EF0FDFFF369E81DF08D91EB79A12B/"

    commandTokenData.red.republicCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181604329/E2F9C9A96EDD4E6D53505D87F32A69626C7B6A02/"
    commandTokenData.red.republicOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181605292/782B85305B4C7BB6D03306E02D33F8D051CDEF47/"
    commandTokenData.red.republicCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181604631/288BB3DB047861724810E08E7512B005E1E7046A/"
    commandTokenData.red.republicSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181605649/09E2E50C8CE87041E630B29183D4D3F3E17801BC/"
    commandTokenData.red.republicSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181605997/96BF8F41D8B4EA9E441FD1F5F6890DCF7337AAFF/"
    commandTokenData.red.republicHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181604927/AF5A4C46BC7FD06425DFE9481A8086DBE865404B/"

    commandTokenData.red.shadowcollectiveCommander = "http://cloud-3.steamusercontent.com/ugc/1856061112422440548/1A0E402A295550F940588A97EF946FD326EC5229/"
    commandTokenData.red.shadowcollectiveOperative = "http://cloud-3.steamusercontent.com/ugc/1856061112422440693/1CFD79EF8B8817D18A7F3849407084767052D5A7/"
    commandTokenData.red.shadowcollectiveCorps = "http://cloud-3.steamusercontent.com/ugc/1856061112422440599/36E169D393C702BB1579B46E84C142D5C3DFCCB2/"
    commandTokenData.red.shadowcollectiveSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1856061112422440731/C495B15A488DA05675CAAC55FE5B23AA5CA4473F/"
    commandTokenData.red.shadowcollectiveSupport = "http://cloud-3.steamusercontent.com/ugc/1856061112422440777/A42960E2117A5C155C20C98E2385C8325206906B/"
    commandTokenData.red.shadowcollectiveHeavy = "http://cloud-3.steamusercontent.com/ugc/1856061112422440651/50E7A74A18D237B66362BA5BE12E3219FED55FF7/"

    commandTokenData.blue = {}
    commandTokenData.blue.imperialCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181467231/3D469F73AB4AEE0A8D4DAC26EE98A82C144C2312/"
    commandTokenData.blue.imperialOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181470653/D06C37C9664EEE89FA4B4A5A4588C4576CC9C72E/"
    commandTokenData.blue.imperialCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181469578/56191D081421C02B875AC944DCEFE2063F1D7FC1/"
    commandTokenData.blue.imperialSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181471412/21A6DB99FF4692AC1EA2C2A1E9EAEA867F32150E/"
    commandTokenData.blue.imperialSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181471773/10D6943934FD8A2FB6DC1F2F5ED766C8AF4B05CB/"
    commandTokenData.blue.imperialHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181469895/150FB46A62076AE9617AF4E24421060702896E17/"

    commandTokenData.blue.rebelCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181476307/3A7B81D4F46F476F3D74834F4B61448EDE37FDC6/"
    commandTokenData.blue.rebelOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181480853/E2992559CBCB8D9712DB3B69F6C2BEF780A194AA/"
    commandTokenData.blue.rebelCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181477778/29C9963DB9D2CFE5565EDF4F2B687A5648F8F8DE/"
    commandTokenData.blue.rebelSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181481428/CA5B75597BF564B305A8638F732B802BE4CB3DA0/"
    commandTokenData.blue.rebelSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181481946/5898BF5462D11B8D49D6735D959379AC8B527DCF/"
    commandTokenData.blue.rebelHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181479826/6106C3F552B8A4286B6FE02FB319593D9245E658/"

    commandTokenData.blue.separatistCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181449743/EAF70993553414449641A211913A77AD021B18C9/"
    commandTokenData.blue.separatistOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181450993/AFE85A02D6C48DDBC4846FA571E2E1B7AACD968A/"
    commandTokenData.blue.separatistCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181450408/539DA5CD945A8D06F4D94862CD785F5FEE304CCB/"
    commandTokenData.blue.separatistSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181466311/BBAE13B86F470FB0098906CE82C217ECED36F22E/"
    commandTokenData.blue.separatistSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181466661/6827A183859436F4BAB606B62EC27FB1F02DDAB2/"
    commandTokenData.blue.separatistHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181450723/2D5159B73DF62A6E9910A376D47DC0A7EB702338/"

    commandTokenData.blue.republicCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181472136/4A0FA517DC4F0D56E9D2532283931EE40C779EC0/"
    commandTokenData.blue.republicOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181474496/EB70DAE07E3E9D9BAC1D8D245D6318668C06D17D/"
    commandTokenData.blue.republicCorps = "http://cloud-3.steamusercontent.com/ugc/1018319581181472463/64892947D4142261C8A9F729533D5A075EA383D1/"
    commandTokenData.blue.republicSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1018319581181474915/D48FDC9815EEDBE6306F310E78ED1C9ADFF69D57/"
    commandTokenData.blue.republicSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181475330/17110C087B25CEE6E0ADDBA8F4E4D34A6594D3C7/"
    commandTokenData.blue.republicHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181472795/79E2E21BD525AC36BA389C77A0227E12E624707B/"

    commandTokenData.blue.shadowcollectiveCommander = "http://cloud-3.steamusercontent.com/ugc/1856061112422440157/1D014DEA71FDEFAE0230A09DAC383A7558983ABF/"
    commandTokenData.blue.shadowcollectiveOperative = "http://cloud-3.steamusercontent.com/ugc/1856061112422440362/BEE23D08126F88FF445DB47C3639E4E2E1B3C2A0/"
    commandTokenData.blue.shadowcollectiveCorps = "http://cloud-3.steamusercontent.com/ugc/1856061112422440235/CA277E7D315182CAB0CF1C92384860012D9ED1EA/"
    commandTokenData.blue.shadowcollectiveSpecialforces = "http://cloud-3.steamusercontent.com/ugc/1856061112422440443/02FF552DE7B9C6EAB6432B3BED254FCDCED09756/"
    commandTokenData.blue.shadowcollectiveSupport = "http://cloud-3.steamusercontent.com/ugc/1856061112422440497/3ACEF5EA33F7540A6A37885F3BCBDF862391A661/"
    commandTokenData.blue.shadowcollectiveHeavy = "http://cloud-3.steamusercontent.com/ugc/1856061112422440313/2394BEAFFF809A9161472A900619B2D6175C39F3/"

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

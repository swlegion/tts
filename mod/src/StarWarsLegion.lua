#include !/data/CardInfo
#include !/data/ListBuilder
#include !/data/MiniInfo
#include !/data/TemplateMenu
#include !/data/UnitInfo

function onLoad()
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
    initChessClocks(clockGUIDs)

    battlefieldTable = "3a3ed9"

    templateInfo = {}

    templateInfo.templateAGUID = {
        small = {"15849b", "f8f24c", "7568b1"}, medium = {"e20bd9", "9ab5d8", "ea3b10"}, big = {"28e15d", "2b6fd5", "62e790"}, huge = {"d80f36", "819324", "28a694"}
    }
    templateInfo.templateBGUID = {
        small = {"b35f7f", "4536a9", "c6150a"}, medium = {"46d669", "7c0b7a", "a99aaa"}, big = {"53689b", "93219f", "62d768"}, huge = {"0975c7", "968781", "f80c9d"}
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

    templateInfo.aStart = {}
    templateInfo.aStart.small = 	{1.968995,3,4}
    templateInfo.aStart.medium = 	{2.234375,3.26538,4.26538}
    templateInfo.aStart.big =		 {2.640625,3.67163,4.67163}
    templateInfo.aStart.huge =		 {3.21875,4.249755,5.249755}
    templateInfo.aStart.long =		 {4.71875,5.749755,6.749755}
    templateInfo.aStart.epic =		 {4.21875,5.249755,6.249755}

    templateInfo.bStart = {}
    templateInfo.bStart.small = 	{1.968995,3,4}
    templateInfo.bStart.medium =	 {2.234375,3.26538,4.26538}
    templateInfo.bStart.big =		 {2.640625,3.67163,4.67163}
    templateInfo.bStart.huge =		 {3.21875,4.249755,5.249755}
    templateInfo.bStart.long =		 {4.71875,5.749755,6.749755}

    templateInfo.bStart.epic = templateInfo.aStart.epic



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
    templateInfo.templateNameToData.whiteTemplateASnap60mm = {baseSize = "big", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateASnap90mm = {baseSize = "huge", selectedSpeed = 1}

    templateInfo.templateNameToData.blackTemplateASnap25mm = {baseSize = "small", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateASnap40mm = {baseSize = "medium", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateASnap60mm = {baseSize = "big", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateASnap90mm = {baseSize = "huge", selectedSpeed = 2}

    templateInfo.templateNameToData.redTemplateASnap25mm = {baseSize = "small", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateASnap40mm = {baseSize = "medium", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateASnap60mm = {baseSize = "big", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateASnap90mm = {baseSize = "huge", selectedSpeed = 3}

    templateInfo.templateNameToData.whiteTemplateBSnap25mm = {baseSize = "small", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateBSnap40mm = {baseSize = "medium", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateBSnap60mm = {baseSize = "big", selectedSpeed = 1}
    templateInfo.templateNameToData.whiteTemplateBSnap90mm = {baseSize = "huge", selectedSpeed = 1}

    templateInfo.templateNameToData.blackTemplateBSnap25mm = {baseSize = "small", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateBSnap40mm = {baseSize = "medium", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateBSnap60mm = {baseSize = "big", selectedSpeed = 2}
    templateInfo.templateNameToData.blackTemplateBSnap90mm = {baseSize = "huge", selectedSpeed = 2}

    templateInfo.templateNameToData.redTemplateBSnap25mm = {baseSize = "small", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateBSnap40mm = {baseSize = "medium", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateBSnap60mm = {baseSize = "big", selectedSpeed = 3}
    templateInfo.templateNameToData.redTemplateBSnap90mm = {baseSize = "huge", selectedSpeed = 3}
    templateInfo.diceTrayGUID = "3d3ac4"

    templateInfo.moveTemplate = {}
    templateInfo.moveTemplate[1] = {}
    templateInfo.moveTemplate[1].mesh = {}
    templateInfo.moveTemplate[1].mesh.small = "http://cloud-3.steamusercontent.com/ugc/785234780854759842/01D41C421A255FA3851BD89F18C85B5B294545EB/"
    templateInfo.moveTemplate[1].mesh.medium = "http://cloud-3.steamusercontent.com/ugc/785234780854759842/01D41C421A255FA3851BD89F18C85B5B294545EB/"
    templateInfo.moveTemplate[1].mesh.big = "http://cloud-3.steamusercontent.com/ugc/785234780854759842/01D41C421A255FA3851BD89F18C85B5B294545EB/"
    templateInfo.moveTemplate[1].mesh.huge = "http://cloud-3.steamusercontent.com/ugc/785234780854759842/01D41C421A255FA3851BD89F18C85B5B294545EB/"
    templateInfo.moveTemplate[1].mesh.long = "http://cloud-3.steamusercontent.com/ugc/785234780854759842/01D41C421A255FA3851BD89F18C85B5B294545EB/"
    templateInfo.moveTemplate[1].mesh.epic = "http://cloud-3.steamusercontent.com/ugc/785234780854759842/01D41C421A255FA3851BD89F18C85B5B294545EB/"
    templateInfo.moveTemplate[1].diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780854759947/54081B46AD51B4601980DE9C7AC85FA76DDB09EA/"
    templateInfo.moveTemplate[1].shortCollider = "http://cloud-3.steamusercontent.com/ugc/785234780854760268/38CA5CF242EFC8AC89552BB5AB04C2F82E26869F/"
    templateInfo.moveTemplate[1].longCollider = "http://cloud-3.steamusercontent.com/ugc/785234780854760161/68075BDD0F19BAD552C1FAD7E0B5DC2B11ACC9CA/"
    templateInfo.moveTemplate[1].colorTint = {1,1,1}


    templateInfo.moveTemplate[2] = {}
    templateInfo.moveTemplate[2].mesh = {}
    templateInfo.moveTemplate[2].mesh.small = "http://cloud-3.steamusercontent.com/ugc/785234780854723671/BBF8FA3F838F18A0A774CB6F275A69922A829BDE/"
    templateInfo.moveTemplate[2].mesh.medium = "http://cloud-3.steamusercontent.com/ugc/785234780854723671/BBF8FA3F838F18A0A774CB6F275A69922A829BDE/"
    templateInfo.moveTemplate[2].mesh.big = "http://cloud-3.steamusercontent.com/ugc/785234780854723671/BBF8FA3F838F18A0A774CB6F275A69922A829BDE/"
    templateInfo.moveTemplate[2].mesh.huge = "http://cloud-3.steamusercontent.com/ugc/785234780854723671/BBF8FA3F838F18A0A774CB6F275A69922A829BDE/"
    templateInfo.moveTemplate[2].mesh.long = "http://cloud-3.steamusercontent.com/ugc/785234780854723671/BBF8FA3F838F18A0A774CB6F275A69922A829BDE/"
    templateInfo.moveTemplate[2].mesh.epic = "http://cloud-3.steamusercontent.com/ugc/785234780854723671/BBF8FA3F838F18A0A774CB6F275A69922A829BDE/"
    templateInfo.moveTemplate[2].diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780854724909/C072D675F67ED9DE36A6ECBC57399DB0497034C5/"
    templateInfo.moveTemplate[2].shortCollider = "http://cloud-3.steamusercontent.com/ugc/785234780854760528/0F20A46474850AA384B713829775CEDA580618A9/"
    templateInfo.moveTemplate[2].longCollider = "http://cloud-3.steamusercontent.com/ugc/785234780854726030/A28F7F71502F3C567F4A69089A3440EEDA4049A0/"
    templateInfo.moveTemplate[2].colorTint = {0.5,0.5,0.5}

    templateInfo.moveTemplate[3] = {}
    templateInfo.moveTemplate[3].mesh = {}
    templateInfo.moveTemplate[3].mesh.small = "http://cloud-3.steamusercontent.com/ugc/785234780854760704/CE714393A691700C653EAD87BF876BA9194CDE9C/"
    templateInfo.moveTemplate[3].mesh.medium = "http://cloud-3.steamusercontent.com/ugc/785234780854760704/CE714393A691700C653EAD87BF876BA9194CDE9C/"
    templateInfo.moveTemplate[3].mesh.big = "http://cloud-3.steamusercontent.com/ugc/785234780854760704/CE714393A691700C653EAD87BF876BA9194CDE9C/"
    templateInfo.moveTemplate[3].mesh.huge = "http://cloud-3.steamusercontent.com/ugc/785234780854760704/CE714393A691700C653EAD87BF876BA9194CDE9C/"
    templateInfo.moveTemplate[3].mesh.long = "http://cloud-3.steamusercontent.com/ugc/785234780854760704/CE714393A691700C653EAD87BF876BA9194CDE9C/"
    templateInfo.moveTemplate[3].mesh.epic = "http://cloud-3.steamusercontent.com/ugc/785234780854760704/CE714393A691700C653EAD87BF876BA9194CDE9C/"
    templateInfo.moveTemplate[3].diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780854771943/3C734C233CD0ECF47797501CBFBE21E0AB8A84F0/"
    templateInfo.moveTemplate[3].shortCollider = "http://cloud-3.steamusercontent.com/ugc/785234780854760896/35D512103AAFBC7856FA2FF4ACF14C342688A40D/"
    templateInfo.moveTemplate[3].longCollider = "http://cloud-3.steamusercontent.com/ugc/785234780854760805/D65DED99C49D606A540D8BFAC4740E2FF55C9ACD/"
    templateInfo.moveTemplate[3].colorTint = {1,0.2,0.2}

    templateInfo.baseRadius = {
      -- Troopers
      small = 1.06299,

      -- Tauntauns, Droidekas, Speeder Bikes, Mortars
      medium = 1.9685,

      -- AT-RTs, eWebs
      big = 2.75591,

      -- Landspeeder, AT-ST
      huge = 3.93701,

      -- Occupier Tank
      long = 3.93701,

      -- AAT, Saber Tank
      epic = 5.867,
    }

    templateInfo.cohesionRadius = {
      -- Troopers
      small = 4.494485,

      -- Tauntauns, Droidekas, Speeder Bikes, Mortars
      medium = 5.45275,

      -- AT-RTs, eWebs
      big = 7.133865,

      -- These are obviously incorrect, but currently cohesion does not matter for any of these units.

      -- Landspeeder, AT-ST
      huge = 8.905515,

      -- Occupier Tank
      long = 8.905515,

       -- AAT, Saber Tank
      epic = 8.905515
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

    -- unitInfo
    unitInfo = buildUnitInfo()
  
    -- LIST BUILDER info
    redSelectedArmyFaction = ""
    blueSelectedArmyFaction = ""
    listBuilder = buildListBuilder()
    templateMenu = buildTemplateMenu()

    -- mini info
    miniInfo = buildMiniInfo()
    cardInfo = buildCardInfo()

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

    gameController.setUpCardsPos = {}
    gameController.setUpCardsPos.objective = {{0.18, -3.42, -2.62}, {0.18, -3.42, 0.08}, {0.18, -3.42, 2.76}}
    gameController.setUpCardsPos.deployment = {{1.23, -1.88, -2.62},  {1.23, -1.88, 0.08}, {1.23, -1.88, 2.76}}
    gameController.setUpCardsPos.conditions = {{2.27, -0.32, -2.62}, {2.27, -0.32,0.08}, {2.27, -0.32, 2.76}}


    -- TV
    screenGUID = "33d1ed"


    -- setup cards

    setUpCards = {}
    setUpCards.objective = {}
    setUpCards.objective.keyPositions = {
        varName = "keyPositions",
        name = "Key Positions",
        tokens = true
    }
    setUpCards.objective.breakthrough = {
        varName = "breakthrough",
        name = "Breakthrough",
        tokens = false
    }
    setUpCards.objective.interceptTheTransmissions = {
        varName = "interceptTheTransmissions",
        name = "Intercept the Transmissions",
        tokens = true
    }
    setUpCards.objective.recoverTheSupplies = {
        varName = "recoverTheSupplies",
        name = "Recover the Supplies",
        tokens = true
    }
    setUpCards.objective.sabotageTheMoistureVaporators = {
        varName = "sabotageTheMoistureVaporators",
        name = "Sabotage the Moisture Vaporators",
        tokens = true
    }
    setUpCards.objective.payload = {
        varName = "payload",
        name = "Payload",
        tokens = true
    }
    setUpCards.objective.bombingRun = {
        varName = "bombingRun",
        name = "Bombing Run",
        tokens = true
    }
    setUpCards.objective.hostageExchange = {
        varName = "hostageExchange",
        name = "Hostage Exchange",
        tokens = true
    }

    setUpCards.deployment = {}
    setUpCards.deployment.battleLines = {
        varName = "battleLines",
        name = "Battle Lines"
    }
    setUpCards.deployment.theLongMarch = {
        varName = "theLongMarch",
        name = "The Long March"
    }
    setUpCards.deployment.disarray = {
        varName = "disarray",
        name = "Disarray"
    }
    setUpCards.deployment.majorOffensive = {
        varName = "majorOffensive",
        name = "Major Offensive"
    }
    setUpCards.deployment.advancedPositions = {
        varName = "advancedPositions",
        name = "Advanced Positions"
    }
    setUpCards.deployment.rollOut = {
        varName = "rollOut",
        name = "Roll Out"
    }
    setUpCards.deployment.dangerClose = {
        varName = "dangerClose",
        name = "Danger Close"
    }
    setUpCards.deployment.hemmedIn = {
        varName = "hemmedIn",
        name = "Hemmed In"
    }

    setUpCards.conditions = {}
    setUpCards.conditions.clearConditions = {
        varName = "clearConditions",
        name = "Clear Conditions",
        tokens = false
    }
    setUpCards.conditions.limitedVisibility = {
        varName = "limitedVisibility",
        name = "Limited Visibility",
        tokens = false
    }
    setUpCards.conditions.rapidReinforcements = {
        varName = "rapidReinforcements",
        name = "Rapid Reinforcements",
        tokens = true
    }
    setUpCards.conditions.hostileEnvironment = {
        varName = "hostileEnvironment",
        name = "Hostile Environment",
        tokens = false
    }
    setUpCards.conditions.mineField = {
        varName = "mineField",
        name = "Minefield",
        tokens = true
    }
    setUpCards.conditions.warWeary = {
        varName = "warWeary",
        name = "War Weary",
        tokens = false
    }
    setUpCards.conditions.fortifiedPositions = {
        varName = "fortifiedPositions",
        name = "Fortified Positions",
        tokens = true
    }
    setUpCards.conditions.supplyDrop = {
        varName = "supplyDrop",
        name = "Supply Drop",
        tokens = true
    }

    -- setup data
    setUpData = {}
    setUpData.deploymentCartridgeGUID = "208a88"
    setUpData.conditionsCartridgeGUID = "1c7fbf"
    setUpData.objectiveCartridgeGUID = "3d15a5"
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
    commandTokenData.red.imperialCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181601340/9C023439BD650520C6260EE49AE23C619AD3A3E2/"
    commandTokenData.red.imperialSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181602934/38C669F790A0932DFB092B5A6DDC10F3017CB9AA/"
    commandTokenData.red.imperialSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181603317/6299EEDC4EAC45EB5C6CE9DD1451C49012C42A56/"
    commandTokenData.red.imperialHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181601845/B2E886C7B7639C491D0B7A5F369E9DACDE31A8FF/"

    commandTokenData.red.rebelCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181606961/B11A9AB1E8860F6E1EA263150C5608580522773C/"
    commandTokenData.red.rebelOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181607788/309F540CF290A636E47BCEC08509BF049EA2C96C/"
    commandTokenData.red.rebelCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181607230/299FF1E61697FFCBB40A74AAC189D11B4EAFBA3B/"
    commandTokenData.red.rebelSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181608049/93F9E0FA9F969438FC7F0A2508739CBE55119089/"
    commandTokenData.red.rebelSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181608299/117B4BBD9BFCA743B24FA873529080F60D127376/"
    commandTokenData.red.rebelHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181607465/424CED4049BE2724595B4D8DCA61034090D2F163/"

    commandTokenData.red.separatistCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181506935/F326233CD49B1CB2CE69DEFE791B37BD56B7BD25/"
    commandTokenData.red.separatistOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181507250/B6874C9325A8638EF87FC5C6BA68CF2629A84E45/"
    commandTokenData.red.separatistCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181507051/6C46619634312333ECE65818274D508912E18C39/"
    commandTokenData.red.separatistSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181507369/C0070810C0D058539BEDDE5B6893E6EAAB2798AD/"
    commandTokenData.red.separatistSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181507457/78724FE17CEC857896F886FBF5A4F6698502AB3C/"
    commandTokenData.red.separatistHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181507153/50D4D88CB44EF0FDFFF369E81DF08D91EB79A12B/"

    commandTokenData.red.republicCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181604329/E2F9C9A96EDD4E6D53505D87F32A69626C7B6A02/"
    commandTokenData.red.republicOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181605292/782B85305B4C7BB6D03306E02D33F8D051CDEF47/"
    commandTokenData.red.republicCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181604631/288BB3DB047861724810E08E7512B005E1E7046A/"
    commandTokenData.red.republicSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181605649/09E2E50C8CE87041E630B29183D4D3F3E17801BC/"
    commandTokenData.red.republicSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181605997/96BF8F41D8B4EA9E441FD1F5F6890DCF7337AAFF/"
    commandTokenData.red.republicHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181604927/AF5A4C46BC7FD06425DFE9481A8086DBE865404B/"

    commandTokenData.blue = {}
    commandTokenData.blue.imperialCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181467231/3D469F73AB4AEE0A8D4DAC26EE98A82C144C2312/"
    commandTokenData.blue.imperialOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181470653/D06C37C9664EEE89FA4B4A5A4588C4576CC9C72E/"
    commandTokenData.blue.imperialCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181469578/56191D081421C02B875AC944DCEFE2063F1D7FC1/"
    commandTokenData.blue.imperialSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181471412/21A6DB99FF4692AC1EA2C2A1E9EAEA867F32150E/"
    commandTokenData.blue.imperialSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181471773/10D6943934FD8A2FB6DC1F2F5ED766C8AF4B05CB/"
    commandTokenData.blue.imperialHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181469895/150FB46A62076AE9617AF4E24421060702896E17/"

    commandTokenData.blue.rebelCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181476307/3A7B81D4F46F476F3D74834F4B61448EDE37FDC6/"
    commandTokenData.blue.rebelOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181480853/E2992559CBCB8D9712DB3B69F6C2BEF780A194AA/"
    commandTokenData.blue.rebelCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181477778/29C9963DB9D2CFE5565EDF4F2B687A5648F8F8DE/"
    commandTokenData.blue.rebelSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181481428/CA5B75597BF564B305A8638F732B802BE4CB3DA0/"
    commandTokenData.blue.rebelSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181481946/5898BF5462D11B8D49D6735D959379AC8B527DCF/"
    commandTokenData.blue.rebelHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181479826/6106C3F552B8A4286B6FE02FB319593D9245E658/"

    commandTokenData.blue.separatistCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181449743/EAF70993553414449641A211913A77AD021B18C9/"
    commandTokenData.blue.separatistOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181450993/AFE85A02D6C48DDBC4846FA571E2E1B7AACD968A/"
    commandTokenData.blue.separatistCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181450408/539DA5CD945A8D06F4D94862CD785F5FEE304CCB/"
    commandTokenData.blue.separatistSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181466311/BBAE13B86F470FB0098906CE82C217ECED36F22E/"
    commandTokenData.blue.separatistSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181466661/6827A183859436F4BAB606B62EC27FB1F02DDAB2/"
    commandTokenData.blue.separatistHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181450723/2D5159B73DF62A6E9910A376D47DC0A7EB702338/"

    commandTokenData.blue.republicCommander = "http://cloud-3.steamusercontent.com/ugc/1018319581181472136/4A0FA517DC4F0D56E9D2532283931EE40C779EC0/"
    commandTokenData.blue.republicOperative = "http://cloud-3.steamusercontent.com/ugc/1018319581181474496/EB70DAE07E3E9D9BAC1D8D245D6318668C06D17D/"
    commandTokenData.blue.republicCore = "http://cloud-3.steamusercontent.com/ugc/1018319581181472463/64892947D4142261C8A9F729533D5A075EA383D1/"
    commandTokenData.blue.republicSpecialForces = "http://cloud-3.steamusercontent.com/ugc/1018319581181474915/D48FDC9815EEDBE6306F310E78ED1C9ADFF69D57/"
    commandTokenData.blue.republicSupport = "http://cloud-3.steamusercontent.com/ugc/1018319581181475330/17110C087B25CEE6E0ADDBA8F4E4D34A6594D3C7/"
    commandTokenData.blue.republicHeavy = "http://cloud-3.steamusercontent.com/ugc/1018319581181472795/79E2E21BD525AC36BA389C77A0227E12E624707B/"

    commandTokenTrayData = {}
    commandTokenTrayData.red = {}
    commandTokenTrayData.red.trayZoneGUID = "a74687"
    commandTokenTrayData.red.rebelCommander = "071592"
    commandTokenTrayData.red.rebelOperative = "369fa9"
    commandTokenTrayData.red.rebelCore = "af4c28"
    commandTokenTrayData.red.rebelSpecialForces = "abb909"
    commandTokenTrayData.red.rebelSupport = "ce9be9"
    commandTokenTrayData.red.rebelHeavy = "f68963"
    commandTokenTrayData.red.imperialCommander = "071592"
    commandTokenTrayData.red.imperialOperative = "369fa9"
    commandTokenTrayData.red.imperialCore = "af4c28"
    commandTokenTrayData.red.imperialSpecialForces = "abb909"
    commandTokenTrayData.red.imperialSupport = "ce9be9"
    commandTokenTrayData.red.imperialHeavy = "f68963"
    commandTokenTrayData.red.republicCommander = "071592"
    commandTokenTrayData.red.republicOperative = "369fa9"
    commandTokenTrayData.red.republicCore = "af4c28"
    commandTokenTrayData.red.republicSpecialForces = "abb909"
    commandTokenTrayData.red.republicSupport = "ce9be9"
    commandTokenTrayData.red.republicHeavy = "f68963"
    commandTokenTrayData.red.separatistCommander = "071592"
    commandTokenTrayData.red.separatistOperative = "369fa9"
    commandTokenTrayData.red.separatistCore = "af4c28"
    commandTokenTrayData.red.separatistSpecialForces = "abb909"
    commandTokenTrayData.red.separatistSupport = "ce9be9"
    commandTokenTrayData.red.separatistHeavy = "f68963"
    commandTokenTrayData.red.stack = "e2202d"

    commandTokenTrayData.blue = {}
    commandTokenTrayData.blue.trayZoneGUID = "97b998"
    commandTokenTrayData.blue.rebelCommander = "57ab78"
    commandTokenTrayData.blue.rebelOperative = "b30914"
    commandTokenTrayData.blue.rebelCore = "e5e8df"
    commandTokenTrayData.blue.rebelSpecialForces = "3832c6"
    commandTokenTrayData.blue.rebelSupport = "d2c857"
    commandTokenTrayData.blue.rebelHeavy = "6d221d"
    commandTokenTrayData.blue.imperialCommander = "57ab78"
    commandTokenTrayData.blue.imperialOperative = "b30914"
    commandTokenTrayData.blue.imperialCore = "e5e8df"
    commandTokenTrayData.blue.imperialSpecialForces = "3832c6"
    commandTokenTrayData.blue.imperialSupport = "d2c857"
    commandTokenTrayData.blue.imperialHeavy = "6d221d"
    commandTokenTrayData.blue.republicCommander = "57ab78"
    commandTokenTrayData.blue.republicOperative = "b30914"
    commandTokenTrayData.blue.republicCore = "e5e8df"
    commandTokenTrayData.blue.republicSpecialForces = "3832c6"
    commandTokenTrayData.blue.republicSupport = "d2c857"
    commandTokenTrayData.blue.republicHeavy = "6d221d"
    commandTokenTrayData.blue.separatistCommander = "57ab78"
    commandTokenTrayData.blue.separatistOperative = "b30914"
    commandTokenTrayData.blue.separatistCore = "e5e8df"
    commandTokenTrayData.blue.separatistSpecialForces = "3832c6"
    commandTokenTrayData.blue.separatistSupport = "d2c857"
    commandTokenTrayData.blue.separatistHeavy = "6d221d"
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
function initChessClocks(guids)
  for k, v in pairs(guids) do
    getObjectFromGUID(v).Clock.setValue(5400)
  end
end

-- Builds all mod-specific hotkeys. Players can customize key bindings via in-game menus
-- addHotkey is preferred over onScriptingButton[Up|Down] due to customizability by players
function initHotkeys()
  initRangebandHotkeys()
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

function showRangeOnHoveredModel(hoverObject)
  if hoverObject then
    if hoverObject.interactable then
      unitData = {}
      if selectedUnitObj == hoverObject then
        clearRangeRulers()
        selectedUnitObj = nil
        return
      end
      newUnitData = hoverObject.getTable("unitData")
      if not newUnitData then return end
      selectedUnitObj = hoverObject
      unitData.baseSize = newUnitData.baseSize
      unitData.fixedMove = newUnitData.fixedMove
      unitData.strafeMove = newUnitData.strafeMove
      unitData.selectedSpeed = newUnitData.selectedSpeed
      unitData.fixedArc = newUnitData.fixedArc

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
  end
  clearRangeRulers()
  spawnRangeRuler()
end

-- Refactor this to work with the refactored spawnRangeRuler()
function clearRangeRulers()
  --log(1)
  if rangeRuler ~= nil then
    for i = 1,5,1 do
      if rangeRuler[i] ~= nil then destroyObject(rangeRuler[i]) end
    end
    rangeRuler = nil
  end
  --log(2)
  if frontArc ~= nil then destroyObject(frontArc) end
  --log(3)
  if backArc ~= nil then destroyObject(backArc) end
  --log(4)
  noRulers = true
end

-- Refactor this to accept an object as a parameter
-- Spawn range rulers on that object
function spawnRangeRuler()

  if selectedUnitObj == nil then return end
  basePos = selectedUnitObj.getPosition()
  baseRot = selectedUnitObj.getRotation()

  rangeRuler = {}

  baseAddition = {}
  baseAddition.small = 1.06299 / 2
  baseAddition.medium = 1.9685 / 2
  baseAddition.big = 2.75591 / 2
  baseAddition.huge = 3.93701 / 2
  baseAddition.long = 3.525856871366164 / 2
  baseAddition.epic = 5.90551 / 2

  longMesh = {}
  longMesh[1] = "http://cloud-3.steamusercontent.com/ugc/785234780861489665/6C93696005D62FDD38A344398E06D9AD8753141C/"
  longMesh[2] = "http://cloud-3.steamusercontent.com/ugc/785234780861491012/E6A15521D46FD2CE19CE547612DC2050DC916603/"
  longMesh[3] = "http://cloud-3.steamusercontent.com/ugc/785234780861491929/4AD760438DD5333AD61144E3256533ACC85E08E4/"
  longMesh[4] = "http://cloud-3.steamusercontent.com/ugc/785234780861492649/CFB2183925F6DF41E80A0B2BBB59EB6908DFB103/"
  longMesh[5] = "http://cloud-3.steamusercontent.com/ugc/785234780861492649/CFB2183925F6DF41E80A0B2BBB59EB6908DFB103/"
  for i = 1, 5, 1 do

    if unitData.baseSize ~= "long" then
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
    luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID ~= nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y,0})\nend\nend"
    rangeRuler[i].setLuaScript(luaScript)
  end

  rangeRuler[1].setColorTint({0.7, 0.7, 0.7})
  rangeRuler[2].setColorTint({0.1, 0.1, 0.1})
  rangeRuler[3].setColorTint({0.6, 0, 0})
  rangeRuler[4].setColorTint({209/255, 143/255, 30/255})
  rangeRuler[5].setColorTint({231/255, 229/255, 44/255})


  fixedArcScale = (5 * 6) + baseAddition[unitData.baseSize]
  if unitData.fixedArc then
    if unitData.baseSize ~= "long" then
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
      luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID ~= nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y+135,0})\nend\nend"
      backArc.setLuaScript(luaScript)

      luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID ~= nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y-45,0})\nend\nend"
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
      luaScript = "targetGUID = '"..selectedUnitObj.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID ~= nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation({0,targetObj.getRotation().y,0})\nend\nend"
      frontArc.setLuaScript(luaScript)
    end
    frontArc.setLock(true)
    frontArc.setColorTint({0.1, 0.1, 0.1})
    frontArc.setName("Range Ruler")


  end
  noRulers = false
end
-- END Rangeband Hotkeys --

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

-- Toggles the active clock between Red and Blue
-- If neither clock is currently active, activates Blue
function toggleChessClocks(playerColor, hoveredObject, worldPosition, keyDownUp)
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
end

-- Calls pauseStart() for each clock that is not already paused
function pauseAllChessClocks(playerColor, hoveredObject, worldPosition, keyDownUp)
  for k, v in pairs(clocks) do
    if not v.paused then v.pauseStart() end
  end
  broadcastToAll('All chess clocks paused')
end
-- END Chessclock Hotkeys --

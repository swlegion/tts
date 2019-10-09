function onLoad()

    timerCounter = 1

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

    battlefieldTable = "653dd0"

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

    templateInfo.cohesionRadius = {}
    templateInfo.cohesionRadius.small = 4.594485
    templateInfo.cohesionRadius.medium = 5.95275
    templateInfo.cohesionRadius.big = 7.133865
    templateInfo.cohesionRadius.huge = 8.905515
    templateInfo.cohesionRadius.long = 8.905515
    templateInfo.cohesionRadius.epic = 8.905515

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

    templateInfo.baseRadius = {}
    templateInfo.baseRadius.small = 1.06299
    templateInfo.baseRadius.medium = 1.9685
    templateInfo.baseRadius.big = 2.75591
    templateInfo.baseRadius.huge = 3.93701
    templateInfo.baseRadius.long = 3.93701
    templateInfo.baseRadius.epic = 3.93701

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

    whiteD8BagGUID = "014405"
    blackD8BagGUID = "79ead4"
    redD8BagGUID = "a0a037"

    whiteD6BagGUID = "7a88d3"
    redD6BagGUID = "22127e"

    unitIDTokenBagGUID = "21550f"


    -- unitInfo
    unitInfo = {}

    unitInfo.rebelTrooper = {}
    unitInfo.rebelTrooper.commandType = "rebelCore"
    unitInfo.rebelTrooper.baseSize = "small"
    unitInfo.rebelTrooper.fixedMove = false
    unitInfo.rebelTrooper.selectedSpeed = 2
    unitInfo.rebelTrooper.fixedArc = false
    unitInfo.rebelTrooper.squadStatus = true
    unitInfo.rebelTrooper.buttonHeight = 2

    unitInfo.rebelOfficer = {}
    unitInfo.rebelOfficer.commandType = "rebelCommander"
    unitInfo.rebelOfficer.baseSize = "small"
    unitInfo.rebelOfficer.fixedMove = false
    unitInfo.rebelOfficer.selectedSpeed = 2
    unitInfo.rebelOfficer.fixedArc = false
    unitInfo.rebelOfficer.squadStatus = true
    unitInfo.rebelOfficer.buttonHeight = 2

    unitInfo.rebelCommandos = {}
    unitInfo.rebelCommandos.commandType = "rebelSpecialForces"
    unitInfo.rebelCommandos.baseSize = "small"
    unitInfo.rebelCommandos.fixedMove = false
    unitInfo.rebelCommandos.selectedSpeed = 2
    unitInfo.rebelCommandos.fixedArc = false
    unitInfo.rebelCommandos.squadStatus = true
    unitInfo.rebelCommandos.buttonHeight = 2

    unitInfo.rebelCommandosStrikeTeam = {}
    unitInfo.rebelCommandosStrikeTeam.commandType = "rebelSpecialForces"
    unitInfo.rebelCommandosStrikeTeam.baseSize = "small"
    unitInfo.rebelCommandosStrikeTeam.fixedMove = false
    unitInfo.rebelCommandosStrikeTeam.selectedSpeed = 2
    unitInfo.rebelCommandosStrikeTeam.fixedArc = false
    unitInfo.rebelCommandosStrikeTeam.squadStatus = true
    unitInfo.rebelCommandosStrikeTeam.buttonHeight = 2

    unitInfo.rebelPathfinders = {}
    unitInfo.rebelPathfinders.commandType = "rebelSpecialForces"
    unitInfo.rebelPathfinders.baseSize = "small"
    unitInfo.rebelPathfinders.fixedMove = false
    unitInfo.rebelPathfinders.selectedSpeed = 2
    unitInfo.rebelPathfinders.fixedArc = false
    unitInfo.rebelPathfinders.squadStatus = true
    unitInfo.rebelPathfinders.buttonHeight = 2

    unitInfo.wookieeWarriors = {}
    unitInfo.wookieeWarriors.commandType = "rebelSpecialForces"
    unitInfo.wookieeWarriors.baseSize = "small"
    unitInfo.wookieeWarriors.fixedMove = false
    unitInfo.wookieeWarriors.selectedSpeed = 2
    unitInfo.wookieeWarriors.fixedArc = false
    unitInfo.wookieeWarriors.squadStatus = true
    unitInfo.wookieeWarriors.buttonHeight = 2

    unitInfo.fleetTroopers = {}
    unitInfo.fleetTroopers.commandType = "rebelCore"
    unitInfo.fleetTroopers.baseSize = "small"
    unitInfo.fleetTroopers.fixedMove = false
    unitInfo.fleetTroopers.selectedSpeed = 2
    unitInfo.fleetTroopers.fixedArc = false
    unitInfo.fleetTroopers.squadStatus = true
    unitInfo.fleetTroopers.buttonHeight = 2

    unitInfo.rebelVeterans = {}
    unitInfo.rebelVeterans.commandType = "rebelCore"
    unitInfo.rebelVeterans.baseSize = "small"
    unitInfo.rebelVeterans.fixedMove = false
    unitInfo.rebelVeterans.selectedSpeed = 2
    unitInfo.rebelVeterans.fixedArc = false
    unitInfo.rebelVeterans.squadStatus = true
    unitInfo.rebelVeterans.buttonHeight = 2

    unitInfo.markIIMediumBlasterTrooper = {}
    unitInfo.markIIMediumBlasterTrooper.commandType = "rebelCore"
    unitInfo.markIIMediumBlasterTrooper.baseSize = "medium"
    unitInfo.markIIMediumBlasterTrooper.fixedMove = true
    unitInfo.markIIMediumBlasterTrooper.selectedSpeed = 1
    unitInfo.markIIMediumBlasterTrooper.fixedArc = true
    unitInfo.markIIMediumBlasterTrooper.squadStatus = false
    unitInfo.markIIMediumBlasterTrooper.buttonHeight = 2

    unitInfo.lukeSkywalker = {}
    unitInfo.lukeSkywalker.commandType = "rebelCommander"
    unitInfo.lukeSkywalker.baseSize = "small"
    unitInfo.lukeSkywalker.fixedMove = false
    unitInfo.lukeSkywalker.selectedSpeed = 2
    unitInfo.lukeSkywalker.fixedArc = false
    unitInfo.lukeSkywalker.squadStatus = false
    unitInfo.lukeSkywalker.buttonHeight = 2

    unitInfo.lukeSkywalkerJediKnight = {}
    unitInfo.lukeSkywalkerJediKnight.commandType = "rebelOperative"
    unitInfo.lukeSkywalkerJediKnight.baseSize = "small"
    unitInfo.lukeSkywalkerJediKnight.fixedMove = false
    unitInfo.lukeSkywalkerJediKnight.selectedSpeed = 2
    unitInfo.lukeSkywalkerJediKnight.fixedArc = false
    unitInfo.lukeSkywalkerJediKnight.squadStatus = false
    unitInfo.lukeSkywalkerJediKnight.buttonHeight = 2

    unitInfo.hanSolo = {}
    unitInfo.hanSolo.commandType = "rebelCommander"
    unitInfo.hanSolo.baseSize = "small"
    unitInfo.hanSolo.fixedMove = false
    unitInfo.hanSolo.selectedSpeed = 2
    unitInfo.hanSolo.fixedArc = false
    unitInfo.hanSolo.squadStatus = false
    unitInfo.hanSolo.buttonHeight = 2

    unitInfo.leiaOrgana = {}
    unitInfo.leiaOrgana.commandType = "rebelCommander"
    unitInfo.leiaOrgana.baseSize = "small"
    unitInfo.leiaOrgana.fixedMove = false
    unitInfo.leiaOrgana.selectedSpeed = 2
    unitInfo.leiaOrgana.fixedArc = false
    unitInfo.leiaOrgana.squadStatus = false
    unitInfo.leiaOrgana.buttonHeight = 2

    unitInfo.jynErso = {}
    unitInfo.jynErso.commandType = "rebelCommander"
    unitInfo.jynErso.baseSize = "small"
    unitInfo.jynErso.fixedMove = false
    unitInfo.jynErso.selectedSpeed = 2
    unitInfo.jynErso.fixedArc = false
    unitInfo.jynErso.squadStatus = false
    unitInfo.jynErso.buttonHeight = 2

    unitInfo.chewbacca = {}
    unitInfo.chewbacca.commandType = "rebelOperative"
    unitInfo.chewbacca.baseSize = "small"
    unitInfo.chewbacca.fixedMove = false
    unitInfo.chewbacca.selectedSpeed = 2
    unitInfo.chewbacca.fixedArc = false
    unitInfo.chewbacca.squadStatus = false
    unitInfo.chewbacca.buttonHeight = 2

    unitInfo.c3po = {}
    unitInfo.c3po.commandType = nil
    unitInfo.c3po.baseSize = "small"
    unitInfo.c3po.fixedMove = false
    unitInfo.c3po.selectedSpeed = 1
    unitInfo.c3po.fixedArc = false
    unitInfo.c3po.squadStatus = false
    unitInfo.c3po.buttonHeight = 2
    unitInfo.c3po.noToken = true

    unitInfo.r2d2 = {}
    unitInfo.r2d2.commandType = "rebelOperative"
    unitInfo.r2d2.baseSize = "small"
    unitInfo.r2d2.fixedMove = false
    unitInfo.r2d2.selectedSpeed = 1
    unitInfo.r2d2.fixedArc = false
    unitInfo.r2d2.squadStatus = true
    unitInfo.r2d2.buttonHeight = 2

    unitInfo.republicC3po = {}
    unitInfo.republicC3po.commandType = nil
    unitInfo.republicC3po.baseSize = "small"
    unitInfo.republicC3po.fixedMove = false
    unitInfo.republicC3po.selectedSpeed = 1
    unitInfo.republicC3po.fixedArc = false
    unitInfo.republicC3po.squadStatus = false
    unitInfo.republicC3po.buttonHeight = 2
    unitInfo.republicC3po.noToken = true

    unitInfo.republicR2d2 = {}
    unitInfo.republicR2d2.commandType = "republicOperative"
    unitInfo.republicR2d2.baseSize = "small"
    unitInfo.republicR2d2.fixedMove = false
    unitInfo.republicR2d2.selectedSpeed = 1
    unitInfo.republicR2d2.fixedArc = false
    unitInfo.republicR2d2.squadStatus = true
    unitInfo.republicR2d2.buttonHeight = 2

    unitInfo.sabineWren = {}
    unitInfo.sabineWren.commandType = "rebelOperative"
    unitInfo.sabineWren.baseSize = "small"
    unitInfo.sabineWren.fixedMove = false
    unitInfo.sabineWren.selectedSpeed = 3
    unitInfo.sabineWren.fixedArc = false
    unitInfo.sabineWren.squadStatus = false
    unitInfo.sabineWren.buttonHeight = 2

    unitInfo.atrt = {}
    unitInfo.atrt.commandType = "rebelSupport"
    unitInfo.atrt.baseSize = "big"
    unitInfo.atrt.fixedMove = true
    unitInfo.atrt.selectedSpeed = 2
    unitInfo.atrt.fixedArc = true
    unitInfo.atrt.squadStatus = false
    unitInfo.atrt.buttonHeight = 3.3

    unitInfo.tauntaunRiders = {}
    unitInfo.tauntaunRiders.commandType = "rebelSupport"
    unitInfo.tauntaunRiders.baseSize = "medium"
    unitInfo.tauntaunRiders.fixedMove = true
    unitInfo.tauntaunRiders.selectedSpeed = 3
    unitInfo.tauntaunRiders.fixedArc = true
    unitInfo.tauntaunRiders.squadStatus = true
    unitInfo.tauntaunRiders.buttonHeight = 3.3

    unitInfo.fdLaserCannonTeam = {}
    unitInfo.fdLaserCannonTeam.commandType = "rebelSupport"
    unitInfo.fdLaserCannonTeam.baseSize = "huge"
    unitInfo.fdLaserCannonTeam.fixedMove = true
    unitInfo.fdLaserCannonTeam.selectedSpeed = 2
    unitInfo.fdLaserCannonTeam.fixedArc = true
    unitInfo.fdLaserCannonTeam.squadStatus = false
    unitInfo.fdLaserCannonTeam.buttonHeight = 3.1

    unitInfo.x34Landspeeder = {}
    unitInfo.x34Landspeeder.commandType = "rebelHeavy"
    unitInfo.x34Landspeeder.baseSize = "huge"
    unitInfo.x34Landspeeder.fixedMove = true
    unitInfo.x34Landspeeder.selectedSpeed = 2
    unitInfo.x34Landspeeder.fixedArc = true
    unitInfo.x34Landspeeder.squadStatus = false
    unitInfo.x34Landspeeder.buttonHeight = 3.1

    unitInfo.darthVader = {}
    unitInfo.darthVader.commandType = "imperialCommander"
    unitInfo.darthVader.baseSize = "small"
    unitInfo.darthVader.fixedMove = false
    unitInfo.darthVader.selectedSpeed = 1
    unitInfo.darthVader.fixedArc = false
    unitInfo.darthVader.squadStatus = false
    unitInfo.darthVader.buttonHeight = 2

    unitInfo.darthVaderTheEmperorsApprentice = {}
    unitInfo.darthVaderTheEmperorsApprentice.commandType = "imperialOperative"
    unitInfo.darthVaderTheEmperorsApprentice.baseSize = "small"
    unitInfo.darthVaderTheEmperorsApprentice.fixedMove = false
    unitInfo.darthVaderTheEmperorsApprentice.selectedSpeed = 1
    unitInfo.darthVaderTheEmperorsApprentice.fixedArc = false
    unitInfo.darthVaderTheEmperorsApprentice.squadStatus = false
    unitInfo.darthVaderTheEmperorsApprentice.buttonHeight = 2

    unitInfo.generalVeers = {}
    unitInfo.generalVeers.commandType = "imperialCommander"
    unitInfo.generalVeers.baseSize = "small"
    unitInfo.generalVeers.fixedMove = false
    unitInfo.generalVeers.selectedSpeed = 2
    unitInfo.generalVeers.fixedArc = false
    unitInfo.generalVeers.squadStatus = false
    unitInfo.generalVeers.buttonHeight = 2

    unitInfo.emperorPalpatine = {}
    unitInfo.emperorPalpatine.commandType = "imperialCommander"
    unitInfo.emperorPalpatine.baseSize = "small"
    unitInfo.emperorPalpatine.fixedMove = false
    unitInfo.emperorPalpatine.selectedSpeed = 1
    unitInfo.emperorPalpatine.fixedArc = false
    unitInfo.emperorPalpatine.squadStatus = false
    unitInfo.emperorPalpatine.buttonHeight = 2

    unitInfo.directorOrsonKrennic = {}
    unitInfo.directorOrsonKrennic.commandType = "imperialCommander"
    unitInfo.directorOrsonKrennic.baseSize = "small"
    unitInfo.directorOrsonKrennic.fixedMove = false
    unitInfo.directorOrsonKrennic.selectedSpeed = 2
    unitInfo.directorOrsonKrennic.fixedArc = false
    unitInfo.directorOrsonKrennic.squadStatus = false
    unitInfo.directorOrsonKrennic.buttonHeight = 2

    unitInfo.imperialOfficer = {}
    unitInfo.imperialOfficer.commandType = "imperialCommander"
    unitInfo.imperialOfficer.baseSize = "small"
    unitInfo.imperialOfficer.fixedMove = false
    unitInfo.imperialOfficer.selectedSpeed = 1
    unitInfo.imperialOfficer.fixedArc = false
    unitInfo.imperialOfficer.squadStatus = false
    unitInfo.imperialOfficer.buttonHeight = 2

    unitInfo.bobaFett = {}
    unitInfo.bobaFett.commandType = "imperialOperative"
    unitInfo.bobaFett.baseSize = "small"
    unitInfo.bobaFett.fixedMove = false
    unitInfo.bobaFett.selectedSpeed = 3
    unitInfo.bobaFett.fixedArc = false
    unitInfo.bobaFett.squadStatus = false
    unitInfo.bobaFett.buttonHeight = 2

    unitInfo.bossk = {}
    unitInfo.bossk.commandType = "imperialOperative"
    unitInfo.bossk.baseSize = "small"
    unitInfo.bossk.fixedMove = false
    unitInfo.bossk.selectedSpeed = 3
    unitInfo.bossk.fixedArc = false
    unitInfo.bossk.squadStatus = false
    unitInfo.bossk.buttonHeight = 2

    unitInfo.stormtrooper = {}
    unitInfo.stormtrooper.commandType = "imperialCore"
    unitInfo.stormtrooper.baseSize = "small"
    unitInfo.stormtrooper.fixedMove = false
    unitInfo.stormtrooper.selectedSpeed = 2
    unitInfo.stormtrooper.fixedArc = false
    unitInfo.stormtrooper.squadStatus = true
    unitInfo.stormtrooper.buttonHeight = 2

    unitInfo.snowtrooper = {}
    unitInfo.snowtrooper.commandType = "imperialCore"
    unitInfo.snowtrooper.baseSize = "small"
    unitInfo.snowtrooper.fixedMove = false
    unitInfo.snowtrooper.selectedSpeed = 1
    unitInfo.snowtrooper.fixedArc = false
    unitInfo.snowtrooper.squadStatus = true
    unitInfo.snowtrooper.buttonHeight = 2

    unitInfo.shoretroopers = {}
    unitInfo.shoretroopers.commandType = "imperialCore"
    unitInfo.shoretroopers.baseSize = "small"
    unitInfo.shoretroopers.fixedMove = false
    unitInfo.shoretroopers.selectedSpeed = 2
    unitInfo.shoretroopers.fixedArc = false
    unitInfo.shoretroopers.squadStatus = true
    unitInfo.shoretroopers.buttonHeight = 2

    unitInfo.df90MortarTrooper = {}
    unitInfo.df90MortarTrooper.commandType = "imperialCore"
    unitInfo.df90MortarTrooper.baseSize = "medium"
    unitInfo.df90MortarTrooper.fixedMove = true
    unitInfo.df90MortarTrooper.selectedSpeed = 1
    unitInfo.df90MortarTrooper.fixedArc = true
    unitInfo.df90MortarTrooper.squadStatus = false
    unitInfo.df90MortarTrooper.buttonHeight = 2

    unitInfo.scoutTroopers = {}
    unitInfo.scoutTroopers.commandType = "imperialSpecialForces"
    unitInfo.scoutTroopers.baseSize = "small"
    unitInfo.scoutTroopers.fixedMove = false
    unitInfo.scoutTroopers.selectedSpeed = 2
    unitInfo.scoutTroopers.fixedArc = false
    unitInfo.scoutTroopers.squadStatus = true
    unitInfo.scoutTroopers.buttonHeight = 2

    unitInfo.scoutTroopersStrikeTeam = {}
    unitInfo.scoutTroopersStrikeTeam.commandType = "imperialSpecialForces"
    unitInfo.scoutTroopersStrikeTeam.baseSize = "small"
    unitInfo.scoutTroopersStrikeTeam.fixedMove = false
    unitInfo.scoutTroopersStrikeTeam.selectedSpeed = 2
    unitInfo.scoutTroopersStrikeTeam.fixedArc = false
    unitInfo.scoutTroopersStrikeTeam.squadStatus = true
    unitInfo.scoutTroopersStrikeTeam.buttonHeight = 2

    unitInfo.imperialDeathTroopers = {}
    unitInfo.imperialDeathTroopers.commandType = "imperialSpecialForces"
    unitInfo.imperialDeathTroopers.baseSize = "small"
    unitInfo.imperialDeathTroopers.fixedMove = false
    unitInfo.imperialDeathTroopers.selectedSpeed = 2
    unitInfo.imperialDeathTroopers.fixedArc = false
    unitInfo.imperialDeathTroopers.squadStatus = true
    unitInfo.imperialDeathTroopers.buttonHeight = 2

    unitInfo.imperialRoyalGuards = {}
    unitInfo.imperialRoyalGuards.commandType = "imperialSpecialForces"
    unitInfo.imperialRoyalGuards.baseSize = "small"
    unitInfo.imperialRoyalGuards.fixedMove = false
    unitInfo.imperialRoyalGuards.selectedSpeed = 2
    unitInfo.imperialRoyalGuards.fixedArc = false
    unitInfo.imperialRoyalGuards.squadStatus = true
    unitInfo.imperialRoyalGuards.buttonHeight = 2

    unitInfo.speederBike = {}
    unitInfo.speederBike.commandType = "imperialSupport"
    unitInfo.speederBike.baseSize = "medium"
    unitInfo.speederBike.fixedMove = true
    unitInfo.speederBike.selectedSpeed = 3
    unitInfo.speederBike.fixedArc = true
    unitInfo.speederBike.squadStatus = true
    unitInfo.speederBike.buttonHeight = 2.2

    unitInfo.eWebHeavyBlasterTeam = {}
    unitInfo.eWebHeavyBlasterTeam.commandType = "imperialSupport"
    unitInfo.eWebHeavyBlasterTeam.baseSize = "big"
    unitInfo.eWebHeavyBlasterTeam.fixedMove = true
    unitInfo.eWebHeavyBlasterTeam.selectedSpeed = 1
    unitInfo.eWebHeavyBlasterTeam.fixedArc = true
    unitInfo.eWebHeavyBlasterTeam.squadStatus = false
    unitInfo.eWebHeavyBlasterTeam.buttonHeight = 2

    unitInfo.dewbackRider = {}
    unitInfo.dewbackRider.commandType = "imperialSupport"
    unitInfo.dewbackRider.baseSize = "big"
    unitInfo.dewbackRider.fixedMove = true
    unitInfo.dewbackRider.selectedSpeed = 1
    unitInfo.dewbackRider.fixedArc = true
    unitInfo.dewbackRider.squadStatus = false
    unitInfo.dewbackRider.buttonHeight = 3.3

    unitInfo.atst = {}
    unitInfo.atst.commandType = "imperialHeavy"
    unitInfo.atst.baseSize = "huge"
    unitInfo.atst.fixedMove = true
    unitInfo.atst.selectedSpeed = 2
    unitInfo.atst.fixedArc = true
    unitInfo.atst.squadStatus = false
    unitInfo.atst.buttonHeight = 8.7

    unitInfo.tx225 = {}
    unitInfo.tx225.commandType = "imperialHeavy"
    unitInfo.tx225.baseSize = "long"
    unitInfo.tx225.fixedMove = true
    unitInfo.tx225.selectedSpeed = 1
    unitInfo.tx225.fixedArc = true
    unitInfo.tx225.squadStatus = false
    unitInfo.tx225.buttonHeight = 2.5

    unitInfo.airSpeeder = {}
    unitInfo.airSpeeder.commandType = "rebelHeavy"
    unitInfo.airSpeeder.baseSize = "huge"
    unitInfo.airSpeeder.fixedMove = true
    unitInfo.airSpeeder.selectedSpeed = 3
    unitInfo.airSpeeder.fixedArc = true
    unitInfo.airSpeeder.squadStatus = false
    unitInfo.airSpeeder.buttonHeight = 5.6

    unitInfo.generalGrievous = {}
    unitInfo.generalGrievous.commandType = "separatistCommander"
    unitInfo.generalGrievous.baseSize = "small"
    unitInfo.generalGrievous.fixedMove = false
    unitInfo.generalGrievous.selectedSpeed = 2
    unitInfo.generalGrievous.fixedArc = false
    unitInfo.generalGrievous.squadStatus = false
    unitInfo.generalGrievous.buttonHeight = 2

    unitInfo.countDooku = {}
    unitInfo.countDooku.commandType = "separatistCommander"
    unitInfo.countDooku.baseSize = "small"
    unitInfo.countDooku.fixedMove = false
    unitInfo.countDooku.selectedSpeed = 2
    unitInfo.countDooku.fixedArc = false
    unitInfo.countDooku.squadStatus = false
    unitInfo.countDooku.buttonHeight = 2

    unitInfo.b1BattleDroids = {}
    unitInfo.b1BattleDroids.commandType = "separatistCore"
    unitInfo.b1BattleDroids.baseSize = "small"
    unitInfo.b1BattleDroids.fixedMove = false
    unitInfo.b1BattleDroids.selectedSpeed = 2
    unitInfo.b1BattleDroids.fixedArc = false
    unitInfo.b1BattleDroids.squadStatus = true
    unitInfo.b1BattleDroids.buttonHeight = 2

    unitInfo.b2SuperBattleDroids = {}
    unitInfo.b2SuperBattleDroids.commandType = "separatistCore"
    unitInfo.b2SuperBattleDroids.baseSize = "small"
    unitInfo.b2SuperBattleDroids.fixedMove = false
    unitInfo.b2SuperBattleDroids.selectedSpeed = 2
    unitInfo.b2SuperBattleDroids.fixedArc = false
    unitInfo.b2SuperBattleDroids.squadStatus = true
    unitInfo.b2SuperBattleDroids.buttonHeight = 2

    unitInfo.droidekas = {}
    unitInfo.droidekas.commandType = "separatistSupport"
    unitInfo.droidekas.baseSize = "medium"
    unitInfo.droidekas.fixedMove = true
    unitInfo.droidekas.selectedSpeed = 1
    unitInfo.droidekas.fixedArc = true
    unitInfo.droidekas.squadStatus = true
    unitInfo.droidekas.buttonHeight = 2.2

    unitInfo.aatTank = {}
    unitInfo.aatTank.commandType = "separatistHeavy"
    unitInfo.aatTank.baseSize = "epic"
    unitInfo.aatTank.fixedMove = true
    unitInfo.aatTank.strafeMove = true
    unitInfo.aatTank.selectedSpeed = 1
    unitInfo.aatTank.fixedArc = true
    unitInfo.aatTank.squadStatus = false
    unitInfo.aatTank.buttonHeight = 4

    unitInfo.obiWanKenobi = {}
    unitInfo.obiWanKenobi.commandType = "republicCommander"
    unitInfo.obiWanKenobi.baseSize = "small"
    unitInfo.obiWanKenobi.fixedMove = false
    unitInfo.obiWanKenobi.selectedSpeed = 2
    unitInfo.obiWanKenobi.fixedArc = false
    unitInfo.obiWanKenobi.squadStatus = false
    unitInfo.obiWanKenobi.buttonHeight = 2

    unitInfo.cloneCaptainRex = {}
    unitInfo.cloneCaptainRex.commandType = "republicCommander"
    unitInfo.cloneCaptainRex.baseSize = "small"
    unitInfo.cloneCaptainRex.fixedMove = false
    unitInfo.cloneCaptainRex.selectedSpeed = 2
    unitInfo.cloneCaptainRex.fixedArc = false
    unitInfo.cloneCaptainRex.squadStatus = false
    unitInfo.cloneCaptainRex.buttonHeight = 2

    unitInfo.phaseICloneTroopers = {}
    unitInfo.phaseICloneTroopers.commandType = "republicCore"
    unitInfo.phaseICloneTroopers.baseSize = "small"
    unitInfo.phaseICloneTroopers.fixedMove = false
    unitInfo.phaseICloneTroopers.selectedSpeed = 2
    unitInfo.phaseICloneTroopers.fixedArc = false
    unitInfo.phaseICloneTroopers.squadStatus = true
    unitInfo.phaseICloneTroopers.buttonHeight = 2

    unitInfo.phaseIICloneTroopers = {}
    unitInfo.phaseIICloneTroopers.commandType = "republicCore"
    unitInfo.phaseIICloneTroopers.baseSize = "small"
    unitInfo.phaseIICloneTroopers.fixedMove = false
    unitInfo.phaseIICloneTroopers.selectedSpeed = 2
    unitInfo.phaseIICloneTroopers.fixedArc = false
    unitInfo.phaseIICloneTroopers.squadStatus = true
    unitInfo.phaseIICloneTroopers.buttonHeight = 2

    unitInfo.barcSpeeder = {}
    unitInfo.barcSpeeder.commandType = "republicSupport"
    unitInfo.barcSpeeder.baseSize = "big"
    unitInfo.barcSpeeder.fixedMove = true
    unitInfo.barcSpeeder.selectedSpeed = 3
    unitInfo.barcSpeeder.fixedArc = true
    unitInfo.barcSpeeder.squadStatus = false
    unitInfo.barcSpeeder.buttonHeight = 3

    unitInfo.saberTank = {}
    unitInfo.saberTank.commandType = "republicHeavy"
    unitInfo.saberTank.baseSize = "epic"
    unitInfo.saberTank.fixedMove = true
    unitInfo.saberTank.strafeMove = true
    unitInfo.saberTank.selectedSpeed = 2
    unitInfo.saberTank.fixedArc = true
    unitInfo.saberTank.squadStatus = false
    unitInfo.saberTank.buttonHeight = 4

    unitInfo.unitNamesToType = {}
    -- RED REBEL
    unitInfo.unitNamesToType[1] = {name = "Red Rebel Trooper Leader", type = "rebelTrooper", token = "Red Rebel Core Command Token", colorSide = "red", commandType = "rebelCore"}
    unitInfo.unitNamesToType[2] = {name = "Red Luke Skywalker", type = "lukeSkywalker", token = "Red Rebel Commander Command Token", colorSide = "red", commandType = "rebelCommander"}
    unitInfo.unitNamesToType[3] = {name = "Red AT-RT", type = "atrt", token = "Red Rebel Support Command Token", colorSide = "red", commandType = "rebelSupport"}
    unitInfo.unitNamesToType[4] = {name = "Red T-47 Airspeeder", type = "airSpeeder", token = "Red Rebel Heavy Command Token", colorSide = "red", commandType = "rebelHeavy"}

    -- RED IMPERIAL
    unitInfo.unitNamesToType[5] = {name = "Red Stormtrooper Leader", type = "stormtrooper", token = "Red Imperial Core Command Token", colorSide = "red", commandType = "imperialCore"}
    unitInfo.unitNamesToType[6] = {name = "Red Darth Vader", type = "darthVader", token = "Red Imperial Commander Command Token", colorSide = "red", commandType = "imperialCommander"}
    unitInfo.unitNamesToType[7] = {name = "Red 74-Z Speeder Bike Leader", type = "speederBike", token = "Red Imperial Support Command Token", colorSide = "red", commandType = "imperialSupport"}
    unitInfo.unitNamesToType[8] = {name = "Red AT-ST", type = "atst", token = "Red Imperial Heavy Command Token", colorSide = "red", commandType = "imperialHeavy"}

    -- BLUE REBEL
    unitInfo.unitNamesToType[9] = {name = "Blue Rebel Trooper Leader", type = "rebelTrooper", token = "Blue Rebel Core Command Token", colorSide = "blue", commandType = "rebelCore"}
    unitInfo.unitNamesToType[10] = {name = "Blue Luke Skywalker", type = "lukeSkywalker", token = "Blue Rebel Commander Command Token", colorSide = "blue", commandType = "rebelCommander"}
    unitInfo.unitNamesToType[11] = {name = "Blue AT-RT", type = "atrt", token = "Blue Rebel Support Command Token", colorSide = "blue", commandType = "rebelSupport"}
    unitInfo.unitNamesToType[12] = {name = "Blue T-47 Airspeeder", type = "airSpeeder", token = "Blue Rebel Heavy Command Token", colorSide = "blue", commandType = "rebelHeavy"}
    -- BLUE IMPERIAL
    unitInfo.unitNamesToType[13] = {name = "Blue Stormtrooper Leader", type = "stormtrooper", token = "Blue Imperial Core Command Token", colorSide = "blue", commandType = "imperialCore"}
    unitInfo.unitNamesToType[14] = {name = "Blue Darth Vader", type = "darthVader", token = "Blue Imperial Commander Command Token", colorSide = "blue", commandType = "imperialCommander"}
    unitInfo.unitNamesToType[15] = {name = "Blue 74-Z Speeder Bike Leader", type = "speederBike", token = "Blue Imperial Support Command Token", colorSide = "blue", commandType = "imperialSupport"}
    unitInfo.unitNamesToType[16] = {name = "Blue AT-ST", type = "atst", token = "Blue Imperial Heavy Command Token", colorSide = "blue", commandType = "imperialHeavy"}

    unitInfo.tokenPosition = {}
    unitInfo.tokenPosition.red = {}
    unitInfo.tokenPosition.red.imperialCommander = {4.99, 1.03, -18.68}
    unitInfo.tokenPosition.red.imperialCore = {6.99, 1.03, -18.68}
    unitInfo.tokenPosition.red.imperialSupport = {8.99, 1.03, -18.68}
    unitInfo.tokenPosition.red.imperialHeavy = {10.98, 1.03, -18.68}

    unitInfo.tokenPosition.red.rebelCommander = {4.99, 1.03, -18.68}
    unitInfo.tokenPosition.red.rebelCore = {6.99, 1.03, -18.68}
    unitInfo.tokenPosition.red.rebelSupport = {8.99, 1.03, -18.68}
    unitInfo.tokenPosition.red.rebelHeavy = {10.98, 1.03, -18.68}

    unitInfo.tokenPosition.blue = {}
    unitInfo.tokenPosition.blue.imperialCommander = {10.98, 1.03, 18.68}
    unitInfo.tokenPosition.blue.imperialCore = {8.99, 1.03, 18.68}
    unitInfo.tokenPosition.blue.imperialSupport = {6.99, 1.03, 18.68}
    unitInfo.tokenPosition.blue.imperialHeavy = {4.99, 1.03, 18.68}

    unitInfo.tokenPosition.blue.rebelCommander = {10.98, 1.03, 18.68}
    unitInfo.tokenPosition.blue.rebelCore = {8.99, 1.03, 18.68}
    unitInfo.tokenPosition.blue.rebelSupport = {6.99, 1.03, 18.68}
    unitInfo.tokenPosition.blue.rebelHeavy = {4.99, 1.03, 18.68}

    unitInfo.tokenRotation = {}
    unitInfo.tokenRotation.red = {x = 0, y = 180 ,z = 0}
    unitInfo.tokenRotation.blue = {x = 0,y = 0,z = 0}

    unitInfo.tokenGUID = {}
    unitInfo.tokenGUID.red = {}

    unitInfo.tokenGUID.red.rebelCommander = "9c0ec1"
    unitInfo.tokenGUID.red.rebelCore = "e3ef39"
    unitInfo.tokenGUID.red.rebelSupport = "700459"
    unitInfo.tokenGUID.red.rebelHeavy = "da5c03"

    unitInfo.tokenGUID.red.imperialCommander = "09f61d"
    unitInfo.tokenGUID.red.imperialCore  = "61230d"
    unitInfo.tokenGUID.red.imperialSupport = "841b09"
    unitInfo.tokenGUID.red.imperialHeavy  = "ea5be4"

    unitInfo.tokenGUID.blue = {}

    unitInfo.tokenGUID.blue.rebelCommander = "7eda25"
    unitInfo.tokenGUID.blue.rebelCore = "043896"
    unitInfo.tokenGUID.blue.rebelSupport = "4d8e75"
    unitInfo.tokenGUID.blue.rebelHeavy = "58d6a7"

    unitInfo.tokenGUID.blue.imperialCommander = "ba785b"
    unitInfo.tokenGUID.blue.imperialCore = "6e7d02"
    unitInfo.tokenGUID.blue.imperialSupport = "23fd1d"
    unitInfo.tokenGUID.blue.imperialHeavy = "9fed13"

    unitInfo.unitCountPos = {}
    unitInfo.unitCountPos.small = {-0.3, 0.2, 0.2}
    unitInfo.unitCountPos.medium = {-0.4, 0.2, 0.5}
    unitInfo.unitCountPos.big = {0,0.2,1}
    unitInfo.unitCountPos.huge = {0,0.2,1.6}
    -- LIST BUILDER info

    redSelectedArmyFaction = ""
    blueSelectedArmyFaction = ""

    listBuilder = {}
    listBuilder.modelTemplateGUID = "ba9920"
    listBuilder.redZoneGUID = "2c09a9"
    listBuilder.blueZoneGUID = "818608"

    listBuilder.redDeckMountGUID = "eb2d78"
    listBuilder.blueDeckMountGUID = "0c1c93"

    listBuilder.redDeckZoneGUID = "99d398"
    listBuilder.blueDeckZoneGUID = "4541f9"

    listBuilder.redCounterGUID = "5c7de3"
    listBuilder.blueCounterGUID = "55da62"

    listBuilder.commandCardsGUID = "4ee41a"

    listBuilder.dataDisk = {}
    listBuilder.dataDisk.guid = "66f23c"

    listBuilder.redDataDiskZone = "ccdc98"
    listBuilder.blueDataDiskZone = "cd7b3b"

    listBuilder.deckBuilderPos = {}

    listBuilder.deckBuilderPos.red = {-35.11, 0.95, -30.45}
    listBuilder.deckBuilderPos.blue = {-35.11, 0.95, 30.45}

    listBuilder.deckBuilderMesh = "http://cloud-3.steamusercontent.com/ugc/786360308354566451/1A3E2F61E3596E35D3FFA10660B8C63D5BE010E1/"
    listBuilder.deckBuilderDiffuse = "http://cloud-3.steamusercontent.com/ugc/786360308354566564/58E3DBF4523A099C371DA8A674AE9DB1932B4006/"
    listBuilder.deckBuilderGUID = "082f27"

    listBuilder.redTemplatePos = {}
    listBuilder.redTemplatePos[1] = {x = -23.57,y= 1,z=-22}
    listBuilder.redTemplatePos[2] = {x =-16.60,y= 1,z=-22}
    listBuilder.redTemplatePos[3] = {x =-9.60,y= 1,z=-22}
    listBuilder.redTemplatePos[4] = {x =-2.63,y= 1,z=-22}
    listBuilder.redTemplatePos[5] = {x =4.38,y= 1,z=-22}
    listBuilder.redTemplatePos[6] = {x =11.38,y= 1,z=-22}
    listBuilder.redTemplatePos[7] = {x =18.35,y= 1,z=-22}
    listBuilder.redTemplatePos[8] = {x =25.07,y= 1,z=-22}
    listBuilder.redTemplatePos[9] = {x =32.36,y= 1,z=-22}
    listBuilder.redTemplatePos[10] = {x =39.37,y= 1,z=-22}

    listBuilder.redTemplatePos[11] = {x = -23.57,y= 1,z= -33.09}
    listBuilder.redTemplatePos[12] = {x =-16.60,y= 1,z= -33.09}
    listBuilder.redTemplatePos[13] = {x =-9.60,y= 1,z= -33.09}
    listBuilder.redTemplatePos[14] = {x =-2.63,y= 1,z= -33.09}
    listBuilder.redTemplatePos[15] = {x =4.38,y= 1,z= -33.09}
    listBuilder.redTemplatePos[16] = {x =11.38,y= 1,z= -33.09}
    listBuilder.redTemplatePos[17] = {x =18.35,y= 1,z= -33.09}
    listBuilder.redTemplatePos[18] = {x =25.07,y= 1,z= -33.09}
    listBuilder.redTemplatePos[19] = {x =32.36,y= 1,z= -33.09}
    listBuilder.redTemplatePos[20] = {x =39.37,y= 1,z= -33.09}



    listBuilder.blueTemplatePos = {}
    listBuilder.blueTemplatePos[1] = {x=39.37,y= 1,z=22}
    listBuilder.blueTemplatePos[2] = {x=32.36,y= 1,z=22}
    listBuilder.blueTemplatePos[3] = {x=25.07,y= 1,z=22}
    listBuilder.blueTemplatePos[4] = {x=18.35,y= 1,z=22}
    listBuilder.blueTemplatePos[5] = {x=11.38,y= 1,z=22}
    listBuilder.blueTemplatePos[6] = {x=4.38,y= 1,z=22}
    listBuilder.blueTemplatePos[7] = {x=-2.63,y= 1,z=22}
    listBuilder.blueTemplatePos[8] = {x=-9.60,y= 1,z=22}
    listBuilder.blueTemplatePos[9] = {x=-16.60,y= 1,z=22}
    listBuilder.blueTemplatePos[10] = {x=-23.57,y= 1,z=22}

    listBuilder.blueTemplatePos[11] = {x=39.37,y= 1,z=33.09}
    listBuilder.blueTemplatePos[12] = {x=32.36,y= 1,z=33.09}
    listBuilder.blueTemplatePos[13] = {x=25.07,y= 1,z=33.09}
    listBuilder.blueTemplatePos[14] = {x=18.35,y= 1,z=33.09}
    listBuilder.blueTemplatePos[15] = {x=11.38,y= 1,z=33.09}
    listBuilder.blueTemplatePos[16] = {x=4.38,y= 1,z=33.09}
    listBuilder.blueTemplatePos[17] = {x=-2.63,y= 1,z=33.09}
    listBuilder.blueTemplatePos[18] = {x=-9.60,y= 1,z=33.09}
    listBuilder.blueTemplatePos[19] = {x=-16.60,y= 1,z=33.09}
    listBuilder.blueTemplatePos[20] = {x=-23.57,y= 1,z=33.09}

    listBuilder.miniSpawnPos = {}
    listBuilder.miniSpawnPos[1] = {c = 5.32, q = -90}
    listBuilder.miniSpawnPos[2] = {q = 74.097447395813,  c = -5.5109073663055}
    listBuilder.miniSpawnPos[3] = {q = 83.470464001153, c = -6.6833524521754}
    listBuilder.miniSpawnPos[4] = {q = -83.460700769998, c = 6.6734174153878}
    listBuilder.miniSpawnPos[5] = {q = -73.826845678316, c = 5.5288063811279}
    listBuilder.miniSpawnPos[6] = {q = -78.799202212116, c = 4.1184463089859}
    listBuilder.miniSpawnPos[7] = {q = 79.544342439695, c = -4.0777076893764}
    listBuilder.miniSpawnPos[8] = {c = 7.9, q = -90}

    listBuilder.handPos = {}
    listBuilder.handPos.red = {}
    listBuilder.handPos.red.pos = {7.07, 2.39, -40.63}
    listBuilder.handPos.red.rot = {0,180,0}
    listBuilder.handPos.blue = {}
    listBuilder.handPos.blue.pos = {7.07, 2.39, 40.17}
    listBuilder.handPos.blue.rot = {0,0,0}

    listBuilder.tokenModelGUID = "a57c41"
    modelToken = getObjectFromGUID(listBuilder.tokenModelGUID)
    listBuilder.tokenScript = modelToken.getLuaScript()

    listBuilder.modelMiniGUID = "99f1c8"
    modelMini = getObjectFromGUID(listBuilder.modelMiniGUID)
    listBuilder.modelMiniScript = modelMini.getLuaScript()


    listBuilder.commandCards = {}
    -- IMPERIAL
    listBuilder.commandCards.generalVeers = {
        varName = "generalVeers",
        cards = {"Maximum Firepower","Evasive Maneuvers","Imperial Discipline"}

    }
    listBuilder.commandCards.imperialOfficer = {
        varName = "imperialOfficer"
    }
    listBuilder.commandCards.darthVader = {
        varName = "darthVader",
        cards = {"Implacable","New Ways to Motivate Them","Master of Evil"},
        cards2 = {"Vaders Might","Fear and Dead Men","Darkness Descends"}
    }
    listBuilder.commandCards.darthVaderTheEmperorsApprentice = {
        varName = "darthVaderTheEmperorsApprentice",
        cards = {"Implacable","New Ways to Motivate Them","Master of Evil"},
        cards2 = {"Vaders Might","Fear and Dead Men","Darkness Descends"}
    }
    listBuilder.commandCards.emperorPalpatine = {
        varName = "emperorPalpatine",
        cards = {"And Now... You Will Die", "Give in to Your Anger", "An Entire Legion"}
    }
    listBuilder.commandCards.directorOrsonKrennic = {
        varName = "directorOrsonKrennic",
        cards = {"Voracious Ambition", "Deploy the Garrison", "Annihilation Looms"}
    }
    listBuilder.commandCards.bobaFett = {
        varName = "bobaFett",
        cards = {"Whipcord Launcher", "ZX Flame Projector", "Z-6 Jetpack Rocket"}
    }
    listBuilder.commandCards.bossk = {
        varName = "bossk",
        cards = {"Merciless Munitions", "Reptilian Rampage", "Lying in Wait"}
    }

    -- REBEL
    listBuilder.commandCards.lukeSkywalker = {
        varName = "lukeSkywalker",
        cards = {"Son of Skywalker", "My Ally Is the Force", "Return of the Jedi"},
        cards2 = {"You Serve Your Master Well", "Full of Surprises", "I am a Jedi"}
    }
    listBuilder.commandCards.lukeSkywalkerJediKnight = {
        varName = "lukeSkywalkerJediKnight",
        cards = {"Son of Skywalker", "My Ally Is the Force", "Return of the Jedi"},
        cards2 = {"You Serve Your Master Well", "Full of Surprises", "I am a Jedi"}
    }
    listBuilder.commandCards.leiaOrgana = {
        varName = "leiaOrgana",
        cards = {"Coordinated Bombardment","No Time for Sorrows","Somebody Has to Save Our Skins"}
    }
    listBuilder.commandCards.hanSolo = {
        varName = "hanSolo",
        cards = {"Sorry About the Mess","Reckless Diversion","Change of Plans"}
    }
    listBuilder.commandCards.jynErso = {
        varName = "jynErso",
        cards = {"Rebellious","Trust Goes Both Ways","Complete the Mission"}
    }
    listBuilder.commandCards.chewbacca = {
        varName = "chewbacca",
        cards = {"Common Cause","Brains and Brawn","Notorious Scoundrels"}
    }
    listBuilder.commandCards.sabineWren = {
        varName = "sabineWren",
        cards = {"Explosions!","Symbol of Rebellion","Legacy of Mandalore"}
    }
    listBuilder.commandCards.r2d2 = {
        varName = "r2d2",
        cards = {"Blast Off!", "Push", "Assault"}
    }
    listBuilder.commandCards.c3po = {
        varName = "c3po",
        cards = {"Ambush", "Push", "Assault"}
    }
    listBuilder.commandCards.rebelOfficer = {
        varName = "rebelOfficer"
    }
    -- SEPARATIST
    listBuilder.commandCards.generalGrievous = {
        varName = "generalGrievous",
        cards = {"Trained in Your Jedi Arts","Supreme Commander","Crush Them!"}
    }
    listBuilder.commandCards.countDooku = {
        varName = "countDooku",
        cards = {"Ambush","Push","You Disappoint Me"}
    }
    -- REPUBLIC
    listBuilder.commandCards.obiWanKenobi = {
        varName = "obiWanKenobi",
        cards = {"Hello There!","Knowledge and Defense","General Kenobi"}
    }
    listBuilder.commandCards.cloneCaptainRex = {
        varName = "cloneCaptainRex",
        cards = {"Ambush","Push","Were Not Programmed"}
    }
    listBuilder.commandCards.republicR2d2 = {
        varName = "republicR2d2",
        cards = {"Blast Off!", "Push", "Assault"}
    }
    listBuilder.commandCards.republicC3po = {
        varName = "republicC3po",
        cards = {"Ambush", "Push", "Assault"}
    }

    -- NEUTRAL
    listBuilder.commandCards.neutral = {
        varName = "neutral",
        cards = {"Ambush", "Push", "Assault"}
    }
    listBuilder.commandCards.neutralAltArt = {
        varName = "neutral",
        cards = {"Ambush Alt Art", "Push Alt Art", "Assault Alt Art"}
    }
    listBuilder.commandCards.neutralImperial = {
        varName = "neutralImperial",
        cards = {"Covert Observation", "Pinned Down", "Coordinated Fire"}
    }
    listBuilder.commandCards.neutralRebel = {
        varName = "neutralRebel",
        cards = {"Sabotaged Communications", "Turning the Tide", "Covering Fire"}
    }

    templateMenu = {}

    templateMenu.mainMenu = {}
    templateMenu.mainMenu[1] = {name = "Commander", varName = "commander"}
    templateMenu.mainMenu[2] = {name = "Operative", varName = "operative"}
    templateMenu.mainMenu[3] = {name = "Corps", varName = "corps"}
    templateMenu.mainMenu[4] = {name = "Special Forces", varName = "specialForces"}
    templateMenu.mainMenu[5] = {name = "Support", varName = "support"}
    templateMenu.mainMenu[6] = {name = "Heavy", varName = "heavy"}

    templateMenu.rebel = {}
    templateMenu.rebel.commander = {}
    templateMenu.rebel.commander[1] = {name = "Luke Skywalker", varName = "lukeSkywalker"}
    templateMenu.rebel.commander[2] = {name = "Leia Organa", varName = "leiaOrgana"}
    templateMenu.rebel.commander[3] = {name = "Han Solo", varName = "hanSolo"}
    templateMenu.rebel.commander[4] = {name = "Jyn Erso", varName = "jynErso"}
    templateMenu.rebel.commander[5] = {name = "Rebel Officer", varName = "rebelOfficer"}

    templateMenu.rebel.operative = {}
    templateMenu.rebel.operative[1] = {name = "Chewbacca", varName = "chewbacca"}
    templateMenu.rebel.operative[2] = {name = "Sabine Wren", varName = "sabineWren"}
    templateMenu.rebel.operative[3] = {name = "Luke Skywalker", varName = "lukeSkywalkerJediKnight"}
    templateMenu.rebel.operative[4] = {name = "R2-D2", varName = "r2d2"}
    templateMenu.rebel.operative[5] = {name = "C-3PO", varName = "c3po"}

    templateMenu.rebel.corps = {}
    templateMenu.rebel.corps[1] = {name = "Rebel Troopers", varName = "rebelTrooper"}
    templateMenu.rebel.corps[2] = {name = "Fleet Troopers", varName = "fleetTroopers"}
    templateMenu.rebel.corps[3] = {name = "Rebel Veterans", varName = "rebelVeterans"}
    templateMenu.rebel.corps[4] = {name = "Mark II Medium Blaster Trooper", varName = "markIIMediumBlasterTrooper"}

    templateMenu.rebel.specialForces = {}
    templateMenu.rebel.specialForces[1] = {name = "Rebel Commandos", varName = "rebelCommandos"}
    templateMenu.rebel.specialForces[2] = {name = "Rebel Commandos Strike Team", varName = "rebelCommandosStrikeTeam"}
    templateMenu.rebel.specialForces[3] = {name = "Wookiee Warriors", varName = "wookieeWarriors"}
    templateMenu.rebel.specialForces[4] = {name = "Rebel Pathfinders", varName = "rebelPathfinders"}

    templateMenu.rebel.support = {}
    templateMenu.rebel.support[1] = {name = "AT-RT", varName = "atrt"}
    templateMenu.rebel.support[2] = {name = "1.4 FD Laser Cannon Team", varName = "fdLaserCannonTeam"}
    templateMenu.rebel.support[3] = {name = "Tauntaun Riders", varName = "tauntaunRiders"}

    templateMenu.rebel.heavy = {}
    templateMenu.rebel.heavy[1] = {name = "T-47 Airspeeder", varName = "airSpeeder"}
    templateMenu.rebel.heavy[2] = {name = "X-34 Landspeeder", varName = "x34Landspeeder"}


    templateMenu.imperial = {}
    templateMenu.imperial.commander = {}
    templateMenu.imperial.commander[1] = {name = "Darth Vader", varName = "darthVader"}
    templateMenu.imperial.commander[2] = {name = "General Veers", varName = "generalVeers"}
    templateMenu.imperial.commander[3] = {name = "Emperor Palpatine", varName = "emperorPalpatine"}
    templateMenu.imperial.commander[4] = {name = "Director Orson Krennic", varName = "directorOrsonKrennic"}
    templateMenu.imperial.commander[5] = {name = "Imperial Officer", varName = "imperialOfficer"}

    templateMenu.imperial.operative = {}
    templateMenu.imperial.operative[1] = {name = "Boba Fett", varName = "bobaFett"}
    templateMenu.imperial.operative[2] = {name = "Bossk", varName = "bossk"}
    templateMenu.imperial.operative[3] = {name = "Darth Vader", varName = "darthVaderTheEmperorsApprentice"}

    templateMenu.imperial.corps = {}
    templateMenu.imperial.corps[1] = {name = "Stormtroopers", varName = "stormtrooper"}
    templateMenu.imperial.corps[2] = {name = "Snowtroopers", varName = "snowtrooper"}
    templateMenu.imperial.corps[3] = {name = "Shoretroopers", varName = "shoretroopers"}
    templateMenu.imperial.corps[4] = {name = "DF-90 Mortar Trooper", varName = "df90MortarTrooper"}

    templateMenu.imperial.specialForces = {}
    templateMenu.imperial.specialForces[1] = {name = "Scout Troopers", varName = "scoutTroopers"}
    templateMenu.imperial.specialForces[2] = {name = "Scout Troopers Strike Team", varName = "scoutTroopersStrikeTeam"}
    templateMenu.imperial.specialForces[3] = {name = "Imperial Royal Guards", varName = "imperialRoyalGuards"}
    templateMenu.imperial.specialForces[4] = {name = "Imperial Death Troopers", varName = "imperialDeathTroopers"}

    templateMenu.imperial.support = {}
    templateMenu.imperial.support[1] = {name = "74-Z Speeder Bikes", varName = "speederBike"}
    templateMenu.imperial.support[2] = {name = "E-Web Heavy Blaster Team", varName = "eWebHeavyBlasterTeam"}
    templateMenu.imperial.support[3] = {name = "Dewback Rider", varName = "dewbackRider"}

    templateMenu.imperial.heavy = {}
    templateMenu.imperial.heavy[1] = {name = "AT-ST", varName = "atst"}
    templateMenu.imperial.heavy[2] = {name = "TX-225 GAVw Occupier", varName = "tx225"}

    templateMenu.separatist = {}
    templateMenu.separatist.commander = {}
    templateMenu.separatist.commander[1] = {name = "General Grievous", varName = "generalGrievous"}
    templateMenu.separatist.commander[2] = {name = "Count Dooku", varName = "countDooku"}

    templateMenu.separatist.operative = {}

    templateMenu.separatist.corps = {}
    templateMenu.separatist.corps[1] = {name = "B1 Battle Droids", varName = "b1BattleDroids"}
    templateMenu.separatist.corps[2] = {name = "B2 Super Battle Droids", varName = "b2SuperBattleDroids"}

    templateMenu.separatist.specialForces = {}

    templateMenu.separatist.support = {}
    templateMenu.separatist.support[1] = {name = "Droidekas", varName = "droidekas"}

    templateMenu.separatist.heavy = {}
    templateMenu.separatist.heavy[1] = {name = "AAT Trade Federation Battle Tank", varName = "aatTank"}

    templateMenu.republic = {}
    templateMenu.republic.commander = {}
    templateMenu.republic.commander[1] = {name = "Obi-Wan Kenobi", varName = "obiWanKenobi"}
    templateMenu.republic.commander[2] = {name = "Clone Captain Rex", varName = "cloneCaptainRex"}

    templateMenu.republic.operative = {}
    templateMenu.republic.operative[1] = {name = "R2-D2", varName = "republicR2d2"}
    templateMenu.republic.operative[2] = {name = "C-3PO", varName = "republicC3po"}

    templateMenu.republic.corps = {}
    templateMenu.republic.corps[1] = {name = "Phase I Clone Troopers", varName = "phaseICloneTroopers"}
    templateMenu.republic.corps[2] = {name = "Phase II Clone Troopers", varName = "phaseIICloneTroopers"}

    templateMenu.republic.specialForces = {}

    templateMenu.republic.support = {}
    templateMenu.republic.support[1] = {name = "BARC Speeder", varName = "barcSpeeder"}

    templateMenu.republic.heavy = {}
    templateMenu.republic.heavy[1] = {name = "TX-130 Saber-Class Fighter Tank", varName = "saberTank"}

    templateMenu.buttonPositions = {}
    templateMenu.buttonPositions[1] = {
        {-1.87, 0.28, 2.13},
        {-1.87, 0.28, 1.78},
        {-1.87, 0.28, 1.43},
        {-1.87, 0.28, 1.08},
        {-1.87, 0.28, 0.73},
        {-1.57, 0.28, 0.36},{-2.17, 0.28, 0.36}
    }
    templateMenu.buttonPositions[2] = {
        {1.87, 0.28, -0.58},
        {1.87, 0.28, -0.93},
        {1.87, 0.28, -1.28},
        {1.87, 0.28, -1.63},
        {1.87, 0.28, -1.98},
        {2.17, 0.28, -2.33},{1.57, 0.28, -2.33}
    }
    templateMenu.buttonPositions[3] = {
        {0, 0.28, -0.58},
        {0, 0.28, -0.93},
        {0, 0.28, -1.28},
        {0, 0.28, -1.63},
        {0, 0.28, -1.98},
        {0.3, 0.28, -2.33},{-0.3, 0.28, -2.33}
    }
    templateMenu.buttonPositions[4] = {
        {-1.87, 0.28, -0.58},
        {-1.87, 0.28, -0.93},
        {-1.87, 0.28, -1.28},
        {-1.87, 0.28, -1.63},
        {-1.87, 0.28, -1.98},
        {-1.57, 0.28, -2.33},{-2.17, 0.28, -2.33}
    }
    templateMenu.buttonPositions[5] = {
        {1.87, 0.28, -3.31},
        {1.87, 0.28, -3.66},
        {1.87, 0.28, -4.01},
        {1.87, 0.28, -4.36},
        {1.87, 0.28, -4.71},
        {2.17, 0.28, -5.06},{1.57, 0.28, -5.06}
    }
    templateMenu.buttonPositions[6] = {
        {0, 0.28, -3.31},
        {0, 0.28, -3.66},
        {0, 0.28, -4.01},
        {0, 0.28, -4.36},
        {0, 0.28, -4.71},
        {0.3, 0.28, -5.06},{-0.3, 0.28, -5.06}
    }
    templateMenu.buttonPositions[7] = {
        {-1.87, 0.28, -3.31},
        {-1.87, 0.28, -3.66},
        {-1.87, 0.28, -4.01},
        {-1.87, 0.28, -4.36},
        {-1.87, 0.28, -4.71},
        {-1.57, 0.28, -5.06},{-2.17, 0.28, -5.06}
    }

    templateMenu.buttonPositions[8] = {
        {1.87, 0.28, -6.5},
        {1.87, 0.28, -6.85}
    }
    templateMenu.buttonPositions[9] = {
        {0, 0.28, -6.5},
        {0, 0.28, -6.85}
    }
    templateMenu.buttonPositions[10] = {
        {-1.87, 0.28, -6.5},
        {-1.87, 0.28, -6.85}
    }

    templateMenu.upgradeCardPos = {}
    templateMenu.upgradeCardPos[1] = {q = 146.451578117502, c = 2.2437691503361}
    templateMenu.upgradeCardPos[2] = {q = -37.790038154384, c = 2.3663051367058}
    templateMenu.upgradeCardPos[3] = {q = -90, c = 1.45}
    templateMenu.upgradeCardPos[4] = {q = -142.209961845616, c = 2.3663051367058}
    templateMenu.upgradeCardPos[5] = {q = -65.897765498839, c = 4.5792248252297}
    templateMenu.upgradeCardPos[6] = {q = -90, c = 4.18}

    -- mini info
    miniInfo = {}
    miniInfo.lukeSkywalker = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540537100371/0B15B2810ABEBE5429E4A24852D96BAC2DC28BF7/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540537079134/11A17263AD81DC9D4271B7C6BD809B69141DCB61/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540537079134/11A17263AD81DC9D4271B7C6BD809B69141DCB61/",
        scale = {1,1,1},
        name = "Luke Skywalker"
    }
    miniInfo.lukeSkywalkerJediKnight = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/777357228030156264/12F93F60CC26F1FDC2B577D4014787B7CAFBF9A1/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/777357228030156398/F811CAE962A0BFE369544C0A96C251F5BF198B3A/",
        blue = "http://cloud-3.steamusercontent.com/ugc/777357228030156398/F811CAE962A0BFE369544C0A96C251F5BF198B3A/",
        scale = {1,1,1},
        name = "Luke Skywalker Jedi Knight"
    }
    miniInfo.leiaOrgana = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540537137572/2AC01B05AF1576F49C3156EDB614E2C1804C2A42/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540537137853/F8E5FE7B221E9115B36E22C14E5707B7CFA6CFC3/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540537137853/F8E5FE7B221E9115B36E22C14E5707B7CFA6CFC3/",
        scale = {1,1,1},
        name = "Leia Organa"
    }
    miniInfo.hanSolo = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540669649/C440F429AB1182944D329D0C16C3402DB731CA87/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540669835/B4E395AA781518EAC4FBFFCB27BAA646201F411C/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540669835/B4E395AA781518EAC4FBFFCB27BAA646201F411C/",
        scale = {1,1,1},
        name = "Han Solo"
    }
    miniInfo.jynErso = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475778/55B558E631655D0430BAF76E71C93899AAECA7A1/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305475871/06400240648CC39F933BE504C74DA9BEF4D006C4/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305475871/06400240648CC39F933BE504C74DA9BEF4D006C4/",
        scale = {1,1,1},
        name = "Jyn Erso"
    }
    miniInfo.chewbacca = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540669973/90DD9EA44756CCF9B2473302DC644F3AEEED07B4/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670117/5AA04499FC8CC467864F9F335601E6335C03326D/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670117/5AA04499FC8CC467864F9F335601E6335C03326D/",
        scale = {1,1,1},
        name = "Chewbacca"
    }
    miniInfo.sabineWren = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/948474323838790939/3E9EB4AAF653CD476FF3D90EA82072EDC2D4AC66/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/948474323838791034/38CDAF985C2DC983942183E1DFD3ACBC33D8E40E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/948474323838791034/38CDAF985C2DC983942183E1DFD3ACBC33D8E40E/",
        scale = {1,1,1},
        name = "Sabine Wren"
    }
    miniInfo.r2d2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806966/EFBA4A71BFE748A2868C14B82DA3A7B0D559874A/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/777357228032306302/F5CA6FC54A8625E261F123D73792DE36D74E1686/",
        blue = "http://cloud-3.steamusercontent.com/ugc/777357228032306302/F5CA6FC54A8625E261F123D73792DE36D74E1686/",
        scale = {1,1,1},
        name = "R2-D2"
    }
    miniInfo.c3po = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456807069/DE7E32B39455DB5111769436FD0C5BFDA3841268/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/777357228032306506/D60CB8A1159723917EF1831D4042318A67458A7A/",
        blue = "http://cloud-3.steamusercontent.com/ugc/777357228032306506/D60CB8A1159723917EF1831D4042318A67458A7A/",
        scale = {1,1,1},
        name = "C-3PO"
    }
    miniInfo.rebelOfficer = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862726770/62FECAB3FED284E098751CC3BBC70C4CFF828A58/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862727097/DE589901F66E4079D82BA2C819672F622A5D7240/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862727097/DE589901F66E4079D82BA2C819672F622A5D7240/",
        scale = {1,1,1},
        name = "Rebel Officer"
    }
    miniInfo.rebelOfficerLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862726770/62FECAB3FED284E098751CC3BBC70C4CFF828A58/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862727097/DE589901F66E4079D82BA2C819672F622A5D7240/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862727097/DE589901F66E4079D82BA2C819672F622A5D7240/",
        scale = {1,1,1},
        name = "Rebel Officer",
        leader = true
    }

    miniInfo.rebelTrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862752262/41BD6AB8B17AB7449226A3D80EF186EB8ABA3952/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        scale = {1,1,1},
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862764799/98CBD8B4DD0C08CFA01A8E6C8B5A70A137804EAB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        scale = {1,1,1},
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862755846/CD522BCA5D6E918E13A3FF593D7212FF4B0E79CA/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        scale = {1,1,1},
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862761532/2FB3D83FC2BD077F4ADE619382382B9A59CD0ABE/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        scale = {1,1,1},
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862746147/3F3A21962C4AC0DA0445024688BF580A144D3825/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670236/6257E7A3CE86803490A8A0FAC7F81C281D700F52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670236/6257E7A3CE86803490A8A0FAC7F81C281D700F52/",
        scale = {1,1,1},
        name = "Rebel Trooper Leader",
        altModelInfo = miniInfo.rebelTrooper4
    }
    miniInfo.z6Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862734756/1F48FA301357905B28DA35A03658DFA39154DBFE/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862736228/22D1A1ACC79493FE82165CC95A5E23170A4FBC5B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862736228/22D1A1ACC79493FE82165CC95A5E23170A4FBC5B/",
        scale = {1,1,1},
        name = "Z-6 Trooper"
    }
    miniInfo.mpl57IonTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670338/28625FDF1F56EF08F0DB236C4ECFF67A54083B2B/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        scale = {1,1,1},
        name = "MPL-57 Ion Trooper"
    }
    miniInfo.fleetTroopers1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670667/CB316B23D59F28C5EF22E94A43280D49DFFDD6AC/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        scale = {1,1,1},
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540671182/A605D9D0DB356DC71473F5C9DF27DE1CADB4F320/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540671278/9B94D359A61113F72EEB0435D70A1291431D737A/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540671278/9B94D359A61113F72EEB0435D70A1291431D737A/",
        scale = {1,1,1},
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670978/0642E99CB4E8CABA1AA10389F2387A1C70D9322D/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        scale = {1,1,1},
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopers4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670863/20FE73C6E9F8468BD468C820C88EAB9F697EC33E/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        scale = {1,1,1},
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670464/96FB3825C890968C09B07A2E0E227886D2CC768C/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670556/9B759F6F1A8B7C11AE5F2908208CBA9EF99ECE2C/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670556/9B759F6F1A8B7C11AE5F2908208CBA9EF99ECE2C/",
        scale = {1,1,1},
        name = "Fleet Trooper Leader",
        altModelInfo = miniInfo.fleetTroopers4
    }
    miniInfo.scatterGunTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540671094/4A4BCE6286ACB413B661F827BB00B920617F3E91/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        scale = {1,1,1},
        name = "Scatter Gun Trooper"
    }
    miniInfo.mpl57BarrageTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540671382/63267B140C2A619525B99FD943DF2421F75B9130/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540540671503/D8BCEE815B07EA7074085CF1F43AF8041DEC8981/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540540671503/D8BCEE815B07EA7074085CF1F43AF8041DEC8981/",
        scale = {1,1,1},
        name = "MPL-57 Barrage Trooper"
    }
    miniInfo.medicalDroid21B = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594268997/6248E4CAF3E978154106E7095E6984DCE6677CCA/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594282950/7A9A3E5518394273A507A64CCF7425A2E7EFC29B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594282950/7A9A3E5518394273A507A64CCF7425A2E7EFC29B/",
        scale = {1,1,1},
        name = "2-1B Medical Droid"
    }
    miniInfo.rebelCommsTechnician = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594474909/F8F049D7F88171ADBA83AF3EAF819495053C2873/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594268734/CF3C536F7B068020A99C5E3EE11CA9C54438E250/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594268734/CF3C536F7B068020A99C5E3EE11CA9C54438E250/",
        scale = {1,1,1},
        name = "Rebel Comms Technician"
    }
    miniInfo.r5AstromechDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594428341/4AC5A309D701979A4B3E94725BC1E8745C598BCE/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594267684/F84F03E4A52F50EF5255A464FF85083CF4FB3D26/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594267684/F84F03E4A52F50EF5255A464FF85083CF4FB3D26/",
        scale = {1,1,1},
        name = "R5 Astromech Droid"
    }
    miniInfo.rebelVeteransLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192015/F194EFE217778158ED30DFD40EFC1F70BEC01772/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        scale = {1,1,1},
        name = "Rebel Veterans Leader",
        altModelInfo = miniInfo.rebelVeteransLeader
    }
    miniInfo.rebelVeterans1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192232/D15615AF2A0F4F4887E9BD3DFFA141C8ACCCEC78/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        scale = {1,1,1},
        name = "Rebel Veteran"
    }
    miniInfo.rebelVeterans2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192402/4D1858AA566FEEE91774E40B10C233AAD8C381D5/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        scale = {1,1,1},
        name = "Rebel Veteran"
    }
    miniInfo.rebelVeterans3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192498/BF583EA43B457E816CDE323C172B2F4558B7A8BD/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        scale = {1,1,1},
        name = "Rebel Veteran"
    }
    miniInfo.rebelVeterans4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192589/466305BFF474DBAB11F58FA13B3F4ACC9BB7127C/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        scale = {1,1,1},
        name = "Rebel Veteran"
    }
    miniInfo.cm093Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687947/DCC60167A78C152DDAE932E699D7C70C5629008B/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        scale = {1,1,1},
        name = "CM-0/93 Trooper"
    }
    miniInfo.markIIMediumBlasterTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688462/6B35D0B4E18CB7D0081825BEDC6E6C4AE45AA329/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702688570/1827E8E24FE65F309AF936EF35D07CC2149CD95E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702688570/1827E8E24FE65F309AF936EF35D07CC2149CD95E/",
        scale = {1,1,1},
        name = "Mark II Medium Blaster Trooper"
    }
    miniInfo.rebelCommandosLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173156/D637683F992DD0C4488252BE266EEEA1F26006B0/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        scale = {1,1,1},
        name = "Rebel Commandos Leader"
    }
    miniInfo.rebelCommandos1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541172497/B3E1593143504101920CC6419BE7C2EAEF52993F/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541188141/6E23E29BB42963B94A0B7DFE01C4C49D776D9657/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541188141/6E23E29BB42963B94A0B7DFE01C4C49D776D9657/",
        scale = {1,1,1},
        name = "Rebel Commandos"
    }
    miniInfo.rebelCommandos2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173253/155BAA01BA51A8EB524DD434A3C512D8C0B3A04B/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        scale = {1,1,1},
        name = "Rebel Commandos"
    }
    miniInfo.rebelCommandos3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173354/3483C6FB73C66481BC6CCC398BAB8E796F7EC076/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541188141/6E23E29BB42963B94A0B7DFE01C4C49D776D9657/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541188141/6E23E29BB42963B94A0B7DFE01C4C49D776D9657/",
        scale = {1,1,1},
        name = "Rebel Commandos"
    }
    miniInfo.rebelCommandos4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173710/DAD1A2BE9F1D9C74C10D975D5AD5FDA05566C100/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        scale = {1,1,1},
        name = "Rebel Commandos"
    }
    miniInfo.dh447Sniper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862776611/B8222AA4A3B680E969DC106C8A281D11845994EB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862776974/21649563BC0CB84E12C0B249C720919F528596D3/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862776974/21649563BC0CB84E12C0B249C720919F528596D3/",
        scale = {1,1,1},
        name = "DH-447 Sniper"
    }
    miniInfo.dh447SniperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862776611/B8222AA4A3B680E969DC106C8A281D11845994EB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780862776974/21649563BC0CB84E12C0B249C720919F528596D3/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780862776974/21649563BC0CB84E12C0B249C720919F528596D3/",
        scale = {1,1,1},
        name = "DH-447 Sniper",
        leader = true
    }
    miniInfo.protonChargeSaboteur = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173465/8193FD1F0862270CD23BA9243679840BE6324DC6/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541173570/3C100E92F0DEDEF117D3A0392D3271951BC90DD0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541173570/3C100E92F0DEDEF117D3A0392D3271951BC90DD0/",
        scale = {1,1,1},
        name = "Proton Charge Saboteur"
    }
    miniInfo.protonChargeSaboteurLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173465/8193FD1F0862270CD23BA9243679840BE6324DC6/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541173570/3C100E92F0DEDEF117D3A0392D3271951BC90DD0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541173570/3C100E92F0DEDEF117D3A0392D3271951BC90DD0/",
        scale = {1,1,1},
        name = "Proton Charge Saboteur",
        leader = true
    }
    miniInfo.wookieeWarriorsLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173937/5179F4315AD6B0839454E1934E794A7F006C7813/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541174467/18352D89A219B89F6C869D89B9EDE22822F7F950/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541174467/18352D89A219B89F6C869D89B9EDE22822F7F950/",
        scale = {1,1,1},
        name = "Wookiee Warriors Leader"
    }
    miniInfo.wookieeWarriors1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541174158/677BF72C323CFF2314C174393AFA361C398C5519/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541174034/90C4A124BB82CCE0B5E38E13860ED49BB9A4973B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541174034/90C4A124BB82CCE0B5E38E13860ED49BB9A4973B/",
        scale = {1,1,1},
        name = "Wookiee Warrior"
    }
    miniInfo.wookieeWarriors2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541174304/9053CDD2798CEA905F8486498D0104B6ACA2F078/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541174467/18352D89A219B89F6C869D89B9EDE22822F7F950/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541174467/18352D89A219B89F6C869D89B9EDE22822F7F950/",
        scale = {1,1,1},
        name = "Wookiee Warrior"
    }
    miniInfo.bowcasterWookiee = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541174665/9E1AA98159F76E271185345E9D347D7453C05D4B/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541174034/90C4A124BB82CCE0B5E38E13860ED49BB9A4973B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541174034/90C4A124BB82CCE0B5E38E13860ED49BB9A4973B/",
        scale = {1,1,1},
        name = "Bowcaster Wookiee"
    }
    miniInfo.rebelPathfindersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475193/3C613417B99B185BBAEC7A4C66AAE10E8FD6F8D5/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        scale = {1,1,1},
        name = "Rebel Pathfinders Leader"
    }
    miniInfo.rebelPathfinders1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475558/EE0863D9DE3C9D35C486B7273E1D555BB1F09566/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        scale = {1,1,1},
        name = "Rebel Pathfinders"
    }
    miniInfo.rebelPathfinders2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475456/26BF332D69FD5B08D677EBDB91948820E03690DB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        scale = {1,1,1},
        name = "Rebel Pathfinders"
    }
    miniInfo.rebelPathfinders3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475667/B5CC42E1CAB9059DEE4B1237222CF0FE3BB6B838/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        scale = {1,1,1},
        name = "Rebel Pathfinders"
    }
    miniInfo.pao = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/993513208355174746/6F5A50CE6D4E23C6278AE868FD359A49E1C80179/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/993513208355174858/CCC2B3862F1FEB611B03317594F6F0E761750C70/",
        blue = "http://cloud-3.steamusercontent.com/ugc/993513208355174858/CCC2B3862F1FEB611B03317594F6F0E761750C70/",
        scale = {1,1,1},
        name = "Pao",
        leader = true
    }
    miniInfo.bistan = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/993513208355174951/467D917BF6BCABCC9F6DD17F5DEDB43A11DEA9A7/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/993513208355175183/AD143EC79EC2BA3E7B93B114CC8AFEAAD322D806/",
        blue = "http://cloud-3.steamusercontent.com/ugc/993513208355175183/AD143EC79EC2BA3E7B93B114CC8AFEAAD322D806/",
        scale = {1,1,1},
        name = "Bistan"
    }
    miniInfo.atrt = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541266463/014ECD21C93F864E1C1DFD104A365DFC555EBAF8/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541267239/D9891291A896CC024383C024B20C5ACF87EC8A18/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541267239/D9891291A896CC024383C024B20C5ACF87EC8A18/",
        scale = {1,1,1},
        name = "AT-RT"
    }
    miniInfo.tauntaunRidersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499191489/E91DEB380842511B21284A125A505B6C71D18474/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499191676/8E19A176FF0B3D2923F8F3D6DEA80D389F77CB27/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499191676/8E19A176FF0B3D2923F8F3D6DEA80D389F77CB27/",
        scale = {1,1,1},
        name = "Tauntaun Rider Leader"
    }
    miniInfo.tauntaunRiders1= {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499191881/3DBB7DF0943F0D25484DE34581411825BA566F8A/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/788608699499191676/8E19A176FF0B3D2923F8F3D6DEA80D389F77CB27/",
        blue = "http://cloud-3.steamusercontent.com/ugc/788608699499191676/8E19A176FF0B3D2923F8F3D6DEA80D389F77CB27/",
        scale = {1,1,1},
        name = "Tauntaun Rider"
    }
    miniInfo.fdLaserCannonTeam = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541267781/BE163E2112B28E8C7C5E536B037D3115103F9642/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540541270022/6A40D7E3F7ACD02D54C370A8C299AE69142F72D8/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541269701/797EACA86E0FB799D16DC8FE907A70C4B976C5EE/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541269701/797EACA86E0FB799D16DC8FE907A70C4B976C5EE/",
        scale = {1,1,1},
        name = "1.4 FD Laser Cannon Team"
    }
    miniInfo.airSpeeder = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/999141806429331055/047818ABA85804B98787BC67BEF12D24EC8F8ADB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540541270022/6A40D7E3F7ACD02D54C370A8C299AE69142F72D8/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541315963/DD72FAD5F49D303A83A4463B0D3796E3A8FD5BE8/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541315963/DD72FAD5F49D303A83A4463B0D3796E3A8FD5BE8/",
        scale = {1,1,1},
        name = "T-47 Airspeeder"
    }
    miniInfo.x34Landspeeder = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594267188/9FA2B8A42C94B6E3683F1B753CEBA14FC3258592/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540541270022/6A40D7E3F7ACD02D54C370A8C299AE69142F72D8/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594267308/582E5F56A65FE6CD486BCBABB510CAE4B4DF6C8C/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594267308/582E5F56A65FE6CD486BCBABB510CAE4B4DF6C8C/",
        scale = {1,1,1},
        name = "X-34 Landspeeder"
    }

    miniInfo.darthVader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541323740/BF58AB674CB7D638333F1B04A7C9A5B9D7DBF0E4/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541324289/B37D84D512722740E8310629C3E7BFC45AF0FBC9/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541324289/B37D84D512722740E8310629C3E7BFC45AF0FBC9/",
        scale = {1,1,1},
        name = "Darth Vader"
    }
    miniInfo.darthVaderTheEmperorsApprentice = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/777357228030156593/FEBA127ECDF2917EA8F8066BBB10BADA7D365D3E/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541324289/B37D84D512722740E8310629C3E7BFC45AF0FBC9//",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541324289/B37D84D512722740E8310629C3E7BFC45AF0FBC9/",
        scale = {1,1,1},
        name = "Darth Vader The Emperors Apprentice"
    }
    miniInfo.generalVeers = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565411/F5F84397A9353DAD3D913F34E49812C1C895DA65/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541565593/F948637FEE70F52681A5A3C49C0E00EF25471AC1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541565593/F948637FEE70F52681A5A3C49C0E00EF25471AC1/",
        scale = {1,1,1},
        name = "General Veers"
    }
    miniInfo.emperorPalpatine = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565714/71E1936EB657F4BC1074EB740BC9AA0531A130AC/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541565804/0EB3EBFD318678DBE5B7C83B39A31DC8AB3376B6/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541565804/0EB3EBFD318678DBE5B7C83B39A31DC8AB3376B6/",
        scale = {1,1,1},
        name = "Emperor Palpatine"
    }
    miniInfo.directorOrsonKrennic = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305476013/77069645EC03E0F1C1DB10C2CE7EA85917E45404/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305476130/772EEBD3EC49A7271C1C7647F817C51ED23DE3B2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305476130/772EEBD3EC49A7271C1C7647F817C51ED23DE3B2/",
        scale = {1,1,1},
        name = "Director Orson Krennic"
    }
    miniInfo.imperialOfficer = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565898/F06AB6731446249164D34ACA208E4FAE70C6FE00/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541566011/A7A84EBF79DA5E1D5BCE71E863FC16EC40937F6F/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541566011/A7A84EBF79DA5E1D5BCE71E863FC16EC40937F6F/",
        scale = {1,1,1},
        name = "Imperial Officer"
    }
    miniInfo.imperialOfficerLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565898/F06AB6731446249164D34ACA208E4FAE70C6FE00/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541566011/A7A84EBF79DA5E1D5BCE71E863FC16EC40937F6F/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541566011/A7A84EBF79DA5E1D5BCE71E863FC16EC40937F6F/",
        scale = {1,1,1},
        name = "Imperial Officer",
        leader = true
    }
    miniInfo.bobaFett = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541667697/9BC2C54E14EA265620F3D96553274503245D1681/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541669466/60DFE8F3EC756ECE7E5729D3261EF37CACA587C6/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541669466/60DFE8F3EC756ECE7E5729D3261EF37CACA587C6/",
        scale = {1,1,1},
        name = "bobaFett"
    }
    miniInfo.bossk = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/948474323838791181/6B9D77B77DF8FD7AFA19342AD687F0E15A2E21B7/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/948474323838791276/ABFCDD8C71D484E6B6050080BB80B79D0DE93178/",
        blue = "http://cloud-3.steamusercontent.com/ugc/948474323838791276/ABFCDD8C71D484E6B6050080BB80B79D0DE93178/",
        scale = {1,1,1},
        name = "bossk"
    }

    miniInfo.stormtrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711529/FF076CE02269A8505CB8EFC06749196FFD446391/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        scale = {1,1,1},
        name = "Stormtrooper"
    }
    miniInfo.stormtrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711653/C170DF086178164DC66188071D15E9EB36C9A742/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        scale = {1,1,1},
        name = "Stormtrooper"
    }
    miniInfo.stormtrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711874/7E06BF6E8E18DD05BBBF10343614B47B8BEE9948/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        scale = {1,1,1},
        name = "Stormtrooper"
    }
    miniInfo.stormtrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711777/1E415A2A18F2269B0C63E1C2901E5192DCCFE8CB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        scale = {1,1,1},
        name = "Stormtrooper"
    }
    miniInfo.stormtrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711094/1DF94C3CDF022814179AFBA6D7521E6196760949/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        scale = {1,1,1},
        name = "Stormtrooper Leader",
        altModelInfo = miniInfo.stormtrooper4
    }

    miniInfo.snowtrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801837/D52F333945BF667A37E06611977C36186CEFC7B6/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        scale = {1,1,1},
        name = "Snowtrooper"
    }
    miniInfo.snowtrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801500/728C586E21D0A4EBD8DE54EEF4E097EFEEECE871/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        scale = {1,1,1},
        name = "Snowtrooper"
    }
    miniInfo.snowtrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801363/743D9E272367ABB1F6296D5EFB6010637C58D5E4/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        scale = {1,1,1},
        name = "Snowtrooper"
    }
    miniInfo.snowtrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801717/EDEA1301FC55A6970D5FBCF0A9F10456E4C2EE40/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        scale = {1,1,1},
        name = "Snowtrooper"
    }
    miniInfo.snowtrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801027/2A5DEE9952A0179FC8448FFA52819B387124ACD7/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        scale = {1,1,1},
        name = "Snowtrooper Leader",
        altModelInfo = miniInfo.snowtrooper4
    }
    miniInfo.dlt19Stormtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541712202/29BA56F42F8BE16DB10155B0066AEE36EF700A83/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        scale = {1,1,1},
        name = "DLT-19 Stormtrooper"
    }
    miniInfo.t7IonSnowtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541802160/69A03779E6B67F6F547C2FBD70ACDFC39281387D/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541802252/037749C730FACCA3361B041BCB3C68E7E19DCDF8/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541802252/037749C730FACCA3361B041BCB3C68E7E19DCDF8/",
        scale = {1,1,1},
        name = "T-7 Ion Snowtrooper"
    }
    miniInfo.flametrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801931/BDE907EBE0BFC0DC4180C76AFEA3F8667013FF3B/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541802054/044AD0961CD1485A61AC3B6CB3669FD8AA5A0FEB/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541802054/044AD0961CD1485A61AC3B6CB3669FD8AA5A0FEB/",
        scale = {1,1,1},
        name = "Flametrooper"
    }
    miniInfo.hh12Stormtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711981/5D8FB39102FEE64DF1802AA71B66666B4E03717F/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541712102/C37F3281C89F697024FF1F343B06FB5AC828EA10/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541712102/C37F3281C89F697024FF1F343B06FB5AC828EA10/",
        scale = {1,1,1},
        name = "HH12 Stormtrooper"
    }
    miniInfo.fx9MedicalDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594268065/7B4874981CECB7BB80D5BC54F60F1939B9A9DAB1/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594268174/00246DE6DCE285206330C43B8049B19FFDF5BB41/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594268174/00246DE6DCE285206330C43B8049B19FFDF5BB41/",
        scale = {1,1,1},
        name = "FX-9 Medical Droid"
    }
    miniInfo.imperialCommsTechnician = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594268417/62CC1D5BCBD1EE294C72781B03AB972B3ED5AD12/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594268526/CA2596C0B2D7DF68D794B2A7880F34B5459F1206/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594268526/CA2596C0B2D7DF68D794B2A7880F34B5459F1206/",
        scale = {1,1,1},
        name = "Imperial Comms Technician"
    }
    miniInfo.r4AstromechDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594492173/DDA1CC3AEEC3D5ADB3B04F35125EE8A6FB7EB93A/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/949599512594267919/F44B2C3C810757626C7A4A61DAA7F2BC2BEECFC6/",
        blue = "http://cloud-3.steamusercontent.com/ugc/949599512594267919/F44B2C3C810757626C7A4A61DAA7F2BC2BEECFC6/",
        scale = {1,1,1},
        name = "R4 Astromech Droid"
    }
    miniInfo.shoretroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688359/642C317FE5C91E4DCC908FEA02A7ED4000B06A9F/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        scale = {1,1,1},
        name = "Shoretrooper Leader",
        altModelInfo = miniInfo.shoretroopers4
    }
    miniInfo.shoretroopers1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687570/0D2A602282BAACDCE665EF9D1D65CEA413944083/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        scale = {1,1,1},
        name = "Shoretrooper"
    }
    miniInfo.shoretroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688133/C8D721D29D711045A27EEC3868D4B7A111C86F20/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        scale = {1,1,1},
        name = "Shoretrooper"
    }
    miniInfo.shoretroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687282/B02342FDEEE7DDE82DF96EB434B1D033B0A4C899/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        scale = {1,1,1},
        name = "Shoretrooper"
    }
    miniInfo.shoretroopers4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688256/B266465186713632AE14D6B4B473AB4E94814685/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        scale = {1,1,1},
        name = "Shoretrooper"
    }
    miniInfo.t21BTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687816/8C17AF1D2344B7E8B1C8D34A0F2228E9ADC2FFAA/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702687407/D5B685EA41E9C664F2D16381474B5F08DF9CFAE5/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702687407/D5B685EA41E9C664F2D16381474B5F08DF9CFAE5/",
        scale = {1,1,1},
        name = "T-21B Trooper"
    }
    miniInfo.df90MortarTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688709/1EB7C549A90465F116EF307643FEA1D572CE1008/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702688820/94F2B4954FD378EA9E5544E37B80B8556812F2F2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702688820/94F2B4954FD378EA9E5544E37B80B8556812F2F2/",
        scale = {1,1,1},
        name = "DF-90 Mortar Trooper"
    }
    miniInfo.scoutTroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911155/36E8C01A67E5E7A4188FC619261E0BAB0DF438C1/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        scale = {1,1,1},
        name = "Scout Trooper Leader"
    }
    miniInfo.scoutTroopers1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911406/C33160A2888F0CE53C9712B1872478E038F9B0EA/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        scale = {1,1,1},
        name = "Scout Trooper"
    }
    miniInfo.scoutTroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911585/324AE8DA9D33C07E2FE620FC4B49E2C190F39F5A/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        scale = {1,1,1},
        name = "Scout Trooper"
    }
    miniInfo.scoutTroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911689/42647324CBDBF25155498DF1FFDDDC2EC04FB5EC/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        scale = {1,1,1},
        name = "Scout Trooper"
    }
    miniInfo.dlt19xSniper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/950714557093540011/2B022A8CE1BC7DBF59011A5DF503F590549ADB68/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093540121/4801D28173F40744AF6DEE698E9A9523C6C55E5F/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093540121/4801D28173F40744AF6DEE698E9A9523C6C55E5F/",
        scale = {1,1,1},
        name = "DLT-19x Sniper"
    }
    miniInfo.dlt19xSniperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/950714557093540011/2B022A8CE1BC7DBF59011A5DF503F590549ADB68/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093540121/4801D28173F40744AF6DEE698E9A9523C6C55E5F/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093540121/4801D28173F40744AF6DEE698E9A9523C6C55E5F/",
        scale = {1,1,1},
        name = "DLT-19x Sniper",
        leader = true
    }
    miniInfo.sonicChargeSaboteur = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/950714557093539716/6A0D63306F505A074395AFA61EB990280DB8995D/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093539899/FF7A535E91BF79D4C3E0D55E874C1ACEB6FBF434/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093539899/FF7A535E91BF79D4C3E0D55E874C1ACEB6FBF434/",
        scale = {1,1,1},
        name = "Sonic Charge Saboteur"
    }
    miniInfo.sonicChargeSaboteurLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/950714557093539716/6A0D63306F505A074395AFA61EB990280DB8995D/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/950714557093539899/FF7A535E91BF79D4C3E0D55E874C1ACEB6FBF434/",
        blue = "http://cloud-3.steamusercontent.com/ugc/950714557093539899/FF7A535E91BF79D4C3E0D55E874C1ACEB6FBF434/",
        scale = {1,1,1},
        name = "Sonic Charge Saboteur",
        leader = true
    }
    miniInfo.imperialRoyalGuardsLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911959/D583DF28D96DBDF2F1FE9FB6AAB25809774C46EF/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        scale = {1,1,1},
        name = "Imperial Royal Guard Leader"
    }
    miniInfo.imperialRoyalGuards1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541912172/73A36C525BC98DD1F4EC7953943FE5F660B0E9D8/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        scale = {1,1,1},
        name = "Imperial Royal Guard"
    }
    miniInfo.imperialRoyalGuards2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541912365/CB3109223BD5A017AA159066A3B17002B8892047/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        scale = {1,1,1},
        name = "Imperial Royal Guard"
    }
    miniInfo.electrostaffGuard = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541912278/DC9D78CD5742236F9F272AC1F8AA1D59D07CF5A9/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        scale = {1,1,1},
        name = "Electrostaff Guard"
    }
    miniInfo.imperialDeathTroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305474570/777B8146B150032E3D733D17110BE5887D1AB991/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        scale = {1,1,1},
        name = "Imperial Death Troopers Leader"
    }
    miniInfo.imperialDeathTroopers1= {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305474824/49EFFD221EF1EBD3F3365B6B73B9A4A5C6E6A075/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        scale = {1,1,1},
        name = "Imperial Death Troopers"
    }
    miniInfo.imperialDeathTroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305474956/BB78111128E91BB2DB22F2990AFB438B9EA5FC0E/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        scale = {1,1,1},
        name = "Imperial Death Troopers"
    }
    miniInfo.imperialDeathTroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475069/81803116C6F5F9B133D2D0CC39E2A2CA6043E9DB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        scale = {1,1,1},
        name = "Imperial Death Troopers"
    }
    miniInfo.dtf16 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/993513208355174615/DD0DA9DFDBCA621CF297C9A9EB2356279A733158/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        scale = {1,1,1},
        name = "DT-F16",
        leader = true
    }
    miniInfo.dlt19DTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/999144021179640024/44B7ECC02D8366F7B36358297EC908DF853F6A2D/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        blue = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        scale = {1,1,1},
        name = "DLT-19D Trooper"
    }
    miniInfo.speederBikeLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540542045506/0E2EC344AA0AD37699FFEFD4E1BA86A4FD4CD48B/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540542045645/AF0264339BB7E1D09E74AF920E2FB693C3CA1592/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540542045645/AF0264339BB7E1D09E74AF920E2FB693C3CA1592/",
        scale = {1,1,1},
        name = "74-Z Speeder Bike Leader"
    }
    miniInfo.speederBike = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540542045928/74630975D4992CA09BDDD88460874FB9E4095FC9/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540542045645/AF0264339BB7E1D09E74AF920E2FB693C3CA1592/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540542045645/AF0264339BB7E1D09E74AF920E2FB693C3CA1592/",
        scale = {1,1,1},
        name = "74-Z Speeder Bike"
    }
    miniInfo.eWebHeavyBlasterTeam = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540542046063/4018BD67779A3F2ACCFA92C35306880C2FC60188/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540542046257/D259CAB86BBC7A60FB09149229F33508C8DF4CE8/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540542046257/D259CAB86BBC7A60FB09149229F33508C8DF4CE8/",
        scale = {1,1,1},
        name = "E-Web Heavy Blaster Team"
    }
    miniInfo.dewbackRider = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688959/0FCB94B52F0C2DF6E3F296AB6980CEC158E3E496/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/786359682702689114/727755B3BE824994C869F1C869D8B5A07A3CD284/",
        blue = "http://cloud-3.steamusercontent.com/ugc/786359682702689114/727755B3BE824994C869F1C869D8B5A07A3CD284/",
        scale = {1,1,1},
        name = "Dewback Rider"
    }
    miniInfo.atst = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/999141806429351360/24C098E7B3D1708CDCFB9AEA4B2C445EF2DBAEE0/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540541270022/6A40D7E3F7ACD02D54C370A8C299AE69142F72D8/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234540542046425/F18B487C68529B4C8FF37C88F96A3CCA3D0E24BD/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234540542046609/68BF9FE41CDCD77BE4C678F35A7C505495FD8E94/",
        scale = {1,1,1},
        name = "AT-ST"
    }
    miniInfo.tx225 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/963116666702885311/3A0E9E0D8580544E62D1FD1223A0B48484F1B011/",
        collider = "http://cloud-3.steamusercontent.com/ugc/963116666702885485/70F17B3327115A379D06F81C6F47F76470D7B826/",
        red = "http://cloud-3.steamusercontent.com/ugc/999143816035492932/675DF233BD5B8BD58097F0205F2D984D04D9D16C/",
        blue = "http://cloud-3.steamusercontent.com/ugc/999143816035492932/675DF233BD5B8BD58097F0205F2D984D04D9D16C/",
        scale = {1,1,1},
        name = "TX-225 GAVw Occupier"
    }
    -- SEPARATIST
    miniInfo.generalGrievous = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167436/AAA2C61A17BB43F2673AF16D30BD0478B9AAAD2A/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780869167571/EF86CBDA5F361282AD077D61FA81ABF0FEE061A0/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780869167571/EF86CBDA5F361282AD077D61FA81ABF0FEE061A0/",
        scale = {1,1,1},
        name = "General Grievous"
    }
    miniInfo.countDooku = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586543/25BD09F275C593DB6C794359A9C50F3188F4D804/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849586640/B0512CC73C982F94EB5FEAE1661CF4438DAD8879/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849586640/B0512CC73C982F94EB5FEAE1661CF4438DAD8879/",
        scale = {1,1,1},
        name = "Count Dooku"
    }
    miniInfo.b1BattleDroidLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869166347/AA861F86A0B74CF335533E425A6CBACB99395A09/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780869166529/263C2AB95B1743539EC2CBDE40B0A14B1F5E5693/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780869166529/263C2AB95B1743539EC2CBDE40B0A14B1F5E5693/",
        scale = {1,1,1},
        name = "B1 Battle Droid Leader"
    }
    miniInfo.b1BattleDroid1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167061/48F42C02EDD970E6DE8E59B8601EF3E7F11C1742/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        scale = {1,1,1},
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid2 = miniInfo.b1BattleDroid1
    miniInfo.b1BattleDroid3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167318/DBC7863706A08B96020D3BFBE7A0C2C5689B7B08/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        scale = {1,1,1},
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869166660/36AF6887F11FC70FF6AB75D0434EA79952C9E882/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        scale = {1,1,1},
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid5 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167194/9ADFFD9AD608CBE3E9F6F61AB416E699A4156109/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        scale = {1,1,1},
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid6 = miniInfo.b1BattleDroid3
    miniInfo.e5CB1Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780871782781/4DCE4780DE1CCDFB2996C28200A26C3B0696DD5A/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780871782881/ADC1DBC3987C84AF486F9CD0E19A0455F4C33291/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780871782881/ADC1DBC3987C84AF486F9CD0E19A0455F4C33291/",
        scale = {1,1,1},
        name = "E-5C B1 Trooper"
    }
    miniInfo.e60RB1Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780871782500/34D317CFE0BE32E4FFFB84567822CDF7AC4D4C98/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785234780871782620/9A9EA2B54691F42EA6D34762D33D523A836201B2/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785234780871782620/9A9EA2B54691F42EA6D34762D33D523A836201B2/",
        scale = {1,1,1},
        name = "E-60R B1 Trooper"
    }
    miniInfo.b2SuperBattleDroidLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586118/94F967F21EA7E390A200C4BDA5581D07DBB37AC2/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        scale = {1,1,1},
        name = "B2 Battle Droid Leader"
    }
    miniInfo.b2SuperBattleDroid1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586430/E5941CF7A3631E6D4A28832AE489A4340C96B0B9/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        scale = {1,1,1},
        name = "B2 Battle Droid"
    }
    miniInfo.b2SuperBattleDroid2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586226/9326AD8D3EC80CC53F4BF2D156014978DCD715D9/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        scale = {1,1,1},
        name = "B2 Battle Droid"
    }
    miniInfo.b2SuperBattleDroid3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586324/B5D59E535AFA2BF99FCA3C584E28FA500ADB89BD/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        scale = {1,1,1},
        name = "B2 Battle Droid"
    }
    miniInfo.b2HATrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849585631/7FF051E2079AB28A4FB77CCC739BCEB42F4CCFAA/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        scale = {1,1,1},
        name = "B2-HA Trooper"
    }
    miniInfo.b2ACMTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849585917/4D4047069796D1E0567BE9ABD836984FDF12E80E/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        blue = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        scale = {1,1,1},
        name = "B2-ACM Trooper"
    }
    miniInfo.droidekaLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785235151812759044/95037BEC00715812E918EC16919526DADE6F523F/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785235151812759497/47C2BFAE32E13C07FE68522008085B8C1F2EFDBD/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785235151812759497/47C2BFAE32E13C07FE68522008085B8C1F2EFDBD/",
        scale = {1,1,1},
        name = "Droideka Leader"
    }
    miniInfo.droideka1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785235151812759044/95037BEC00715812E918EC16919526DADE6F523F/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785235151812759310/88CC976372EF6B912EF2A761563F5632595C2295/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785235151812759310/88CC976372EF6B912EF2A761563F5632595C2295/",
        scale = {1,1,1},
        name = "Droideka"
    }
    miniInfo.aatTank = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785235151813166538/2F32058DDD51C131547B66A3927041BDACDD9E72/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785235151813181413/7151B328CAFD5AA2F36C3731A1C3B0A00714FC88/",
        red = "http://cloud-3.steamusercontent.com/ugc/785235151813166725/2751E83472B0B6BD0559F5E77FAA3D62A0E17BB1/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785235151813166725/2751E83472B0B6BD0559F5E77FAA3D62A0E17BB1/",
        scale = {1,1,1},
        name = "AAT Trade Federation Battle Tank"
    }

    -- REPUBLIC
    miniInfo.obiWanKenobi = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873394134/94407058FBA842AD0FDCC0BBB8AB613EA9A739C2/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873394267/272C1C9A8C15C36DC5C10DD62D5EFCEF9BFF4496/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873394267/272C1C9A8C15C36DC5C10DD62D5EFCEF9BFF4496/",
        scale = {1,1,1},
        name = "Obi-Wan Kenobi"
    }
    miniInfo.cloneCaptainRex = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806720/869654FC3B0590BFFF2E1845C3CFA9169838EBF9/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456806858/52327997163A5113DF9E11B85F9DA8B6B970012C/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456806858/52327997163A5113DF9E11B85F9DA8B6B970012C/",
        scale = {1,1,1},
        name = "Obi-Wan Kenobi"
    }
    miniInfo.phaseICloneTrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393043/33A6FEA07374DAC8EBB6CDD463B6C761DC765D03/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper Leader"
    }
    miniInfo.phaseICloneTrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393589/6AF627688F36D2049C1307BCB67A755FB27D51C5/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393727/8C4030EF9FEEB32E048567DC2EC38A1985E7C8C0/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873457225/6382F0EA6E2DB0BC65921C3F4E5C97A84B422187/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873394019/F7EDA9D80C35FADA3C000A88C8105823172123B8/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.z6PhaseITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393876/DEDAF52B0D07E0F2A2BCB54DE9A56E4FA437A3E4/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "Z-6 Phase I Clone Trooper"
    }
    miniInfo.dc15PhaseITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393393/915E79CA7D72B0DA950656C69F104A7BB586C0E0/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        scale = {1,1,1},
        name = "DC-15 Phase I Clone Trooper"
    }
    miniInfo.phaseIICloneTrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456805632/5EFC453DA5756A419155D7A2564F30D078A16998/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper Leader"
    }
    miniInfo.phaseIICloneTrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806277/B6E8E97A784420BE0BA72D4DDD8288A4BF3943D3/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseIICloneTrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806431/B4EA83469C800B6B5B0506EE6E6ABE30D00D80DB/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseIICloneTrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456953028/A36587741C54DCDDAAFE60A0D253077D9DDE575D/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseIICloneTrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806596/C3FFC651464D351B03E7EC77F3E341DFFF4F7ABF/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        scale = {1,1,1},
        name = "Phase I Clone Trooper"
    }
    miniInfo.z6PhaseIITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393876/DEDAF52B0D07E0F2A2BCB54DE9A56E4FA437A3E4/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540537095586/C31C1C750AB535B6816C9216B20609C554578249/",
        red = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        blue = "http://cloud-3.steamusercontent.com/ugc/776232727456805854/9E21DEB2F2D99016C5AC6EAC2AD6303A1EA0680E/",
        scale = {1,1,1},
        name = "Z-6 Phase I Clone Trooper"
    }
    miniInfo.barcSpeeder = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873394399/018F8CC63E0D90F58AADA6328DF1709D4D1DF796/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234540540671597/B477FDC4D3200384E974945C2974ABFEFA566166/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873394534/3E2F0490BA5D1024741F5806A4921D0E0E79EA9F/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873394534/3E2F0490BA5D1024741F5806A4921D0E0E79EA9F/",
        scale = {1,1,1},
        name = "BARC Speeder"
    }

    miniInfo.saberTank = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873392482/BC01571E47E96306C31FABABE3EA971814E00C96/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785235151813181413/7151B328CAFD5AA2F36C3731A1C3B0A00714FC88/",
        red = "http://cloud-3.steamusercontent.com/ugc/785236717873392638/CE1C3404249840D5F7F9499D1427E83530ACEB19/",
        blue = "http://cloud-3.steamusercontent.com/ugc/785236717873392638/CE1C3404249840D5F7F9499D1427E83530ACEB19/",
        scale = {1,1,1},
        name = "TX-130 Saber-Class Fighter Tank"
    }

    cardInfo = {}

    -- upgrade cards
    cardInfo.upgradeCards = {}

    -- force
    cardInfo.upgradeCards.forcePush = {name = "Force Push", guid = "eaa6d3", ptCost = 10,varName="forcePush"}
    cardInfo.upgradeCards.forceReflexes = {name = "Force Reflexes", guid = "d69042", ptCost = 10,varName="forceReflexes"}
    cardInfo.upgradeCards.saberThrow = {name = "Saber Throw", guid = "c3bf77", ptCost = 5,varName="saberThrow"}
    cardInfo.upgradeCards.jediMindTrick = {name = "Jedi Mind Trick", guid = "ae1865", ptCost = 5,varName="jediMindTrick"}
    cardInfo.upgradeCards.battleMeditation = {name = "Battle Meditation", guid = "62dbea", ptCost = 5,varName="battleMeditation"}
    cardInfo.upgradeCards.forceChoke = {name = "Force Choke", guid = "d12be1", ptCost = 5,varName="forceChoke"}
    cardInfo.upgradeCards.anger = {name = "Anger", guid = "d1g2be1", ptCost = 5,varName="anger"}
    cardInfo.upgradeCards.fear = {name = "Fear", guid = "d1rg2be1", ptCost = 3,varName="fear"}
    cardInfo.upgradeCards.forceGuidance = {name = "Force Guidance", guid = "d1g2ggbe1", ptCost = 10,varName="forceGuidance"}
    cardInfo.upgradeCards.hope = {name = "Hope", guid = "d1g2ggggbe1", ptCost = 3,varName="hope"}

    -- tech
    cardInfo.upgradeCards.targetingScopes = {name = "Targeting Scopes", guid = "d03bcc", ptCost = 4,varName="targetingScopes"}
    cardInfo.upgradeCards.grapplingHooks = {name = "Grappling Hooks", guid = "b5db9f", ptCost = 3,varName="grapplingHooks"}
    cardInfo.upgradeCards.environmentalGear = {name = "Environmental Gear", guid = "bg5db9f", ptCost = 3,varName="environmentalGear"}
    cardInfo.upgradeCards.emergencyStims = {name = "Emergency Stims", guid = "bgg5db9f", ptCost = 12,varName="emergencyStims"}
    cardInfo.upgradeCards.reconIntel = {name = "Recon Intel", guid = "bgg5gdb9f", ptCost = 2,varName="reconIntel"}
    cardInfo.upgradeCards.personalCombatShield = {name = "Personal Combat Shield", guid = "bgg5gdgb9f", ptCost = 10,varName="personalCombatShield"}
    cardInfo.upgradeCards.electroGrapplingLine = {name = "Electro Grappling Line", guid = "bggg5gdgb9f", ptCost = 5,varName="electroGrapplingLine"}
    cardInfo.upgradeCards.electrobinoculars = {name = "Electrobinoculars", guid = "bgggg5gdgb9f", ptCost = 8,varName="electrobinoculars"}

    -- grenade
    cardInfo.upgradeCards.concussionGrenades = {name = "Concussion Grenades", guid = "2089d0", ptCost = 5,varName="concussionGrenades"}
    cardInfo.upgradeCards.impactGrenades = {name = "Impact Grenades", guid = "2g089d0", ptCost = 5,varName="impactGrenades"}
    cardInfo.upgradeCards.fragmentationGrenades = {name = "Fragmentation Grenades", guid = "2g089gd0", ptCost = 5,varName="fragmentationGrenades"}
    cardInfo.upgradeCards.smokeGrenades = {name = "Smoke Grenades", guid = "2g0g89gd0", ptCost = 6,varName="smokeGrenades"}

    -- comms
    cardInfo.upgradeCards.commsJammer = {name =  "Comms Jammer", guid = "10f887", ptCost = 5,varName="commsJammer"}
    cardInfo.upgradeCards.longRangeComlink = {name =  "Long-Range Comlink", guid = "489490", ptCost = 5,varName="longRangeComlink"}
    cardInfo.upgradeCards.hqUplink = {name =  "HQ Uplink", guid = "48g9490", ptCost = 10,varName="hqUplink"}
    cardInfo.upgradeCards.commsRelay = {name =  "Comms Relay", guid = "48g9g490", ptCost = 5,varName="commsRelay"}
    cardInfo.upgradeCards.linkedTargetingArray = {name =  "Linked Targeting Array", guid = "4g8g9g490", ptCost = 5,varName="linkedTargetingArray"}
    cardInfo.upgradeCards.integratedCommsAntenna = {name =  "Integrated Comms Antenna", guid = "4gg3g490", ptCost = 3,varName="integratedCommsAntenna"}

    -- generators
    cardInfo.upgradeCards.barrageGenerator = {name =  "Barrage Generator", guid = "1g0f887", ptCost = 7,varName="barrageGenerator"}
    cardInfo.upgradeCards.overchargedGenerator = {name =  "Overcharged Generator", guid = "489g490", ptCost = 7,varName="overchargedGenerator"}

    -- hardpoint
    cardInfo.upgradeCards.rotaryBlaster = {name =  "AT-RT Rotary Blaster", guid = "a48d05", ptCost = 20,varName="rotaryBlaster"}
    cardInfo.upgradeCards.laserCannon = {name =  "AT-RT Laser Cannon", guid = "731f40", ptCost = 20,varName="laserCannon"}
    cardInfo.upgradeCards.flamethrower = {name =  "AT-RT Flamethrower", guid = "a30f08", ptCost = 20,varName="flamethrower"}
    cardInfo.upgradeCards.ax108GroundBuzzer = {name = 'Ax-108 "Ground Buzzer"', guid = "a30f5408", ptCost = 10,varName="ax108GroundBuzzer"}
    cardInfo.upgradeCards.powerHarpoon = {name =  "Mo/Dk Power Harpoon", guid = "a30fgr084", ptCost = 3,varName="powerHarpoon"}
    cardInfo.upgradeCards.atstMortarLauncher = {name =  "AT-ST Mortar Launcher", guid = "a30fv084", ptCost = 10,varName="atstMortarLauncher"}
    cardInfo.upgradeCards.twinLightBlasterCannon = {name =  "88 Twin Light Blaster Cannon", guid = "a3f0f084", ptCost = 20,varName="twinLightBlasterCannon"}
    cardInfo.upgradeCards.dw3ConcussionGrenadeLauncher = {name =  "DW-3 Concussion Grenade Launcher", guid = "a30gf084", ptCost = 15,varName="dw3ConcussionGrenadeLauncher"}

    cardInfo.upgradeCards.m45IonBlaster = {name =  "M-45 Ion Blaster", guid = "ag05", ptCost = 38,varName="m45IonBlaster"}
    cardInfo.upgradeCards.markIIMediumBlaster = {name =  "Mark II Medium Blaster", guid = "731g0", ptCost = 34,varName="markIIMediumBlaster"}
    cardInfo.upgradeCards.rt97CRiflePintle = {name =  "RT-97C Rifle Pintle", guid = "ag08", ptCost = 14,varName="rt97CRiflePintle"}
    cardInfo.upgradeCards.dlt19RiflePintle = {name = 'DLT-19 Rifle Pintle', guid = "a3gg", ptCost = 18,varName="dlt19RiflePintle"}

    -- CREW
    cardInfo.upgradeCards.a300RifleGunner = {name =  "A-300 Rifle Gunner", guid = "ag0ggg", ptCost = 9,varName="a300RifleGunner"}
    cardInfo.upgradeCards.rps6RocketGunner = {name = 'RPS-6 Rocket Gunner', guid = "a3ggasfgfg", ptCost = 36,varName="rps6RocketGunner"}
    cardInfo.upgradeCards.barcRPS6Gunner = {name = 'BARC RPS-6 Gunner', guid = "a3ggasgfgfg", ptCost = 24,varName="barcRPS6Gunner"}
    cardInfo.upgradeCards.barcTwinLaserGunner = {name = 'BARC Twin Laser Gunner', guid = "a3gggasfgfg", ptCost = 18,varName="barcTwinLaserGunner"}
    cardInfo.upgradeCards.barcIonGunner = {name = 'BARC Ion Gunner', guid = "a3ggagsfgfg", ptCost = 28,varName="barcIonGunner"}

    -- heavy
    cardInfo.upgradeCards.z6Trooper = {name = "Z-6 Trooper", guid = "6d0dc1", ptCost = 22, miniGUID = "81cbcb", miniInfo = miniInfo.z6Trooper,varName="z6Trooper"}
    cardInfo.upgradeCards.hh12Stormtrooper = {name = "HH-12 Stormtrooper", guid = "f811e0", ptCost = 26, miniGUID = "896f11", miniInfo = miniInfo.hh12Stormtrooper,varName="hh12Stormtrooper"}
    cardInfo.upgradeCards.mpl57IonTrooper = {name = "MPL-57 Ion Trooper", guid = "158270", ptCost = 24, miniInfo = miniInfo.mpl57IonTrooper,varName="mpl57IonTrooper"}
    cardInfo.upgradeCards.dlt19Stormtrooper = {name = "DLT-19 Stormtrooper", guid = "d8965a", ptCost = 24, miniGUID = "1d1re16", miniInfo = miniInfo.dlt19Stormtrooper,varName="dlt19Stormtrooper"}
    cardInfo.upgradeCards.t7IonSnowtrooper = {name = "T-7 Ion Snowtrooper", guid = "d896g5a", ptCost = 26, miniGUID = "1dg1fe16", miniInfo = miniInfo.t7IonSnowtrooper,varName="t7IonSnowtrooper"}
    cardInfo.upgradeCards.flametrooper = {name = "Flametrooper", guid = "d896gg5a", ptCost = 20, miniGUID = "1dg1fge16", miniInfo = miniInfo.flametrooper, varName="flametrooper"}
    cardInfo.upgradeCards.scatterGunTrooper = {name = "Scatter Gun Trooper", guid = "d8e9g6g5a", ptCost = 23, miniGUID = "1dgg1e16", miniInfo = miniInfo.scatterGunTrooper,varName="scatterGunTrooper"}
    cardInfo.upgradeCards.mpl57BarrageTrooper = {name = "MPL-57 Barrage Trooper", guid = "d8e9gg6g5a", ptCost = 25, miniGUID = "1dggg1e16", miniInfo = miniInfo.mpl57BarrageTrooper,varName="mpl57BarrageTrooper"}
    cardInfo.upgradeCards.electrostaffGuard = {name = "Electrostaff Guard", guid = "d8e9gg6gg5a", ptCost = 25, miniGUID = "1dgggg1e16", miniInfo = miniInfo.electrostaffGuard,varName="electrostaffGuard"}
    cardInfo.upgradeCards.dh447Sniper = {name = "DH-447 Sniper", guid = "d8e9ggg6gg5a", ptCost = 28, miniGUID = "1dggggg1e16", miniInfo = miniInfo.dh447Sniper,varName="dh447Sniper"}
    cardInfo.upgradeCards.protonChargeSaboteur = {name = "Proton Charge Saboteur", guid = "d8e9gggg6gg5a", ptCost = 26, miniGUID = "1dgggggg1e16", miniInfo = miniInfo.protonChargeSaboteur,varName="protonChargeSaboteur"}
    cardInfo.upgradeCards.bowcasterWookiee = {name = "Bowcaster Wookiee", guid = "d8e9ggggg6gg5a", ptCost = 35, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.bowcasterWookiee,varName="bowcasterWookiee"}
    cardInfo.upgradeCards.dh447SniperLeader = {name = "DH-447 Sniper", guid = "d8e9ggg6gg5a", ptCost = 28, miniGUID = "1dggggg1e16", miniInfo = miniInfo.dh447SniperLeader,varName="dh447SniperLeader"}
    cardInfo.upgradeCards.protonChargeSaboteurLeader = {name = "Proton Charge Saboteur", guid = "d8e9gggg6gg5a", ptCost = 26, miniGUID = "1dgggggg1e16", miniInfo = miniInfo.protonChargeSaboteurLeader,varName="protonChargeSaboteurLeader"}
    cardInfo.upgradeCards.dlt19xSniper = {name = "DLT-19x Sniper", guid = "d8e9gggg6gg5a", ptCost = 28, miniGUID = "1dgggggg1e16", miniInfo = miniInfo.dlt19xSniper,varName="dlt19xSniper"}
    cardInfo.upgradeCards.sonicChargeSaboteurLeader = {name = "Sonic Charge Saboteur", guid = "d8egg9gggg6gg5a", ptCost = 26, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.sonicChargeSaboteurLeader,varName="sonicChargeSaboteurLeader"}
    cardInfo.upgradeCards.dlt19xSniperLeader = {name = "DLT-19x Sniper", guid = "d8e9ggggg6gg5a", ptCost = 28, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.dlt19xSniperLeader,varName="dlt19xSniperLeader"}
    cardInfo.upgradeCards.sonicChargeSaboteur = {name = "Sonic Charge Saboteur", guid = "d8eggg9gggg6gg5a", ptCost = 26, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.sonicChargeSaboteur,varName="sonicChargeSaboteur"}

    cardInfo.upgradeCards.b2HATrooper = {name = "B2-HA Trooper", guid = "d8lug5a", ptCost = 32, miniGUID = "1dgmh6e16", miniInfo = miniInfo.b2HATrooper,varName="b2HATrooper"}
    cardInfo.upgradeCards.b2ACMTrooper = {name = "B2-ACM Trooper", guid = "d8egkiy6gg5a", ptCost = 26, miniGUID = "1dgjfgguk6", miniInfo = miniInfo.b2ACMTrooper,varName="b2ACMTrooper"}


    cardInfo.upgradeCards.pao = {name = "Pao", guid = "d8e9ggd5a", ptCost = 22, miniGUID = "gadfr", miniInfo = miniInfo.pao,varName="pao"}
    cardInfo.upgradeCards.bistan = {name = "Bistan", guid = "dgfsgd5a", ptCost = 32, miniGUID = "ggfr", miniInfo = miniInfo.bistan,varName="bistan"}

    cardInfo.upgradeCards.dtf16 = {name = "DT-F16", guid = "dghff5a", ptCost = 22, miniGUID = "gghgfgfar", miniInfo = miniInfo.dtf16,varName="dtf16"}
    cardInfo.upgradeCards.dlt19DTrooper = {name = "DLT-19D Trooper", guid = "dghgff5a", ptCost = 34, miniGUID = "gghggfgfar", miniInfo = miniInfo.dlt19DTrooper,varName="dlt19DTrooper"}

    cardInfo.upgradeCards.cm093Trooper = {name = "CM-0/93 Trooper", guid = "dgghff5a", ptCost = 26, miniGUID = "gghggfgfar", miniInfo = miniInfo.cm093Trooper,varName="cm093Trooper"}
    cardInfo.upgradeCards.t21BTrooper = {name = "T-21B Trooper", guid = "dggghff5a", ptCost = 32, miniGUID = "gggghggfgfar", miniInfo = miniInfo.t21BTrooper,varName="t21BTrooper"}

    cardInfo.upgradeCards.z6PhaseITrooper = {name = "Z-6 Phase I Trooper", guid = "dhgf5a", ptCost = 25, miniGUID = "gghtvgfgfar", miniInfo = miniInfo.z6PhaseITrooper,varName="z6PhaseITrooper"}
    cardInfo.upgradeCards.dc15PhaseITrooper  = {name = "DC-15 Phase I Trooper", guid = "d3hff5a", ptCost = 30, miniGUID = "g42r", miniInfo = miniInfo.dc15PhaseITrooper, varName="dc15PhaseITrooper"}
    cardInfo.upgradeCards.e60RB1Trooper = {name = "E-60R B1 Trooper", guid = "4f5a", ptCost = 20, miniGUID = "4fgfar", miniInfo = miniInfo.e60RB1Trooper,varName="e60RB1Trooper"}
    cardInfo.upgradeCards.e5CB1Trooper = {name = "E-5C B1 Trooper", guid = "d4hff5a", ptCost = 18, miniGUID = "g4gfar", miniInfo = miniInfo.e5CB1Trooper,varName="e5CB1Trooper"}


    -- trooper
    cardInfo.upgradeCards.rebelTrooper = {name =  "Rebel Trooper", guid = "2048e9", ptCost = 10, miniInfo = miniInfo.rebelTrooper4,varName="rebelTrooper"}
    cardInfo.upgradeCards.fleetTrooper = {name =  "Fleet Trooper", guid = "20g48e9", ptCost = 11, miniInfo = miniInfo.fleetTroopers4,varName="fleetTrooper"}
    cardInfo.upgradeCards.stormtrooper = {name =  "Stormtrooper", guid = "d7d8b7", ptCost = 11, miniInfo = miniInfo.stormtrooper4,varName="stormtrooper"}
    cardInfo.upgradeCards.snowtrooper = {name =  "Snowtrooper", guid = "d7dg8gb7", ptCost = 12, miniInfo = miniInfo.snowtrooper4,varName="snowtrooper"}
    cardInfo.upgradeCards.rebelOfficer = {name = "Rebel Officer", guid = "d8e9gggggg6gg5a", ptCost = 19, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.rebelOfficerLeader,varName="rebelOfficer"}
    cardInfo.upgradeCards.imperialOfficer = {name = "Imperial Officer", guid = "d8e9ggggggg6gg5a", ptCost = 20, miniGUID = "1dggggggggg1e16", miniInfo = miniInfo.imperialOfficerLeader,varName="imperialOfficer"}

    cardInfo.upgradeCards.medicalDroid21B = {name =  "2-1B Medical Droid", guid = "20458e9", ptCost = 18, miniInfo = miniInfo.medicalDroid21B,varName="medicalDroid21B"}
    cardInfo.upgradeCards.r4AstromechDroid = {name =  "R4 Astromech Droid", guid = "20g458e9", ptCost = 9, miniInfo = miniInfo.r4AstromechDroid,varName="r4AstromechDroid"}

    cardInfo.upgradeCards.r5AstromechDroid = {name =  "R5 Astromech Droid", guid = "20458ge9", ptCost = 8, miniInfo = miniInfo.r5AstromechDroid,varName="r5AstromechDroid"}
    cardInfo.upgradeCards.fx9MedicalDroid = {name =  "FX-9 Medical Droid", guid = "2g045g8e9", ptCost = 19, miniInfo = miniInfo.fx9MedicalDroid,varName="fx9MedicalDroid"}

    cardInfo.upgradeCards.imperialCommsTechnician = {name =  "Imperial Comms Technician", guid = "2g0g45g8e9", ptCost = 10, miniInfo = miniInfo.imperialCommsTechnician,varName="imperialCommsTechnician"}
    cardInfo.upgradeCards.rebelCommsTechnician = {name =  "Rebel Comms Technician", guid = "2gg0g4g5g8e9", ptCost = 9, miniInfo = miniInfo.rebelCommsTechnician,varName="rebelCommsTechnician"}

    cardInfo.upgradeCards.rebelVeteran = {name =  "Rebel Veteran", guid = "2gg0gg4g5g8e9", ptCost = 12, miniInfo = miniInfo.rebelVeterans4,varName="rebelVeteran"}
    cardInfo.upgradeCards.shoretrooper = {name =  "Shoretrooper", guid = "2gg0gg4gg5g8e9", ptCost = 13, miniInfo = miniInfo.shoretroopers4,varName="shoretrooper"}

    cardInfo.upgradeCards.b2SuperBattleDroid = {name =  "B2 Super Battle Droid", guid = "2440gg4g5g8e9", ptCost = 16, miniInfo = miniInfo.b2SuperBattleDroid3,varName="b2SuperBattleDroid"}
    cardInfo.upgradeCards.phaseIICloneTrooper = {name =  "Phase II Clone Trooper", guid = "2gg3g5g8e9", ptCost = 15, miniInfo = miniInfo.phaseIICloneTrooper4,varName="phaseIICloneTrooper"}
    cardInfo.upgradeCards.phaseICloneTrooper = {name =  "Phase I Clone Trooper", guid = "235g8e9", ptCost = 13, miniInfo = miniInfo.phaseICloneTrooper4,varName="phaseICloneTrooper"}
    cardInfo.upgradeCards.b1BattleDroid = {name =  "B1 Battle Droid", guid = "2g45gg5g8e9", ptCost = 6, miniInfo = miniInfo.b1BattleDroid6,varName="b1BattleDroid"}


    -- Pilot
    cardInfo.upgradeCards.wedgeAntilles = {name =  "Wedge Antilles", guid = "d7d8gb7", ptCost = 5,varName="wedgeAntilles"}
    cardInfo.upgradeCards.generalWeiss = {name =  "General Weiss", guid = "d7dg8gb7", ptCost = 10,varName="generalWeiss"}
    cardInfo.upgradeCards.firstSergeantArbmarb = {name =  "First Sergeant Arbmarb", guid = "dg7d8gb7", ptCost = 5,varName="firstSergeantArbmarb"}
    cardInfo.upgradeCards.ryderAzadi = {name =  "Ryder Azadi", guid = "d7gdgg8gb7", ptCost = 5,varName="ryderAzadi"}
    cardInfo.upgradeCards.imperialHammersEliteArmorPilot = {name =  "Imperial Hammers Elite Armor Pilot", guid = "d7g8gb7", ptCost = 10,varName="imperialHammersEliteArmorPilot"}
    cardInfo.upgradeCards.outerRimSpeederJockey = {name =  "Outer Rim Speeder Jockey", guid = "dgfg8gb7", ptCost = 10,varName="outerRimSpeederJockey"}
    cardInfo.upgradeCards.aaylaSecura = {name =  "Aayla Secura", guid = "d48gb7", ptCost = 5,varName="aaylaSecura"}
    cardInfo.upgradeCards.tSeriesTacticalDroidPilot = {name =  "T-Series Tactical Droid Pilot", guid = "458gb7", ptCost = 5,varName="tSeriesTacticalDroidPilot"}

    -- leadership
    cardInfo.upgradeCards.commandingPresence = {name =  "Commanding Presence", guid = "a30fg", ptCost = 5,varName="commandingPresence"}
    cardInfo.upgradeCards.esteemedLeader = {name = "Esteemed Leader", guid = "ag30fg", ptCost = 5,varName="esteemedLeader"}
    cardInfo.upgradeCards.improvisedOrders = {name = "Improvised Orders", guid = "agg30fg", ptCost = 10,varName="improvisedOrders"}
    cardInfo.upgradeCards.strictOrders = {name = "Strict Orders", guid = "agg3g0fg", ptCost = 5,varName="strictOrders"}
    cardInfo.upgradeCards.aggressiveTactics = {name = "Aggressive Tactics", guid = "gressivetr", ptCost = 10,varName = "aggressiveTactics"}

    -- tactics
    cardInfo.upgradeCards.duckAndCover = {name = "Duck and Cover", guid = "ag3g0fg", ptCost = 4, varName = "duckAndCover"}
    cardInfo.upgradeCards.hunter = {name = "Hunter", guid = "ag3gg0fg", ptCost = 6, varName = "hunter"}
    cardInfo.upgradeCards.tenacity = {name = "Tenacity", guid = "agg3gg0fg", ptCost = 4, varName = "tenacity"}
    cardInfo.upgradeCards.endurance = {name = "Endurance", guid = "agg3gggg0fg", ptCost = 6, varName = "endurance"}
    cardInfo.upgradeCards.overwatch = {name = "Overwatch", guid = "agg3ggfdfg", ptCost = 4, varName = "overwatch"}
    cardInfo.upgradeCards.offensivePush = {name = "Offensive Push", guid = "ag7kfdfg", ptCost = 4, varName = "offensivePush"}

    -- sidearm
    cardInfo.upgradeCards.a300 = {name = "A-300", guid = "ag3gg0fg", ptCost = 0, varName = "a300"}
    cardInfo.upgradeCards.a180 = {name = "A-180", guid = "aggfg0fg", ptCost = 0, varName = "a180"}
    cardInfo.upgradeCards.e11D = {name = "E-11D", guid = "aggrgg0fg", ptCost = 8, varName = "e11D"}
    cardInfo.upgradeCards.theDarksaber = {name = "The Darksaber", guid = "aghgfg3ggg0fg", ptCost = 25, varName = "theDarksaber"}
    cardInfo.upgradeCards.dt57Annihilator = {name = 'DT-57 "Annihilator"', guid = "agggg0fg", ptCost = 12, varName = "dt57Annihilator"}

    cardInfo.upgradeCards.rt97BlasterRifle = {name = "RT-97 Blaster Rifle", guid = "agg3gg0fg", ptCost = 15, varName = "rt97BlasterRifle"}
    cardInfo.upgradeCards.cr24FlameRifle = {name = "CR-24 Flame Rifle", guid = "aggfggg0fg", ptCost = 20, varName = "cr24FlameRifle"}
    cardInfo.upgradeCards.t21BlasterRifle = {name = "T-21 Blaster Rifle", guid = "aggrggg0fg", ptCost = 10, varName = "t21BlasterRifle"}


      -- upgradeMenu
    cardInfo.upgradeMenu = {}
    -- separatist
    cardInfo.upgradeMenu.separatist = {}
    cardInfo.upgradeMenu.separatist.force = {
        cardInfo.upgradeCards.forcePush,
        cardInfo.upgradeCards.forceReflexes,
        cardInfo.upgradeCards.saberThrow,
        cardInfo.upgradeCards.forceChoke,
        cardInfo.upgradeCards.battleMeditation,
        cardInfo.upgradeCards.anger,
        cardInfo.upgradeCards.fear,
        cardInfo.upgradeCards.forceGuidance
    }
    cardInfo.upgradeMenu.separatist.comms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay,
        cardInfo.upgradeCards.integratedCommsAntenna
    }
    cardInfo.upgradeMenu.separatist.emplacementVehicleComms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay,
        cardInfo.upgradeCards.linkedTargetingArray
    }
    cardInfo.upgradeMenu.separatist.pilot = {
        cardInfo.upgradeCards.tSeriesTacticalDroidPilot
    }
    cardInfo.upgradeMenu.separatist.leadership = {
        cardInfo.upgradeCards.commandingPresence,
        cardInfo.upgradeCards.esteemedLeader,
        cardInfo.upgradeCards.improvisedOrders,
        cardInfo.upgradeCards.strictOrders,
        cardInfo.upgradeCards.aggressiveTactics
    }
    cardInfo.upgradeMenu.separatist.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush
    }
    cardInfo.upgradeMenu.separatist.generalGrievousSideArm = {
        cardInfo.upgradeCards.dt57Annihilator
    }
    cardInfo.upgradeMenu.separatist.b1BattleDroidsTrooper = {
        cardInfo.upgradeCards.b1BattleDroid
    }
    cardInfo.upgradeMenu.separatist.b1BattleDroidsSpecialist = {
        cardInfo.upgradeCards.e60RB1Trooper,
        cardInfo.upgradeCards.e5CB1Trooper
    }
    cardInfo.upgradeMenu.separatist.b1Tech = {
        cardInfo.upgradeCards.electrobinoculars
    }
    cardInfo.upgradeMenu.separatist.b2Trooper = {
        cardInfo.upgradeCards.b2SuperBattleDroid
    }

    -- REPUBLIC
    cardInfo.upgradeMenu.republic = {}
    cardInfo.upgradeMenu.republic.force = {
        cardInfo.upgradeCards.forcePush,
        cardInfo.upgradeCards.forceReflexes,
        cardInfo.upgradeCards.saberThrow,
        cardInfo.upgradeCards.jediMindTrick,
        cardInfo.upgradeCards.battleMeditation,
        cardInfo.upgradeCards.forceGuidance,
        cardInfo.upgradeCards.hope
    }
    cardInfo.upgradeMenu.republic.comms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay
    }
    cardInfo.upgradeMenu.republic.emplacementVehicleComms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay,
        cardInfo.upgradeCards.linkedTargetingArray
    }
    cardInfo.upgradeMenu.republic.tx130Pilot = {
        cardInfo.upgradeCards.aaylaSecura
    }
    cardInfo.upgradeMenu.republic.leadership = {
        cardInfo.upgradeCards.commandingPresence,
        cardInfo.upgradeCards.esteemedLeader,
        cardInfo.upgradeCards.improvisedOrders,
        cardInfo.upgradeCards.strictOrders,
        cardInfo.upgradeCards.aggressiveTactics
    }
    cardInfo.upgradeMenu.republic.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush
    }
    cardInfo.upgradeMenu.republic.phaseICloneTroopersTrooper = {
        cardInfo.upgradeCards.phaseICloneTrooper
    }
    cardInfo.upgradeMenu.republic.phaseICloneTroopersSpecialist = {
        cardInfo.upgradeCards.z6PhaseITrooper,
        cardInfo.upgradeCards.dc15PhaseITrooper
    }
    cardInfo.upgradeMenu.republic.phaseIICloneTroopersTrooper = {
        cardInfo.upgradeCards.phaseIICloneTrooper
    }
    cardInfo.upgradeMenu.republic.barcSpeederCrew = {
        cardInfo.upgradeCards.barcTwinLaserGunner,
        cardInfo.upgradeCards.barcRPS6Gunner,
        cardInfo.upgradeCards.barcIonGunner
    }
    cardInfo.upgradeMenu.republic.grenade = {
        cardInfo.upgradeCards.concussionGrenades,
        cardInfo.upgradeCards.impactGrenades,
        cardInfo.upgradeCards.fragmentationGrenades,
        cardInfo.upgradeCards.smokeGrenades
    }
    cardInfo.upgradeMenu.republic.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars
    }
    -- rebel
    cardInfo.upgradeMenu.rebel = {}
    cardInfo.upgradeMenu.rebel.force = {
        cardInfo.upgradeCards.forcePush,
        cardInfo.upgradeCards.forceReflexes,
        cardInfo.upgradeCards.saberThrow,
        cardInfo.upgradeCards.jediMindTrick,
        cardInfo.upgradeCards.battleMeditation,
        cardInfo.upgradeCards.forceGuidance,
        cardInfo.upgradeCards.hope
    }
    cardInfo.upgradeMenu.rebel.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars
    }
    cardInfo.upgradeMenu.rebel.sabineWrenTech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.personalCombatShield,
        cardInfo.upgradeCards.electroGrapplingLine
    }
    cardInfo.upgradeMenu.rebel.grenade = {
        cardInfo.upgradeCards.concussionGrenades,
        cardInfo.upgradeCards.impactGrenades,
        cardInfo.upgradeCards.fragmentationGrenades,
        cardInfo.upgradeCards.smokeGrenades
    }
    cardInfo.upgradeMenu.rebel.comms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay
    }
    cardInfo.upgradeMenu.rebel.emplacementVehicleComms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay,
        cardInfo.upgradeCards.linkedTargetingArray
    }
    cardInfo.upgradeMenu.rebel.atrtHardPoint = {
        cardInfo.upgradeCards.rotaryBlaster,
        cardInfo.upgradeCards.laserCannon,
        cardInfo.upgradeCards.flamethrower
    }
    cardInfo.upgradeMenu.rebel.airSpeederHardPoint = {
        cardInfo.upgradeCards.ax108GroundBuzzer,
        cardInfo.upgradeCards.powerHarpoon
    }

    cardInfo.upgradeMenu.rebel.landSpeederHardPoint = {
        cardInfo.upgradeCards.m45IonBlaster,
        cardInfo.upgradeCards.markIIMediumBlaster
    }


    cardInfo.upgradeMenu.rebel.rebelTrooperSpecialist = {
        cardInfo.upgradeCards.z6Trooper,
        cardInfo.upgradeCards.mpl57IonTrooper
    }
    cardInfo.upgradeMenu.rebel.pathfindersSpecialist = {
        cardInfo.upgradeCards.pao,
        cardInfo.upgradeCards.bistan
    }

    cardInfo.upgradeMenu.rebel.rebelVeteransSpecialist = {
        cardInfo.upgradeCards.cm093Trooper
    }

    cardInfo.upgradeMenu.rebel.rebelVeteransTrooper = {
        cardInfo.upgradeCards.rebelVeteran,
        cardInfo.upgradeCards.rebelOfficer,
        cardInfo.upgradeCards.medicalDroid21B,
        cardInfo.upgradeCards.r5AstromechDroid,
        cardInfo.upgradeCards.rebelCommsTechnician
    }

    cardInfo.upgradeMenu.rebel.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush
    }
    cardInfo.upgradeMenu.rebel.rebelTrooperTrooper = {
        cardInfo.upgradeCards.rebelTrooper,
        cardInfo.upgradeCards.rebelOfficer,
        cardInfo.upgradeCards.medicalDroid21B,
        cardInfo.upgradeCards.r5AstromechDroid,
        cardInfo.upgradeCards.rebelCommsTechnician
    }
    cardInfo.upgradeMenu.rebel.fleetTroopersSpecialist = {
        cardInfo.upgradeCards.scatterGunTrooper,
        cardInfo.upgradeCards.mpl57BarrageTrooper
    }
    cardInfo.upgradeMenu.rebel.fleetTroopersTrooper = {
        cardInfo.upgradeCards.fleetTrooper,
        cardInfo.upgradeCards.rebelOfficer,
        cardInfo.upgradeCards.medicalDroid21B,
        cardInfo.upgradeCards.r5AstromechDroid,
        cardInfo.upgradeCards.rebelCommsTechnician
    }
    cardInfo.upgradeMenu.rebel.repulsorPilot = {
        cardInfo.upgradeCards.wedgeAntilles,
        cardInfo.upgradeCards.ryderAzadi,
        cardInfo.upgradeCards.outerRimSpeederJockey
    }
    cardInfo.upgradeMenu.rebel.leadership = {
        cardInfo.upgradeCards.commandingPresence,
        cardInfo.upgradeCards.esteemedLeader,
        cardInfo.upgradeCards.improvisedOrders,
        cardInfo.upgradeCards.strictOrders,
        cardInfo.upgradeCards.aggressiveTactics
    }
    cardInfo.upgradeMenu.rebel.generator = {
        cardInfo.upgradeCards.barrageGenerator,
        cardInfo.upgradeCards.overchargedGenerator
    }
    cardInfo.upgradeMenu.rebel.rebelCommandosSpecialist = {
        cardInfo.upgradeCards.dh447Sniper,
        cardInfo.upgradeCards.protonChargeSaboteur
    }
    cardInfo.upgradeMenu.rebel.rebelCommandosSpecialistLeader = {
        cardInfo.upgradeCards.dh447SniperLeader,
        cardInfo.upgradeCards.protonChargeSaboteurLeader
    }
    cardInfo.upgradeMenu.rebel.wookieeWarriorsSpecialist = {
        cardInfo.upgradeCards.bowcasterWookiee
    }
    cardInfo.upgradeMenu.rebel.jynErsoSideArm = {
        cardInfo.upgradeCards.a180
    }

    cardInfo.upgradeMenu.rebel.sabineWrenSideArm = {
        cardInfo.upgradeCards.theDarksaber
    }
    cardInfo.upgradeMenu.rebel.rebelPathfindersSideArm = {
        cardInfo.upgradeCards.a300
    }
    cardInfo.upgradeMenu.rebel.x34LandspeederCrew = {
        cardInfo.upgradeCards.a300RifleGunner,
        cardInfo.upgradeCards.rps6RocketGunner
    }
    -- imperial

    cardInfo.upgradeMenu.imperial = {}
    cardInfo.upgradeMenu.imperial.force = {
        cardInfo.upgradeCards.forcePush,
        cardInfo.upgradeCards.forceReflexes,
        cardInfo.upgradeCards.saberThrow,
        cardInfo.upgradeCards.forceChoke,
        cardInfo.upgradeCards.battleMeditation,
        cardInfo.upgradeCards.anger,
        cardInfo.upgradeCards.fear,
        cardInfo.upgradeCards.forceGuidance
    }
    cardInfo.upgradeMenu.imperial.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars
    }
    cardInfo.upgradeMenu.imperial.grenade = {
        cardInfo.upgradeCards.concussionGrenades,
        cardInfo.upgradeCards.impactGrenades,
        cardInfo.upgradeCards.fragmentationGrenades,
        cardInfo.upgradeCards.smokeGrenades
    }
    cardInfo.upgradeMenu.imperial.comms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay
    }
    cardInfo.upgradeMenu.imperial.emplacementVehicleComms = {
        cardInfo.upgradeCards.commsJammer,
        cardInfo.upgradeCards.longRangeComlink,
        cardInfo.upgradeCards.hqUplink,
        cardInfo.upgradeCards.commsRelay,
        cardInfo.upgradeCards.linkedTargetingArray
    }
    cardInfo.upgradeMenu.imperial.stormtrooperSpecialist = {
        cardInfo.upgradeCards.hh12Stormtrooper,
        cardInfo.upgradeCards.dlt19Stormtrooper
    }
    cardInfo.upgradeMenu.imperial.stormtrooperTrooper = {
        cardInfo.upgradeCards.stormtrooper,
        cardInfo.upgradeCards.imperialOfficer,
        cardInfo.upgradeCards.fx9MedicalDroid,
        cardInfo.upgradeCards.r4AstromechDroid,
        cardInfo.upgradeCards.imperialCommsTechnician
    }
    cardInfo.upgradeMenu.imperial.snowtrooperSpecialist = {
        cardInfo.upgradeCards.t7IonSnowtrooper,
        cardInfo.upgradeCards.flametrooper
    }
    cardInfo.upgradeMenu.imperial.shoretroopersSpecialist = {
        cardInfo.upgradeCards.t21BTrooper
    }
    cardInfo.upgradeMenu.imperial.shoretroopersTrooper = {
        cardInfo.upgradeCards.shoretrooper,
        cardInfo.upgradeCards.imperialOfficer,
        cardInfo.upgradeCards.fx9MedicalDroid,
        cardInfo.upgradeCards.r4AstromechDroid,
        cardInfo.upgradeCards.imperialCommsTechnician
    }
    cardInfo.upgradeMenu.imperial.scoutTroopersSpecialist = {
        cardInfo.upgradeCards.dlt19xSniper,
        cardInfo.upgradeCards.sonicChargeSaboteur
    }
    cardInfo.upgradeMenu.imperial.scoutTroopersSpecialistLeader = {
        cardInfo.upgradeCards.dlt19xSniperLeader,
        cardInfo.upgradeCards.sonicChargeSaboteurLeader
    }
    cardInfo.upgradeMenu.imperial.imperialRoyalGuardsSpecialist = {
        cardInfo.upgradeCards.electrostaffGuard
    }
    cardInfo.upgradeMenu.imperial.snowtrooperTrooper = {
        cardInfo.upgradeCards.snowtrooper,
        cardInfo.upgradeCards.imperialOfficer,
        cardInfo.upgradeCards.r4AstromechDroid,
        cardInfo.upgradeCards.fx9MedicalDroid,
        cardInfo.upgradeCards.imperialCommsTechnician
    }
    cardInfo.upgradeMenu.imperial.leadership = {
        cardInfo.upgradeCards.commandingPresence,
        cardInfo.upgradeCards.esteemedLeader,
        cardInfo.upgradeCards.improvisedOrders,
        cardInfo.upgradeCards.strictOrders,
        cardInfo.upgradeCards.aggressiveTactics
    }
    cardInfo.upgradeMenu.imperial.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush
    }
    cardInfo.upgradeMenu.imperial.groundPilot = {
        cardInfo.upgradeCards.generalWeiss,
        cardInfo.upgradeCards.firstSergeantArbmarb,
        cardInfo.upgradeCards.imperialHammersEliteArmorPilot
    }
    cardInfo.upgradeMenu.imperial.atstHardpoint = {
        cardInfo.upgradeCards.atstMortarLauncher,
        cardInfo.upgradeCards.twinLightBlasterCannon,
        cardInfo.upgradeCards.dw3ConcussionGrenadeLauncher
    }

    cardInfo.upgradeMenu.imperial.tx225Hardpoint = {
        cardInfo.upgradeCards.rt97CRiflePintle,
        cardInfo.upgradeCards.dlt19RiflePintle
    }

    cardInfo.upgradeMenu.imperial.generator = {
        cardInfo.upgradeCards.barrageGenerator,
        cardInfo.upgradeCards.overchargedGenerator
    }
    cardInfo.upgradeMenu.imperial.imperialDeathTroopersSideArm = {
        cardInfo.upgradeCards.e11D
    }
    cardInfo.upgradeMenu.imperial.imperialDeathTroopersSpecialist= {
        cardInfo.upgradeCards.dtf16,
        cardInfo.upgradeCards.dlt19DTrooper
    }

    cardInfo.upgradeMenu.imperial.dewbackRiderSideArm = {
        cardInfo.upgradeCards.rt97BlasterRifle,
        cardInfo.upgradeCards.cr24FlameRifle,
        cardInfo.upgradeCards.t21BlasterRifle
    }


    -- unitCard GUID
    cardInfo.unitCardsGUID = "8e9aea"
    cardInfo.upgradeCardsGUID = "ffc227"

    -- unitCards
    cardInfo.unitCards = {}
    -- Separatist
    cardInfo.unitCards.generalGrievous = {
        guid = "3dgg4f",
        ptCost = 175 , availableUpgrades = {
            cardInfo.upgradeMenu.separatist.leadership,
            cardInfo.upgradeMenu.separatist.leadership,
            cardInfo.upgradeMenu.separatist.tactics,
            cardInfo.upgradeMenu.separatist.generalGrievousSideArm
        },
        miniInfo = {
            miniInfo.generalGrievous
        },
        tokenName = "Separatist Commander Command Token",
        fullName = "General Grievous",
        rank = "Commander"
    }
    cardInfo.unitCards.countDooku = {
        guid = "3dh54f",
        ptCost = 205 , availableUpgrades = {
            cardInfo.upgradeMenu.separatist.force,
            cardInfo.upgradeMenu.separatist.force,
            cardInfo.upgradeMenu.separatist.force,
            cardInfo.upgradeMenu.separatist.leadership
        },
        miniInfo = {
            miniInfo.countDooku
        },
        tokenName = "Separatist Commander Command Token",
        fullName = "Count Dooku",
        rank = "Commander"
    }
    cardInfo.unitCards.b1BattleDroids = {
        guid = "24de",
        ptCost = 36,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.b1BattleDroidsTrooper,
          cardInfo.upgradeMenu.separatist.b1BattleDroidsSpecialist,
          cardInfo.upgradeMenu.separatist.comms,
          cardInfo.upgradeMenu.separatist.b1Tech
        },
        miniInfo = {
            miniInfo.b1BattleDroidLeader,
            miniInfo.b1BattleDroid1,
            miniInfo.b1BattleDroid2,
            miniInfo.b1BattleDroid3,
            miniInfo.b1BattleDroid4,
            miniInfo.b1BattleDroid5
        },
        tokenName = "Separatist Corps Command Token",
        fullName = "B1 Battle Droids",
        rank = "Corps"
    }
    cardInfo.unitCards.b2SuperBattleDroids = {
        guid = "2h6de",
        ptCost = 48,
        availableUpgrades = {
            cardInfo.upgradeMenu.separatist.comms,
            cardInfo.upgradeMenu.separatist.b2Trooper
        },
        miniInfo = {
            miniInfo.b2SuperBattleDroidLeader,
            miniInfo.b2SuperBattleDroid1,
            miniInfo.b2SuperBattleDroid2
        },
        tokenName = "Separatist Corps Command Token",
        fullName = "B2 Super Battle Droids",
        rank = "Corps"
    }
    cardInfo.unitCards.droidekas = {
        guid = "2g4de",
        ptCost = 100,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.droidekaLeader,
            miniInfo.droideka1
        },
        tokenName = "Separatist Support Command Token",
        fullName = "Droidekas",
        rank = "Support"
    }
    cardInfo.unitCards.aatTank = {
        guid = "2g4r4de",
        ptCost = 170,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.pilot,
          cardInfo.upgradeMenu.separatist.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.aatTank
        },
        tokenName = "Separatist Heavy Command Token",
        fullName = "AAT Trade Federation Battle Tank",
        rank = "Heavy"
    }

    -- republic
    cardInfo.unitCards.obiWanKenobi = {
        guid = "3dgggg4f",
        ptCost = 175 , availableUpgrades = {
            cardInfo.upgradeMenu.republic.force,
            cardInfo.upgradeMenu.republic.force,
            cardInfo.upgradeMenu.republic.leadership,
            cardInfo.upgradeMenu.republic.tactics
        },
        miniInfo = {
            miniInfo.obiWanKenobi
        },
        tokenName = "Republic Commander Command Token",
        fullName = "Obi-Wan Kenobi",
        rank = "Commander"
    }
    cardInfo.unitCards.cloneCaptainRex = {
        guid = "3dggj74f",
        ptCost = 90 , availableUpgrades = {
            cardInfo.upgradeMenu.republic.leadership,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.tech,
            cardInfo.upgradeMenu.republic.tech,
            cardInfo.upgradeMenu.republic.grenade
        },
        miniInfo = {
            miniInfo.cloneCaptainRex
        },
        tokenName = "Republic Commander Command Token",
        fullName = "Clone Captain Rex",
        rank = "Commander"
    }
    cardInfo.unitCards.republicR2d2 = {
        guid = "e18gg61",
        ptCost = 35,
        availableUpgrades = {
            cardInfo.upgradeMenu.separatist.comms
        },
        miniInfo = {miniInfo.r2d2},
        tokenName = "Republic Operative Command Token",
        fullName = "R2-D2",
        rank = "Operative"
    }
    cardInfo.unitCards.republicC3po = {
        guid = "e18l9g61",
        ptCost = 15,
        availableUpgrades = {
        },
        miniInfo = {miniInfo.c3po},
        tokenName = "",
        fullName = "C-3PO",
        rank = "Counterpart",
        noToken = true
    }
    cardInfo.unitCards.phaseICloneTroopers = {
        guid = "2443de",
        ptCost = 52,
        availableUpgrades = {
            cardInfo.upgradeMenu.republic.phaseICloneTroopersTrooper,
            cardInfo.upgradeMenu.republic.phaseICloneTroopersSpecialist,
            cardInfo.upgradeMenu.republic.tech,
            cardInfo.upgradeMenu.republic.grenade
        },
        miniInfo = {
            miniInfo.phaseICloneTrooperLeader,
            miniInfo.phaseICloneTrooper1,
            miniInfo.phaseICloneTrooper2,
            miniInfo.phaseICloneTrooper3
        },
        tokenName = "Republic Corps Command Token",
        fullName = "Phase I Clone Troopers",
        rank = "Corps"
    }
    cardInfo.unitCards.phaseIICloneTroopers = {
        guid = "244g4de",
        ptCost = 60,
        availableUpgrades = {
            cardInfo.upgradeMenu.republic.phaseIICloneTroopersTrooper,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.tech,
            cardInfo.upgradeMenu.republic.grenade
        },
        miniInfo = {
            miniInfo.phaseIICloneTrooperLeader,
            miniInfo.phaseIICloneTrooper1,
            miniInfo.phaseIICloneTrooper2,
            miniInfo.phaseIICloneTrooper3
        },
        tokenName = "Republic Corps Command Token",
        fullName = "Phase II Clone Troopers",
        rank = "Corps"
    }
    cardInfo.unitCards.barcSpeeder = {
        guid = "2g424de",
        ptCost = 75,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.emplacementVehicleComms,
          cardInfo.upgradeMenu.republic.barcSpeederCrew
        },
        miniInfo = {
            miniInfo.barcSpeeder
        },
        tokenName = "Republic Support Command Token",
        fullName = "BARC Speeder",
        rank = "Support"
    }
    cardInfo.unitCards.saberTank = {
        guid = "2g4r4de",
        ptCost = 170,
        availableUpgrades = {
            cardInfo.upgradeMenu.republic.tx130Pilot,
            cardInfo.upgradeMenu.separatist.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.saberTank
        },
        tokenName = "Republic Heavy Command Token",
        fullName = "TX-130 Saber-Class Fighter Tank",
        rank = "Heavy"
    }


    -- REBEL
    cardInfo.unitCards.lukeSkywalker = {
        guid = "3dc70f",
        ptCost = 160 , availableUpgrades = {
            cardInfo.upgradeMenu.rebel.force,
            cardInfo.upgradeMenu.rebel.force,
            cardInfo.upgradeMenu.rebel.tech
        },
        miniInfo = {
            miniInfo.lukeSkywalker
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Luke Skywalker",
        rank = "Commander"
    }
    cardInfo.unitCards.lukeSkywalkerJediKnight = {
        guid = "3dc7405f",
        ptCost = 200 , availableUpgrades = {
            cardInfo.upgradeMenu.rebel.force,
            cardInfo.upgradeMenu.rebel.force,
            cardInfo.upgradeMenu.rebel.force,
            cardInfo.upgradeMenu.rebel.tactics
        },
        miniInfo = {
            miniInfo.lukeSkywalkerJediKnight
        },
        tokenName = "Rebel Operative Command Token",
        fullName = "Luke Skywalker Jedi Knight",
        rank = "Operative"
    }
    cardInfo.unitCards.leiaOrgana = {
        guid = "3dggcd70f",
        ptCost = 90 , availableUpgrades = {
            cardInfo.upgradeMenu.rebel.leadership,
            cardInfo.upgradeMenu.rebel.leadership,
            cardInfo.upgradeMenu.rebel.tech
        },
        miniInfo = {
            miniInfo.leiaOrgana
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Leia Organa",
        rank = "Commander"
    }
    cardInfo.unitCards.hanSolo = {
        guid = "3dggc7g0f",
        ptCost = 120 , availableUpgrades = {
            cardInfo.upgradeMenu.rebel.leadership,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech
        },
        miniInfo = {
            miniInfo.hanSolo
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Han Solo",
        rank = "Commander"
    }
    cardInfo.unitCards.jynErso = {
        guid = "3dggcggg7g0f",
        ptCost = 110 , availableUpgrades = {
            cardInfo.upgradeMenu.rebel.leadership,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.jynErsoSideArm
        },
        miniInfo = {
            miniInfo.jynErso
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Jyn Erso",
        rank = "Commander"
    }
    cardInfo.unitCards.rebelOfficer = {
        guid = "3dggcg7g0f",
        ptCost = 50 , availableUpgrades = {
            cardInfo.upgradeMenu.rebel.leadership,
            cardInfo.upgradeMenu.rebel.tech
        },
        miniInfo = {
            miniInfo.rebelOfficer
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Rebel Officer",
        rank = "Commander"
    }
    cardInfo.unitCards.chewbacca = {
        guid = "e12cgg8777g61",
        ptCost = 95,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech
        },
        miniInfo = {miniInfo.chewbacca},
        tokenName = "Rebel Operative Command Token",
        fullName = "Chewbacca",
        rank = "Operative"
    }
    cardInfo.unitCards.sabineWren = {
        guid = "e12cgg75gg61",
        ptCost = 125,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.sabineWrenTech,
            cardInfo.upgradeMenu.rebel.sabineWrenTech,
            cardInfo.upgradeMenu.rebel.sabineWrenSideArm
        },
        miniInfo = {miniInfo.sabineWren},
        tokenName = "Rebel Operative Command Token",
        fullName = "Sabine Wren",
        rank = "Operative"
    }
    cardInfo.unitCards.r2d2 = {
        guid = "e18gg61",
        ptCost = 35,
        availableUpgrades = {
            cardInfo.upgradeMenu.separatist.comms
        },
        miniInfo = {miniInfo.r2d2},
        tokenName = "Rebel Operative Command Token",
        fullName = "R2-D2",
        rank = "Operative"
    }
    cardInfo.unitCards.c3po = {
        guid = "e186g4g61",
        ptCost = 15,
        availableUpgrades = {
        },
        miniInfo = {miniInfo.c3po},
        tokenName = "",
        fullName = "C-3PO",
        rank = "Counterpart",
        noToken = true
    }
    cardInfo.unitCards.rebelTrooper = {
        guid = "2972de",
        ptCost = 40,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.rebelTrooperTrooper,
            cardInfo.upgradeMenu.rebel.rebelTrooperSpecialist,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.comms
        },
        miniInfo = {
            miniInfo.rebelTrooperLeader,
            miniInfo.rebelTrooper1,
            miniInfo.rebelTrooper2,
            miniInfo.rebelTrooper3
        },
        tokenName = "Rebel Corps Command Token",
        fullName = "Rebel Troopers",
        rank = "Corps"
    }
    cardInfo.unitCards.fleetTroopers = {
        guid = "2972gde",
        ptCost = 44,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.fleetTroopersTrooper,
            cardInfo.upgradeMenu.rebel.fleetTroopersSpecialist,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.comms
        },
        miniInfo = {
            miniInfo.fleetTroopersLeader,
            miniInfo.fleetTroopers1,
            miniInfo.fleetTroopers2,
            miniInfo.fleetTroopers3
        },
        tokenName = "Rebel Corps Command Token",
        fullName = "Fleet Troopers",
        rank = "Corps"
    }
    cardInfo.unitCards.rebelVeterans = {
        guid = "2g972de",
        ptCost = 48,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.rebelVeteransTrooper,
            cardInfo.upgradeMenu.rebel.rebelVeteransSpecialist,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.comms
        },
        miniInfo = {
            miniInfo.rebelVeteransLeader,
            miniInfo.rebelVeterans1,
            miniInfo.rebelVeterans2,
            miniInfo.rebelVeterans3
        },
        tokenName = "Rebel Corps Command Token",
        fullName = "Rebel Veterans",
        rank = "Corps"
    }
    cardInfo.unitCards.markIIMediumBlasterTrooper = {
        guid = "2g9gg72de",
        ptCost = 38,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.markIIMediumBlasterTrooper
        },
        tokenName = "Rebel Corps Command Token",
        fullName = "Mark II Medium Blaster Trooper",
        rank = "Corps"
    }
    cardInfo.unitCards.rebelCommandos = {
        guid = "2g97g2ggde",
        ptCost = 60,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.comms,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.rebelCommandosSpecialist
        },
        miniInfo = {
            miniInfo.rebelCommandosLeader,
            miniInfo.rebelCommandos1,
            miniInfo.rebelCommandos2,
            miniInfo.rebelCommandos3
        },
        tokenName = "Rebel Special Forces Command Token",
        fullName = "Rebel Commandos",
        rank = "Special Forces"
    }
    cardInfo.unitCards.rebelCommandosStrikeTeam = {
        guid = "2g972ggggde",
        ptCost = 20,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.comms,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.rebelCommandosSpecialistLeader
        },
        miniInfo = {
            miniInfo.rebelCommandos4
        },
        tokenName = "Rebel Special Forces Command Token",
        fullName = "Rebel Commandos Strike Team",
        rank = "Special Forces"
    }
    cardInfo.unitCards.wookieeWarriors = {
        guid = "2hg9g72ggde",
        ptCost = 75,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.wookieeWarriorsSpecialist,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade
        },
        miniInfo = {
            miniInfo.wookieeWarriorsLeader,
            miniInfo.wookieeWarriors1,
            miniInfo.wookieeWarriors2
        },
        tokenName = "Rebel Special Forces Command Token",
        fullName = "Wookiee Warriors",
        rank = "Special Forces"
    }
    cardInfo.unitCards.rebelPathfinders = {
        guid = "2hg9g72gggggde",
        ptCost = 68,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.comms,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.rebelPathfindersSideArm,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.pathfindersSpecialist
        },
        miniInfo = {
            miniInfo.rebelPathfindersLeader,
            miniInfo.rebelPathfinders1,
            miniInfo.rebelPathfinders2,
            miniInfo.rebelPathfinders3
        },
        tokenName = "Rebel Special Forces Command Token",
        fullName = "Rebel Pathfinders",
        rank = "Special Forces"
    }
    cardInfo.unitCards.atrt = {
        guid = "5365a3",
        ptCost = 55,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.atrtHardPoint,
            cardInfo.upgradeMenu.rebel.emplacementVehicleComms
        },
        miniInfo = {miniInfo.atrt},
        tokenName = "Rebel Support Command Token",
        fullName = "AT-RT",
        rank = "Support"
    }
    cardInfo.unitCards.fdLaserCannonTeam = {
        guid = "536gg5a3",
        ptCost = 70,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.emplacementVehicleComms,
            cardInfo.upgradeMenu.rebel.generator
        },
        miniInfo = {miniInfo.fdLaserCannonTeam},
        tokenName = "Rebel Support Command Token",
        fullName = "1.4 FD Laser Cannon Team",
        rank = "Support"
    }
    cardInfo.unitCards.tauntaunRiders = {
        guid = "5365ga3",
        ptCost = 90,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.comms
        },
        miniInfo = {miniInfo.tauntaunRidersLeader,miniInfo.tauntaunRiders1},
        tokenName = "Rebel Support Command Token",
        fullName = "Tauntaun Riders",
        rank = "Support"
    }
    cardInfo.unitCards.airSpeeder = {
        guid = "9ee47a",
        ptCost = 140,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.repulsorPilot,
            cardInfo.upgradeMenu.rebel.airSpeederHardPoint,
            cardInfo.upgradeMenu.rebel.emplacementVehicleComms,
        },
        miniInfo = {miniInfo.airSpeeder},
        tokenName = "Rebel Heavy Command Token",
        fullName = "T-47 Airspeeder",
        rank = "Heavy"
    }
    cardInfo.unitCards.x34Landspeeder = {
        guid = "9eegg47a",
        ptCost = 75,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.repulsorPilot,
            cardInfo.upgradeMenu.rebel.emplacementVehicleComms,
            cardInfo.upgradeMenu.rebel.x34LandspeederCrew,
            cardInfo.upgradeMenu.rebel.x34LandspeederCrew,
            cardInfo.upgradeMenu.rebel.landSpeederHardPoint
        },
        miniInfo = {miniInfo.x34Landspeeder},
        tokenName = "Rebel Heavy Command Token",
        fullName = "X-34 Landspeeder",
        rank = "Heavy"
    }

    -- IMPERIAL
    cardInfo.unitCards.darthVader = {
        guid = "e12c61",
        ptCost = 190,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.force
        },
        miniInfo = {miniInfo.darthVader},
        tokenName = "Imperial Commander Command Token",
        fullName = "Darth Vader",
        rank = "Commander"
    }
    cardInfo.unitCards.darthVaderTheEmperorsApprentice = {
        guid = "e124g4c61",
        ptCost = 170,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.tactics
        },
        miniInfo = {miniInfo.darthVaderTheEmperorsApprentice},
        tokenName = "Imperial Operative Command Token",
        fullName = "Darth Vader The Emperors Apprentice",
        rank = "Operative"
    }
    cardInfo.unitCards.generalVeers = {
        guid = "e12cg61",
        ptCost = 80,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.leadership,
            cardInfo.upgradeMenu.imperial.leadership,
            cardInfo.upgradeMenu.imperial.tech
        },
        miniInfo = {miniInfo.generalVeers},
        tokenName = "Imperial Commander Command Token",
        fullName = "General Veers",
        rank = "Commander"
    }
    cardInfo.unitCards.emperorPalpatine = {
        guid = "e1g2cg61",
        ptCost = 210,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.force,
            cardInfo.upgradeMenu.imperial.leadership
        },
        miniInfo = {miniInfo.emperorPalpatine},
        tokenName = "Imperial Commander Command Token",
        fullName = "Emperor Palpatine",
        rank = "Commander"
    }
    cardInfo.unitCards.directorOrsonKrennic = {
        guid = "e1g2cgg61",
        ptCost = 90,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.leadership,
            cardInfo.upgradeMenu.imperial.leadership,
            cardInfo.upgradeMenu.imperial.tech
        },
        miniInfo = {miniInfo.directorOrsonKrennic},
        tokenName = "Imperial Commander Command Token",
        fullName = "Director Orson Krennic",
        rank = "Commander"
    }
    cardInfo.unitCards.imperialOfficer = {
        guid = "e1g2cggg61",
        ptCost = 50,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.leadership,
            cardInfo.upgradeMenu.imperial.tech
        },
        miniInfo = {miniInfo.imperialOfficer},
        tokenName = "Imperial Commander Command Token",
        fullName = "Imperial Officer",
        rank = "Commander"
    }
    cardInfo.unitCards.bobaFett = {
        guid = "e12cgg61",
        ptCost = 140,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.tech
        },
        miniInfo = {miniInfo.bobaFett},
        tokenName = "Imperial Operative Command Token",
        fullName = "Boba Fett",
        rank = "Operative"
    }
    cardInfo.unitCards.bossk = {
        guid = "e12gcgg6g1",
        ptCost = 115,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tech
        },
        miniInfo = {miniInfo.bossk},
        tokenName = "Imperial Operative Command Token",
        fullName = "Bossk",
        rank = "Operative"
    }
    cardInfo.unitCards.stormtrooper = {
        guid = "6b166a",
        ptCost = 44,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.stormtrooperTrooper,
            cardInfo.upgradeMenu.imperial.stormtrooperSpecialist,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.comms
        },
        miniInfo = {
            miniInfo.stormtrooperLeader, miniInfo.stormtrooper1, miniInfo.stormtrooper2, miniInfo.stormtrooper3
        },
        tokenName = "Imperial Corps Command Token",
        fullName = "Stormtroopers",
        rank = "Corps"
    }
    cardInfo.unitCards.snowtrooper = {
        guid = "6b16g6a",
        ptCost = 48,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.snowtrooperTrooper,
            cardInfo.upgradeMenu.imperial.snowtrooperSpecialist,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.comms
        },
        miniInfo = {
            miniInfo.snowtrooperLeader, miniInfo.snowtrooper1, miniInfo.snowtrooper2, miniInfo.snowtrooper3
        },
        tokenName = "Imperial Corps Command Token",
        fullName = "Snowtroopers",
        rank = "Corps"
    }
    cardInfo.unitCards.shoretroopers = {
        guid = "6b1gg6g6a",
        ptCost = 52,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.shoretroopersTrooper,
            cardInfo.upgradeMenu.imperial.shoretroopersSpecialist,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.comms
        },
        miniInfo = {
            miniInfo.shoretroopersLeader,
            miniInfo.shoretroopers1,
            miniInfo.shoretroopers2,
            miniInfo.shoretroopers3
        },
        tokenName = "Imperial Corps Command Token",
        fullName = "Shoretroopers",
        rank = "Corps"
    }
    cardInfo.unitCards.df90MortarTrooper = {
        guid = "6b1ggg6g6a",
        ptCost = 36,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.df90MortarTrooper
        },
        tokenName = "Imperial Corps Command Token",
        fullName = "DF-90 Mortar Trooper",
        rank = "Corps"
    }
    cardInfo.unitCards.scoutTroopers = {
        guid = "2ghh972ggde",
        ptCost = 60,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.comms,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.scoutTroopersSpecialist
        },
        miniInfo = {
            miniInfo.scoutTroopersLeader,
            miniInfo.scoutTroopers1,
            miniInfo.scoutTroopers2,
            miniInfo.scoutTroopers3
        },
        tokenName = "Imperial Special Forces Command Token",
        fullName = "Scout Troopers",
        rank = "Special Forces"
    }
    cardInfo.unitCards.scoutTroopersStrikeTeam = {
        guid = "2gh9g72gggde",
        ptCost = 20,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.comms,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.scoutTroopersSpecialistLeader
        },
        miniInfo = {
            miniInfo.scoutTroopers3
        },
        tokenName = "Imperial Special Forces Command Token",
        fullName = "Scout Troopers Strike Team",
        rank = "Special Forces"
    }
    cardInfo.unitCards.imperialRoyalGuards = {
        guid = "2gh97g2gggde",
        ptCost = 75,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.imperialRoyalGuardsSpecialist,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade
        },
        miniInfo = {
            miniInfo.imperialRoyalGuardsLeader,
            miniInfo.imperialRoyalGuards1,
            miniInfo.imperialRoyalGuards2
        },
        tokenName = "Imperial Special Forces Command Token",
        fullName = "Imperial Royal Guards",
        rank = "Special Forces"
    }
    cardInfo.unitCards.imperialDeathTroopers = {
        guid = "2gh97g2ggggde",
        ptCost = 76,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.comms,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.imperialDeathTroopersSideArm,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.imperialDeathTroopersSpecialist
        },
        miniInfo = {
            miniInfo.imperialDeathTroopersLeader,
            miniInfo.imperialDeathTroopers1,
            miniInfo.imperialDeathTroopers2,
            miniInfo.imperialDeathTroopers3
        },
        tokenName = "Imperial Special Forces Command Token",
        fullName = "Imperial Death Troopers",
        rank = "Special Forces"
    }
    cardInfo.unitCards.speederBike = {
        guid = "b87e92",
        ptCost = 75,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.speederBikeLeader, miniInfo.speederBike
        },
        tokenName = "Imperial Support Command Token",
        fullName = "74-Z Speeder Bikes",
        rank = "Support"
    }
    cardInfo.unitCards.eWebHeavyBlasterTeam = {
        guid = "bg87e9g2",
        ptCost = 55,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.emplacementVehicleComms,
            cardInfo.upgradeMenu.imperial.generator
        },
        miniInfo = {
            miniInfo.eWebHeavyBlasterTeam
        },
        tokenName = "Imperial Support Command Token",
        fullName = "E-Web Heavy Blaster Team",
        rank = "Support"
    }
    cardInfo.unitCards.dewbackRider = {
        guid = "bg87e9gg2",
        ptCost = 90,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.comms,
            cardInfo.upgradeMenu.imperial.dewbackRiderSideArm
        },
        miniInfo = {
            miniInfo.dewbackRider
        },
        tokenName = "Imperial Support Command Token",
        fullName = "Dewback Rider",
        rank = "Support"
    }
    cardInfo.unitCards.atst = {
        guid = "12b447",
        ptCost = 170,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.groundPilot,
            cardInfo.upgradeMenu.imperial.emplacementVehicleComms,
            cardInfo.upgradeMenu.imperial.atstHardpoint,
            cardInfo.upgradeMenu.imperial.atstHardpoint,
            cardInfo.upgradeMenu.imperial.atstHardpoint

        },
        miniInfo = {
            miniInfo.atst
        },
        tokenName = "Imperial Heavy Command Token",
        fullName = "AT-ST",
        rank = "Heavy"
    }
    cardInfo.unitCards.tx225 = {
        guid = "12b4gg47",
        ptCost = 155,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.groundPilot,
            cardInfo.upgradeMenu.imperial.emplacementVehicleComms,
            cardInfo.upgradeMenu.imperial.tx225Hardpoint
        },
        miniInfo = {
            miniInfo.tx225
        },
        tokenName = "Imperial Heavy Command Token",
        fullName = "TX-225 GAVw Occupier",
        rank = "Heavy"
    }

    --dieRollerInfo.diePos[] = {q = , c = }

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

    commandTokenData.red = {}
    commandTokenData.red.imperialCommander = "http://cloud-3.steamusercontent.com/ugc/785234540537257865/567C32F753BF0F90826183C9FA0FA1442818236B/"
    commandTokenData.red.imperialOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537258128/CAE6EF6D62DD9DB8C9B51572EF3AE273AF6B060D/"
    commandTokenData.red.imperialCore = "http://cloud-3.steamusercontent.com/ugc/785234540537258234/1900F64D5E016B1E3D486ED4E04434CE49DEF2A0/"
    commandTokenData.red.imperialSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537258351/C7B65FD5F16CD9ADA68BB56EC82DD758A416D4AA/"
    commandTokenData.red.imperialSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537258487/A9659A60582D71A930940EB58E665BBF5CAA0FBD/"
    commandTokenData.red.imperialHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537258659/0587E8DD11995ED96EDD205532ECA63EBEF66756/"

    commandTokenData.red.rebelCommander = "http://cloud-3.steamusercontent.com/ugc/786359883314446623/2CB59936B5D3A430C6C4F065A471CAF11F6D4ADD/"
    commandTokenData.red.rebelOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537258815/5CB640797C7ADE51D3CB1683B2DEA05B7D50477C/"
    commandTokenData.red.rebelCore = "http://cloud-3.steamusercontent.com/ugc/785234540537258957/4604772D735B9375B31EBBF6F67990C7E139FCE7/"
    commandTokenData.red.rebelSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537259072/EE69F2C0E4CD8894B4AC536C4857B58CC56B4C62/"
    commandTokenData.red.rebelSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537259206/2DF78788B4E11707D5E84153C2570570A8956658/"
    commandTokenData.red.rebelHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537259441/0113878C48E4F0383281EC92D25B6ABC3C727E48/"

    commandTokenData.red.separatistCommander = "http://cloud-3.steamusercontent.com/ugc/785234540537257865/567C32F753BF0F90826183C9FA0FA1442818236B/"
    commandTokenData.red.separatistOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537258128/CAE6EF6D62DD9DB8C9B51572EF3AE273AF6B060D/"
    commandTokenData.red.separatistCore = "http://cloud-3.steamusercontent.com/ugc/785234540537258234/1900F64D5E016B1E3D486ED4E04434CE49DEF2A0/"
    commandTokenData.red.separatistSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537258351/C7B65FD5F16CD9ADA68BB56EC82DD758A416D4AA/"
    commandTokenData.red.separatistSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537258487/A9659A60582D71A930940EB58E665BBF5CAA0FBD/"
    commandTokenData.red.separatistHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537258659/0587E8DD11995ED96EDD205532ECA63EBEF66756/"

    commandTokenData.red.republicCommander = "http://cloud-3.steamusercontent.com/ugc/786359883314446623/2CB59936B5D3A430C6C4F065A471CAF11F6D4ADD/"
    commandTokenData.red.republicOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537258815/5CB640797C7ADE51D3CB1683B2DEA05B7D50477C/"
    commandTokenData.red.republicCore = "http://cloud-3.steamusercontent.com/ugc/785234540537258957/4604772D735B9375B31EBBF6F67990C7E139FCE7/"
    commandTokenData.red.republicSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537259072/EE69F2C0E4CD8894B4AC536C4857B58CC56B4C62/"
    commandTokenData.red.republicSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537259206/2DF78788B4E11707D5E84153C2570570A8956658/"
    commandTokenData.red.republicHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537259441/0113878C48E4F0383281EC92D25B6ABC3C727E48/"

    commandTokenData.blue = {}
    commandTokenData.blue.imperialCommander = "http://cloud-3.steamusercontent.com/ugc/786359883314446728/D84677D2392728794EE10B473413B9590D0F41D4/"
    commandTokenData.blue.imperialOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537257249/2CC320C098752EDF380FD7681B9AB3F3E64F29C3/"
    commandTokenData.blue.imperialCore = "http://cloud-3.steamusercontent.com/ugc/785234540537257382/7C27C82C633C71E6A1337AAD6734108B3164A7C2/"
    commandTokenData.blue.imperialSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537257506/028F6B15528723606C1FB0DAFBFE4C4820B8169F/"
    commandTokenData.blue.imperialSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537257620/0DA38421478BA47CD873BDB52C089D92022B07EC/"
    commandTokenData.blue.imperialHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537257723/BF0A191767BFDF1238B7E51208F2A4ECABD540FB/"

    commandTokenData.blue.rebelCommander = "http://cloud-3.steamusercontent.com/ugc/785234540537256154/C18E1869413105754D5E82EB4ADE5187D623E83D/"
    commandTokenData.blue.rebelOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537256443/2BB4CE950D5EC9192DA15B9CB2138C796769037B/"
    commandTokenData.blue.rebelCore = "http://cloud-3.steamusercontent.com/ugc/785234540537256613/5BA013615EDA2587191570DF3CE52B710F02E087/"
    commandTokenData.blue.rebelSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537256812/5D14E707F02DDD128091B0FE655E7731FC09E6D9/"
    commandTokenData.blue.rebelSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537256946/A04364601E83E62FA88AD7B5336C8E5330975B77/"
    commandTokenData.blue.rebelHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537257076/9051972F9C208620CFEBB6550A13A0C2AF273823/"

    commandTokenData.blue.separatistCommander = "http://cloud-3.steamusercontent.com/ugc/786359883314446728/D84677D2392728794EE10B473413B9590D0F41D4/"
    commandTokenData.blue.separatistOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537257249/2CC320C098752EDF380FD7681B9AB3F3E64F29C3/"
    commandTokenData.blue.separatistCore = "http://cloud-3.steamusercontent.com/ugc/785234540537257382/7C27C82C633C71E6A1337AAD6734108B3164A7C2/"
    commandTokenData.blue.separatistSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537257506/028F6B15528723606C1FB0DAFBFE4C4820B8169F/"
    commandTokenData.blue.separatistSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537257620/0DA38421478BA47CD873BDB52C089D92022B07EC/"
    commandTokenData.blue.separatistHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537257723/BF0A191767BFDF1238B7E51208F2A4ECABD540FB/"

    commandTokenData.blue.republicCommander = "http://cloud-3.steamusercontent.com/ugc/785234540537256154/C18E1869413105754D5E82EB4ADE5187D623E83D/"
    commandTokenData.blue.republicOperative = "http://cloud-3.steamusercontent.com/ugc/785234540537256443/2BB4CE950D5EC9192DA15B9CB2138C796769037B/"
    commandTokenData.blue.republicCore = "http://cloud-3.steamusercontent.com/ugc/785234540537256613/5BA013615EDA2587191570DF3CE52B710F02E087/"
    commandTokenData.blue.republicSpecialForces = "http://cloud-3.steamusercontent.com/ugc/785234540537256812/5D14E707F02DDD128091B0FE655E7731FC09E6D9/"
    commandTokenData.blue.republicSupport = "http://cloud-3.steamusercontent.com/ugc/785234540537256946/A04364601E83E62FA88AD7B5336C8E5330975B77/"
    commandTokenData.blue.republicHeavy = "http://cloud-3.steamusercontent.com/ugc/785234540537257076/9051972F9C208620CFEBB6550A13A0C2AF273823/"

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

    timerCounter = timerCounter + 1


    Timer.create({
        identifier     = "standbyTokens"..math.random()..timerCounter,
        function_name  = "standbyTokens",
        function_owner = self,
        delay          = 5
    })

    updateModLoad()



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

function updateModLoad()
    WebRequest.get("https://tierenswlegion.firebaseio.com/modLoadCount.json", self, "readCallback")
end

function readCallback(req)
    if req.is_done and not req.is_error then
        local currNum = tonumber(req.text)
        if currNum then
            WebRequest.put('https://tierenswlegion.firebaseio.com/modLoadCount.json', tostring(currNum+1), self, 'dummy')
        end
    end
end


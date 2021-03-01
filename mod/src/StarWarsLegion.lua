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

    clockGUIDs = {}
    clockGUIDs.blue = "4f823a"
    clockGUIDs.red = "6ce1bb"
    initChessClocks(clockGUIDs)

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
    unitInfo = {}

    unitInfo.rebelTrooper = {}
    unitInfo.rebelTrooper.commandType = "rebelCore"
    unitInfo.rebelTrooper.baseSize = "small"
    unitInfo.rebelTrooper.selectedSpeed = 2
    unitInfo.rebelTrooper.buttonHeight = 2

    unitInfo.rebelOfficer = {}
    unitInfo.rebelOfficer.commandType = "rebelCommander"
    unitInfo.rebelOfficer.baseSize = "small"
    unitInfo.rebelOfficer.selectedSpeed = 2
    unitInfo.rebelOfficer.buttonHeight = 2

    unitInfo.rebelCommandos = {}
    unitInfo.rebelCommandos.commandType = "rebelSpecialForces"
    unitInfo.rebelCommandos.baseSize = "small"
    unitInfo.rebelCommandos.selectedSpeed = 2
    unitInfo.rebelCommandos.buttonHeight = 2

    unitInfo.rebelCommandosStrikeTeam = {}
    unitInfo.rebelCommandosStrikeTeam.commandType = "rebelSpecialForces"
    unitInfo.rebelCommandosStrikeTeam.baseSize = "small"
    unitInfo.rebelCommandosStrikeTeam.selectedSpeed = 2
    unitInfo.rebelCommandosStrikeTeam.buttonHeight = 2

    unitInfo.rebelPathfinders = {}
    unitInfo.rebelPathfinders.commandType = "rebelSpecialForces"
    unitInfo.rebelPathfinders.baseSize = "small"
    unitInfo.rebelPathfinders.selectedSpeed = 2
    unitInfo.rebelPathfinders.buttonHeight = 2

    unitInfo.wookieeWarriors = {}
    unitInfo.wookieeWarriors.commandType = "rebelSpecialForces"
    unitInfo.wookieeWarriors.baseSize = "small"
    unitInfo.wookieeWarriors.selectedSpeed = 2
    unitInfo.wookieeWarriors.buttonHeight = 2

    unitInfo.mandalorianResistance = {}
    unitInfo.mandalorianResistance.commandType = "rebelSpecialForces"
    unitInfo.mandalorianResistance.baseSize = "small"
    unitInfo.mandalorianResistance.selectedSpeed = 3
    unitInfo.mandalorianResistance.buttonHeight = 2

    unitInfo.clanWren = {}
    unitInfo.clanWren.commandType = "rebelSpecialForces"
    unitInfo.clanWren.baseSize = "small"
    unitInfo.clanWren.selectedSpeed = 3
    unitInfo.clanWren.buttonHeight = 2

    unitInfo.fleetTroopers = {}
    unitInfo.fleetTroopers.commandType = "rebelCore"
    unitInfo.fleetTroopers.baseSize = "small"
    unitInfo.fleetTroopers.selectedSpeed = 2
    unitInfo.fleetTroopers.buttonHeight = 2

    unitInfo.rebelVeterans = {}
    unitInfo.rebelVeterans.commandType = "rebelCore"
    unitInfo.rebelVeterans.baseSize = "small"
    unitInfo.rebelVeterans.selectedSpeed = 2
    unitInfo.rebelVeterans.buttonHeight = 2

    unitInfo.markIIMediumBlasterTrooper = {}
    unitInfo.markIIMediumBlasterTrooper.commandType = "rebelCore"
    unitInfo.markIIMediumBlasterTrooper.baseSize = "medium"
    unitInfo.markIIMediumBlasterTrooper.selectedSpeed = 1
    unitInfo.markIIMediumBlasterTrooper.buttonHeight = 2

    unitInfo.lukeSkywalker = {}
    unitInfo.lukeSkywalker.commandType = "rebelCommander"
    unitInfo.lukeSkywalker.baseSize = "small"
    unitInfo.lukeSkywalker.selectedSpeed = 2
    unitInfo.lukeSkywalker.buttonHeight = 2

    unitInfo.lukeSkywalkerJediKnight = {}
    unitInfo.lukeSkywalkerJediKnight.commandType = "rebelOperative"
    unitInfo.lukeSkywalkerJediKnight.baseSize = "small"
    unitInfo.lukeSkywalkerJediKnight.selectedSpeed = 2
    unitInfo.lukeSkywalkerJediKnight.buttonHeight = 2

    unitInfo.hanSolo = {}
    unitInfo.hanSolo.commandType = "rebelCommander"
    unitInfo.hanSolo.baseSize = "small"
    unitInfo.hanSolo.selectedSpeed = 2
    unitInfo.hanSolo.buttonHeight = 2

    unitInfo.leiaOrgana = {}
    unitInfo.leiaOrgana.commandType = "rebelCommander"
    unitInfo.leiaOrgana.baseSize = "small"
    unitInfo.leiaOrgana.selectedSpeed = 2
    unitInfo.leiaOrgana.buttonHeight = 2

    unitInfo.jynErso = {}
    unitInfo.jynErso.commandType = "rebelCommander"
    unitInfo.jynErso.baseSize = "small"
    unitInfo.jynErso.selectedSpeed = 2
    unitInfo.jynErso.buttonHeight = 2

    unitInfo.cassianAndor = {}
    unitInfo.cassianAndor.commandType = "rebelCommander"
    unitInfo.cassianAndor.baseSize = "small"
    unitInfo.cassianAndor.selectedSpeed = 2
    unitInfo.cassianAndor.buttonHeight = 2

    unitInfo.landoCalrissian = {}
    unitInfo.landoCalrissian.commandType = "rebelCommander"
    unitInfo.landoCalrissian.baseSize = "small"
    unitInfo.landoCalrissian.selectedSpeed = 2
    unitInfo.landoCalrissian.buttonHeight = 2

    unitInfo.chewbacca = {}
    unitInfo.chewbacca.commandType = "rebelOperative"
    unitInfo.chewbacca.baseSize = "small"
    unitInfo.chewbacca.selectedSpeed = 2
    unitInfo.chewbacca.buttonHeight = 2

    unitInfo.c3po = {}
    unitInfo.c3po.commandType = nil
    unitInfo.c3po.baseSize = "small"
    unitInfo.c3po.selectedSpeed = 1
    unitInfo.c3po.buttonHeight = 2
    unitInfo.c3po.noToken = true

    unitInfo.k2so = {}
    unitInfo.k2so.commandType = "rebelOperative"
    unitInfo.k2so.baseSize = "small"
    unitInfo.k2so.selectedSpeed = 2
    unitInfo.k2so.buttonHeight = 2

    unitInfo.r2d2 = {}
    unitInfo.r2d2.commandType = "rebelOperative"
    unitInfo.r2d2.baseSize = "small"
    unitInfo.r2d2.selectedSpeed = 1
    unitInfo.r2d2.buttonHeight = 2

    unitInfo.republicC3po = {}
    unitInfo.republicC3po.commandType = nil
    unitInfo.republicC3po.baseSize = "small"
    unitInfo.republicC3po.selectedSpeed = 1
    unitInfo.republicC3po.buttonHeight = 2
    unitInfo.republicC3po.noToken = true

    unitInfo.republicR2d2 = {}
    unitInfo.republicR2d2.commandType = "republicOperative"
    unitInfo.republicR2d2.baseSize = "small"
    unitInfo.republicR2d2.selectedSpeed = 1
    unitInfo.republicR2d2.buttonHeight = 2

    unitInfo.sabineWren = {}
    unitInfo.sabineWren.commandType = "rebelOperative"
    unitInfo.sabineWren.baseSize = "small"
    unitInfo.sabineWren.selectedSpeed = 3
    unitInfo.sabineWren.buttonHeight = 2

    unitInfo.atrt = {}
    unitInfo.atrt.commandType = "rebelSupport"
    unitInfo.atrt.baseSize = "big"
    unitInfo.atrt.selectedSpeed = 2
    unitInfo.atrt.buttonHeight = 3.3

    unitInfo.tauntaunRiders = {}
    unitInfo.tauntaunRiders.commandType = "rebelSupport"
    unitInfo.tauntaunRiders.baseSize = "medium"
    unitInfo.tauntaunRiders.selectedSpeed = 3
    unitInfo.tauntaunRiders.buttonHeight = 3.3

    unitInfo.fdLaserCannonTeam = {}
    unitInfo.fdLaserCannonTeam.commandType = "rebelSupport"
    unitInfo.fdLaserCannonTeam.baseSize = "huge"
    unitInfo.fdLaserCannonTeam.selectedSpeed = 2
    unitInfo.fdLaserCannonTeam.buttonHeight = 3.1

    unitInfo.x34Landspeeder = {}
    unitInfo.x34Landspeeder.commandType = "rebelHeavy"
    unitInfo.x34Landspeeder.baseSize = "huge"
    unitInfo.x34Landspeeder.selectedSpeed = 2
    unitInfo.x34Landspeeder.buttonHeight = 3.1

    unitInfo.darthVader = {}
    unitInfo.darthVader.commandType = "imperialCommander"
    unitInfo.darthVader.baseSize = "small"
    unitInfo.darthVader.selectedSpeed = 1
    unitInfo.darthVader.buttonHeight = 2

    unitInfo.darthVaderTheEmperorsApprentice = {}
    unitInfo.darthVaderTheEmperorsApprentice.commandType = "imperialOperative"
    unitInfo.darthVaderTheEmperorsApprentice.baseSize = "small"
    unitInfo.darthVaderTheEmperorsApprentice.selectedSpeed = 1
    unitInfo.darthVaderTheEmperorsApprentice.buttonHeight = 2

    unitInfo.generalVeers = {}
    unitInfo.generalVeers.commandType = "imperialCommander"
    unitInfo.generalVeers.baseSize = "small"
    unitInfo.generalVeers.selectedSpeed = 2
    unitInfo.generalVeers.buttonHeight = 2

    unitInfo.emperorPalpatine = {}
    unitInfo.emperorPalpatine.commandType = "imperialCommander"
    unitInfo.emperorPalpatine.baseSize = "small"
    unitInfo.emperorPalpatine.selectedSpeed = 1
    unitInfo.emperorPalpatine.buttonHeight = 2

    unitInfo.directorOrsonKrennic = {}
    unitInfo.directorOrsonKrennic.commandType = "imperialCommander"
    unitInfo.directorOrsonKrennic.baseSize = "small"
    unitInfo.directorOrsonKrennic.selectedSpeed = 2
    unitInfo.directorOrsonKrennic.buttonHeight = 2

    unitInfo.idenVersio = {}
    unitInfo.idenVersio.commandType = "imperialCommander"
    unitInfo.idenVersio.baseSize = "small"
    unitInfo.idenVersio.selectedSpeed = 2
    unitInfo.idenVersio.buttonHeight = 2

    unitInfo.id10 = {}
    unitInfo.id10.commandType = nil
    unitInfo.id10.baseSize = "small"
    unitInfo.id10.selectedSpeed = 1
    unitInfo.id10.buttonHeight = 2
    unitInfo.id10.noToken = true

    unitInfo.imperialOfficer = {}
    unitInfo.imperialOfficer.commandType = "imperialCommander"
    unitInfo.imperialOfficer.baseSize = "small"
    unitInfo.imperialOfficer.selectedSpeed = 2
    unitInfo.imperialOfficer.buttonHeight = 2

    unitInfo.agentKallus = {}
    unitInfo.agentKallus.commandType = "imperialCommander"
    unitInfo.agentKallus.baseSize = "small"
    unitInfo.agentKallus.selectedSpeed = 2
    unitInfo.agentKallus.buttonHeight = 2

    unitInfo.bobaFett = {}
    unitInfo.bobaFett.commandType = "imperialOperative"
    unitInfo.bobaFett.baseSize = "small"
    unitInfo.bobaFett.selectedSpeed = 3
    unitInfo.bobaFett.buttonHeight = 2

    unitInfo.bossk = {}
    unitInfo.bossk.commandType = "imperialOperative"
    unitInfo.bossk.baseSize = "small"
    unitInfo.bossk.selectedSpeed = 2
    unitInfo.bossk.buttonHeight = 2

    unitInfo.stormtrooper = {}
    unitInfo.stormtrooper.commandType = "imperialCore"
    unitInfo.stormtrooper.baseSize = "small"
    unitInfo.stormtrooper.selectedSpeed = 2
    unitInfo.stormtrooper.buttonHeight = 2

    unitInfo.snowtrooper = {}
    unitInfo.snowtrooper.commandType = "imperialCore"
    unitInfo.snowtrooper.baseSize = "small"
    unitInfo.snowtrooper.selectedSpeed = 1
    unitInfo.snowtrooper.buttonHeight = 2

    unitInfo.shoretroopers = {}
    unitInfo.shoretroopers.commandType = "imperialCore"
    unitInfo.shoretroopers.baseSize = "small"
    unitInfo.shoretroopers.selectedSpeed = 2
    unitInfo.shoretroopers.buttonHeight = 2

    unitInfo.df90MortarTrooper = {}
    unitInfo.df90MortarTrooper.commandType = "imperialCore"
    unitInfo.df90MortarTrooper.baseSize = "medium"
    unitInfo.df90MortarTrooper.selectedSpeed = 1
    unitInfo.df90MortarTrooper.buttonHeight = 2

    unitInfo.scoutTroopers = {}
    unitInfo.scoutTroopers.commandType = "imperialSpecialForces"
    unitInfo.scoutTroopers.baseSize = "small"
    unitInfo.scoutTroopers.selectedSpeed = 2
    unitInfo.scoutTroopers.buttonHeight = 2

    unitInfo.scoutTroopersStrikeTeam = {}
    unitInfo.scoutTroopersStrikeTeam.commandType = "imperialSpecialForces"
    unitInfo.scoutTroopersStrikeTeam.baseSize = "small"
    unitInfo.scoutTroopersStrikeTeam.selectedSpeed = 2
    unitInfo.scoutTroopersStrikeTeam.buttonHeight = 2

    unitInfo.imperialDeathTroopers = {}
    unitInfo.imperialDeathTroopers.commandType = "imperialSpecialForces"
    unitInfo.imperialDeathTroopers.baseSize = "small"
    unitInfo.imperialDeathTroopers.selectedSpeed = 2
    unitInfo.imperialDeathTroopers.buttonHeight = 2

    unitInfo.imperialRoyalGuards = {}
    unitInfo.imperialRoyalGuards.commandType = "imperialSpecialForces"
    unitInfo.imperialRoyalGuards.baseSize = "small"
    unitInfo.imperialRoyalGuards.selectedSpeed = 2
    unitInfo.imperialRoyalGuards.buttonHeight = 2

    unitInfo.isf = {}
    unitInfo.isf.commandType = "imperialSpecialForces"
    unitInfo.isf.baseSize = "small"
    unitInfo.isf.selectedSpeed = 2
    unitInfo.isf.buttonHeight = 2

    unitInfo.infernoSquad = {}
    unitInfo.infernoSquad.commandType = "imperialSpecialForces"
    unitInfo.infernoSquad.baseSize = "small"
    unitInfo.infernoSquad.selectedSpeed = 2
    unitInfo.infernoSquad.buttonHeight = 2

    unitInfo.speederBike = {}
    unitInfo.speederBike.commandType = "imperialSupport"
    unitInfo.speederBike.baseSize = "medium"
    unitInfo.speederBike.selectedSpeed = 3
    unitInfo.speederBike.buttonHeight = 2.2

    unitInfo.eWebHeavyBlasterTeam = {}
    unitInfo.eWebHeavyBlasterTeam.commandType = "imperialSupport"
    unitInfo.eWebHeavyBlasterTeam.baseSize = "big"
    unitInfo.eWebHeavyBlasterTeam.selectedSpeed = 1
    unitInfo.eWebHeavyBlasterTeam.buttonHeight = 2

    unitInfo.dewbackRider = {}
    unitInfo.dewbackRider.commandType = "imperialSupport"
    unitInfo.dewbackRider.baseSize = "big"
    unitInfo.dewbackRider.selectedSpeed = 1
    unitInfo.dewbackRider.buttonHeight = 3.3

    unitInfo.atst = {}
    unitInfo.atst.commandType = "imperialHeavy"
    unitInfo.atst.baseSize = "huge"
    unitInfo.atst.selectedSpeed = 2
    unitInfo.atst.buttonHeight = 8.7

    unitInfo.tx225 = {}
    unitInfo.tx225.commandType = "imperialHeavy"
    unitInfo.tx225.baseSize = "long"
    unitInfo.tx225.selectedSpeed = 1
    unitInfo.tx225.buttonHeight = 2.5

    unitInfo.airSpeeder = {}
    unitInfo.airSpeeder.commandType = "rebelHeavy"
    unitInfo.airSpeeder.baseSize = "huge"
    unitInfo.airSpeeder.selectedSpeed = 3
    unitInfo.airSpeeder.buttonHeight = 5.6

    unitInfo.generalGrievous = {}
    unitInfo.generalGrievous.commandType = "separatistCommander"
    unitInfo.generalGrievous.baseSize = "small"
    unitInfo.generalGrievous.selectedSpeed = 2
    unitInfo.generalGrievous.buttonHeight = 2

    unitInfo.countDooku = {}
    unitInfo.countDooku.commandType = "separatistCommander"
    unitInfo.countDooku.baseSize = "small"
    unitInfo.countDooku.selectedSpeed = 2
    unitInfo.countDooku.buttonHeight = 2

    unitInfo.cadBane = {}
    unitInfo.cadBane.commandType = "separatistOperative"
    unitInfo.cadBane.baseSize = "small"
    unitInfo.cadBane.selectedSpeed = 2
    unitInfo.cadBane.buttonHeight = 2

    unitInfo.maul = {}
    unitInfo.maul.commandType = "separatistOperative"
    unitInfo.maul.baseSize = "small"
    unitInfo.maul.selectedSpeed = 2
    unitInfo.maul.buttonHeight = 2

    unitInfo.tSeriesTacticalDroid = {}
    unitInfo.tSeriesTacticalDroid.commandType = "separatistCommander"
    unitInfo.tSeriesTacticalDroid.baseSize = "small"
    unitInfo.tSeriesTacticalDroid.selectedSpeed = 2
    unitInfo.tSeriesTacticalDroid.buttonHeight = 2

    unitInfo.b1BattleDroids = {}
    unitInfo.b1BattleDroids.commandType = "separatistCore"
    unitInfo.b1BattleDroids.baseSize = "small"
    unitInfo.b1BattleDroids.selectedSpeed = 2
    unitInfo.b1BattleDroids.buttonHeight = 2

    unitInfo.b2SuperBattleDroids = {}
    unitInfo.b2SuperBattleDroids.commandType = "separatistCore"
    unitInfo.b2SuperBattleDroids.baseSize = "small"
    unitInfo.b2SuperBattleDroids.selectedSpeed = 2
    unitInfo.b2SuperBattleDroids.buttonHeight = 2

    unitInfo.drk1SithProbeDroids = {}
    unitInfo.drk1SithProbeDroids.commandType = "separatistSpecialForces"
    unitInfo.drk1SithProbeDroids.baseSize = "small"
    unitInfo.drk1SithProbeDroids.selectedSpeed = 2
    unitInfo.drk1SithProbeDroids.buttonHeight = 2

    unitInfo.bxCommandoDroids = {}
    unitInfo.bxCommandoDroids.commandType = "separatistSpecialForces"
    unitInfo.bxCommandoDroids.baseSize = "small"
    unitInfo.bxCommandoDroids.selectedSpeed = 2
    unitInfo.bxCommandoDroids.buttonHeight = 2

    unitInfo.bxCommandoDroidsStrikeTeam = {}
    unitInfo.bxCommandoDroidsStrikeTeam.commandType = "separatistSpecialForces"
    unitInfo.bxCommandoDroidsStrikeTeam.baseSize = "small"
    unitInfo.bxCommandoDroidsStrikeTeam.selectedSpeed = 2
    unitInfo.bxCommandoDroidsStrikeTeam.buttonHeight = 2

    unitInfo.droidekas = {}
    unitInfo.droidekas.commandType = "separatistSupport"
    unitInfo.droidekas.baseSize = "medium"
    unitInfo.droidekas.selectedSpeed = 1
    unitInfo.droidekas.buttonHeight = 2.2

    unitInfo.STAP = {}
    unitInfo.STAP.commandType = "separatistSupport"
    unitInfo.STAP.baseSize = "medium"
    unitInfo.STAP.selectedSpeed = 3
    unitInfo.STAP.buttonHeight = 3

    unitInfo.aatTank = {}
    unitInfo.aatTank.commandType = "separatistHeavy"
    unitInfo.aatTank.baseSize = "epic"
    unitInfo.aatTank.strafeMove = true
    unitInfo.aatTank.selectedSpeed = 1
    unitInfo.aatTank.buttonHeight = 4

    unitInfo.obiWanKenobi = {}
    unitInfo.obiWanKenobi.commandType = "republicCommander"
    unitInfo.obiWanKenobi.baseSize = "small"
    unitInfo.obiWanKenobi.selectedSpeed = 2
    unitInfo.obiWanKenobi.buttonHeight = 2

    unitInfo.cloneCaptainRex = {}
    unitInfo.cloneCaptainRex.commandType = "republicCommander"
    unitInfo.cloneCaptainRex.baseSize = "small"
    unitInfo.cloneCaptainRex.selectedSpeed = 2
    unitInfo.cloneCaptainRex.buttonHeight = 2

    unitInfo.anakinSkywalker = {}
    unitInfo.anakinSkywalker.commandType = "republicCommander"
    unitInfo.anakinSkywalker.baseSize = "small"
    unitInfo.anakinSkywalker.selectedSpeed = 2
    unitInfo.anakinSkywalker.buttonHeight = 2

    unitInfo.padme = {}
    unitInfo.padme.commandType = "republicOperative"
    unitInfo.padme.baseSize = "small"
    unitInfo.padme.selectedSpeed = 2
    unitInfo.padme.buttonHeight = 2

    unitInfo.cloneCommander = {}
    unitInfo.cloneCommander.commandType = "republicCommander"
    unitInfo.cloneCommander.baseSize = "small"
    unitInfo.cloneCommander.selectedSpeed = 2
    unitInfo.cloneCommander.buttonHeight = 2

    unitInfo.phaseICloneTroopers = {}
    unitInfo.phaseICloneTroopers.commandType = "republicCore"
    unitInfo.phaseICloneTroopers.baseSize = "small"
    unitInfo.phaseICloneTroopers.selectedSpeed = 2
    unitInfo.phaseICloneTroopers.buttonHeight = 2

    unitInfo.phaseIICloneTroopers = {}
    unitInfo.phaseIICloneTroopers.commandType = "republicCore"
    unitInfo.phaseIICloneTroopers.baseSize = "small"
    unitInfo.phaseIICloneTroopers.selectedSpeed = 2
    unitInfo.phaseIICloneTroopers.buttonHeight = 2

    unitInfo.arcTroopers = {}
    unitInfo.arcTroopers.commandType = "republicSpecialForces"
    unitInfo.arcTroopers.baseSize = "small"
    unitInfo.arcTroopers.selectedSpeed = 2
    unitInfo.arcTroopers.buttonHeight = 2

    unitInfo.arcTroopersStrikeTeam = {}
    unitInfo.arcTroopersStrikeTeam.commandType = "republicSpecialForces"
    unitInfo.arcTroopersStrikeTeam.baseSize = "small"
    unitInfo.arcTroopersStrikeTeam.selectedSpeed = 2
    unitInfo.arcTroopersStrikeTeam.buttonHeight = 2

    unitInfo.barcSpeeder = {}
    unitInfo.barcSpeeder.commandType = "republicSupport"
    unitInfo.barcSpeeder.baseSize = "big"
    unitInfo.barcSpeeder.selectedSpeed = 3
    unitInfo.barcSpeeder.buttonHeight = 3

    unitInfo.republicATRT = {}
    unitInfo.republicATRT.commandType = "republicSupport"
    unitInfo.republicATRT.baseSize = "big"
    unitInfo.republicATRT.selectedSpeed = 2
    unitInfo.republicATRT.buttonHeight = 3.3

    unitInfo.saberTank = {}
    unitInfo.saberTank.commandType = "republicHeavy"
    unitInfo.saberTank.baseSize = "epic"
    unitInfo.saberTank.strafeMove = true
    unitInfo.saberTank.selectedSpeed = 2
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
    listBuilder.commandCards.idenVersio = {
        varName = "idenVersio",
        cards = {"Pulse Scan", "Concussive Blast", "Tactical Strike"},
        -- Here, versus .id10, because .id10 is a "noToken" and doesn't check cards.
        cards2 = {"Ambush", "Incapacitate", "Assault"}
    }
    listBuilder.commandCards.agentKallus = {
        varName = "agentKallus",
        cards = {"Face Me!", "ISB Investigation", "Ruthless Tactics"}
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
    listBuilder.commandCards.cassianAndor = {
        varName = "cassianAndor",
        cards = {"Crack Shot","Last Stand","Volunteer Mission"}
    }
    listBuilder.commandCards.k2so = {
        varName = "k2so",
        cards = {"Ambush", "Push", "Sacrifice"}
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
        cards = {"Blast Off!", "Impromptu Immolation", "Smoke Screen"}
    }
    listBuilder.commandCards.c3po = {
        varName = "c3po",
        cards = {"Ambush", "Push", "Assault"}
    }
    listBuilder.commandCards.rebelOfficer = {
        varName = "rebelOfficer"
    }
    listBuilder.commandCards.landoCalrissian = {
        varName = "landoCalrissian",
        cards = {"Idiots Array", "Ace Up His Sleeve", "All In"}
    }
    -- SEPARATIST
    listBuilder.commandCards.generalGrievous = {
        varName = "generalGrievous",
        cards = {"Trained in Your Jedi Arts","Supreme Commander","Crush Them!"}
    }
    listBuilder.commandCards.countDooku = {
        varName = "countDooku",
        cards = {"Fear, Suprise, Intimidation","Double the Fall","You Disappoint Me"}
    }
    listBuilder.commandCards.cadBane = {
        varName = "cadBane",
        cards = {"Im Your Worst Nightmare","Im In Control","I Make The Rules Now"}
    }
    listBuilder.commandCards.maul = {
      varName = "maul",
      cards = {"Duel Of The Fates","The Phantom Menace","At Last"}
    }
    listBuilder.commandCards.tSeriesTacticalDroid = {
    varName = "tSeriesTacticalDroid"
    }
    -- REPUBLIC
    listBuilder.commandCards.obiWanKenobi = {
        varName = "obiWanKenobi",
        cards = {"Hello There!","Knowledge and Defense","General Kenobi"}
    }
    listBuilder.commandCards.cloneCaptainRex = {
        varName = "cloneCaptainRex",
        cards = {"Call Me Captain","Take That, Clankers!","Were Not Programmed"}
    }
    listBuilder.commandCards.anakinSkywalker = {
      varName = "anakinSkywalker",
      cards = {"This Is Where The Fun Begins","You Underestimate My Power","Hero Of The Clone Wars"}
  }
    listBuilder.commandCards.republicR2d2 = {
        varName = "republicR2d2",
        cards = {"Blast Off!", "Impromptu Immolation", "Smoke Screen"}
    }
    listBuilder.commandCards.republicC3po = {
        varName = "republicC3po",
        cards = {"Ambush", "Push", "Assault"}
    }
    listBuilder.commandCards.padme = {
        varName = "padme",
        cards = {"Our Fate Is In Your Hands", "Aggressive Negotiations", "Diplomatic Cover"}
    }
    listBuilder.commandCards.cloneCommander = {
        varName = "cloneCommander"
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
    listBuilder.commandCards.neutralSeparatist = {
        varName = "neutralSeparatist",
        cards = {"Mechanized Incursion", "Orbital Strike", "Roger, Roger"}
    }
    listBuilder.commandCards.neutralRepublic = {
        varName = "neutralSeparatist",
        cards = {"Synchronized Offensive", "Air Support", "Attack Of The Clones"}
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
    templateMenu.rebel.commander[5] = {name = "Cassian Andor", varName = "cassianAndor"}
    templateMenu.rebel.commander[6] = {name = "Rebel Officer", varName = "rebelOfficer"}
    templateMenu.rebel.commander[7] = {name = "Lando Calrissian", varName = "landoCalrissian"}

    templateMenu.rebel.operative = {}
    templateMenu.rebel.operative[1] = {name = "Chewbacca", varName = "chewbacca"}
    templateMenu.rebel.operative[2] = {name = "Sabine Wren", varName = "sabineWren"}
    templateMenu.rebel.operative[3] = {name = "Luke Skywalker", varName = "lukeSkywalkerJediKnight"}
    templateMenu.rebel.operative[4] = {name = "R2-D2", varName = "r2d2"}
    templateMenu.rebel.operative[5] = {name = "C-3PO", varName = "c3po"}
    templateMenu.rebel.operative[6] = {name = "K-2SO", varName = "k2so"}

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
    templateMenu.rebel.specialForces[5] = {name = "Mandalorian Resistance", varName = "mandalorianResistance"}
    templateMenu.rebel.specialForces[6] = {name = "Clan Wren", varName = "clanWren"}

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
    templateMenu.imperial.commander[5] = {name = "Iden Versio", varName = "idenVersio"}
    templateMenu.imperial.commander[6] = {name = "Imperial Officer", varName = "imperialOfficer"}
    templateMenu.imperial.commander[7] = {name = "Agent Kallus", varName = "agentKallus"}

    templateMenu.imperial.operative = {}
    templateMenu.imperial.operative[1] = {name = "Boba Fett", varName = "bobaFett"}
    templateMenu.imperial.operative[2] = {name = "Bossk", varName = "bossk"}
    templateMenu.imperial.operative[3] = {name = "Darth Vader", varName = "darthVaderTheEmperorsApprentice"}
    templateMenu.imperial.operative[4] = {name = "ID10 (Iden Versio)", varName = "id10"}

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
    templateMenu.imperial.specialForces[5] = {name = "Imperial Special Forces", varName = "isf"}
    templateMenu.imperial.specialForces[6] = {name = "Inferno Squad", varName = "infernoSquad"}

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
    templateMenu.separatist.commander[3] = {name = "T-Series Tactical Droid", varName = "tSeriesTacticalDroid"}

    templateMenu.separatist.operative = {}
    templateMenu.separatist.operative[1] = {name = "Cad Bane", varName = "cadBane"}
    templateMenu.separatist.operative[2] = {name = "Maul", varName = "maul"}

    templateMenu.separatist.corps = {}
    templateMenu.separatist.corps[1] = {name = "B1 Battle Droids", varName = "b1BattleDroids"}
    templateMenu.separatist.corps[2] = {name = "B2 Super Battle Droids", varName = "b2SuperBattleDroids"}

    templateMenu.separatist.specialForces = {}
    templateMenu.separatist.specialForces[1] = {name = "BX Commando Droids", varName = "bxCommandoDroids"}
    templateMenu.separatist.specialForces[2] = {name = "BX Commando Droids Strike Team", varName = "bxCommandoDroidsStrikeTeam"}
    templateMenu.separatist.specialForces[3] = {name = "DRK-1 Sith Probe Droids", varName = "drk1SithProbeDroids"}

    templateMenu.separatist.support = {}
    templateMenu.separatist.support[1] = {name = "Droidekas", varName = "droidekas"}
    templateMenu.separatist.support[2] = {name = "STAP Riders", varName = "STAP"}

    templateMenu.separatist.heavy = {}
    templateMenu.separatist.heavy[1] = {name = "AAT Trade Federation Battle Tank", varName = "aatTank"}

    templateMenu.republic = {}
    templateMenu.republic.commander = {}
    templateMenu.republic.commander[1] = {name = "Obi-Wan Kenobi", varName = "obiWanKenobi"}
    templateMenu.republic.commander[2] = {name = "Clone Captain Rex", varName = "cloneCaptainRex"}
    templateMenu.republic.commander[3] = {name = "Anakin Skywalker", varName = "anakinSkywalker"}
    templateMenu.republic.commander[4] = {name = "Clone Commander", varName = "cloneCommander"}

    templateMenu.republic.operative = {}
    templateMenu.republic.operative[1] = {name = "R2-D2", varName = "republicR2d2"}
    templateMenu.republic.operative[2] = {name = "C-3PO", varName = "republicC3po"}
    templateMenu.republic.operative[3] = {name = "Padme Amidala", varName = "padme"}

    templateMenu.republic.corps = {}
    templateMenu.republic.corps[1] = {name = "Phase I Clone Troopers", varName = "phaseICloneTroopers"}
    templateMenu.republic.corps[2] = {name = "Phase II Clone Troopers", varName = "phaseIICloneTroopers"}

    templateMenu.republic.specialForces = {}
    templateMenu.republic.specialForces[1] = {name = "ARC Troopers", varName = "arcTroopers"}
    templateMenu.republic.specialForces[2] = {name = "ARC Troopers Strike Team", varName = "arcTroopersStrikeTeam"}

    templateMenu.republic.support = {}
    templateMenu.republic.support[1] = {name = "BARC Speeder", varName = "barcSpeeder"}
    templateMenu.republic.support[2] = {name = "Republic AT-RT", varName = "republicATRT"}

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

    -- q = horizontal offset? c = vertical offset?
    templateMenu.upgradeCardPos = {}
    -- Top Right
    templateMenu.upgradeCardPos[1] = {q = 146.451578117502, c = 2.2437691503361}
    -- Center Left
    templateMenu.upgradeCardPos[2] = {q = -37.790038154384, c = 2.3663051367058}
    -- Center Middle
    templateMenu.upgradeCardPos[3] = {q = -90, c = 1.45}
    -- Center Right
    templateMenu.upgradeCardPos[4] = {q = -142.209961845616, c = 2.3663051367058}
    -- Bottom Left
    templateMenu.upgradeCardPos[5] = {q = -65.897765498839, c = 4.5792248252297}
    -- Bottom Middle
    templateMenu.upgradeCardPos[6] = {q = -90, c = 4.18}
    -- Bottom Right
    templateMenu.upgradeCardPos[7] = {q = -114, c = 4.5792248252297}

    -- mini info
    local _BASE_COLLIDERS = {
      small = "http://cloud-3.steamusercontent.com/ugc/1009315641457429932/1534D6C1AA4F3D5BDA469241B8F0319BE560E7ED/",
      medium = "http://cloud-3.steamusercontent.com/ugc/1009315641457670521/DAD6653F422046BD6BC4360FE18C96927D5F4C44/",
      large = "http://cloud-3.steamusercontent.com/ugc/1009315641457670155/6727179496A9F397E953AAA3268C6CC6444598DF/",
      huge = "http://cloud-3.steamusercontent.com/ugc/1009315641457669798/3B337900892D839BDBC3EBF2A5CC9EC87DDBFED1/",
      epic = "http://cloud-3.steamusercontent.com/ugc/1009315641457669292/A7F6F75580BF1DFAA23E621875A761FB8B9EF2BC/",
      long = "http://cloud-3.steamusercontent.com/ugc/963116666702885485/70F17B3327115A379D06F81C6F47F76470D7B826/"
    }

    miniInfo = {}
    miniInfo.lukeSkywalker = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540537100371/0B15B2810ABEBE5429E4A24852D96BAC2DC28BF7/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540537079134/11A17263AD81DC9D4271B7C6BD809B69141DCB61/",
        name = "Luke Skywalker"
    }
    miniInfo.lukeSkywalkerJediKnight = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/777357228030156264/12F93F60CC26F1FDC2B577D4014787B7CAFBF9A1/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/777357228030156398/F811CAE962A0BFE369544C0A96C251F5BF198B3A/",
        name = "Luke Skywalker Jedi Knight"
    }
    miniInfo.leiaOrgana = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540537137572/2AC01B05AF1576F49C3156EDB614E2C1804C2A42/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540537137853/F8E5FE7B221E9115B36E22C14E5707B7CFA6CFC3/",
        name = "Leia Organa"
    }
    miniInfo.hanSolo = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540669649/C440F429AB1182944D329D0C16C3402DB731CA87/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540669835/B4E395AA781518EAC4FBFFCB27BAA646201F411C/",
        name = "Han Solo"
    }
    miniInfo.jynErso = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475778/55B558E631655D0430BAF76E71C93899AAECA7A1/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305475871/06400240648CC39F933BE504C74DA9BEF4D006C4/",
        name = "Jyn Erso"
    }
    miniInfo.cassianAndor = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/773996263556990389/C38E9CAD7E5BA5496E1A211CA799E9ACBAC51D00/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770611701143191344/5CAA4F0CE9A3FBE89A81560221ADCDDB5A801CC3/",
        name = "Cassian Andor"
    }
    miniInfo.landoCalrissian = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1666859827674318376/E0A03ACDC6D2F607B8CC0C406AE196A9DB5347B7/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1666859827674318640/6674121C184DF4BBD67EAB0DAA75F6B41A93669A/",
        name = "Lando Calrissian"
    }
    miniInfo.k2so = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/773996263557000439/C9EA2A27264C73E42C016FE26E665CBB75F8E7DE/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770611701143471855/26BE70BB475D8B61122C8954CCA2EC79C1ED4C25/",
        name = "K-2SO"
    }
    miniInfo.chewbacca = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540669973/90DD9EA44756CCF9B2473302DC644F3AEEED07B4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670117/5AA04499FC8CC467864F9F335601E6335C03326D/",
        name = "Chewbacca"
    }
    miniInfo.sabineWren = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/948474323838790939/3E9EB4AAF653CD476FF3D90EA82072EDC2D4AC66/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/948474323838791034/38CDAF985C2DC983942183E1DFD3ACBC33D8E40E/",
        name = "Sabine Wren"
    }
    miniInfo.r2d2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806966/EFBA4A71BFE748A2868C14B82DA3A7B0D559874A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/777357228032306302/F5CA6FC54A8625E261F123D73792DE36D74E1686/",
        name = "R2-D2"
    }
    miniInfo.c3po = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456807069/DE7E32B39455DB5111769436FD0C5BFDA3841268/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/777357228032306506/D60CB8A1159723917EF1831D4042318A67458A7A/",
        name = "C-3PO"
    }
    miniInfo.rebelOfficer = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862726770/62FECAB3FED284E098751CC3BBC70C4CFF828A58/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862727097/DE589901F66E4079D82BA2C819672F622A5D7240/",
        name = "Rebel Officer"
    }
    miniInfo.rebelOfficerLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862726770/62FECAB3FED284E098751CC3BBC70C4CFF828A58/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862727097/DE589901F66E4079D82BA2C819672F622A5D7240/",
        name = "Rebel Officer",
        leader = true
    }

    miniInfo.rebelTrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862752262/41BD6AB8B17AB7449226A3D80EF186EB8ABA3952/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862764799/98CBD8B4DD0C08CFA01A8E6C8B5A70A137804EAB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862755846/CD522BCA5D6E918E13A3FF593D7212FF4B0E79CA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862761532/2FB3D83FC2BD077F4ADE619382382B9A59CD0ABE/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        name = "Rebel Trooper"
    }
    miniInfo.rebelTrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862746147/3F3A21962C4AC0DA0445024688BF580A144D3825/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670236/6257E7A3CE86803490A8A0FAC7F81C281D700F52/",
        name = "Rebel Trooper Leader",
        altModelInfo = miniInfo.rebelTrooper4
    }
    miniInfo.z6Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862734756/1F48FA301357905B28DA35A03658DFA39154DBFE/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862736228/22D1A1ACC79493FE82165CC95A5E23170A4FBC5B/",
        name = "Z-6 Trooper"
    }
    miniInfo.mpl57IonTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670338/28625FDF1F56EF08F0DB236C4ECFF67A54083B2B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862750426/2563904D7561144EE85EBCD3E07D68F48D8DD034/",
        name = "MPL-57 Ion Trooper"
    }
    miniInfo.fleetTroopers1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670667/CB316B23D59F28C5EF22E94A43280D49DFFDD6AC/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540671182/A605D9D0DB356DC71473F5C9DF27DE1CADB4F320/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540671278/9B94D359A61113F72EEB0435D70A1291431D737A/",
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670978/0642E99CB4E8CABA1AA10389F2387A1C70D9322D/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopers4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670863/20FE73C6E9F8468BD468C820C88EAB9F697EC33E/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        name = "Fleet Trooper"
    }
    miniInfo.fleetTroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540670464/96FB3825C890968C09B07A2E0E227886D2CC768C/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670556/9B759F6F1A8B7C11AE5F2908208CBA9EF99ECE2C/",
        name = "Fleet Trooper Leader",
        altModelInfo = miniInfo.fleetTroopers4
    }
    miniInfo.scatterGunTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540671094/4A4BCE6286ACB413B661F827BB00B920617F3E91/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540670760/47DF3E87B3F71E8EA42A89ECFE96E4FB3990D7ED/",
        name = "Scatter Gun Trooper"
    }
    miniInfo.mpl57BarrageTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540540671382/63267B140C2A619525B99FD943DF2421F75B9130/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540540671503/D8BCEE815B07EA7074085CF1F43AF8041DEC8981/",
        name = "MPL-57 Barrage Trooper"
    }
    miniInfo.medicalDroid21B = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594268997/6248E4CAF3E978154106E7095E6984DCE6677CCA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594282950/7A9A3E5518394273A507A64CCF7425A2E7EFC29B/",
        name = "2-1B Medical Droid"
    }
    miniInfo.rebelCommsTechnician = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594474909/F8F049D7F88171ADBA83AF3EAF819495053C2873/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594268734/CF3C536F7B068020A99C5E3EE11CA9C54438E250/",
        name = "Rebel Comms Technician"
    }
    miniInfo.r5AstromechDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594428341/4AC5A309D701979A4B3E94725BC1E8745C598BCE/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594267684/F84F03E4A52F50EF5255A464FF85083CF4FB3D26/",
        name = "R5 Astromech Droid"
    }
    miniInfo.rebelTrooperSpecialist = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102173464719285/839B79B3594F31585EB38763EDF43AD32E46F37F/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102173464692456/FD09533718942CE5B08526B2CD1A00D5D38CB734/",
        name = "Rebel Trooper Specialist"
    }
    miniInfo.sx21Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102173464725382/9DADA91B7A5BE8DEEC1BDE838B3140A350D661A4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102173464726852/2ABBCC6938695708489FB87C27C6B7481A1D294A/",
        name = "SX-21 Trooper"
    }
    miniInfo.dlt20ATrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102173464888456/63604C016242E6F545F139BC46515E0A894EC6B2/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102173464889098/17A7BE90F158B80F88518F92EA4D211F16E14003/",
        name = "DLT-20A Trooper"
    }
    miniInfo.rebelTrooperCaptain = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102173464670173/ECC18FB91315A55181F38A6899122E005460C688/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102173464683373/FE0A29CF1A46E7F97FEAE0C9FD665AB192A8D9A8/",
        name = "Rebel Trooper Captain",
        leader = true
    }
    miniInfo.rebelVeteransLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192015/F194EFE217778158ED30DFD40EFC1F70BEC01772/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        name = "Rebel Veterans Leader",
        altModelInfo = miniInfo.rebelVeteransLeader
    }
    miniInfo.rebelVeterans1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192232/D15615AF2A0F4F4887E9BD3DFFA141C8ACCCEC78/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        name = "Rebel Veteran"
    }
    miniInfo.rebelVeterans2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192402/4D1858AA566FEEE91774E40B10C233AAD8C381D5/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        name = "Rebel Veteran"
    }
    miniInfo.rebelVeterans3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192498/BF583EA43B457E816CDE323C172B2F4558B7A8BD/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        name = "Rebel Veteran"
    }
    miniInfo.rebelVeterans4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499192589/466305BFF474DBAB11F58FA13B3F4ACC9BB7127C/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        name = "Rebel Veteran"
    }
    miniInfo.cm093Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687947/DCC60167A78C152DDAE932E699D7C70C5629008B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499192135/526538CE10AC6856578996BE6B8AB7263D32D5C7/",
        name = "CM-0/93 Trooper"
    }
    miniInfo.markIIMediumBlasterTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688462/6B35D0B4E18CB7D0081825BEDC6E6C4AE45AA329/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702688570/1827E8E24FE65F309AF936EF35D07CC2149CD95E/",
        name = "Mark II Medium Blaster Trooper"
    }
    miniInfo.rebelCommandosLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173156/D637683F992DD0C4488252BE266EEEA1F26006B0/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        name = "Rebel Commandos Leader"
    }
    miniInfo.rebelCommandos1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541172497/B3E1593143504101920CC6419BE7C2EAEF52993F/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541188141/6E23E29BB42963B94A0B7DFE01C4C49D776D9657/",
        name = "Rebel Commandos"
    }
    miniInfo.rebelCommandos2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173253/155BAA01BA51A8EB524DD434A3C512D8C0B3A04B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        name = "Rebel Commandos"
    }
    miniInfo.rebelCommandos3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173354/3483C6FB73C66481BC6CCC398BAB8E796F7EC076/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541188141/6E23E29BB42963B94A0B7DFE01C4C49D776D9657/",
        name = "Rebel Commandos"
    }
    miniInfo.rebelCommandos4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173710/DAD1A2BE9F1D9C74C10D975D5AD5FDA05566C100/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541172655/B10522A40482843AF69A3F321BD091B0ECF52C6B/",
        name = "Rebel Commandos"
    }
    miniInfo.dh447Sniper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862776611/B8222AA4A3B680E969DC106C8A281D11845994EB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862776974/21649563BC0CB84E12C0B249C720919F528596D3/",
        name = "DH-447 Sniper"
    }
    miniInfo.dh447SniperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862776611/B8222AA4A3B680E969DC106C8A281D11845994EB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780862776974/21649563BC0CB84E12C0B249C720919F528596D3/",
        name = "DH-447 Sniper",
        leader = true
    }
    miniInfo.protonChargeSaboteur = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173465/8193FD1F0862270CD23BA9243679840BE6324DC6/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541173570/3C100E92F0DEDEF117D3A0392D3271951BC90DD0/",
        name = "Proton Charge Saboteur"
    }
    miniInfo.protonChargeSaboteurLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173465/8193FD1F0862270CD23BA9243679840BE6324DC6/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541173570/3C100E92F0DEDEF117D3A0392D3271951BC90DD0/",
        name = "Proton Charge Saboteur",
        leader = true
    }
    miniInfo.wookieeWarriorsLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541173937/5179F4315AD6B0839454E1934E794A7F006C7813/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541174467/18352D89A219B89F6C869D89B9EDE22822F7F950/",
        name = "Wookiee Warriors Leader"
    }
    miniInfo.wookieeWarriors1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541174158/677BF72C323CFF2314C174393AFA361C398C5519/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541174034/90C4A124BB82CCE0B5E38E13860ED49BB9A4973B/",
        name = "Wookiee Warrior"
    }
    miniInfo.wookieeWarriors2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541174304/9053CDD2798CEA905F8486498D0104B6ACA2F078/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541174467/18352D89A219B89F6C869D89B9EDE22822F7F950/",
        name = "Wookiee Warrior"
    }
    miniInfo.bowcasterWookiee = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541174665/9E1AA98159F76E271185345E9D347D7453C05D4B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541174034/90C4A124BB82CCE0B5E38E13860ED49BB9A4973B/",
        name = "Bowcaster Wookiee"
    }
    miniInfo.rebelPathfindersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475193/3C613417B99B185BBAEC7A4C66AAE10E8FD6F8D5/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        name = "Rebel Pathfinders Leader"
    }
    miniInfo.rebelPathfinders1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475558/EE0863D9DE3C9D35C486B7273E1D555BB1F09566/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        name = "Rebel Pathfinders"
    }
    miniInfo.rebelPathfinders2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475456/26BF332D69FD5B08D677EBDB91948820E03690DB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        name = "Rebel Pathfinders"
    }
    miniInfo.rebelPathfinders3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475667/B5CC42E1CAB9059DEE4B1237222CF0FE3BB6B838/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305475310/FF2A55C2559DA2CA2108EE6D7E5605774EF1B04D/",
        name = "Rebel Pathfinders"
    }
    miniInfo.pao = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/993513208355174746/6F5A50CE6D4E23C6278AE868FD359A49E1C80179/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/993513208355174858/CCC2B3862F1FEB611B03317594F6F0E761750C70/",
        name = "Pao",
        leader = true
    }
    miniInfo.bistan = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/993513208355174951/467D917BF6BCABCC9F6DD17F5DEDB43A11DEA9A7/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/993513208355175183/AD143EC79EC2BA3E7B93B114CC8AFEAAD322D806/",
        name = "Bistan"
    }
    miniInfo.mandalorianResistanceLeader = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696350886421665/441B37D17213CA1B82174A8988ED23AA2D59336E/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696350886421832/BBE3592A7496E444E116271913178A8ED41F5323/",
      name = "Mandalorian Resistance Leader"
    }
    miniInfo.mandalorianResistance1 = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696515357880094/FFFBDA79DE3B6192926EFCDFC257708C2A360562/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696515357880292/78883B5B08CCDC0B7BC4EF36D45DAB06E9057FEB/",
      name = "Mandalorian Resistance"
    }
    miniInfo.mandalorianResistance2 = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696350886396178/07FB37CA0A11552BEF96C3DCA10AF232C65AF7B6/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696350886396372/35E5047903DC30F882B40719809ECF90DBC65A5A/",
      name = "Mandalorian Resistance"
    }
    miniInfo.clanWren1 = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696515357880886/06542D3BD6F03DC43D9E675680F86F2964B210F9/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696515357880292/78883B5B08CCDC0B7BC4EF36D45DAB06E9057FEB/",
      name = "Clan Wren"
    }
    miniInfo.beskadDuelist = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696515357841451/50164A1C84E6D119BC45BDD31C8209ED7D9A0F29/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696515357841757/1DC29C81D9DFCB2FB7D8A3B2EA2F2ABD3F416396/",
      name = "Beskad Duelist"
    }
    miniInfo.ursaWren = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696515357881561/B365369415AE0FB6A96E69817D76D9BAD1366038/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696515357880292/78883B5B08CCDC0B7BC4EF36D45DAB06E9057FEB/",
      name = "Ursa Wren",
      leader = true
    }
    miniInfo.tristanWren = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1021696350886429750/5D62ADB1200B1AD16A0349AF87E757F40E720115/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1021696350886427771/60D6CA1D97D822A2222E4FAF614931265B7B0AF2/",
      name = "Tristan Wren"
    }

    miniInfo.atrt = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541266463/014ECD21C93F864E1C1DFD104A365DFC555EBAF8/",
        collider = _BASE_COLLIDERS.large,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541267239/D9891291A896CC024383C024B20C5ACF87EC8A18/",
        name = "AT-RT"
    }
    miniInfo.tauntaunRidersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499191489/E91DEB380842511B21284A125A505B6C71D18474/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499191676/8E19A176FF0B3D2923F8F3D6DEA80D389F77CB27/",
        name = "Tauntaun Rider Leader"
    }
    miniInfo.tauntaunRiders1= {
        mesh = "http://cloud-3.steamusercontent.com/ugc/788608699499191881/3DBB7DF0943F0D25484DE34581411825BA566F8A/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/788608699499191676/8E19A176FF0B3D2923F8F3D6DEA80D389F77CB27/",
        name = "Tauntaun Rider"
    }
    miniInfo.fdLaserCannonTeam = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541267781/BE163E2112B28E8C7C5E536B037D3115103F9642/",
        collider = _BASE_COLLIDERS.huge,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541269701/797EACA86E0FB799D16DC8FE907A70C4B976C5EE/",
        name = "1.4 FD Laser Cannon Team"
    }
    miniInfo.airSpeeder = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/999141806429331055/047818ABA85804B98787BC67BEF12D24EC8F8ADB/",
        collider = _BASE_COLLIDERS.huge,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541315963/DD72FAD5F49D303A83A4463B0D3796E3A8FD5BE8/",
        name = "T-47 Airspeeder"
    }
    miniInfo.x34Landspeeder = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594267188/9FA2B8A42C94B6E3683F1B753CEBA14FC3258592/",
        collider = _BASE_COLLIDERS.huge,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594267308/582E5F56A65FE6CD486BCBABB510CAE4B4DF6C8C/",
        name = "X-34 Landspeeder"
    }

    miniInfo.darthVader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541323740/BF58AB674CB7D638333F1B04A7C9A5B9D7DBF0E4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541324289/B37D84D512722740E8310629C3E7BFC45AF0FBC9/",
        name = "Darth Vader"
    }
    miniInfo.darthVaderTheEmperorsApprentice = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/777357228030156593/FEBA127ECDF2917EA8F8066BBB10BADA7D365D3E/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541324289/B37D84D512722740E8310629C3E7BFC45AF0FBC9//",
        name = "Darth Vader The Emperors Apprentice"
    }
    miniInfo.generalVeers = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565411/F5F84397A9353DAD3D913F34E49812C1C895DA65/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541565593/F948637FEE70F52681A5A3C49C0E00EF25471AC1/",
        name = "General Veers"
    }
    miniInfo.emperorPalpatine = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565714/71E1936EB657F4BC1074EB740BC9AA0531A130AC/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541565804/0EB3EBFD318678DBE5B7C83B39A31DC8AB3376B6/",
        name = "Emperor Palpatine"
    }
    miniInfo.directorOrsonKrennic = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305476013/77069645EC03E0F1C1DB10C2CE7EA85917E45404/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305476130/772EEBD3EC49A7271C1C7647F817C51ED23DE3B2/",
        name = "Director Orson Krennic"
    }
    miniInfo.idenVersio = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/773996263557021593/68887AFFBF8F1A2472A80F6514CD617A54A1D705/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770611889400014191/9442AAB074AB2204C7A5CD8843037C71CFC44540/",
        name = "Iden Versio"
    }
    miniInfo.id10 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/773996263557020821/1E2319EBFD85D7748450F40689A1315696052EFC/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770611889399999868/37F150131345FF1F47592A96239395A583AAE5EA/",
        name = "ID10"
    }
    miniInfo.agentKallus = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1666859827673303054/77A1D7624FA565991825B19513DBE6B70BD4F93C/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1666859827673291479/CA1D69C65D0F6FD2AE838BFFA3FD85A48CCBFB6C/",
        name = "Agent Kallus"
    }
    miniInfo.imperialOfficer = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565898/F06AB6731446249164D34ACA208E4FAE70C6FE00/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541566011/A7A84EBF79DA5E1D5BCE71E863FC16EC40937F6F/",
        name = "Imperial Officer"
    }
    miniInfo.imperialOfficerLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541565898/F06AB6731446249164D34ACA208E4FAE70C6FE00/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541566011/A7A84EBF79DA5E1D5BCE71E863FC16EC40937F6F/",
        name = "Imperial Officer",
        leader = true
    }
    miniInfo.bobaFett = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541667697/9BC2C54E14EA265620F3D96553274503245D1681/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541669466/60DFE8F3EC756ECE7E5729D3261EF37CACA587C6/",
        name = "bobaFett"
    }
    miniInfo.bossk = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/948474323838791181/6B9D77B77DF8FD7AFA19342AD687F0E15A2E21B7/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/948474323838791276/ABFCDD8C71D484E6B6050080BB80B79D0DE93178/",
        name = "bossk"
    }

    miniInfo.stormtrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711529/FF076CE02269A8505CB8EFC06749196FFD446391/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "Stormtrooper"
    }
    miniInfo.stormtrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711653/C170DF086178164DC66188071D15E9EB36C9A742/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "Stormtrooper"
    }
    miniInfo.stormtrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711874/7E06BF6E8E18DD05BBBF10343614B47B8BEE9948/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "Stormtrooper"
    }
    miniInfo.stormtrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711777/1E415A2A18F2269B0C63E1C2901E5192DCCFE8CB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "Stormtrooper"
    }
    miniInfo.stormtrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711094/1DF94C3CDF022814179AFBA6D7521E6196760949/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "Stormtrooper Leader",
        altModelInfo = miniInfo.stormtrooper4
    }
    miniInfo.stormtrooperSpecialist = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102173464686810/87075FBAEFB7A45C107FEDD41E26ACF148C2592D/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "Stormtrooper Specialist"
    }
    miniInfo.rt97CStormtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766101851242660925/33331F4DA2AE832C568A49BD24B65D4C1462AF27/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766101851242654975/755ABA199B9C3BEEA1F33AF58FD05D378A67C97F/",
        name = "RT-97C Stormtrooper"
    }
    miniInfo.t21Stormtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766101851242554815/68F112DE9EC465DA003ECBD26DE129ADD34CD558/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541711313/BBEF6E9A46755A4159DC6222AF0F8302792585D0/",
        name = "T-21 Stormtrooper"
    }
    miniInfo.stormtrooperCaptain = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766101851242555871/B1A38B82950DD8864591296C730D82E0D66BC985/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102173464650963/1A63FC0E22280AA3B95488A298270874B7B6CDD2/",
        name = "Stormtrooper Captain",
        leader = true
    }

    miniInfo.snowtrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801837/D52F333945BF667A37E06611977C36186CEFC7B6/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        name = "Snowtrooper"
    }
    miniInfo.snowtrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801500/728C586E21D0A4EBD8DE54EEF4E097EFEEECE871/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        name = "Snowtrooper"
    }
    miniInfo.snowtrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801363/743D9E272367ABB1F6296D5EFB6010637C58D5E4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        name = "Snowtrooper"
    }
    miniInfo.snowtrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801717/EDEA1301FC55A6970D5FBCF0A9F10456E4C2EE40/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        name = "Snowtrooper"
    }
    miniInfo.snowtrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801027/2A5DEE9952A0179FC8448FFA52819B387124ACD7/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541801215/595165C57A67BF2BD505BE6F0DF8F11AD4EA55D2/",
        name = "Snowtrooper Leader",
        altModelInfo = miniInfo.snowtrooper4
    }
    miniInfo.dlt19Stormtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766101851242465584/D38BBF10F76882CFF4189AB478E9F0691A22298F/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766101851242466181/BEF69EF45F1CCEF50CDF7B5CC6E1FE6BDC556310/",
        name = "DLT-19 Stormtrooper"
    }
    miniInfo.t7IonSnowtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541802160/69A03779E6B67F6F547C2FBD70ACDFC39281387D/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541802252/037749C730FACCA3361B041BCB3C68E7E19DCDF8/",
        name = "T-7 Ion Snowtrooper"
    }
    miniInfo.flametrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541801931/BDE907EBE0BFC0DC4180C76AFEA3F8667013FF3B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541802054/044AD0961CD1485A61AC3B6CB3669FD8AA5A0FEB/",
        name = "Flametrooper"
    }
    miniInfo.hh12Stormtrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541711981/5D8FB39102FEE64DF1802AA71B66666B4E03717F/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541712102/C37F3281C89F697024FF1F343B06FB5AC828EA10/",
        name = "HH12 Stormtrooper"
    }
    miniInfo.fx9MedicalDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594268065/7B4874981CECB7BB80D5BC54F60F1939B9A9DAB1/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594268174/00246DE6DCE285206330C43B8049B19FFDF5BB41/",
        name = "FX-9 Medical Droid"
    }
    miniInfo.imperialCommsTechnician = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594268417/62CC1D5BCBD1EE294C72781B03AB972B3ED5AD12/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594268526/CA2596C0B2D7DF68D794B2A7880F34B5459F1206/",
        name = "Imperial Comms Technician"
    }
    miniInfo.r4AstromechDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/949599512594492173/DDA1CC3AEEC3D5ADB3B04F35125EE8A6FB7EB93A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/949599512594267919/F44B2C3C810757626C7A4A61DAA7F2BC2BEECFC6/",
        name = "R4 Astromech Droid"
    }
    miniInfo.shoretroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688359/642C317FE5C91E4DCC908FEA02A7ED4000B06A9F/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        name = "Shoretrooper Leader",
        altModelInfo = miniInfo.shoretroopers4
    }
    miniInfo.shoretroopers1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687570/0D2A602282BAACDCE665EF9D1D65CEA413944083/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        name = "Shoretrooper"
    }
    miniInfo.shoretroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688133/C8D721D29D711045A27EEC3868D4B7A111C86F20/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        name = "Shoretrooper"
    }
    miniInfo.shoretroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687282/B02342FDEEE7DDE82DF96EB434B1D033B0A4C899/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        name = "Shoretrooper"
    }
    miniInfo.shoretroopers4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688256/B266465186713632AE14D6B4B473AB4E94814685/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702687694/C12AAE8B7F487BE4C1545E253AB3C026E0426AA1/",
        name = "Shoretrooper"
    }
    miniInfo.t21BTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702687816/8C17AF1D2344B7E8B1C8D34A0F2228E9ADC2FFAA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702687407/D5B685EA41E9C664F2D16381474B5F08DF9CFAE5/",
        name = "T-21B Trooper"
    }
    miniInfo.df90MortarTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688709/1EB7C549A90465F116EF307643FEA1D572CE1008/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702688820/94F2B4954FD378EA9E5544E37B80B8556812F2F2/",
        name = "DF-90 Mortar Trooper"
    }
    miniInfo.scoutTroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911155/36E8C01A67E5E7A4188FC619261E0BAB0DF438C1/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        name = "Scout Trooper Leader"
    }
    miniInfo.scoutTroopers1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911406/C33160A2888F0CE53C9712B1872478E038F9B0EA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        name = "Scout Trooper"
    }
    miniInfo.scoutTroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911585/324AE8DA9D33C07E2FE620FC4B49E2C190F39F5A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        name = "Scout Trooper"
    }
    miniInfo.scoutTroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911689/42647324CBDBF25155498DF1FFDDDC2EC04FB5EC/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/950714557093539603/6584D58DCD3135C901F302599C304E2D7044AD4B/",
        name = "Scout Trooper"
    }
    miniInfo.dlt19xSniper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/770610077943667377/92306C3BFB675310563691C3C582BF5B9FC9ACD4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770610077943667167/66F3188269E49FE5DAD649E771D799F2593263FF/",
        name = "DLT-19x Sniper"
    }
    miniInfo.dlt19xSniperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/770610077943667377/92306C3BFB675310563691C3C582BF5B9FC9ACD4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770610077943667167/66F3188269E49FE5DAD649E771D799F2593263FF/",
        name = "DLT-19x Sniper",
        leader = true
    }
    miniInfo.sonicChargeSaboteur = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/950714557093539716/6A0D63306F505A074395AFA61EB990280DB8995D/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/950714557093539899/FF7A535E91BF79D4C3E0D55E874C1ACEB6FBF434/",
        name = "Sonic Charge Saboteur"
    }
    miniInfo.sonicChargeSaboteurLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/950714557093539716/6A0D63306F505A074395AFA61EB990280DB8995D/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/950714557093539899/FF7A535E91BF79D4C3E0D55E874C1ACEB6FBF434/",
        name = "Sonic Charge Saboteur",
        leader = true
    }
    miniInfo.imperialRoyalGuardsLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541911959/D583DF28D96DBDF2F1FE9FB6AAB25809774C46EF/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        name = "Imperial Royal Guard Leader"
    }
    miniInfo.imperialRoyalGuards1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541912172/73A36C525BC98DD1F4EC7953943FE5F660B0E9D8/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        name = "Imperial Royal Guard"
    }
    miniInfo.imperialRoyalGuards2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541912365/CB3109223BD5A017AA159066A3B17002B8892047/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        name = "Imperial Royal Guard"
    }
    miniInfo.electrostaffGuard = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540541912278/DC9D78CD5742236F9F272AC1F8AA1D59D07CF5A9/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540541912060/182C0DD6D66EC8DEF075135B872DE26364010E27/",
        name = "Electrostaff Guard"
    }
    miniInfo.imperialDeathTroopersLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305474570/777B8146B150032E3D733D17110BE5887D1AB991/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        name = "Imperial Death Troopers Leader"
    }
    miniInfo.imperialDeathTroopers1= {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305474824/49EFFD221EF1EBD3F3365B6B73B9A4A5C6E6A075/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        name = "Imperial Death Troopers"
    }
    miniInfo.imperialDeathTroopers2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305474956/BB78111128E91BB2DB22F2990AFB438B9EA5FC0E/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        name = "Imperial Death Troopers"
    }
    miniInfo.imperialDeathTroopers3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/951848302305475069/81803116C6F5F9B133D2D0CC39E2A2CA6043E9DB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        name = "Imperial Death Troopers"
    }
    miniInfo.dtf16 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/993513208355174615/DD0DA9DFDBCA621CF297C9A9EB2356279A733158/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/951848302305474695/F076E77D0278B10EAE330BC9073B05BC9A3BCD57/",
        name = "DT-F16",
        leader = true
    }
    miniInfo.dlt19DTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/770610077943650040/CDB9EFD9CB36DE0EB5AB78B22F2B334BDB1E6DFE/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770610077942938053/6187B2D6848EC35010DE6C3EEBB5DF6125D02D45/",
        name = "DLT-19D Trooper"
    }

    local isfMaterials = "http://cloud-3.steamusercontent.com/ugc/1618438238123043414/B7E9660E470DC070545782406C29F1E1356A5685/"
    miniInfo.isfLeader = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618438238122999812/779C9D69CA440F970DD0B7C6394A812732F9C588/",
      assetbundle_secondary = isfMaterials,
      name = "Imperial Special Forces Leader"
    }
    miniInfo.isfInferno = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618438238122999341/C1AEEE50112F060BA8E5CAFBC16F417A0EF7C3C0/",
      assetbundle_secondary = isfMaterials,
      name = "Inferno Squad"
    }
    miniInfo.isf1 = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618438238122996093/C79160007FD884C2B8737DCA888D61C955073141/",
      assetbundle_secondary = isfMaterials,
      name = "Imperial Special Forces"
    }
    miniInfo.isf2 = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618438238122996656/AAD706C50446522C98259A20C03E757C4F7B98B1/",
      assetbundle_secondary = isfMaterials,
      name = "Imperial Special Forces"
    }
    miniInfo.isf3 = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618438238122997115/F100B28E5DBF4A56FB22D3410270BEE4EF344FEF/",
      assetbundle_secondary = isfMaterials,
      name = "Imperial Special Forces"
    }
    miniInfo.isfT21 = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618438238123000906/C64EAD02CA22F8BFB59320925DAD7D89BA1E7AD6/",
      assetbundle_secondary = isfMaterials,
      name = "T-21 Special Forces Trooper"
    }
    miniInfo.delMeeko = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618437692581074585/1C74BEB92DC42D3585BFC1185A77DE14EC3249CA/",
      assetbundle_secondary = isfMaterials,
      name = "Del Meeko"
    }
    miniInfo.gideonHask = {
      type = "assetbundle",
      assetbundle = "http://cloud-3.steamusercontent.com/ugc/1618437692581075349/6265F81E1BAA090FFA813270A8E3126CF8AD6CC5/",
      assetbundle_secondary = isfMaterials,
      name = "Gideon Hask",
      leader = true
    }

    miniInfo.speederBikeLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540542045928/74630975D4992CA09BDDD88460874FB9E4095FC9/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540542045645/AF0264339BB7E1D09E74AF920E2FB693C3CA1592/",
        name = "74-Z Speeder Bike Leader"
    }
    miniInfo.speederBike = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540542045506/0E2EC344AA0AD37699FFEFD4E1BA86A4FD4CD48B/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540542045645/AF0264339BB7E1D09E74AF920E2FB693C3CA1592/",
        name = "74-Z Speeder Bike"
    }
    miniInfo.eWebHeavyBlasterTeam = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234540542046063/4018BD67779A3F2ACCFA92C35306880C2FC60188/",
        collider = _BASE_COLLIDERS.large,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234540542046257/D259CAB86BBC7A60FB09149229F33508C8DF4CE8/",
        name = "E-Web Heavy Blaster Team"
    }
    miniInfo.dewbackRider = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359682702688959/0FCB94B52F0C2DF6E3F296AB6980CEC158E3E496/",
        collider = _BASE_COLLIDERS.large,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/786359682702689114/727755B3BE824994C869F1C869D8B5A07A3CD284/",
        name = "Dewback Rider"
    }
    miniInfo.atst = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/999141806429351360/24C098E7B3D1708CDCFB9AEA4B2C445EF2DBAEE0/",
        collider = _BASE_COLLIDERS.huge,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1752434998239690716/C6578DAF9012605B1F44A907D1C28646E34A73CF/",
        name = "AT-ST"
    }
    miniInfo.tx225 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/770610077943664603/48F725F2C3EAAF7514813A42EE084CE2E7382909/",
        collider = _BASE_COLLIDERS.long,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/770610077942978328/35E12FB664BC3AE0A7AFCCAFF306AFC7481CE4D3/",
        name = "TX-225 GAVw Occupier"
    }
    -- SEPARATIST
    miniInfo.generalGrievous = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167436/AAA2C61A17BB43F2673AF16D30BD0478B9AAAD2A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780869167571/EF86CBDA5F361282AD077D61FA81ABF0FEE061A0/",
        name = "General Grievous"
    }
    miniInfo.countDooku = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586543/25BD09F275C593DB6C794359A9C50F3188F4D804/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849586640/B0512CC73C982F94EB5FEAE1661CF4438DAD8879/",
        name = "Count Dooku"
    }
    miniInfo.cadBane = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1003681674396400482/F8900CFC9EF2309C9F54AE33AE5444B2B09DB1CD/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1003681674396400696/907F4310FEA7A7CD89EE64A1AF3A8CC77897CCAC/",
        name = "Cad Bane"
    }
    miniInfo.maul = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1647717402898544477/AC748B04B4363679177B27F514758C308A2A7E49/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1647717402898544863/C61437A96B0AB9BC3C226475A87C9BB248D2CA2A/",
      name = "Maul"
  }

    miniInfo.b1BattleDroid1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167061/48F42C02EDD970E6DE8E59B8601EF3E7F11C1742/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid2 = miniInfo.b1BattleDroid1
    miniInfo.b1BattleDroid3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167318/DBC7863706A08B96020D3BFBE7A0C2C5689B7B08/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869166660/36AF6887F11FC70FF6AB75D0434EA79952C9E882/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroid5 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869167194/9ADFFD9AD608CBE3E9F6F61AB416E699A4156109/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780869166919/FE5AD3A71430C729735E3FF7023D9E546E12FEF1/",
        name = "B1 Battle Droid"
    }
    miniInfo.b1BattleDroidLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780869166347/AA861F86A0B74CF335533E425A6CBACB99395A09/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780869166529/263C2AB95B1743539EC2CBDE40B0A14B1F5E5693/",
        name = "B1 Battle Droid Leader",
        altModelInfo = miniInfo.b1BattleDroid4
    }
    miniInfo.b1BattleDroid6 = miniInfo.b1BattleDroid3
    miniInfo.e5CB1Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780871782781/4DCE4780DE1CCDFB2996C28200A26C3B0696DD5A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780871782881/ADC1DBC3987C84AF486F9CD0E19A0455F4C33291/",
        name = "E-5C B1 Trooper"
    }
    miniInfo.e60RB1Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780871782500/34D317CFE0BE32E4FFFB84567822CDF7AC4D4C98/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785234780871782620/9A9EA2B54691F42EA6D34762D33D523A836201B2/",
        name = "E-60R B1 Trooper"
    }
    miniInfo.b1SecurityDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102173467517125/1BEF7A7795DF3F6DB91B84C1C82D8FBB24BF574B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102173467517405/DC3A7F38CF3839B7C5F2FCCE85745041094ADA81/",
        name = "B1 Security Droid"
    }
    miniInfo.e5sB1Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/766102422959434489/60F05B7FC8544DFC640CB33DA55F19EB5F2CB55A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/766102422959428835/10D3F8862BDECE8C0D7A874CC000F25CD6232168/",
        name = "E-5s B1 Trooper"
    }
    miniInfo.oomSeriesBattleDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/767228764785018348/F0B0C50757F4043A6C9B8746A73F8EC4342CA7DA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/767228764785012711/4DF65424F7D5400F0DC8A4DE7A028B373143CE6E/",
        name = "OOM-Series Battle Droid",
        leader = true
    }
    miniInfo.radiationCannonB1Trooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/767228764785008444/482C29486FD00312B2C7848D26A82793BCDF7D7F/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/767228764784997566/39300970854603B1F1539C46D70CC21280E278FF/",
        name = "Radiation Cannon B1 Trooper"
    }
    miniInfo.b2SuperBattleDroidLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586118/94F967F21EA7E390A200C4BDA5581D07DBB37AC2/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        name = "B2 Battle Droid Leader"
    }
    miniInfo.b2SuperBattleDroid1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586430/E5941CF7A3631E6D4A28832AE489A4340C96B0B9/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        name = "B2 Battle Droid"
    }
    miniInfo.b2SuperBattleDroid2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586226/9326AD8D3EC80CC53F4BF2D156014978DCD715D9/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        name = "B2 Battle Droid"
    }
    miniInfo.b2SuperBattleDroid3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849586324/B5D59E535AFA2BF99FCA3C584E28FA500ADB89BD/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        name = "B2 Battle Droid"
    }
    miniInfo.b2HATrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849585631/7FF051E2079AB28A4FB77CCC739BCEB42F4CCFAA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        name = "B2-HA Trooper"
    }
    miniInfo.b2ACMTrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/775105953849585917/4D4047069796D1E0567BE9ABD836984FDF12E80E/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/775105953849585789/91A639AB9F57BE393683DA53212E395886307C52/",
        name = "B2-ACM Trooper"
    }
    miniInfo.tSeriesTacticalDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1022821664192681738/6062182D66F6F043E4DCF98FCD592CBD7ECDFF18/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1022821664192681931/11AB7637C0B8C60CB2E4BDC90F006B887A69DAF0/",
        name = "T-Series Tactical Droid"
    }
    miniInfo.tSeriesTacticalDroidLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035003801/6062182D66F6F043E4DCF98FCD592CBD7ECDFF18/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035004142/11AB7637C0B8C60CB2E4BDC90F006B887A69DAF0/",
        name = "T-Series Tactical Droid",
        leader = true
    }
    miniInfo.evSeriesMedicalDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035000354/6248E4CAF3E978154106E7095E6984DCE6677CCA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035001447/E6B6EC2DDAE8CEA46A1384161E789D76F8F296BA/",
        name = "EV-Series Medical Droid"
    }
    miniInfo.pkSeriesWorkerDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035005605/95FAACF9FF4F9B6AB1921E3FD8C896DC631069BF/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035006060/711173DA172C4BC50686BBBC9C0D8BA1764D3175/",
        name = "PK-Series Worker Droid"
    }
    miniInfo.viperReconDroid = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364034959851/4D7F0531A10AEA9421878B1535604FDF1EBAE8D1/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364034974176/209AEB14BF56D899CB9220BDB0BAB98CE2BA90D4/",
        name = "Viper Recon Droid"
    }
    miniInfo.drk1SithProbeDroidLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1693877203566022298/DF3FC1CF550C49A2C2340F5291798615E1978116/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1693877203566022493/549FA81DA79A87D9134AF78B2D39417113C1C71C/",
        name = "DRK-1 Sith Probe Droid Leader",
        leader = true
    }
    miniInfo.drk1SithProbeDroid1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1693877203566022298/DF3FC1CF550C49A2C2340F5291798615E1978116/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1693877203566022493/549FA81DA79A87D9134AF78B2D39417113C1C71C/",
        name = "DRK-1 Sith Probe Droid"
    }
    miniInfo.drk1SithProbeDroid2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1693877203566022298/DF3FC1CF550C49A2C2340F5291798615E1978116/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1693877203566022493/549FA81DA79A87D9134AF78B2D39417113C1C71C/",
        name = "DRK-1 Sith Probe Droid"
    }
    local bxDroidMaterials = "http://cloud-3.steamusercontent.com/ugc/773995528924546789/8774CBBDC3C4F18B11A444CC96EA5FE7F00DB48F/"
    miniInfo.bxCommandoDroidLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457847081/F7D4E8D3EC85BAEEB5C1B5B913B7F484CC28FC10/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid Leader"
    }
    miniInfo.bxCommandoDroid1 = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457845802/AE70766EAA85C875B023FB980A5A5CEEFB98B1D9/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid"
    }
    miniInfo.bxCommandoDroid2 = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457846188/D7F348E890430AA319DDDFA513D99DC2783ECF91/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid"
    }
    miniInfo.bxCommandoDroid3 = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457846574/F169D9E2E45B73D1E21B17E32D3B4B4D9AACB196/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid"
    }
    miniInfo.bxCommandoDroidSniper = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457847963/0EA6BE014DA494689FF32F9570C6A73CD88F1894/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid Sniper"
    }
    miniInfo.bxCommandoDroidSniperLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457847963/0EA6BE014DA494689FF32F9570C6A73CD88F1894/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid Sniper",
        leader = true
    }
    miniInfo.bxCommandoDroidSaboteur = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457847567/079157D001A1520085C6A30620750817C6C01BFF/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid Saboteur"
    }
    miniInfo.bxCommandoDroidSaboteurLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457847567/079157D001A1520085C6A30620750817C6C01BFF/",
        assetbundle_secondary = bxDroidMaterials,
        name = "BX Commando Droid Saboteur",
        leader = true
    }
    miniInfo.droidekaLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785235151812759044/95037BEC00715812E918EC16919526DADE6F523F/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785235151812759497/47C2BFAE32E13C07FE68522008085B8C1F2EFDBD/",
        name = "Droideka Leader"
    }
    miniInfo.droideka1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785235151812759044/95037BEC00715812E918EC16919526DADE6F523F/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785235151812759310/88CC976372EF6B912EF2A761563F5632595C2295/",
        name = "Droideka"
    }
    miniInfo.STAPLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1003681674396285422/B2205A5D8B8CC1718D0C9B507BC3E33BCA815567/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1003681674396285744/5725FD4B443FFC2C6ADD751A4094D4B65944C098/",
        name = "STAP Rider Leader"
    }
    miniInfo.STAP1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1003681674396285422/B2205A5D8B8CC1718D0C9B507BC3E33BCA815567/",
        collider = _BASE_COLLIDERS.medium,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1003681674396285948/9C496D83F828E242C3C7CC18613FA83AD57BCF93/",
        name = "STAP Rider"
    }
    miniInfo.aatTank = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785235151813166538/2F32058DDD51C131547B66A3927041BDACDD9E72/",
        collider = _BASE_COLLIDERS.epic,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785235151813166725/2751E83472B0B6BD0559F5E77FAA3D62A0E17BB1/",
        name = "AAT Trade Federation Battle Tank"
    }

    -- REPUBLIC
    miniInfo.obiWanKenobi = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873394134/94407058FBA842AD0FDCC0BBB8AB613EA9A739C2/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873394267/272C1C9A8C15C36DC5C10DD62D5EFCEF9BFF4496/",
        name = "Obi-Wan Kenobi"
    }
    miniInfo.cloneCaptainRex = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/776232727456806720/869654FC3B0590BFFF2E1845C3CFA9169838EBF9/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/776232727456806858/52327997163A5113DF9E11B85F9DA8B6B970012C/",
        name = "Clone Captain Rex"
    }
    miniInfo.anakinSkywalker = {
      mesh = "http://cloud-3.steamusercontent.com/ugc/1647717402898546429/B304222EB644FD345A672FA36A7C4F5DF5152C49/",
      collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1647717402898546712/394E72447FF020F1D95846D07120EE63FCD0435B/",
      name = "Anakin Skywalker"
    }
    miniInfo.cloneCommander = {
    mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035126931/4EAB6085C2D2D6C176B3C9847E2F1F228CEFE7BB/",
    collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035127510/89D5E03C721391A7CBC7930180396F3B14E5273F/",
    name = "Clone Commander"
    }
    miniInfo.cloneCommanderLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035126931/4EAB6085C2D2D6C176B3C9847E2F1F228CEFE7BB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035127510/89D5E03C721391A7CBC7930180396F3B14E5273F/",
        name = "Clone Commander",
        leader = true
        }
    miniInfo.padme = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1003681674396399543/F485B2E6C10CBC01661E393966F014E5A5DE8BF9/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1003681674396399785/16C4492225E9C885997F59A86B4C1C67050F4197/",
        name = "Padme Amidala"
    }

    miniInfo.phaseICloneTrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393589/6AF627688F36D2049C1307BCB67A755FB27D51C5/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393727/8C4030EF9FEEB32E048567DC2EC38A1985E7C8C0/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873457225/6382F0EA6E2DB0BC65921C3F4E5C97A84B422187/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873394019/F7EDA9D80C35FADA3C000A88C8105823172123B8/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Phase I Clone Trooper"
    }
    miniInfo.phaseICloneTrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393043/33A6FEA07374DAC8EBB6CDD463B6C761DC765D03/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Phase I Clone Trooper Leader",
        altModelInfo = miniInfo.phaseICloneTrooper4
    }
    miniInfo.z6PhaseITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393876/DEDAF52B0D07E0F2A2BCB54DE9A56E4FA437A3E4/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Z-6 Phase I Clone Trooper"
    }
    miniInfo.dc15PhaseITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873393393/915E79CA7D72B0DA950656C69F104A7BB586C0E0/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "DC-15 Phase I Clone Trooper"
    }
    miniInfo.phaseICloneSpecialist = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/767228764785643001/070425BBB2F0D33E71693679EEB72FEF790FE2F6/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873393180/6359B491483DCD9B2641BA134DC4B92DE10E9D92/",
        name = "Phase I Clone Specialist"
    }
    miniInfo.phaseICloneCaptain = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/767228764785646423/F890985F1B31042E0BC10996930089A3A22BE5C5/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/767228764785647603/8F9ADBD1429C1AF247858C877548E15E5996F4A9/",
        name = "Phase I Clone Captain",
        leader = true
    }
    miniInfo.rps6PhaseITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/767228764785603568/BB31C6873BD81E6B5B6F6D41B907DA95421063F0/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/767228764785565294/2AA6ABC62F52DCD30C56D5DED210C35E7B4FD526/",
        name = "RPS-6 Phase I Trooper"
    }
    miniInfo.dp23PhaseITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/767228764785625549/5461468E09D086E4CF7E835AE69D6F4226690518/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/767228764785620873/E3B1226B0836CF579F16C490896D5E2DE95C31F5/",
        name = "DP-23 Phase I Trooper"
    }
    local phaseIITexture = "http://cloud-3.steamusercontent.com/ugc/1028455893321728189/3FB4241F32F35813B6A934FCD3030D3F3D5B7090/"
    miniInfo.phaseIICloneTrooperLeader = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321070793/294DC7F7A6BE9E31AB2823745854EF8C31D3281A/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Phase II Clone Trooper Leader"
    }
    miniInfo.phaseIICloneTrooper1 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321407636/9315381415E55B835F091392658CBFDED02249F3/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Phase II Clone Trooper"
    }
    miniInfo.phaseIICloneTrooper2 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321577529/3034903B0501BE08E398BCC7F0D735B308DA9377/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Phase II Clone Trooper"
    }
    miniInfo.phaseIICloneTrooper3 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321405998/BF99DA12AC60F2548F73F5D0D001419BFBFA5CB1/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Phase II Clone Trooper"
    }
    miniInfo.phaseIICloneTrooper4 = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321406830/59DC907FEFEF65FBAF245A3B31A4251026FC93AA/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Phase II Clone Trooper"
    }
    miniInfo.z6PhaseIITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321579074/D5F10426146B81D46F02B027B9C4CC875FA6DA00/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Z-6 Phase II Trooper"
    }
    miniInfo.mortarPhaseIITrooper = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1028455893321578281/CBFA560559FE81326342AD0B65D2349447F882EB/",
        collider = _BASE_COLLIDERS.small,
        diffuse = phaseIITexture,
        name = "Phase II Mortar Trooper"
    }
    miniInfo.cloneCommsTechnician = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035131182/F5BA58F09282727EFB8E38BA478970E44B983EED/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035131690/ED66D23D4467396F6858928E9FEE1DABB4F9B446/",
        name = "Clone Comms Technician"
    }
    miniInfo.cloneEngineer = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035133539/7AD5C8B323760EFE19570C8F8D0DDA994973F03B/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035133984/DF3D2C9C54EBD45F87B48DCE203019FDD5FAECD2/",
        name = "Clone Engineer"
    }
    miniInfo.cloneMedic = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1683750364035135224/49D60D4EE5794A206AF8F604A68F58979CFEBC42/",
        collider = _BASE_COLLIDERS.small,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1683750364035135810/BD84B4C5CAA84DDA6302739AD749CD29B1C39669/",
        name = "Clone Medic"
    }

    local arcMaterials = "http://cloud-3.steamusercontent.com/ugc/773995200348530664/5E248091F8CC37B1023257338D4947E4ADFE48AB/"
    miniInfo.arcTrooperLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457802621/01F605D855048F823A0ECA6C46D2A62B56C04124/",
        -- assetbundle = "http://cloud-3.steamusercontent.com/ugc/776248816758255676/F51F732336CFEF3DCF549C2B396CD201FECE6A4B/",
        assetbundle_secondary = arcMaterials,
        name = "ARC Trooper Leader"
    }
    miniInfo.arcTrooper1 = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457799750/AE83DC038BA8AAF48678D07E1F9734D4A9944C1D/",
        assetbundle_secondary = arcMaterials,
        name = "ARC Trooper"
    }
    miniInfo.arcTrooper2 = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457800134/88E2FEC812AD5E7B7570836120992252AC758BF8/",
        assetbundle_secondary = arcMaterials,
        name = "ARC Trooper"
    }
    miniInfo.arcTrooper3 = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457800538/06BBAAAAC7FB68DAA9351F12008475068A96BFFB/",
        assetbundle_secondary = arcMaterials,
        name = "ARC Trooper"
    }
    miniInfo.arcTrooperDC15x = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457800878/34EC84D7ECD99E073417866A9BEC4288E00F5359/",
        assetbundle_secondary = arcMaterials,
        name = "DC-15x ARC Trooper"
    }
    miniInfo.arcTrooperDC15xLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457800878/34EC84D7ECD99E073417866A9BEC4288E00F5359/",
        assetbundle_secondary = arcMaterials,
        name = "DC-15x ARC Trooper",
        leader = true
    }
    miniInfo.echo = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457801321/CED1CD80F307683E79B9A4ED87CECAED7C070EBF/",
        assetbundle_secondary = arcMaterials,
        name = "Echo"
    }
    miniInfo.echoLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457801321/CED1CD80F307683E79B9A4ED87CECAED7C070EBF/",
        assetbundle_secondary = arcMaterials,
        name = "Echo",
        leader = true
    }
    miniInfo.fives = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457802221/506D704E232C1BFD85F063A24EBF24C5914C2C40/",
        assetbundle_secondary = arcMaterials,
        name = "Fives"
    }
    miniInfo.fivesLeader = {
        type = "assetbundle",
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1009315641457802221/506D704E232C1BFD85F063A24EBF24C5914C2C40/",
        assetbundle_secondary = arcMaterials,
        name = "Fives",
        leader = true
    }
    miniInfo.barcSpeeder = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873394399/018F8CC63E0D90F58AADA6328DF1709D4D1DF796/",
        collider = _BASE_COLLIDERS.large,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873394534/3E2F0490BA5D1024741F5806A4921D0E0E79EA9F/",
        name = "BARC Speeder"
    }
    miniInfo.republicATRT = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/1002556126520812865/51DA6EC33B5B7DC2274B97867C4E68F302AF5AE5/",
        collider = _BASE_COLLIDERS.large,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1003681674396366135/D383D40E0AA3F75A159827B6938D2A93C75BC54B/",
        name = "Republic AT-RT"
    }

    miniInfo.saberTank = {
        mesh = "http://cloud-3.steamusercontent.com/ugc/785236717873392482/BC01571E47E96306C31FABABE3EA971814E00C96/",
        collider = _BASE_COLLIDERS.epic,
        diffuse = "http://cloud-3.steamusercontent.com/ugc/785236717873392638/CE1C3404249840D5F7F9499D1427E83530ACEB19/",
        name = "TX-130 Saber-Class Fighter Tank"
    }

    cardInfo = {}

    -- upgrade cards
    cardInfo.upgradeCards = {}

    --[[ Ordnance --]]
    cardInfo.upgradeCards.armorPiercingShells = {
      name = "Armor-Piercing Shells",
      ptCost = 10,
      varName = "armorPiercingShells"
    }

    cardInfo.upgradeCards.highEnergyShells = {
      name = "High-Energy Shells",
      ptCost = 8,
      varName = "highEnergyShells"
    }

    cardInfo.upgradeCards.bunkerBusterShells = {
      name = '"Bunker Buster" Shells',
      ptCost = 12,
      varName = "bunkerBusterShells"
    }

    -- force
    cardInfo.upgradeCards.forcePush = {name = "Force Push", ptCost = 10,varName="forcePush"}
    cardInfo.upgradeCards.forceReflexes = {name = "Force Reflexes", ptCost = 5,varName="forceReflexes"}
    cardInfo.upgradeCards.saberThrow = {name = "Saber Throw", ptCost = 5,varName="saberThrow"}
    cardInfo.upgradeCards.jediMindTrick = {name = "Jedi Mind Trick", ptCost = 5,varName="jediMindTrick"}
    cardInfo.upgradeCards.battleMeditation = {name = "Battle Meditation", ptCost = 5,varName="battleMeditation"}
    cardInfo.upgradeCards.forceChoke = {name = "Force Choke", ptCost = 5,varName="forceChoke"}
    cardInfo.upgradeCards.anger = {name = "Anger", ptCost = 5,varName="anger"}
    cardInfo.upgradeCards.fear = {name = "Fear", ptCost = 3,varName="fear"}
    cardInfo.upgradeCards.forceGuidance = {name = "Force Guidance", ptCost = 5,varName="forceGuidance"}
    cardInfo.upgradeCards.hope = {name = "Hope", ptCost = 3,varName="hope"}
    cardInfo.upgradeCards.forceBarrier = {name = "Force Barrier", ptCost = 10, varName = "forceBarrier"}

    -- tech
    cardInfo.upgradeCards.targetingScopes = {name = "Targeting Scopes", ptCost = 4,varName="targetingScopes"}
    cardInfo.upgradeCards.grapplingHooks = {name = "Grappling Hooks", ptCost = 1,varName="grapplingHooks"}
    cardInfo.upgradeCards.environmentalGear = {name = "Environmental Gear", ptCost = 2,varName="environmentalGear"}
    cardInfo.upgradeCards.emergencyStims = {name = "Emergency Stims", ptCost = 10,varName="emergencyStims"}
    cardInfo.upgradeCards.reconIntel = {name = "Recon Intel", ptCost = 2,varName="reconIntel"}
    cardInfo.upgradeCards.personalCombatShield = {name = "Personal Combat Shield", ptCost = 5,varName="personalCombatShield"}
    cardInfo.upgradeCards.electroGrapplingLine = {name = "Electro Grappling Line", ptCost = 5,varName="electroGrapplingLine"}
    cardInfo.upgradeCards.electrobinoculars = {name = "Electrobinoculars", ptCost = 8,varName="electrobinoculars"}
    cardInfo.upgradeCards.jt12Jetpacks = {name = "JT-12 Jetpacks", ptCost = 10,varName="jt12Jetpacks"}
    cardInfo.upgradeCards.ascensionCables = {name = "Ascension Cables", ptCost = 4,varName="ascensionCables"}
    cardInfo.upgradeCards.portableScanner = {name = "Portable Scanner", ptCost = 6,varName="portableScanner"}

    -- grenade
    cardInfo.upgradeCards.concussionGrenades = {name = "Concussion Grenades", ptCost = 3,varName="concussionGrenades"}
    cardInfo.upgradeCards.impactGrenades = {name = "Impact Grenades", ptCost = 3,varName="impactGrenades"}
    cardInfo.upgradeCards.fragmentationGrenades = {name = "Fragmentation Grenades", ptCost = 5,varName="fragmentationGrenades"}
    cardInfo.upgradeCards.smokeGrenades = {name = "Smoke Grenades", ptCost = 2,varName="smokeGrenades"}
    cardInfo.upgradeCards.empDroidPoppers = {name = "EMP Droid Poppers", ptCost = 3,varName="empDroidPoppers"}

    -- comms
    cardInfo.upgradeCards.commsJammer = {name =  "Comms Jammer", ptCost = 5,varName="commsJammer"}
    cardInfo.upgradeCards.longRangeComlink = {name =  "Long-Range Comlink", ptCost = 5,varName="longRangeComlink"}
    cardInfo.upgradeCards.hqUplink = {name =  "HQ Uplink", ptCost = 10,varName="hqUplink"}
    cardInfo.upgradeCards.commsRelay = {name =  "Comms Relay", ptCost = 5,varName="commsRelay"}
    cardInfo.upgradeCards.linkedTargetingArray = {name =  "Linked Targeting Array", ptCost = 5,varName="linkedTargetingArray"}
    cardInfo.upgradeCards.integratedCommsAntenna = {name =  "Integrated Comms Antenna", ptCost = 3,varName="integratedCommsAntenna"}
    cardInfo.upgradeCards.commandControlArray = {name =  "Command Control Array", ptCost = 2,varName="commandControlArray"}

    -- generators
    cardInfo.upgradeCards.barrageGenerator = {name =  "Barrage Generator", ptCost = 3,varName="barrageGenerator"}
    cardInfo.upgradeCards.overchargedGenerator = {name =  "Overcharged Generator", ptCost = 3,varName="overchargedGenerator"}

    -- hardpoint
    cardInfo.upgradeCards.rotaryBlaster = {name =  "AT-RT Rotary Blaster", ptCost = 20,varName="rotaryBlaster"}
    cardInfo.upgradeCards.laserCannon = {name =  "AT-RT Laser Cannon", ptCost = 10,varName="laserCannon"}
    cardInfo.upgradeCards.flamethrower = {name =  "AT-RT Flamethrower", ptCost = 20,varName="flamethrower"}
    cardInfo.upgradeCards.ax108GroundBuzzer = {name = 'Ax-108 "Ground Buzzer"', ptCost = 10,varName="ax108GroundBuzzer"}
    cardInfo.upgradeCards.powerHarpoon = {name =  "Mo/Dk Power Harpoon", ptCost = 0,varName="powerHarpoon"}
    cardInfo.upgradeCards.atstMortarLauncher = {name =  "AT-ST Mortar Launcher", ptCost = 10,varName="atstMortarLauncher"}
    cardInfo.upgradeCards.twinLightBlasterCannon = {name =  "88 Twin Light Blaster Cannon", ptCost = 20,varName="twinLightBlasterCannon"}
    cardInfo.upgradeCards.dw3ConcussionGrenadeLauncher = {name =  "DW-3 Concussion Grenade Launcher", ptCost = 15,varName="dw3ConcussionGrenadeLauncher"}

    cardInfo.upgradeCards.m45IonBlaster = {name =  "M-45 Ion Blaster", ptCost = 31,varName="m45IonBlaster"}
    cardInfo.upgradeCards.markIIMediumBlaster = {name =  "Mark II Medium Blaster", ptCost = 26,varName="markIIMediumBlaster"}
    cardInfo.upgradeCards.rt97CRiflePintle = {name =  "RT-97C Rifle Pintle", ptCost = 14,varName="rt97CRiflePintle"}
    cardInfo.upgradeCards.dlt19RiflePintle = {name = 'DLT-19 Rifle Pintle', ptCost = 18,varName="dlt19RiflePintle"}

    cardInfo.upgradeCards.tx130beamcannonturret = {
      name = 'TX-130 Beam Cannon Turret',
      ptCost = 30,
      varName = "tx130beamcannonturret"
    }

    cardInfo.upgradeCards.tx130twinlaserturret = {
      name = 'TX-130 Twin Laser Turret',
      ptCost = 14,
      varName = "tx130twinlaserturret"
    }

    -- CREW
    cardInfo.upgradeCards.a300RifleGunner = {name =  "A-300 Rifle Gunner", ptCost = 9,varName="a300RifleGunner"}
    cardInfo.upgradeCards.rps6RocketGunner = {name = 'RPS-6 Rocket Gunner', ptCost = 31,varName="rps6RocketGunner"}
    cardInfo.upgradeCards.barcRPS6Gunner = {name = 'BARC RPS-6 Gunner', ptCost = 21,varName="barcRPS6Gunner"}
    cardInfo.upgradeCards.barcTwinLaserGunner = {name = 'BARC Twin Laser Gunner', ptCost = 15,varName="barcTwinLaserGunner"}
    cardInfo.upgradeCards.barcIonGunner = {name = 'BARC Ion Gunner', ptCost = 22,varName="barcIonGunner"}

    -- heavy
    cardInfo.upgradeCards.z6Trooper = {name = "Z-6 Trooper", ptCost = 20, miniGUID = "81cbcb", miniInfo = miniInfo.z6Trooper,varName="z6Trooper"}
    cardInfo.upgradeCards.hh12Stormtrooper = {name = "HH-12 Stormtrooper", ptCost = 20, miniGUID = "896f11", miniInfo = miniInfo.hh12Stormtrooper,varName="hh12Stormtrooper"}
    cardInfo.upgradeCards.mpl57IonTrooper = {name = "MPL-57 Ion Trooper", ptCost = 22, miniInfo = miniInfo.mpl57IonTrooper,varName="mpl57IonTrooper"}
    cardInfo.upgradeCards.dlt19Stormtrooper = {name = "DLT-19 Stormtrooper", ptCost = 22, miniGUID = "1d1re16", miniInfo = miniInfo.dlt19Stormtrooper,varName="dlt19Stormtrooper"}
    cardInfo.upgradeCards.t7IonSnowtrooper = {name = "T-7 Ion Snowtrooper", ptCost = 20, miniGUID = "1dg1fe16", miniInfo = miniInfo.t7IonSnowtrooper,varName="t7IonSnowtrooper"}
    cardInfo.upgradeCards.flametrooper = {name = "Flametrooper", ptCost = 20, miniGUID = "1dg1fge16", miniInfo = miniInfo.flametrooper, varName="flametrooper"}
    cardInfo.upgradeCards.scatterGunTrooper = {name = "Scatter Gun Trooper", ptCost = 23, miniGUID = "1dgg1e16", miniInfo = miniInfo.scatterGunTrooper,varName="scatterGunTrooper"}
    cardInfo.upgradeCards.mpl57BarrageTrooper = {name = "MPL-57 Barrage Trooper", ptCost = 22, miniGUID = "1dggg1e16", miniInfo = miniInfo.mpl57BarrageTrooper,varName="mpl57BarrageTrooper"}
    cardInfo.upgradeCards.electrostaffGuard = {name = "Electrostaff Guard", ptCost = 25, miniGUID = "1dgggg1e16", miniInfo = miniInfo.electrostaffGuard,varName="electrostaffGuard"}
    cardInfo.upgradeCards.dh447Sniper = {name = "DH-447 Sniper", ptCost = 28, miniGUID = "1dggggg1e16", miniInfo = miniInfo.dh447Sniper,varName="dh447Sniper"}
    cardInfo.upgradeCards.protonChargeSaboteur = {name = "Proton Charge Saboteur", ptCost = 26, miniGUID = "1dgggggg1e16", miniInfo = miniInfo.protonChargeSaboteur,varName="protonChargeSaboteur"}
    cardInfo.upgradeCards.bowcasterWookiee = {name = "Bowcaster Wookiee", ptCost = 31, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.bowcasterWookiee,varName="bowcasterWookiee"}
    cardInfo.upgradeCards.dh447SniperLeader = {name = "DH-447 Sniper", ptCost = 28, miniGUID = "1dggggg1e16", miniInfo = miniInfo.dh447SniperLeader,varName="dh447SniperLeader"}
    cardInfo.upgradeCards.protonChargeSaboteurLeader = {name = "Proton Charge Saboteur", ptCost = 26, miniGUID = "1dgggggg1e16", miniInfo = miniInfo.protonChargeSaboteurLeader,varName="protonChargeSaboteurLeader"}
    cardInfo.upgradeCards.dlt19xSniper = {name = "DLT-19x Sniper", ptCost = 28, miniGUID = "1dgggggg1e16", miniInfo = miniInfo.dlt19xSniper,varName="dlt19xSniper"}
    cardInfo.upgradeCards.sonicChargeSaboteurLeader = {name = "Sonic Charge Saboteur", ptCost = 26, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.sonicChargeSaboteurLeader,varName="sonicChargeSaboteurLeader"}
    cardInfo.upgradeCards.dlt19xSniperLeader = {name = "DLT-19x Sniper", ptCost = 28, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.dlt19xSniperLeader,varName="dlt19xSniperLeader"}
    cardInfo.upgradeCards.sonicChargeSaboteur = {name = "Sonic Charge Saboteur", ptCost = 26, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.sonicChargeSaboteur,varName="sonicChargeSaboteur"}
    cardInfo.upgradeCards.isfT21 = {name = "T-21 Special Forces Trooper", ptCost = 29, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.isfT21,varName="isfT21"}
    cardInfo.upgradeCards.delMeeko = {name = "Del Meeko", ptCost = 38, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.delMeeko,varName="delMeeko"}
    cardInfo.upgradeCards.gideonHask = {name = "Gideon Hask", ptCost = 38, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.gideonHask,varName="gideonHask"}
    cardInfo.upgradeCards.beskadDuelist = {name = "Beskad Duelist", ptCost = 28, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.beskadDuelist,varName="beskadDuelist"}
    cardInfo.upgradeCards.ursaWren = {name = "Ursa Wren", ptCost = 38, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.ursaWren,varName="ursaWren"}
    cardInfo.upgradeCards.tristanWren = {name = "Tristan Wren", ptCost = 38, miniGUID = "1dgggggggg1e16", miniInfo = miniInfo.tristanWren,varName="tristanWren"}

    cardInfo.upgradeCards.b2ACMTrooper = {
      name = "B2-ACM Trooper",
      ptCost = 24,
      miniInfo = miniInfo.b2ACMTrooper,
      varName = "b2ACMTrooper"
    }

    cardInfo.upgradeCards.b2HATrooper = {
      name = "B2-HA Trooper",
      ptCost = 30,
      miniInfo = miniInfo.b2HATrooper,
      varName = "b2HATrooper"
    }

    cardInfo.upgradeCards.bxCommandoDroidSniper = { name = "BX-Series Droid Sniper", ptCost = 30, miniInfo = miniInfo.bxCommandoDroidSniper, varName = "bxCommandoDroidSniper" }
    cardInfo.upgradeCards.bxCommandoDroidSniperLeader = { name = "BX-Series Droid Sniper", ptCost = 30, miniInfo = miniInfo.bxCommandoDroidSniperLeader, varName = "bxCommandoDroidSniperLeader" }

    cardInfo.upgradeCards.bxCommandoDroidSaboteur = { name = "BX-Series Droid Saboteur", ptCost = 28, miniInfo = miniInfo.bxCommandoDroidSaboteur, varName = "bxCommandoDroidSaboteur" }
    cardInfo.upgradeCards.bxCommandoDroidSaboteurLeader = { name = "BX-Series Droid Saboteur", ptCost = 28, miniInfo = miniInfo.bxCommandoDroidSaboteurLeader, varName = "bxCommandoDroidSaboteurLeader" }

    cardInfo.upgradeCards.dp23PhaseITrooper = {name = "DP-23 Phase I Trooper", ptCost = 23, miniGUID = "j7816", miniInfo = miniInfo.dp23PhaseITrooper,varName="dp23PhaseITrooper"}
    cardInfo.upgradeCards.rps6PhaseITrooper = {name = "RPS-6 Phase I Trooper", ptCost = 21, miniGUID = "1jguk6", miniInfo = miniInfo.rps6PhaseITrooper,varName="rps6PhaseITrooper"}
    cardInfo.upgradeCards.e5sB1Trooper = {name = "E-5s B1 Trooper", ptCost = 20, miniGUID = "19pe16", miniInfo = miniInfo.e5sB1Trooper,varName="e5sB1Trooper"}
    cardInfo.upgradeCards.radiationCannonB1Trooper = {name = "Radiation Cannon B1 Trooper", ptCost = 22, miniGUID = "1ugguk6", miniInfo = miniInfo.radiationCannonB1Trooper,varName="radiationCannonB1Trooper"}
    cardInfo.upgradeCards.rt97CStormtrooper = {name = "RT-97C Stormtrooper", ptCost = 26, miniGUID = "1dgmg16", miniInfo = miniInfo.rt97CStormtrooper,varName="rt97CStormtrooper"}
    cardInfo.upgradeCards.t21Stormtrooper = {name = "T-21 Stormtrooper", ptCost = 24, miniGUID = "1dgjfghuk6", miniInfo = miniInfo.t21Stormtrooper,varName="t21Stormtrooper"}
    cardInfo.upgradeCards.sx21Trooper = {name = "SX-21 Trooper", ptCost = 17, miniGUID = "1dgmh6e16", miniInfo = miniInfo.sx21Trooper,varName="sx21Trooper"}
    cardInfo.upgradeCards.dlt20ATrooper = {name = "DLT-20A Trooper", ptCost = 26, miniGUID = "1hguk6", miniInfo = miniInfo.dlt20ATrooper,varName="dlt20ATrooper"}

    cardInfo.upgradeCards.z6PhaseIITrooper = {
      name = "Z-6 Phase II Trooper",
      ptCost = 27,
      miniGUID = "81cbcb",
      miniInfo = miniInfo.z6PhaseIITrooper,
      varName = "z6PhaseIITrooper"
    }

    cardInfo.upgradeCards.mortarPhaseIITrooper = {
      name = "Phase II Mortar Trooper",
      ptCost = 20,
      miniInfo = miniInfo.mortarPhaseIITrooper,
      varName = "mortarPhaseIITrooper"
    }

    cardInfo.upgradeCards.arcTrooperDC15x = { name = "DC-15x ARC Trooper", ptCost = 31, miniInfo = miniInfo.arcTrooperDC15x, varName = "arcTrooperDC15x" }
    cardInfo.upgradeCards.arcTrooperDC15xLeader = { name = "DC-15x ARC Trooper", ptCost = 31, miniInfo = miniInfo.arcTrooperDC15xLeader, varName = "arcTrooperDC15xLeader" }

    cardInfo.upgradeCards.echo = { name = "Echo", ptCost = 40, miniInfo = miniInfo.echoLeader, varName = "echo" }
    -- cardInfo.upgradeCards.echoLeader = { name = "Echo", ptCost = 40, miniInfo = miniInfo.echoLeader, varName = "echoLeader" }

    cardInfo.upgradeCards.fives = { name = "Fives", ptCost = 36, miniInfo = miniInfo.fivesLeader, varName = "fives" }
    -- cardInfo.upgradeCards.fivesLeader = { name = "Fives", ptCost = 36, miniInfo = miniInfo.fivesLeader, varName = "fivesLeader" }

    cardInfo.upgradeCards.cloneCommander = {name = "Clone Commander", ptCost = 20, miniGUID = "gadfr", miniInfo = miniInfo.cloneCommanderLeader,varName="cloneCommander"}
    cardInfo.upgradeCards.cloneCommsTechnician = {name = "Clone Comms Technician", ptCost = 12, miniGUID = "gadfr", miniInfo = miniInfo.cloneCommsTechnician,varName="cloneCommsTechnician"}
    cardInfo.upgradeCards.cloneEngineer = {name = "Clone Engineer", ptCost = 18, miniGUID = "gadfr", miniInfo = miniInfo.cloneEngineer,varName="cloneEngineer"}
    cardInfo.upgradeCards.cloneMedic = {name = "Clone Medic", ptCost = 20, miniGUID = "gadfr", miniInfo = miniInfo.cloneMedic,varName="cloneMedic"}

    cardInfo.upgradeCards.pao = {name = "Pao", ptCost = 22, miniGUID = "gadfr", miniInfo = miniInfo.pao,varName="pao"}
    cardInfo.upgradeCards.bistan = {name = "Bistan", ptCost = 28, miniGUID = "ggfr", miniInfo = miniInfo.bistan,varName="bistan"}

    cardInfo.upgradeCards.dtf16 = {name = "DT-F16", ptCost = 22, miniGUID = "gghgfgfar", miniInfo = miniInfo.dtf16,varName="dtf16"}
    cardInfo.upgradeCards.dlt19DTrooper = {name = "DLT-19D Trooper", ptCost = 34, miniGUID = "gghggfgfar", miniInfo = miniInfo.dlt19DTrooper,varName="dlt19DTrooper"}

    cardInfo.upgradeCards.cm093Trooper = {name = "CM-0/93 Trooper", ptCost = 26, miniGUID = "gghggfgfar", miniInfo = miniInfo.cm093Trooper,varName="cm093Trooper"}
    cardInfo.upgradeCards.t21BTrooper = {name = "T-21B Trooper", ptCost = 35, miniGUID = "gggghggfgfar", miniInfo = miniInfo.t21BTrooper,varName="t21BTrooper"}

    cardInfo.upgradeCards.z6PhaseITrooper = {name = "Z-6 Phase I Trooper", ptCost = 23, miniGUID = "gghtvgfgfar", miniInfo = miniInfo.z6PhaseITrooper,varName="z6PhaseITrooper"}
    cardInfo.upgradeCards.dc15PhaseITrooper  = {name = "DC-15 Phase I Trooper", ptCost = 27, miniGUID = "g42r", miniInfo = miniInfo.dc15PhaseITrooper, varName="dc15PhaseITrooper"}
    cardInfo.upgradeCards.e60RB1Trooper = {name = "E-60R B1 Trooper", ptCost = 20, miniGUID = "4fgfar", miniInfo = miniInfo.e60RB1Trooper,varName="e60RB1Trooper"}
    cardInfo.upgradeCards.e5CB1Trooper = {name = "E-5C B1 Trooper", ptCost = 18, miniGUID = "g4gfar", miniInfo = miniInfo.e5CB1Trooper,varName="e5CB1Trooper"}


    -- trooper
    cardInfo.upgradeCards.rebelTrooper = {name =  "Rebel Trooper", ptCost = 7, miniInfo = miniInfo.rebelTrooper4,varName="rebelTrooper"}
    cardInfo.upgradeCards.fleetTrooper = {name =  "Fleet Trooper", ptCost = 7, miniInfo = miniInfo.fleetTroopers4,varName="fleetTrooper"}
    cardInfo.upgradeCards.stormtrooper = {name =  "Stormtrooper", ptCost = 8, miniInfo = miniInfo.stormtrooper4,varName="stormtrooper"}
    cardInfo.upgradeCards.snowtrooper = {name =  "Snowtrooper", ptCost = 8, miniInfo = miniInfo.snowtrooper4,varName="snowtrooper"}
    cardInfo.upgradeCards.rebelOfficer = {name = "Rebel Officer", ptCost = 16, miniGUID = "1dggggggg1e16", miniInfo = miniInfo.rebelOfficerLeader,varName="rebelOfficer"}
    cardInfo.upgradeCards.imperialOfficer = {name = "Imperial Officer", ptCost = 17, miniGUID = "1dggggggggg1e16", miniInfo = miniInfo.imperialOfficerLeader,varName="imperialOfficer"}

    cardInfo.upgradeCards.medicalDroid21B = {name =  "2-1B Medical Droid", ptCost = 18, miniInfo = miniInfo.medicalDroid21B,varName="medicalDroid21B"}
    cardInfo.upgradeCards.r4AstromechDroid = {name =  "R4 Astromech Droid", ptCost = 9, miniInfo = miniInfo.r4AstromechDroid,varName="r4AstromechDroid"}

    cardInfo.upgradeCards.r5AstromechDroid = {name =  "R5 Astromech Droid", ptCost = 8, miniInfo = miniInfo.r5AstromechDroid,varName="r5AstromechDroid"}
    cardInfo.upgradeCards.fx9MedicalDroid = {name =  "FX-9 Medical Droid", ptCost = 19, miniInfo = miniInfo.fx9MedicalDroid,varName="fx9MedicalDroid"}

    cardInfo.upgradeCards.imperialCommsTechnician = {name =  "Imperial Comms Technician", ptCost = 10, miniInfo = miniInfo.imperialCommsTechnician,varName="imperialCommsTechnician"}
    cardInfo.upgradeCards.rebelCommsTechnician = {name =  "Rebel Comms Technician", ptCost = 9, miniInfo = miniInfo.rebelCommsTechnician,varName="rebelCommsTechnician"}

    cardInfo.upgradeCards.rebelVeteran = {name =  "Rebel Veteran", ptCost = 12, miniInfo = miniInfo.rebelVeterans4,varName="rebelVeteran"}
    cardInfo.upgradeCards.shoretrooper = {name =  "Shoretrooper", ptCost = 13, miniInfo = miniInfo.shoretroopers4,varName="shoretrooper"}

    cardInfo.upgradeCards.b2SuperBattleDroid = {name =  "B2 Super Battle Droid", ptCost = 13, miniInfo = miniInfo.b2SuperBattleDroid3,varName="b2SuperBattleDroid"}
    cardInfo.upgradeCards.phaseIICloneTrooper = {name =  "Phase II Clone Trooper", ptCost = 13, miniInfo = miniInfo.phaseIICloneTrooper4,varName="phaseIICloneTrooper"}
    cardInfo.upgradeCards.phaseICloneTrooper = {name =  "Phase I Clone Trooper", ptCost = 10, miniInfo = miniInfo.phaseICloneTrooper4,varName="phaseICloneTrooper"}
    cardInfo.upgradeCards.b1BattleDroid = {name =  "B1 Battle Droid", ptCost = 5, miniInfo = miniInfo.b1BattleDroid6,varName="b1BattleDroid"}
    cardInfo.upgradeCards.tSeriesTacticalDroid = {name =  "T-Series Tactical Droid", ptCost = 18, miniInfo = miniInfo.tSeriesTacticalDroidLeader,varName="tSeriesTacticalDroid"}
    cardInfo.upgradeCards.evSeriesMedicalDroid = {name =  "EV-Series Medical Droid", ptCost = 14, miniInfo = miniInfo.evSeriesMedicalDroid,varName="evSeriesMedicalDroid"}
    cardInfo.upgradeCards.pkSeriesWorkerDroid = {name =  "PK-Series Worker Droid", ptCost = 12, miniInfo = miniInfo.pkSeriesWorkerDroid,varName="pkSeriesWorkerDroid"}
    cardInfo.upgradeCards.viperReconDroid = {name =  "Viper Recon Droid", ptCost = 8, miniInfo = miniInfo.viperReconDroid,varName="viperReconDroid"}

    cardInfo.upgradeCards.phaseICloneSpecialist = {name = "Phase I Clone Specialist", ptCost = 14, miniGUID = "j78156", miniInfo = miniInfo.phaseICloneSpecialist,varName="phaseICloneSpecialist"}
    cardInfo.upgradeCards.phaseICloneCaptain = {name = "Phase I Clone Captain", ptCost = 14, miniGUID = "1jgukg6", miniInfo = miniInfo.phaseICloneCaptain,varName="phaseICloneCaptain"}
    cardInfo.upgradeCards.oomSeriesBattleDroid = {name = "OOM-Series Battle Droid", ptCost = 9, miniGUID = "19peh16", miniInfo = miniInfo.oomSeriesBattleDroid,varName="oomSeriesBattleDroid"}
    cardInfo.upgradeCards.b1SecurityDroid = {name = "B1 Security Droid", ptCost = 7, miniGUID = "1uhgguk6", miniInfo = miniInfo.b1SecurityDroid,varName="b1SecurityDroid"}
    cardInfo.upgradeCards.stormtrooperCaptain = {name = "Stormtrooper Captain", ptCost = 12, miniGUID = "1dg5mg16", miniInfo = miniInfo.stormtrooperCaptain,varName="stormtrooperCaptain"}
    cardInfo.upgradeCards.stormtrooperSpecialist = {name = "Stormtrooper Specialist", ptCost = 12, miniGUID = "1dgjjfghuk6", miniInfo = miniInfo.stormtrooperSpecialist,varName="stormtrooperSpecialist"}
    cardInfo.upgradeCards.rebelTrooperSpecialist = {name = "Rebel Trooper Specialist", ptCost = 12, miniGUID = "1dgmgh6e16", miniInfo = miniInfo.rebelTrooperSpecialist,varName="rebelTrooperSpecialist"}
    cardInfo.upgradeCards.rebelTrooperCaptain = {name = "Rebel Trooper Captain", ptCost = 11, miniGUID = "1hhguk6", miniInfo = miniInfo.rebelTrooperCaptain,varName="rebelTrooperCaptain"}

    -- Pilot
    cardInfo.upgradeCards.wedgeAntilles = {name =  "Wedge Antilles", ptCost = 1,varName="wedgeAntilles"}
    cardInfo.upgradeCards.generalWeiss = {name =  "General Weiss", ptCost = 1,varName="generalWeiss"}
    cardInfo.upgradeCards.firstSergeantArbmab = {name =  "First Sergeant Arbmab", ptCost = 5,varName="firstSergeantArbmab"}
    cardInfo.upgradeCards.ryderAzadi = {name =  "Ryder Azadi", ptCost = 5,varName="ryderAzadi"}
    cardInfo.upgradeCards.imperialHammersEliteArmorPilot = {name =  "Imperial Hammers Elite Armor Pilot", ptCost = 10,varName="imperialHammersEliteArmorPilot"}
    cardInfo.upgradeCards.outerRimSpeederJockey = {name =  "Outer Rim Speeder Jockey", ptCost = 10,varName="outerRimSpeederJockey"}
    cardInfo.upgradeCards.aaylaSecura = {name =  "Aayla Secura", ptCost = 5,varName="aaylaSecura"}

    cardInfo.upgradeCards.tSeriesTacticalDroidPilot = {
      name =  "T-Series Tactical Droid Pilot",
      ptCost = 5,
      varName="tSeriesTacticalDroidPilot"
    }

    cardInfo.upgradeCards.oomSeriesDroidPilot = {
      name =  "OOM-Series Droid Pilot",
      ptCost = 7,
      varName="oomSeriesDroidPilot"
    }

    cardInfo.upgradeCards.veteranClonePilot = {
      name = "Veteran Clone Pilot",
      ptCost = 7,
      varName = "veteranClonePilot"
    }

    cardInfo.upgradeCards.lokDurd = {
      name = "Lok Durd",
      ptCost = 9,
      varName = "lokDurd"
    }

    cardInfo.upgradeCards.ploKoon = {
      name = "Plo Koon",
      ptCost = 9,
      varName = "ploKoon"
    }

    -- leadership
    cardInfo.upgradeCards.commandingPresence = {name =  "Commanding Presence", ptCost = 5,varName="commandingPresence"}
    cardInfo.upgradeCards.esteemedLeader = {name = "Esteemed Leader", ptCost = 5,varName="esteemedLeader"}
    cardInfo.upgradeCards.improvisedOrders = {name = "Improvised Orders", ptCost = 5,varName="improvisedOrders"}
    cardInfo.upgradeCards.strictOrders = {name = "Strict Orders", ptCost = 5,varName="strictOrders"}
    cardInfo.upgradeCards.aggressiveTactics = {name = "Aggressive Tactics", ptCost = 15,varName = "aggressiveTactics"}
    cardInfo.upgradeCards.inspiringPresence = {name = "Inspiring Presence", ptCost = 5,varName = "inspiringPresence"}
    cardInfo.upgradeCards.vigilance = {name = "Vigilance", ptCost = 5,varName = "vigilance"}

    -- tactics
    cardInfo.upgradeCards.duckAndCover = {name = "Duck and Cover", ptCost = 4, varName = "duckAndCover"}
    cardInfo.upgradeCards.hunter = {name = "Hunter", ptCost = 6, varName = "hunter"}
    cardInfo.upgradeCards.tenacity = {name = "Tenacity", ptCost = 4, varName = "tenacity"}
    cardInfo.upgradeCards.endurance = {name = "Endurance", ptCost = 6, varName = "endurance"}
    cardInfo.upgradeCards.overwatch = {name = "Overwatch", ptCost = 4, varName = "overwatch"}
    cardInfo.upgradeCards.offensivePush = {name = "Offensive Push", ptCost = 4, varName = "offensivePush"}
    cardInfo.upgradeCards.situationalAwareness = {name = "Situational Awareness", ptCost = 2, varName = "situationalAwareness"}
    cardInfo.upgradeCards.offensiveStance = {name = "Offensive Stance", ptCost = 5, varName = "offensiveStance"}
    cardInfo.upgradeCards.seizeTheInitiative = {name = "Seize The Initiative", ptCost = 5, varName = "seizeTheInitiative"}

    -- sidearm
    cardInfo.upgradeCards.a300 = {name = "A-300", ptCost = 0, varName = "a300"}
    cardInfo.upgradeCards.a180 = {name = "A-180", ptCost = 0, varName = "a180"}
    cardInfo.upgradeCards.jynsSE14 = {name = "Jyns SE-14 Blaster", ptCost = 10, varName = "jynsSE14"}
    cardInfo.upgradeCards.a280CFESniperConfig = {name = "A-280-CFE Sniper Config", ptCost = 10, varName = "a280CFESniperConfig"}
    cardInfo.upgradeCards.idensDLT20ARifle = {name = "Idens DLT-20A Rifle", ptCost = 15, varName = "idensDLT20ARifle"}
    cardInfo.upgradeCards.idensTL50Repeater = {name = "Idens TL-50 Repeater", ptCost = 15, varName = "idensTL50Repeater"}
    cardInfo.upgradeCards.e11D = {name = "E-11D", ptCost = 8, varName = "e11D"}
    cardInfo.upgradeCards.theDarksaber = {name = "The Darksaber", ptCost = 15, varName = "theDarksaber"}
    cardInfo.upgradeCards.dt57Annihilator = {name = 'DT-57 "Annihilator"', ptCost = 12, varName = "dt57Annihilator"}
    cardInfo.upgradeCards.vibroswords = {name = 'Vibroswords', ptCost = 6, varName = "vibroswords"}
    cardInfo.upgradeCards.deflectorShields = {name = 'Deflector Shields', ptCost = 18, varName = "deflectorShields"}
    cardInfo.upgradeCards.electroGauntlets = {name = 'Electro Gauntlets', ptCost = 10, varName = "electroGauntlets"}
    cardInfo.upgradeCards.lootedE5Blaster = {name = 'Looted E-5 Blaster', ptCost = 5, varName = "lootedE5Blaster"}
    cardInfo.upgradeCards.jetpackRockets = {name = 'Jetpack Rockets', ptCost = 8, varName = "jetpackRockets"}
    cardInfo.upgradeCards.anakinFlaw = {name = 'Not A Story The Jedi Would Tell', ptCost = 0, varName = "anakinFlaw"}
    cardInfo.upgradeCards.rt97cBlasterRifle = {name = "RT-97C Blaster Rifle", ptCost = 10, varName = "rt97cBlasterRifle"}
    cardInfo.upgradeCards.cr24FlameRifle = {name = "CR-24 Flame Rifle", ptCost = 15, varName = "cr24FlameRifle"}
    cardInfo.upgradeCards.t21BlasterRifle = {name = "T-21 Blaster Rifle", ptCost = 5, varName = "t21BlasterRifle"}
    cardInfo.upgradeCards.j19BoRifleBlasterStaff = {name = 'J-19 Bo-rifle Blaster/Staff', ptCost = 25, varName = "j19BoRifleBlasterStaff"}
    cardInfo.upgradeCards.agentKallusFlaw = {name = 'Developing Sympathies', ptCost = 0, varName = "agentKallusFlaw"}
    cardInfo.upgradeCards.landoFlaw = {name = 'Ive Altered The Deal', ptCost = 0, varName = "landoFlaw"}

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
        cardInfo.upgradeCards.forceGuidance,
        cardInfo.upgradeCards.forceBarrier
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
        cardInfo.upgradeCards.linkedTargetingArray,
        cardInfo.upgradeCards.commandControlArray
    }
    cardInfo.upgradeMenu.separatist.grenade = {
        cardInfo.upgradeCards.concussionGrenades,
        cardInfo.upgradeCards.impactGrenades,
        cardInfo.upgradeCards.fragmentationGrenades,
        cardInfo.upgradeCards.smokeGrenades,
        cardInfo.upgradeCards.empDroidPoppers
    }
    cardInfo.upgradeMenu.separatist.pilot = {
        cardInfo.upgradeCards.tSeriesTacticalDroidPilot,
        cardInfo.upgradeCards.lokDurd,
        cardInfo.upgradeCards.oomSeriesDroidPilot
    }
    cardInfo.upgradeMenu.separatist.leadership = {
        cardInfo.upgradeCards.commandingPresence,
        cardInfo.upgradeCards.esteemedLeader,
        cardInfo.upgradeCards.improvisedOrders,
        cardInfo.upgradeCards.strictOrders,
        cardInfo.upgradeCards.aggressiveTactics,
        cardInfo.upgradeCards.inspiringPresence,
        cardInfo.upgradeCards.vigilance
    }
    cardInfo.upgradeMenu.separatist.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush,
        cardInfo.upgradeCards.situationalAwareness,
        cardInfo.upgradeCards.offensiveStance,
        cardInfo.upgradeCards.seizeTheInitiative
    }
    cardInfo.upgradeMenu.separatist.generalGrievousSideArm = {
        cardInfo.upgradeCards.dt57Annihilator
    }
    cardInfo.upgradeMenu.separatist.cadBaneSideArm = {
        cardInfo.upgradeCards.electroGauntlets
    }
    cardInfo.upgradeMenu.separatist.b1BattleDroidsTrooper = {
        cardInfo.upgradeCards.b1BattleDroid,
        cardInfo.upgradeCards.oomSeriesBattleDroid,
        cardInfo.upgradeCards.b1SecurityDroid,
        cardInfo.upgradeCards.tSeriesTacticalDroid,
        cardInfo.upgradeCards.evSeriesMedicalDroid,
        cardInfo.upgradeCards.pkSeriesWorkerDroid,
        cardInfo.upgradeCards.viperReconDroid
    }
    cardInfo.upgradeMenu.separatist.b1BattleDroidsSpecialist = {
        cardInfo.upgradeCards.e60RB1Trooper,
        cardInfo.upgradeCards.e5CB1Trooper,
        cardInfo.upgradeCards.e5sB1Trooper,
        cardInfo.upgradeCards.radiationCannonB1Trooper
    }

    cardInfo.upgradeMenu.separatist.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.ascensionCables,
        cardInfo.upgradeCards.portableScanner
    }
    cardInfo.upgradeMenu.separatist.b1Tech = {
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.portableScanner
    }

    cardInfo.upgradeMenu.separatist.b2SuperBattleDroidTrooper = {
      cardInfo.upgradeCards.b2SuperBattleDroid,
      cardInfo.upgradeCards.tSeriesTacticalDroid,
      cardInfo.upgradeCards.evSeriesMedicalDroid,
      cardInfo.upgradeCards.pkSeriesWorkerDroid,
      cardInfo.upgradeCards.viperReconDroid
    }

    cardInfo.upgradeMenu.separatist.b2SuperBattleDroidSpecialist = {
      cardInfo.upgradeCards.b2ACMTrooper,
      cardInfo.upgradeCards.b2HATrooper
    }

    cardInfo.upgradeMenu.separatist.bxCommandoDroidSpecialist = {
      cardInfo.upgradeCards.bxCommandoDroidSniper,
      cardInfo.upgradeCards.bxCommandoDroidSaboteur
    }

    cardInfo.upgradeMenu.separatist.bxCommandoDroidSpecialistLeader = {
      cardInfo.upgradeCards.bxCommandoDroidSniperLeader,
      cardInfo.upgradeCards.bxCommandoDroidSaboteurLeader
    }

    cardInfo.upgradeMenu.separatist.bxCommandoDroidSideArm = {
      cardInfo.upgradeCards.vibroswords,
      cardInfo.upgradeCards.deflectorShields
    }

    cardInfo.upgradeMenu.separatist.ordnance = {
      cardInfo.upgradeCards.highEnergyShells,
      cardInfo.upgradeCards.armorPiercingShells,
      cardInfo.upgradeCards.bunkerBusterShells
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
        cardInfo.upgradeCards.hope,
        cardInfo.upgradeCards.forceBarrier,
        cardInfo.upgradeCards.forceChoke,
        cardInfo.upgradeCards.anger,
        cardInfo.upgradeCards.fear
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
        cardInfo.upgradeCards.linkedTargetingArray,
        cardInfo.upgradeCards.commandControlArray
    }

    cardInfo.upgradeMenu.republic.tx130Pilot = {
      cardInfo.upgradeCards.aaylaSecura,
      cardInfo.upgradeCards.veteranClonePilot,
      cardInfo.upgradeCards.ploKoon
    }
    cardInfo.upgradeMenu.republic.leadership = {
        cardInfo.upgradeCards.commandingPresence,
        cardInfo.upgradeCards.esteemedLeader,
        cardInfo.upgradeCards.improvisedOrders,
        cardInfo.upgradeCards.strictOrders,
        cardInfo.upgradeCards.aggressiveTactics,
        cardInfo.upgradeCards.inspiringPresence,
        cardInfo.upgradeCards.vigilance
    }
    cardInfo.upgradeMenu.republic.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush,
        cardInfo.upgradeCards.situationalAwareness,
        cardInfo.upgradeCards.offensiveStance,
        cardInfo.upgradeCards.seizeTheInitiative
    }
    cardInfo.upgradeMenu.republic.padmeSideArm = {
        cardInfo.upgradeCards.lootedE5Blaster
    }
    cardInfo.upgradeMenu.republic.anakinFlawCard = {
        cardInfo.upgradeCards.anakinFlaw
    }
    cardInfo.upgradeMenu.republic.phaseICloneTroopersTrooper = {
        cardInfo.upgradeCards.phaseICloneTrooper,
        cardInfo.upgradeCards.phaseICloneSpecialist,
        cardInfo.upgradeCards.phaseICloneCaptain,
        cardInfo.upgradeCards.cloneCommander,
        cardInfo.upgradeCards.cloneCommsTechnician,
        cardInfo.upgradeCards.cloneEngineer,
        cardInfo.upgradeCards.cloneMedic
    }
    cardInfo.upgradeMenu.republic.phaseICloneTroopersSpecialist = {
        cardInfo.upgradeCards.z6PhaseITrooper,
        cardInfo.upgradeCards.dc15PhaseITrooper,
        cardInfo.upgradeCards.dp23PhaseITrooper,
        cardInfo.upgradeCards.rps6PhaseITrooper,
        cardInfo.upgradeCards.echo,
        cardInfo.upgradeCards.fives
    }
    cardInfo.upgradeMenu.republic.phaseIICloneTroopersTrooper = {
        cardInfo.upgradeCards.phaseIICloneTrooper,
        cardInfo.upgradeCards.cloneCommander,
        cardInfo.upgradeCards.cloneCommsTechnician,
        cardInfo.upgradeCards.cloneEngineer,
        cardInfo.upgradeCards.cloneMedic
    }

    cardInfo.upgradeMenu.republic.phaseIICloneTrooperSpecialist = {
      cardInfo.upgradeCards.z6PhaseIITrooper,
      cardInfo.upgradeCards.mortarPhaseIITrooper,
      cardInfo.upgradeCards.echo,
      cardInfo.upgradeCards.fives
    }

    cardInfo.upgradeMenu.republic.arcTroopersSpecialist = {
      cardInfo.upgradeCards.arcTrooperDC15x,
      cardInfo.upgradeCards.echo,
      cardInfo.upgradeCards.fives
    }

    cardInfo.upgradeMenu.republic.arcTroopersSpecialistLeader = {
      cardInfo.upgradeCards.arcTrooperDC15xLeader,
      cardInfo.upgradeCards.echo,
      cardInfo.upgradeCards.fives
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
        cardInfo.upgradeCards.smokeGrenades,
        cardInfo.upgradeCards.empDroidPoppers
    }
    cardInfo.upgradeMenu.republic.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.ascensionCables,
        cardInfo.upgradeCards.portableScanner
    }
    cardInfo.upgradeMenu.republic.rexTech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.jt12Jetpacks,
        cardInfo.upgradeCards.ascensionCables,
        cardInfo.upgradeCards.portableScanner

    }
    cardInfo.upgradeMenu.republic.arcTech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.jt12Jetpacks,
        cardInfo.upgradeCards.ascensionCables,
        cardInfo.upgradeCards.portableScanner

    }

    cardInfo.upgradeMenu.republic.republicATRTHardPoint = {
        cardInfo.upgradeCards.rotaryBlaster,
        cardInfo.upgradeCards.laserCannon,
        cardInfo.upgradeCards.flamethrower
    }

    cardInfo.upgradeMenu.republic.tx130Hardpoint = {
      cardInfo.upgradeCards.tx130beamcannonturret,
      cardInfo.upgradeCards.tx130twinlaserturret
    }

    cardInfo.upgradeMenu.republic.ordnance = {
      cardInfo.upgradeCards.highEnergyShells,
      cardInfo.upgradeCards.armorPiercingShells,
      cardInfo.upgradeCards.bunkerBusterShells
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
        cardInfo.upgradeCards.hope,
        cardInfo.upgradeCards.forceBarrier
    }
    cardInfo.upgradeMenu.rebel.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.ascensionCables,
        cardInfo.upgradeCards.portableScanner
    }
    cardInfo.upgradeMenu.rebel.sabineWrenTech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.personalCombatShield,
        cardInfo.upgradeCards.electroGrapplingLine,
        cardInfo.upgradeCards.ascensionCables

    }
    cardInfo.upgradeMenu.rebel.grenade = {
        cardInfo.upgradeCards.concussionGrenades,
        cardInfo.upgradeCards.impactGrenades,
        cardInfo.upgradeCards.fragmentationGrenades,
        cardInfo.upgradeCards.smokeGrenades,
        cardInfo.upgradeCards.empDroidPoppers
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
        cardInfo.upgradeCards.linkedTargetingArray,
        cardInfo.upgradeCards.commandControlArray
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
        cardInfo.upgradeCards.mpl57IonTrooper,
        cardInfo.upgradeCards.sx21Trooper,
        cardInfo.upgradeCards.dlt20ATrooper
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
        cardInfo.upgradeCards.offensivePush,
        cardInfo.upgradeCards.situationalAwareness,
        cardInfo.upgradeCards.offensiveStance,
        cardInfo.upgradeCards.seizeTheInitiative
    }
    cardInfo.upgradeMenu.rebel.rebelTrooperTrooper = {
        cardInfo.upgradeCards.rebelTrooper,
        cardInfo.upgradeCards.rebelOfficer,
        cardInfo.upgradeCards.medicalDroid21B,
        cardInfo.upgradeCards.r5AstromechDroid,
        cardInfo.upgradeCards.rebelCommsTechnician,
        cardInfo.upgradeCards.rebelTrooperSpecialist,
        cardInfo.upgradeCards.rebelTrooperCaptain
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
        cardInfo.upgradeCards.aggressiveTactics,
        cardInfo.upgradeCards.inspiringPresence,
        cardInfo.upgradeCards.vigilance
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
    cardInfo.upgradeMenu.rebel.mandalorianResistanceSpecialist = {
      cardInfo.upgradeCards.beskadDuelist,
      cardInfo.upgradeCards.ursaWren,
      cardInfo.upgradeCards.tristanWren
    }
    cardInfo.upgradeMenu.rebel.clanWrenSpecialist = {
      cardInfo.upgradeCards.ursaWren,
      cardInfo.upgradeCards.tristanWren
    }
    cardInfo.upgradeMenu.rebel.mandalorianResistanceSideArm = {
      cardInfo.upgradeCards.jetpackRockets
    }
    cardInfo.upgradeMenu.rebel.jynErsoSideArm = {
        cardInfo.upgradeCards.a180,
        cardInfo.upgradeCards.jynsSE14
    }
    cardInfo.upgradeMenu.rebel.cassianAndorSideArm = {
        cardInfo.upgradeCards.a280CFESniperConfig
    }
    cardInfo.upgradeMenu.rebel.k2soSideArm = {
        cardInfo.upgradeCards.jynsSE14
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
    cardInfo.upgradeMenu.rebel.landoFlawCard = {
        cardInfo.upgradeCards.landoFlaw
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
        cardInfo.upgradeCards.forceGuidance,
        cardInfo.upgradeCards.forceBarrier
    }
    cardInfo.upgradeMenu.imperial.tech = {
        cardInfo.upgradeCards.targetingScopes,
        cardInfo.upgradeCards.grapplingHooks,
        cardInfo.upgradeCards.environmentalGear,
        cardInfo.upgradeCards.emergencyStims,
        cardInfo.upgradeCards.reconIntel,
        cardInfo.upgradeCards.electrobinoculars,
        cardInfo.upgradeCards.ascensionCables,
        cardInfo.upgradeCards.portableScanner
    }
    cardInfo.upgradeMenu.imperial.grenade = {
        cardInfo.upgradeCards.concussionGrenades,
        cardInfo.upgradeCards.impactGrenades,
        cardInfo.upgradeCards.fragmentationGrenades,
        cardInfo.upgradeCards.smokeGrenades,
        cardInfo.upgradeCards.empDroidPoppers
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
        cardInfo.upgradeCards.linkedTargetingArray,
        cardInfo.upgradeCards.commandControlArray
    }
    cardInfo.upgradeMenu.imperial.stormtrooperSpecialist = {
        cardInfo.upgradeCards.hh12Stormtrooper,
        cardInfo.upgradeCards.dlt19Stormtrooper,
        cardInfo.upgradeCards.rt97CStormtrooper,
        cardInfo.upgradeCards.t21Stormtrooper,
        cardInfo.upgradeCards.delMeeko,
        cardInfo.upgradeCards.gideonHask
    }

    cardInfo.upgradeMenu.imperial.stormtrooperTrooper = {
        cardInfo.upgradeCards.stormtrooper,
        cardInfo.upgradeCards.imperialOfficer,
        cardInfo.upgradeCards.fx9MedicalDroid,
        cardInfo.upgradeCards.r4AstromechDroid,
        cardInfo.upgradeCards.imperialCommsTechnician,
        cardInfo.upgradeCards.stormtrooperCaptain,
        cardInfo.upgradeCards.stormtrooperSpecialist
    }
    cardInfo.upgradeMenu.imperial.snowtrooperSpecialist = {
        cardInfo.upgradeCards.t7IonSnowtrooper,
        cardInfo.upgradeCards.flametrooper,
        cardInfo.upgradeCards.delMeeko,
        cardInfo.upgradeCards.gideonHask
    }
    cardInfo.upgradeMenu.imperial.shoretroopersSpecialist = {
        cardInfo.upgradeCards.t21BTrooper,
        cardInfo.upgradeCards.delMeeko,
        cardInfo.upgradeCards.gideonHask
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
    cardInfo.upgradeMenu.imperial.isfSpecialist = {
      cardInfo.upgradeCards.isfT21,
      cardInfo.upgradeCards.delMeeko,
      cardInfo.upgradeCards.gideonHask
    }
    cardInfo.upgradeMenu.imperial.infernoSquadSpecialist = {
      cardInfo.upgradeCards.delMeeko,
      cardInfo.upgradeCards.gideonHask
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
        cardInfo.upgradeCards.aggressiveTactics,
        cardInfo.upgradeCards.inspiringPresence,
        cardInfo.upgradeCards.vigilance
    }
    cardInfo.upgradeMenu.imperial.tactics = {
        cardInfo.upgradeCards.duckAndCover,
        cardInfo.upgradeCards.hunter,
        cardInfo.upgradeCards.tenacity,
        cardInfo.upgradeCards.endurance,
        cardInfo.upgradeCards.overwatch,
        cardInfo.upgradeCards.offensivePush,
        cardInfo.upgradeCards.situationalAwareness,
        cardInfo.upgradeCards.offensiveStance,
        cardInfo.upgradeCards.seizeTheInitiative
    }
    cardInfo.upgradeMenu.imperial.groundPilot = {
        cardInfo.upgradeCards.generalWeiss,
        cardInfo.upgradeCards.firstSergeantArbmab,
        cardInfo.upgradeCards.imperialHammersEliteArmorPilot
    }
    cardInfo.upgradeMenu.imperial.idenVersioSideArm = {
        cardInfo.upgradeCards.idensDLT20ARifle,
        cardInfo.upgradeCards.idensTL50Repeater
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
        cardInfo.upgradeCards.rt97cBlasterRifle,
        cardInfo.upgradeCards.cr24FlameRifle,
        cardInfo.upgradeCards.t21BlasterRifle
    }
    cardInfo.upgradeMenu.imperial.agentKallusSideArm = {
        cardInfo.upgradeCards.j19BoRifleBlasterStaff
    }
    cardInfo.upgradeMenu.imperial.agentKallusFlawCard = {
        cardInfo.upgradeCards.agentKallusFlaw
    }

    -- unitCard GUID
    cardInfo.unitCardsGUID = "8e9aea"
    cardInfo.upgradeCardsGUID = "ffc227"

    -- unitCards
    cardInfo.unitCards = {}
    -- Separatist
    cardInfo.unitCards.generalGrievous = {
        ptCost = 170 , availableUpgrades = {
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
        ptCost = 200 , availableUpgrades = {
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
    cardInfo.unitCards.tSeriesTacticalDroid = {
        ptCost = 55 , availableUpgrades = {
            cardInfo.upgradeMenu.separatist.leadership,
            cardInfo.upgradeMenu.separatist.comms,
            cardInfo.upgradeMenu.separatist.tech
        },
        miniInfo = {
            miniInfo.tSeriesTacticalDroid
        },
        tokenName = "Separatist Commander Command Token",
        fullName = "T-Series Tactical Droid",
        rank = "Commander"
    }
    cardInfo.unitCards.cadBane = {
        ptCost = 125 , availableUpgrades = {
            cardInfo.upgradeMenu.separatist.tactics,
            cardInfo.upgradeMenu.separatist.comms,
            cardInfo.upgradeMenu.separatist.tech,
            cardInfo.upgradeMenu.separatist.cadBaneSideArm,
            cardInfo.upgradeMenu.separatist.grenade
        },
        miniInfo = {
            miniInfo.cadBane
        },
        tokenName = "Separatist Operative Command Token",
        fullName = "Cad Bane",
        rank = "Operative"
    }
    cardInfo.unitCards.maul = {
        ptCost = 160,
        availableUpgrades = {
            cardInfo.upgradeMenu.separatist.force,
            cardInfo.upgradeMenu.separatist.force,
            cardInfo.upgradeMenu.separatist.tactics,
            cardInfo.upgradeMenu.separatist.tactics
        },
        miniInfo = {
            miniInfo.maul
        },
        tokenName = "Separatist Operative Command Token",
        fullName = "Maul",
        rank = "Operative"
    }
    cardInfo.unitCards.b1BattleDroids = {
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
        ptCost = 45,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.b2SuperBattleDroidSpecialist,
          cardInfo.upgradeMenu.separatist.b2SuperBattleDroidTrooper,
          cardInfo.upgradeMenu.separatist.comms
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
    cardInfo.unitCards.bxCommandoDroids = {
        ptCost = 68,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.bxCommandoDroidSpecialist,
          cardInfo.upgradeMenu.separatist.tactics,
          cardInfo.upgradeMenu.separatist.bxCommandoDroidSideArm,
          cardInfo.upgradeMenu.separatist.comms,
          cardInfo.upgradeMenu.separatist.grenade
        },
        miniInfo = {
            miniInfo.bxCommandoDroidLeader,
            miniInfo.bxCommandoDroid1,
            miniInfo.bxCommandoDroid2,
            miniInfo.bxCommandoDroid3
        },
        tokenName = "Separatist Special Forces Command Token",
        fullName = "BX Commando Droids",
        rank = "Special Forces"
    }
    cardInfo.unitCards.bxCommandoDroidsStrikeTeam = {
        ptCost = 20,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.bxCommandoDroidSpecialistLeader,
          cardInfo.upgradeMenu.separatist.tactics,
          cardInfo.upgradeMenu.separatist.bxCommandoDroidSideArm,
          cardInfo.upgradeMenu.separatist.comms,
          cardInfo.upgradeMenu.separatist.grenade
        },
        miniInfo = {
            miniInfo.bxCommandoDroid1
        },
        tokenName = "Separatist Special Forces Command Token",
        fullName = "BX Commando Droids Strike Team",
        rank = "Special Forces"
    }
    cardInfo.unitCards.drk1SithProbeDroids = {
        ptCost = 35,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.comms
        },
        miniInfo = {
            miniInfo.drk1SithProbeDroidLeader,
            miniInfo.drk1SithProbeDroid1,
            miniInfo.drk1SithProbeDroid2
        },
        tokenName = "Separatist Special Forces Command Token",
        fullName = "DRK-1 Sith Probe Droids",
        rank = "Special Forces"
    }
    cardInfo.unitCards.droidekas = {
        ptCost = 80,
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
    cardInfo.unitCards.STAP = {
        ptCost = 73,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.emplacementVehicleComms
        },
        miniInfo = {
            miniInfo.STAPLeader,
            miniInfo.STAP1
        },
        tokenName = "Separatist Support Command Token",
        fullName = "STAP Riders",
        rank = "Support"
    }
    cardInfo.unitCards.aatTank = {
        ptCost = 170,
        availableUpgrades = {
          cardInfo.upgradeMenu.separatist.pilot,
          cardInfo.upgradeMenu.separatist.ordnance,
          cardInfo.upgradeMenu.separatist.ordnance,
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
        ptCost = 170 , availableUpgrades = {
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
        ptCost = 90 , availableUpgrades = {
            cardInfo.upgradeMenu.republic.leadership,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.rexTech,
            cardInfo.upgradeMenu.republic.rexTech,
            cardInfo.upgradeMenu.republic.grenade
        },
        miniInfo = {
            miniInfo.cloneCaptainRex
        },
        tokenName = "Republic Commander Command Token",
        fullName = "Clone Captain Rex",
        rank = "Commander"
    }
    cardInfo.unitCards.anakinSkywalker = {
        ptCost = 160 , availableUpgrades = {
            cardInfo.upgradeMenu.republic.force,
            cardInfo.upgradeMenu.republic.force,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.anakinFlawCard
        },
        miniInfo = {
            miniInfo.anakinSkywalker
        },
        tokenName = "Republic Commander Command Token",
        fullName = "Anakin Skywalker",
        rank = "Commander"
    }
    cardInfo.unitCards.cloneCommander = {
        ptCost = 55 , availableUpgrades = {
            cardInfo.upgradeMenu.republic.leadership,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.tech
        },
        miniInfo = {
            miniInfo.cloneCommander
        },
        tokenName = "Republic Commander Command Token",
        fullName = "Clone Commander",
        rank = "Commander"
    }
    cardInfo.unitCards.republicR2d2 = {
        ptCost = 45,
        availableUpgrades = {
            cardInfo.upgradeMenu.separatist.comms
        },
        miniInfo = {miniInfo.r2d2},
        tokenName = "Republic Operative Command Token",
        fullName = "R2-D2",
        rank = "Operative"
    }
    cardInfo.unitCards.republicC3po = {
        ptCost = 15,
        availableUpgrades = {
        },
        miniInfo = {miniInfo.c3po},
        tokenName = "",
        fullName = "C-3PO",
        rank = "Counterpart",
        noToken = true
    }
    cardInfo.unitCards.padme = {
        ptCost = 90,
        availableUpgrades = {
          cardInfo.upgradeMenu.republic.leadership,
          cardInfo.upgradeMenu.republic.tactics,
          cardInfo.upgradeMenu.republic.tech,
          cardInfo.upgradeMenu.republic.padmeSideArm
        },
        miniInfo = {miniInfo.padme},
        tokenName = "Republic Operative Command Token",
        fullName = "Padme Amidala",
        rank = "Operative"
    }
    cardInfo.unitCards.phaseICloneTroopers = {
        ptCost = 52,
        availableUpgrades = {
            cardInfo.upgradeMenu.republic.phaseICloneTroopersTrooper,
            cardInfo.upgradeMenu.republic.phaseICloneTroopersSpecialist,
            cardInfo.upgradeMenu.republic.tech,
            cardInfo.upgradeMenu.republic.tech,
            cardInfo.upgradeMenu.republic.tactics,
            cardInfo.upgradeMenu.republic.comms,
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
        ptCost = 62,
        availableUpgrades = {
          cardInfo.upgradeMenu.republic.phaseIICloneTrooperSpecialist,
          cardInfo.upgradeMenu.republic.phaseIICloneTroopersTrooper,
          cardInfo.upgradeMenu.republic.tactics,
          cardInfo.upgradeMenu.republic.tech,
          cardInfo.upgradeMenu.republic.comms,
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
    cardInfo.unitCards.arcTroopers = {
        ptCost = 78,
        availableUpgrades = {
          cardInfo.upgradeMenu.republic.arcTroopersSpecialist,
          cardInfo.upgradeMenu.republic.tactics,
          cardInfo.upgradeMenu.republic.comms,
          cardInfo.upgradeMenu.republic.arcTech,
          cardInfo.upgradeMenu.republic.arcTech,
          cardInfo.upgradeMenu.republic.grenade
        },
        miniInfo = {
            miniInfo.arcTrooperLeader,
            miniInfo.arcTrooper1,
            miniInfo.arcTrooper2,
            miniInfo.arcTrooper3
        },
        tokenName = "Republic Special Forces Command Token",
        fullName = "ARC Troopers",
        rank = "Special Forces"
    }
    cardInfo.unitCards.arcTroopersStrikeTeam = {
        ptCost = 27,
        availableUpgrades = {
          cardInfo.upgradeMenu.republic.arcTroopersSpecialistLeader,
          cardInfo.upgradeMenu.republic.tactics,
          cardInfo.upgradeMenu.republic.comms,
          cardInfo.upgradeMenu.republic.arcTech,
          cardInfo.upgradeMenu.republic.arcTech,
          cardInfo.upgradeMenu.republic.grenade
        },
        miniInfo = {
            miniInfo.arcTrooper1
        },
        tokenName = "Republic Special Forces Command Token",
        fullName = "ARC Troopers Strike Team",
        rank = "Special Forces"
    }
    cardInfo.unitCards.barcSpeeder = {
        ptCost = 60,
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
    cardInfo.unitCards.republicATRT = {
        ptCost = 65,
        availableUpgrades = {
            cardInfo.upgradeMenu.republic.republicATRTHardPoint,
            cardInfo.upgradeMenu.republic.emplacementVehicleComms
        },
        miniInfo = {miniInfo.republicATRT},
        tokenName = "Republic Support Command Token",
        fullName = "Republic AT-RT",
        rank = "Support"
    }
    cardInfo.unitCards.saberTank = {
        ptCost = 170,
        availableUpgrades = {
          cardInfo.upgradeMenu.republic.tx130Pilot,
          cardInfo.upgradeMenu.republic.tx130Hardpoint,
          cardInfo.upgradeMenu.republic.ordnance,
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
        ptCost = 195 , availableUpgrades = {
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
        ptCost = 100 , availableUpgrades = {
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
        ptCost = 100 , availableUpgrades = {
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
    cardInfo.unitCards.cassianAndor = {
        ptCost = 90 ,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.cassianAndorSideArm
        },
        miniInfo = {
            miniInfo.cassianAndor
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Cassian Andor",
        rank = "Commander"
    }
    cardInfo.unitCards.landoCalrissian = {
        ptCost = 105 ,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.leadership,
            cardInfo.upgradeMenu.rebel.tactics,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.landoFlawCard
        },
        miniInfo = {
            miniInfo.landoCalrissian
        },
        tokenName = "Rebel Commander Command Token",
        fullName = "Lando Calrissian",
        rank = "Commander"
    }
    cardInfo.unitCards.k2so = {
        ptCost = 70,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.comms,
            cardInfo.upgradeMenu.rebel.k2soSideArm
        },
        miniInfo = {miniInfo.k2so},
        tokenName = "Rebel Operative Command Token",
        fullName = "K-2SO",
        rank = "Operative",
    }
    cardInfo.unitCards.rebelOfficer = {
        ptCost = 45 , availableUpgrades = {
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
        ptCost = 90,
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
        ptCost = 45,
        availableUpgrades = {
            cardInfo.upgradeMenu.separatist.comms
        },
        miniInfo = {miniInfo.r2d2},
        tokenName = "Rebel Operative Command Token",
        fullName = "R2-D2",
        rank = "Operative"
    }
    cardInfo.unitCards.c3po = {
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
        ptCost = 40,
        availableUpgrades = {
            cardInfo.upgradeMenu.rebel.rebelTrooperTrooper,
            cardInfo.upgradeMenu.rebel.rebelTrooperSpecialist,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.grenade,
            cardInfo.upgradeMenu.rebel.comms,
            cardInfo.upgradeMenu.rebel.tech,
            cardInfo.upgradeMenu.rebel.tactics
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
        ptCost = 40,
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
        ptCost = 50,
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
        ptCost = 69,
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
        ptCost = 58,
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
    cardInfo.unitCards.mandalorianResistance = {
      ptCost = 72,
      availableUpgrades = {
        cardInfo.upgradeMenu.rebel.mandalorianResistanceSpecialist,
        cardInfo.upgradeMenu.rebel.tactics,
        cardInfo.upgradeMenu.rebel.comms,
        cardInfo.upgradeMenu.rebel.tech,
        cardInfo.upgradeMenu.rebel.mandalorianResistanceSideArm,
        cardInfo.upgradeMenu.rebel.grenade
      },
      miniInfo = {
          miniInfo.mandalorianResistanceLeader,
          miniInfo.mandalorianResistance1,
          miniInfo.mandalorianResistance2
      },
      tokenName = "Rebel Special Forces Command Token",
      fullName = "Mandalorian Resistance",
      rank = "Special Forces"
    }
    cardInfo.unitCards.clanWren = {
      ptCost = 34,
      availableUpgrades = {
        cardInfo.upgradeMenu.rebel.clanWrenSpecialist,
        cardInfo.upgradeMenu.rebel.clanWrenSpecialist,
        cardInfo.upgradeMenu.rebel.tactics,
        cardInfo.upgradeMenu.rebel.comms,
        cardInfo.upgradeMenu.rebel.tech,
        cardInfo.upgradeMenu.rebel.mandalorianResistanceSideArm,
        cardInfo.upgradeMenu.rebel.grenade
      },
      miniInfo = {
          miniInfo.clanWren1
      },
      tokenName = "Rebel Special Forces Command Token",
      fullName = "Clan Wren",
      rank = "Special Forces"
    }
    cardInfo.unitCards.atrt = {
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
        ptCost = 95,
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
        ptCost = 130,
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
        ptCost = 60,
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
        ptCost = 175,
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
        ptCost = 155,
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
        ptCost = 200,
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
    cardInfo.unitCards.idenVersio = {
        ptCost = 100,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.idenVersioSideArm
        },
        miniInfo = {miniInfo.idenVersio},
        tokenName = "Imperial Commander Command Token",
        fullName = "Iden Versio",
        rank = "Commander"
    }
    cardInfo.unitCards.id10 = {
        ptCost = 15,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.comms
        },
        miniInfo = {miniInfo.id10},
        tokenName = nil,
        fullName = "Idens ID10 Seeker Droid",
        rank = "Counterpart",
        noToken = true
    }
    cardInfo.unitCards.agentKallus = {
        ptCost = 90 ,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.leadership,
            cardInfo.upgradeMenu.imperial.tactics,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.agentKallusSideArm,
            cardInfo.upgradeMenu.imperial.agentKallusFlawCard
        },
        miniInfo = {
            miniInfo.agentKallus
        },
        tokenName = "Imperial Commander Command Token",
        fullName = "Agent Kallus",
        rank = "Commander"
    }
    cardInfo.unitCards.imperialOfficer = {
        ptCost = 45,
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
        ptCost = 125,
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
        ptCost = 44,
        availableUpgrades = {
            cardInfo.upgradeMenu.imperial.stormtrooperTrooper,
            cardInfo.upgradeMenu.imperial.stormtrooperSpecialist,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.grenade,
            cardInfo.upgradeMenu.imperial.comms,
            cardInfo.upgradeMenu.imperial.tech,
            cardInfo.upgradeMenu.imperial.tactics
        },
        miniInfo = {
            miniInfo.stormtrooperLeader, miniInfo.stormtrooper1, miniInfo.stormtrooper2, miniInfo.stormtrooper3
        },
        tokenName = "Imperial Corps Command Token",
        fullName = "Stormtroopers",
        rank = "Corps"
    }
    cardInfo.unitCards.snowtrooper = {
        ptCost = 44,
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
        ptCost = 38,
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
        ptCost = 48,
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
    cardInfo.unitCards.isf = {
      ptCost = 68,
      availableUpgrades = {
        cardInfo.upgradeMenu.imperial.isfSpecialist,
        cardInfo.upgradeMenu.imperial.tactics,
        cardInfo.upgradeMenu.imperial.tactics,
        cardInfo.upgradeMenu.imperial.comms,
        cardInfo.upgradeMenu.imperial.tech,
        cardInfo.upgradeMenu.imperial.grenade
      },
      miniInfo = {
        miniInfo.isfLeader,
        miniInfo.isf1,
        miniInfo.isf2,
        miniInfo.isf3
      },
      tokenName = "Imperial Special Forces Command Token",
      fullName = "Imperial Special Forces",
      rank = "Special Forces"
    }
    cardInfo.unitCards.infernoSquad = {
      ptCost = 34,
      availableUpgrades = {
        cardInfo.upgradeMenu.imperial.infernoSquadSpecialist,
        cardInfo.upgradeMenu.imperial.infernoSquadSpecialist,
        cardInfo.upgradeMenu.imperial.tactics,
        cardInfo.upgradeMenu.imperial.tactics,
        cardInfo.upgradeMenu.imperial.comms,
        cardInfo.upgradeMenu.imperial.tech,
        cardInfo.upgradeMenu.imperial.grenade
      },
      miniInfo = {
        miniInfo.isfInferno,
      },
      tokenName = "Imperial Special Forces Command Token",
      fullName = "Inferno Squad",
      rank = "Special Forces"
    }
    cardInfo.unitCards.speederBike = {
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
        ptCost = 75,
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
        ptCost = 160,
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
        ptCost = 145,
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
        diffuse = getObjectFromGUID(clockGUIDs.red).Clock
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

function onLoad(save_state)
    -- BUTTONS
    self.interactable = false
    listBuilderOption1 = getObjectFromGUID("58f562")
    listBuilderOption2 = getObjectFromGUID("bcaa6a")
    listBuilderOption3 = getObjectFromGUID("d01adc")
    listBuilderOption4 = getObjectFromGUID("887737")

    listBuilderOption1Button = getObjectFromGUID("e5ab6a")
    listBuilderOption2Button = getObjectFromGUID("16651c")
    listBuilderOption3Button = getObjectFromGUID("5fd41f")
    listBuilderOption4Button = getObjectFromGUID("e1e76b")

    backButton = getObjectFromGUID("002439")

    dataDiskMount = getObjectFromGUID("87a622")

    colorZone = "blue"

    -- INIT
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    battlefieldTint = gameData.getTable("battlefieldTint")
    listBuilder = Global.getTable("listBuilder")
    cardZone = getObjectFromGUID(listBuilder[colorZone .. "ZoneGUID"])
    ptCounter = getObjectFromGUID(listBuilder[colorZone.."CounterGUID"])
    colorSide = colorZone
    battlefieldTable = getObjectFromGUID(Global.getVar("battlefieldTable"))
    cardInfo = Global.getTable("cardInfo")
    templateMenu = Global.getTable("templateMenu")
    miniInfo = Global.getTable("miniInfo")
    unitInfo = Global.getTable("unitInfo")
    unitIDTokenBag = getObjectFromGUID(Global.getVar("unitIDTokenBagGUID"))
    commandTokenData = Global.getTable("commandTokenData")
    commandTokenTrayData = Global.getTable("commandTokenTrayData")

    gameController = Global.getTable("gameController")
    objectiveCards = getObjectFromGUID(gameController.objectiveCardsGUID)
    deploymentCards = getObjectFromGUID(gameController.deploymentCardsGUID)
    conditionsCards = getObjectFromGUID(gameController.conditionsCardsGUID)

    allBattlefieldCards = getObjectFromGUID(gameController.battlefieldCardsGUID)

    deckMount = getObjectFromGUID(listBuilder[colorSide.."DeckMountGUID"])
    deckZone = getObjectFromGUID(listBuilder[colorSide.."DeckZoneGUID"])


    mainMenu()

end


function clearAllButtons()
    listBuilderOption1.clearButtons()
    listBuilderOption2.clearButtons()
    listBuilderOption3.clearButtons()
    listBuilderOption4.clearButtons()
    listBuilderOption1Button.clearButtons()
    listBuilderOption2Button.clearButtons()
    listBuilderOption3Button.clearButtons()
    listBuilderOption4Button.clearButtons()
    backButton.clearButtons()

    listBuilderOption1Button.setColorTint({0,0,0})
    listBuilderOption2Button.setColorTint({0,0,0})
    listBuilderOption3Button.setColorTint({0,0,0})
    backButton.setColorTint({0,0,0})

end


function createOptionButton(optionNumber, optionObj, optionButton, optionClickFunction, optionLabel, optionToolTip,tint)

    _G[colorSide.."ListBuilderOptionFunction"..optionNumber] = function()
        optionButton.AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end

    optionObj.createButton({
        click_function = colorSide.."ListBuilderOptionFunction"..optionNumber, function_owner = self, label = optionLabel, position = {-0.35, 0.3, 0}, scale = {0.5, 0.5, 0.5}, width = 4200, height = 600, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100},tooltip = optionToolTip
    })

    optionButton.createButton({
        click_function = colorSide.."ListBuilderOptionFunction"..optionNumber, function_owner = self, label = "", position = {0, 0.65, 0}, width = 1400, height = 1400, font_size = 1100, color = {1,1,1,0.01},font_color = {1,1,1,100}, tooltip = optionToolTip, alignment = 3
    })

    optionButton.setColorTint(tint)
end

function changeBackButton(optionClickFunction, optionToolTip)
    _G[colorSide.."ListBuilderBackButtonFunction"] = function()
        backButton.AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end

    backButton.createButton({
        click_function = colorSide.."ListBuilderBackButtonFunction", function_owner = self, label = "BACK", position = {0, 0.65, 0}, scale = {1, 1, 0.7}, width = 1500, height = 2000, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = optionToolTip
    })
    backButton.setColorTint({1,0,0})
end

function mainMenu()
    clearAllButtons()

    createOptionButton(1, listBuilderOption1, listBuilderOption1Button, "chooseArmy", "Create Army", "Create a custom Army", {0,0.913,1})
    createOptionButton(2, listBuilderOption2, listBuilderOption2Button, "loadArmy", "Load Army", "Load army from Data Disk", {0,0.913,1})
    createOptionButton(3, listBuilderOption3, listBuilderOption3Button, "clearZone", "Clear Cards", "Clears current cards", {0,0.913,1})
end

function chooseArmy()
    clearAllButtons()

    changeBackButton("mainMenu", "Go back to Main Menu")
    createOptionButton(1, listBuilderOption1, listBuilderOption1Button, "createRebelArmy", "Rebels", "Create a custom Rebel army", {0,0.913,1})
    createOptionButton(2, listBuilderOption2, listBuilderOption2Button, "createImperialArmy", "Imperials", "Create a custom Imperial army", {0,0.913,1})
    createOptionButton(3, listBuilderOption3, listBuilderOption3Button, "createSeparatistArmy", "Separatist", "Create a custom Separatist army", {0,0.913,1})
    createOptionButton(4, listBuilderOption4, listBuilderOption4Button, "createRepublicArmy", "Republic", "Create a custom Republic army", {0,0.913,1})
end

function createArmyMenu()
    clearAllButtons()

    changeBackButton("chooseArmy", "Go back to Faction Selection")
    createOptionButton(1, listBuilderOption1, listBuilderOption1Button, "finishArmy", "Spawn Minis", "Finished creating army", {1,0,0})
    createOptionButton(2, listBuilderOption2, listBuilderOption2Button, "saveArmy", "Save Army", "Save army to Data Disk", {0,0.913,1})
    createOptionButton(3, listBuilderOption3, listBuilderOption3Button, "respawnZone", "Reset Army", "Reset Army Creation", {0,0.913,1})

end

function dud()
end

function loadArmy()
    local diskObjNumber = 0
    diskZone = getObjectFromGUID(listBuilder[colorSide.. "DataDiskZone"])
    diskObjs = diskZone.getObjects()
    diskObjNumber = 0

    for i, obj in pairs(diskObjs) do
        if obj.getTable("listData") != nil then
            loadDisk = obj
            diskObjNumber = i
        end
    end
    if diskObjNumber == 0 then
        loadArmyMenu()
    else
        clearZone()
        --- LOAD COMMAND CARDS
        spawnArmyFromDisk()
    end
end

function spawnUnitIDToken(idSpawnPos, idSpawnRot,idNumber)
    idSpawnRot.y = idSpawnRot.y +180
    idToken = unitIDTokenBag.takeObject({
        position       = idSpawnPos,
        rotation       = idSpawnRot,
        smooth         = false
    })
    if idNumber != 1 then
        idToken.setState(idNumber)
    end
end

function spawnMini(colorSide, miniSpawnPos, miniSpawnRot, miniData)
    local funcSpawnedMini
    if miniData.type and miniData.type == "assetbundle" then
      funcSpawnedMini = spawnObject({
          type           = "Custom_AssetBundle",
          position       = miniSpawnPos,
          rotation       = miniSpawnRot,
          scale          = miniSpawnScale
      })
      funcSpawnedMini.setCustomObject({
          assetbundle = miniData.assetbundle,
          assetbundle_secondary = miniData.assetbundle_secondary,
          type = 1,
          material = 3
      })
    else
      funcSpawnedMini = spawnObject({
          type           = "Custom_Model",
          position       = miniSpawnPos,
          rotation       = miniSpawnRot,
          scale          = miniSpawnScale
      })
      funcSpawnedMini.setCustomObject({
          mesh = miniData.mesh,
          collider = miniData.collider,
          diffuse = miniData[colorSide],
          type = 1,
          material = 3
      })
    end

    funcSpawnedMini.setColorTint(gameData.getTable("battlefieldTint"))
    return funcSpawnedMini
end

function initializeMini(pMiniTable)

    local strColor = pMiniTable.colorSide
    strColor = strColor:gsub("^%l", string.upper)

    -- detect leader units
    leaderInt = 1
    for h, entry in pairs(pMiniTable.miniObjs) do
        if entry.leader == true then
            leaderInt = h
        end
    end

    for i, objEntry in pairs(pMiniTable.miniObjs) do
        -- init mini script
        local selectedMiniScript = ""

        -- SET NAME
        objEntry.obj.setName(strColor.. " "..objEntry.name)
        selectedMiniScript = selectedMiniScript .. "colorSide = '"..pMiniTable.colorSide.."'\nminiName = '"..objEntry.name.."'\n"

        if i == leaderInt then
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

function spawnArmyFromDisk()
    loadListData = loadDisk.getTable("listData")
    spawnArmy(loadListData)
end

function cloneBattlefieldCards()
    allBattlefieldCardsClone = allBattlefieldCards.clone({
        position     = {5,-10,0}
    })
    allBattlefieldCardsClone.setPosition({5,-10,0})
    allBattlefieldCardsClone.setLock(false)
end

function destroyBattlefieldCards()
    destroyObject(allBattlefieldCardsClone)
end

function drawBattlefieldCard(data, cardType)
    for k, entry in pairs(data.battlefieldDeck[cardType]) do
        -- compare to deck
        local cardTable = allBattlefieldCardsClone.getObjects()
        cardInt = -1
        for l, entryCard in pairs(cardTable) do
            if entry == entryCard.nickname then
                cardInt = entryCard.index
                break
            end
        end

        -- draw card
        if cardInt != -1 then
            drawnCard = allBattlefieldCardsClone.takeObject({
                smooth            = false,
                index             = cardInt,
                top               = false
            })
            drawnCard.setLock(false)
            drawnCard.setScale({0.83,0.83,0.83})

            local deckMountPos = deckMount.getPosition()
            deckMountPos.y = deckMountPos.y + 0.23 + (deckHeight * 0.1)
            deckHeight = deckHeight + 1
            drawnCard.setPosition(deckMountPos)
            local deckRot = deckMount.getRotation()
            deckRot.z = 180
            drawnCard.setRotation(deckRot)
        end

    end
end


function spawnArmy(loadListData)
    if loadListData.battlefieldDeck != nil then
        -- deal command Cards
        for i=1,7,1 do
            dealCommandCard(loadListData.commandCards[i])
        end

        -- create battlefield deck
        cloneBattlefieldCards()
        deckHeight = 1
        drawBattlefieldCard(loadListData, "objective")
        drawBattlefieldCard(loadListData, "deployment")
        drawBattlefieldCard(loadListData, "conditions")
        destroyBattlefieldCards()



        -- spawn units
        for n, unit in pairs(loadListData.units) do
            spawnMiniTable = {}

            -- get var name
            if unit.varName != nil then
                spawnMiniTable.varName = unit.varName
            else
                broadcastToAll("Old Data Disk version. Please remake new Data Disk.", {1,1,1})
                break
            end


            -- initialise
            templatePos = listBuilder[colorSide.."TemplatePos"][n]
            spawnMiniTable.colorSide = colorSide
            spawnMiniTable.upgrades = {}
            spawnMiniTable.miniObjs = {}
            spawnMiniTable.unitID = n

            -- SPAWN CARDS
            -- spawn unit Card

            spawnUnitCardObj = spawnUnitCard(unit.unitName, templatePos, self.getRotation())
            spawnMiniTable.unitCardObj = spawnUnitCardObj

            spawnUnitIDToken(templatePos, self.getRotation(), n)


            -- spawn upgrade card

            for j, upgrade in pairs(unit.upgrades) do
                listBuilder = Global.getTable("listBuilder")
                templatePos = listBuilder[colorSide.."TemplatePos"][n]
                spawnUpgradeCard(upgrade.name,templatePos, self.getRotation(), j)

                table.insert(spawnMiniTable.upgrades, upgrade.name)
            end


            -- SPAWN MINIS
            -- mini table

            -- detect leader
            upgradeLeader = false
            for u, upgrade in pairs(unit.upgrades) do
                listBuilder = Global.getTable("listBuilder")

                if cardInfo.upgradeCards[upgrade.varName].miniInfo != nil then
                    if cardInfo.upgradeCards[upgrade.varName].miniInfo.leader == true then
                        upgradeLeader = true
                    end
                end
            end

            for m, data in pairs(cardInfo.unitCards[spawnMiniTable.varName].miniInfo) do
                -- math position
                listBuilder = Global.getTable("listBuilder")
                spawnPos = translatePos(listBuilder[colorSide.."TemplatePos"][n], self.getRotation(), listBuilder.miniSpawnPos[m].c, listBuilder.miniSpawnPos[m].q+90)

                if m == 1 and upgradeLeader == true and data.altModelInfo != nil then
                    passedData = data.altModelInfo
                else
                    passedData = data
                end

                -- spawn Minis
                local spawnedMini = spawnMini(colorSide, spawnPos, {self.getRotation().x,self.getRotation().y + 180, self.getRotation().z}, passedData)

                table.insert(spawnMiniTable.miniObjs, {obj = spawnedMini, name = data.name})
                spawnedMinisNumber = m
            end
--
            -- spawn upgrade minis
            for q, upgrade in pairs(unit.upgrades) do
                listBuilder = Global.getTable("listBuilder")

                if cardInfo.upgradeCards[upgrade.varName].miniInfo != nil then

                    local spawnMiniInfo = cardInfo.upgradeCards[upgrade.varName].miniInfo

                    -- math position
                    spawnedMinisNumber = spawnedMinisNumber + 1

                    local spawnPos = translatePos(listBuilder[colorSide.."TemplatePos"][n], self.getRotation(), listBuilder.miniSpawnPos[spawnedMinisNumber].c, listBuilder.miniSpawnPos[spawnedMinisNumber].q+90)

                    -- spawnMinis

                    local spawnedMini = spawnMini(colorSide, spawnPos, {self.getRotation().x,self.getRotation().y + 180, self.getRotation().z}, spawnMiniInfo)

                    local insertInfo = {obj = spawnedMini, name = spawnMiniInfo.name}

                    if spawnMiniInfo.leader == true then
                        insertInfo.leader = true
                    end

                    table.insert(spawnMiniTable.miniObjs, insertInfo)
                end
            end

            refreshTimer()
            Timer.create({
                identifier     = "initMinis"..timerCounter,
                function_name  = "initializeMini",
                function_owner = self,
                parameters     = spawnMiniTable,
                delay          = 2
            })

            -- spawn command token
            if unitInfo[spawnMiniTable.varName].noToken == nil then
                commandData = {}

                local commandType = unitInfo[spawnMiniTable.varName].commandType
                local commandTray = getObjectFromGUID(commandTokenTrayData[colorSide][commandType])
                local pos = commandTray.getPosition()
                pos.y = pos.y + 0.5 + (0.2 * n)
                local rot = self.getRotation()
                rot.y = rot.y + 180

                commandData.commandType = commandType
                commandData.pos = pos
                commandData.rot = rot
                commandData.varName = spawnMiniTable.varName

                refreshTimer()
                Timer.create({
                    identifier     = "initCommandToken"..timerCounter,
                    function_name  = "initializeCommandToken",
                    function_owner = self,
                    parameters     = commandData,
                    delay          = 2.2
                })
            end



        end
        listBuilder = Global.getTable("listBuilder")
    else
        broadcastToAll("Old Data Disk version. Please remake new Data Disk.", {1,1,1})
    end
end

function initializeCommandToken(cData)


    tokenObj = spawnObject({
        type           = "Custom_Model",
        position       = cData.pos,
        rotation       = cData.rot
    })

    tokenObj.setCustomObject({
        mesh = "http://cloud-3.steamusercontent.com/ugc/786359883314446513/4DBBAC00ABA5EABE88C2A86C3311C3FB6645FF25/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234780866339915/85F7E717B9EFBE0396126CA673DF17EAFEC7D451/",
        diffuse = commandTokenData[colorSide][cData.commandType],
        type = 0,
        material = 3
    })

    tokenObj.setPosition(cData.pos)
    tokenObj.setRotation(cData.rot)

    local strColor = colorSide

    strColor = strColor:gsub("^%l", string.upper)

    tokenObj.setName(strColor .. " " .. cardInfo.unitCards[cData.varName].tokenName)
    local luaScript = "unitName = '"..cData.varName.."'\ncommandType = '"..cData.commandType.."'\ncolorSide = '"..colorSide.."'\n"..listBuilder.tokenScript
    tokenObj.setLuaScript(luaScript)

end

function spawnUnitCard(cardName, passedTemplatePos, passedTemplateRot)
    local templatePosUnit = passedTemplatePos


    local originalUnitCards = getObjectFromGUID(cardInfo.unitCardsGUID)
    copy({originalUnitCards})
    local pastedObj = paste({
        position     = {0,-10,0}
    })
    local unitCards = pastedObj[1]
    local unitCardTable = unitCards.getObjects()

    for i, entry in pairs(unitCardTable) do
        if entry.nickname == cardName then
            cardInt = entry.index
            break
        end
    end

    unitCard = unitCards.takeObject({
        position       = {0,10,0},
        index          = cardInt
    })

    destroyObject(unitCards)

    pos = translatePos(passedTemplatePos, passedTemplateRot, 1.5620819440734, 52.543226290399+90)
    pos.y = passedTemplatePos.y


    unitCard.setRotation({0,passedTemplateRot.y+180,0})
    unitCard.setScale({0.83,1,0.83})

    --unitCard.setVar("ptCost", cardInfo.unitCards[card].ptCost)
    unitCard.setPosition(pos)
    unitCard.setLock(false)

    return unitCard

end

function spawnUpgradeCard(cardName, pTemplatePos, pTemplateRot, upgradeNumber)

    local originalUpgradeCards = getObjectFromGUID(cardInfo.upgradeCardsGUID)
    local upgradeCards = originalUpgradeCards.clone({ position = {0,-30,0} })
    local upgradeCardTable = upgradeCards.getObjects()

    local cardPos = templateMenu.upgradeCardPos[upgradeNumber]

    for i, entry in pairs(upgradeCardTable) do
        if entry.nickname == cardName then
            cardInt = entry.index
            break
        end
    end

    upgradeCard = upgradeCards.takeObject({
        position       = {0,10,0},
        index          = cardInt
    })

    destroyObject(upgradeCards)

    local rotUpgrade = pTemplateRot
    local posUpgrade = pTemplatePos

    local finalPos = translatePos(posUpgrade, rotUpgrade, cardPos.c , cardPos.q+90)

    --finalPos = translatePos(passedTemplatePos, passedTemplateRot, 1.5620819440734, 52.543226290399+90)
    upgradeCard.setScale({0.83,0.83,0.83})
    upgradeCard.setPosition(finalPos)
    upgradeCard.setRotation({0,pTemplateRot.y+180,0})
    upgradeCard.setLock(false)

end


function dealCommandCard(selectionCard)
    -- Uppercase color
    strColor = colorSide
    strColor = strColor:gsub("^%l", string.upper)

    originalCommandCards = getObjectFromGUID(listBuilder.commandCardsGUID)
    commandCards = originalCommandCards.clone({ position = {0,-30,0} })
    commandCardsTable = commandCards.getObjects()
    commandCards.setScale({1,1,1})

    for i, entry in pairs(commandCardsTable) do
        if entry.nickname == selectionCard then

            takenCard = commandCards.takeObject({
                position       = listBuilder.handPos[colorSide].pos ,
                index          = entry.index
            })

            takenCard.setRotation(listBuilder.handPos[colorSide].rot)
            --takenCard.deal(1, "Red", 1)
            -- takenCard.deal(1, strColor)
            break
        end
    end

    destroyObject(commandCards)
end


function loadArmyMenu()
    clearAllButtons()
    changeBackButton("mainMenu", "Go back to Main Menu")
    createOptionButton(1, listBuilderOption1, listBuilderOption1Button, "dud", "Insert Data Disk", "Insert Data Disk into Slot Above", {0,0,0})
    createOptionButton(2, listBuilderOption2, listBuilderOption2Button, "loadArmy", "Load Army", "Load army from Data Disk", {0,0.913,1})
end

function getListData()
    if templateObjs[1][1] != nil then
        listData = {}
        listData.commandCards = {}
        listData.units = {}

        commandCardsNumber = 0

        -- GET DATA
        for i=1,20,1 do
            if templateObjs[i][1].call("getListText") != nil then
                local recievedData = templateObjs[i][1].call("getListText")

                insertTable = {}
                insertTable.unitName = recievedData.unitName
                insertTable.varName = recievedData.varName
                insertTable.upgrades = {}
                for i, entry in pairs(recievedData.upgrades) do
                    insertTable.upgrades[i] = {name = entry.name, varName = entry.varName}
                end
                --insertTable.setTable("upgrades", recievedData.upgrades)

                table.insert(listData.units, insertTable)

            end
        end

        selectedArmyFactionText = Global.getVar(colorZone.."SelectedArmyFaction")

        listData.armyFaction = selectedArmyFactionText

        -- set command Cards

        listData.commandCards = deckBuilderObj.getTable("commandCardSelection")

        table.insert(listData.commandCards, "Standing Orders")


        -- set battlefield deck
        local battlefieldCardSelection = deckBuilderObj.getTable("battlefieldCardSelection")
        listData.battlefieldDeck = {}
        listData.battlefieldDeck.objective = {}
        listData.battlefieldDeck.deployment = {}
        listData.battlefieldDeck.conditions = {}

        n = 1
        for i, entry in pairs(battlefieldCardSelection.objective) do
            table.insert(listData.battlefieldDeck.objective, entry)

            n = n + 1
        end
        for j, entry in pairs(battlefieldCardSelection.deployment) do
            table.insert(listData.battlefieldDeck.deployment, entry)
            n = n + 1
        end
        for k, entry in pairs(battlefieldCardSelection.conditions) do
            table.insert(listData.battlefieldDeck.conditions, entry)
            n = n + 1
        end


        return listData
    else
        return nil
    end
end

function saveArmy()
    -- get listData
    listData = getListData()

    if listData != nil then
        -- parse list

        luaString = "function onload()\nlistData = {}\nlistData.pts = "..totalPts.."\nlistData.armyFaction = '" .. listData.armyFaction .."'\nlistData.commandCards = {}\n"
        -- COMMAND CARDS
        for j=1,7,1 do
            luaString = luaString .. "listData.commandCards[" .. j ..  "] = '"..listData.commandCards[j].."'\n"
        end

        -- UNITS
        luaString = luaString .. "listData.units = {}\n"
        for k, unit in pairs(listData.units) do
            luaString = luaString .. "listData.units["..k.."] = {}\nlistData.units["..k.."].unitName = '" .. listData.units[k].unitName .."'\nlistData.units["..k.."].varName = '" .. listData.units[k].varName .."'\n"
            -- UPGRADES
            luaString = luaString .. "listData.units["..k.."].upgrades = {}\n"
            for l, upgrade in pairs(listData.units[k].upgrades) do

                luaString = luaString .. "listData.units["..k.."].upgrades["..l.."] = {name = '" .. upgrade.name .."', varName = '"..upgrade.varName.."'}\n"
            end
        end
        -- battlefieldDeck
        luaString = luaString .. "listData.battlefieldDeck = {}\nlistData.battlefieldDeck.objective = {}\nlistData.battlefieldDeck.deployment = {}\nlistData.battlefieldDeck.conditions = {}\n"

        local deckTypes = {"deployment", "objective", "conditions"}

        for j, deckType in pairs(deckTypes) do
            for l, battlefieldCardEntry in pairs(listData.battlefieldDeck[deckType]) do
                luaString = luaString .. "listData.battlefieldDeck."..deckType.."["..l.."] = '"..battlefieldCardEntry.."'\n"
            end
        end


        luaString = luaString .. "self.createButton({click_function = 'dud', function_owner = self, label = '[' .. listData.pts .. ' pts]', position = {0, 0.4, -0.55}, rotation = {0, 180, 0}, scale = {0.5, 0.5, 0.5}, width = 2000, height = 400, font_size = 300, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0.303, 0.1814, 0.0849, 100}})\nend\nfunction dud() end"

        dataDisk = getObjectFromGUID(listBuilder.dataDisk.guid).clone({
            position     = {0,-10,0},
            snap_to_grid = false
        })

        dataDisk.setScale({1,1,1})
        pos = translatePos(dataDiskMount.getPosition(),dataDiskMount.getRotation(),0.03,90)
        pos.y = pos.y + 1
        dataDisk.setPosition(pos)

        diskName = "(RENAME ME!) Army Data Disk ["..totalPts .. " Points]"
        dataDisk.setRotation(self.getRotation())
        dataDisk.setName(diskName)
        dataDisk.setLuaScript(luaString)
        dataDisk.setLock(false)

    end
end

function createRebelArmy()
    createArmyMenu()
    Global.setVar(colorZone.."SelectedArmyFaction", "rebel")
    respawnZone()
end

function createImperialArmy()
    createArmyMenu()
    Global.setVar(colorZone.."SelectedArmyFaction", "imperial")
    respawnZone()
end

function createSeparatistArmy()
    createArmyMenu()
    Global.setVar(colorZone.."SelectedArmyFaction", "separatist")
    respawnZone()
end

function createRepublicArmy()
    createArmyMenu()
    Global.setVar(colorZone.."SelectedArmyFaction", "republic")
    respawnZone()
end

function respawnZone()
    clearZone()
    spawnTemplates()
end

function finishArmy()
    listData = getListData()
    clearZone()
    spawnArmy(listData)
    mainMenu()
end

function clearSpawnTemplates()
end


function spawnTemplates()


    deckBuilderObj = spawnObject({
        type           = "Custom_Model",
        position       = listBuilder.deckBuilderPos[colorSide],
        rotation       = self.getRotation()
    })
    deckBuilderObj.setCustomObject({
        mesh = listBuilder.deckBuilderMesh,
        collider = listBuilder.deckBuilderMesh,
        diffuse = listBuilder.deckBuilderDiffuse,
        type = 1,
        material = 3
    })

    deckBuilderObj.setPosition(listBuilder.deckBuilderPos[colorSide])
    deckBuilderObj.setRotation(self.getRotation())
    deckBuilderObj.setLock(true)
    local deckBuilderScript = getObjectFromGUID(listBuilder.deckBuilderGUID).getLuaScript()
    local factionScript = ("selectedFaction = '"..Global.getVar(colorZone.."SelectedArmyFaction").."'\n")
    deckBuilderObj.setLuaScript(factionScript..deckBuilderScript)


    templateObjs = {}
    for i=1,20,1 do
        templateParams = {getObjectFromGUID(listBuilder.modelTemplateGUID)}
        copy(templateParams)
        pastedObj = paste({
            position = listBuilder[colorZone.."TemplatePos"][i]
        })

        templateObjs[i] = pastedObj

        templateObjs[i][1].setLock(true)
        templateObjs[i][1].setPosition({templateObjs[i][1].getPosition().x,1,templateObjs[i][1].getPosition().z})
        templateObjs[i][1].setScale({1,1,1})

        templateObjs[i][1].setVar("colorSide", colorZone)
        templateObjs[i][1].setVar("listBuilderObj", self)
        templateObjs[i][1].setVar("templateIndex", i)
        templateObjs[i][1].setVar("deckBuilderObj", deckBuilderObj)
        templateObjs[i][1].setName("")

        if colorSide == "red" then
            templateObjs[i][1].setRotation({0,0,180})

        else
            templateObjs[i][1].setRotation({0,180,180})
        end
    end
end

function clearZone()
    zoneObjs = {}
    zoneObjs = cardZone.getObjects()
        -- Zone.getObjects() returns {Object, ...}
    if zoneObjs != nil then
        for _, obj in pairs(zoneObjs) do
            if obj != battlefieldTable then
                destroyObject(obj)
            end
        end
    end

    local trayZone = getObjectFromGUID(commandTokenTrayData[colorSide].trayZoneGUID)
    local trayZoneObjs = trayZone.getObjects()
    for _, obj in pairs(trayZoneObjs) do
        if obj.getVar("isAToken") == true then
            destroyObject(obj)
        end
    end

    local commandStack = getObjectFromGUID(commandTokenTrayData[colorSide].stack)

    local commandStackObjs = commandStack.getObjects()

    for _, obj in pairs(commandStackObjs) do
        local drawnObj = commandStack.takeObject()
        destroyObject(drawnObj)
    end

    if deckBuilderObj != nil then
        destroyObject(deckBuilderObj)
    end

    for i, obj in pairs(deckZone.getObjects()) do
        if obj != deckMount then
            destroyObject(obj)
        end

    end

end

function calculatePts()
    allCards = cardZone.getObjects()
    totalPts = 0
    for i, card in pairs(allCards) do
        local cardPoint = card.getVar("ptCost")
        if cardPoint != nil then
            totalPts = totalPts + cardPoint
        end
    end
    ptCounter.setValue(totalPts)
end

function onObjectEnterScriptingZone(cardZone, enter_object)

    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "calculate"..math.random()..timerCounter..self.getGUID(),
        function_name  = "calculatePts",
        function_owner = self,
        delay          = 0.1
    })
end

function onObjectLeaveScriptingZone(cardZone, leave_object)
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "calculate"..math.random()..timerCounter..self.getGUID(),
        function_name  = "calculatePts",
        function_owner = self,
        delay          = 0.1
    })
end

function onObjectDestroyed(dying_object)
    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    Timer.create({
        identifier     = "calculate"..math.random()..timerCounter..self.getGUID(),
        function_name  = "calculatePts",
        function_owner = self,
        delay          = 0.1
    })
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

function refreshTimer()
    timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
end

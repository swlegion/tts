-- model template
function onLoad(save_state)
    if self.getName() != " " then
        local timerCounter = Global.getVar("timerCounter")
        timerCounter = timerCounter + 1
        Global.setVar("timerCounter", timerCounter)
        Timer.create({
            identifier     = "template".. timerCounter..self.getGUID(),
            function_name  = "setUp",
            function_owner = self,
            delay          = 0.05
        })
    end

end

function setUp()
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    battlefieldTint = gameData.getTable("battlefieldTint")
    templateMenu = Global.getTable("templateMenu")
    cardInfo = Global.getTable("cardInfo")
    selectedArmyFaction = Global.getVar(colorSide.."SelectedArmyFaction")
    listBuilder = Global.getTable("listBuilder")
    miniInfo = Global.getTable("miniInfo")
    unitInfo = Global.getTable("unitInfo")
    unitIDTokenBag = getObjectFromGUID(Global.getVar("unitIDTokenBagGUID"))
    unitCard = nil
    upgradeCardIndex = {}
    upgradeCardInstance = {}
    listText = ""
    selectedCommandCard = {1,1,1}

    self.createButton({
        click_function = "initialize", function_owner = self, label = "ADD UNIT", position = {0, -0.2, 1}, rotation = {180, 0, 0}, scale = {0.5, 0.5, 0.5}, width = 5100, height = 1000, font_size = 350, color = {0, 0, 0, 1}, font_color = {0.2969, 0.979, 1, 1}
    })

    if templateIndex < 5 then
        initialize()
    end

end

function initialize()
    local templateRot = self.getRotation()
    templateRot.z = 0
    self.setRotation(templateRot)
    self.setColorTint({1,1,1})
    mainMenu()
end


function mainMenu()
    self.clearButtons()
    if unitCard != nil then
        destroyObject(unitCard)
        if cardInfo.unitCards[selectedUnit].rank == "Commander" or cardInfo.unitCards[selectedUnit].rank == "Operative"  then
            deckBuilderObj.call("removeCommander", selectedUnit)
        end

    end
    for _,upgradeCard in pairs(upgradeCardInstance) do
        destroyObject(upgradeCard)
    end
    upgradeCardInstance = nil
    upgradeCardInstance = {}
    upgradeCardIndex = nil
    upgradeCardIndex = {}
    selectedUnit = nil

    upgradeSelectionIndex = {}
    for n=1, 7, 1 do
        upgradeSelectionIndex[n] = 0
    end

    for i,entry in pairs(templateMenu.mainMenu) do
        refreshTimer()

        _G["mainMenu"..timerCounter] = function() unitSubMenu(entry.varName) end

        local fontSize = correctStringLength(entry.name)

        self.createButton({
            click_function = "mainMenu"..timerCounter,
            function_owner = self,
            label          = entry.name,
            position       = {0.93, 0.28, 2.48-(i*0.35)},
            width          = 1010,
            height         = 190,
            font_size      = fontSize,
            rotation       = {0,180,0},
            color          = {0.1764, 0.1764, 0.1764, 0.01},
            font_color     = {0, 0, 0, 100},
            tooltip        = entry.name.."Sub Menu"
        })

    end
    --createDudMenuButton({0.93, 0.28, 2.48-(6*0.35)})
    updateBackButton("dud", "", 1, "")

    upgradeMenu()

end

function correctStringLength(measuredString)
    if string.len(measuredString) > 21 then
        local returnLength = 80 - ((string.len(measuredString) - 22) * 5)
        return returnLength
    else
        return 80
    end
end

function updateBackButton(backFunction, backLabel, colorAlpha, backToolTip)
    self.createButton({
        click_function = backFunction,
        function_owner = self,
        label          = backLabel,
        position       = {2.12, 0.28, 2.13},
        width          = 270,
        height         = 190,
        font_size      = 80,
        rotation       = {0,180,0},
        color          = {0.1764, 0.1764, 0.1764, colorAlpha},
        font_color     = {0, 0, 0, 100},
        tooltip        = backToolTip
    })
end

function createDudMenuButton(pos)
    self.createButton({
        click_function = "dud",
        function_owner = self,
        label          = "",
        position       = pos,
        width          = 1010,
        height         = 190,
        font_size      = 80,
        rotation       = {0,180,0},
        color          = {0.1764, 0.1764, 0.1764},
        font_color     = {0, 0, 0, 100},
        tooltip        = ""
    })

end

function unitSubMenu(selectedRank)
    self.clearButtons()
    updateBackButton("mainMenu", "X", 0.01, "Go back to main menu")

    for i=1, 6, 1 do

        if templateMenu[selectedArmyFaction][selectedRank][i] != nil then
            local entry = templateMenu[selectedArmyFaction][selectedRank][i]

            refreshTimer()

            _G["subMenu"..timerCounter] = function() spawnUnitCard(entry.varName) end

            local fontSize = correctStringLength(entry.name)

            self.createButton({
                click_function = "subMenu"..timerCounter,
                function_owner = self,
                label          = entry.name,
                position       = {0.93, 0.28, 2.48-(i*0.35)},
                width          = 1010,
                height         = 190,
                font_size      = fontSize,
                rotation       = {0,180,0},
                color          = {0.1764, 0.1764, 0.1764, 0.01},
                font_color     = {0, 0, 0, 100},
                tooltip        = "Spawn ".. entry.name.."Unit Card"
            })
        else
            createDudMenuButton({0.93, 0.28, 2.48-(i*0.35)})
        end
    end

    upgradeMenu()
end

function refreshTimer()
    timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
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

function spawnUnitCard(card)
    mainMenu()
    local originalUnitCards = getObjectFromGUID(cardInfo.unitCardsGUID)
    local unitCards = originalUnitCards.clone({ position = {0,-30,0} })
    local cardName = cardInfo.unitCards[card].fullName
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

    pos = translatePos(self.getPosition(),self.getRotation(),1.5620819440734, 52.543226290399+90)
    pos.y = self.getPosition().y + 0.35

    --{-0.95, 1.58, 1.24}

    unitCard.setRotation({0,self.getRotation().y+180,0})
    unitCard.setScale({0.83,1,0.83})

    unitCard.createButton({
        click_function = "mainMenu",
        function_owner = self,
        label          = "X",
        position       = {-0.7,0.5,-1.4},
        width          = 140,
        height         = 180,
        font_size      = 100,
        color          = {1,0,0},
        font_color     = {1,1,1},
        tooltip        = "Delete Unit Card"
    })
    unitCard.setVar("ptCost", cardInfo.unitCards[card].ptCost)
    unitCard.setPosition(pos)
    unitCard.setLock(false)
    selectedUnit = card

    -- update deckBuilder
    if cardInfo.unitCards[selectedUnit].rank == "Commander" or cardInfo.unitCards[selectedUnit].rank == "Operative"  then
        deckBuilderObj.call("addCommander", selectedUnit)

    end

    upgradeMenu()

end

function dud()
end

function getTimerCounter()
    local timerCounterFunc = Global.getVar("timerCounter")
    timerCounterFunc = timerCounterFunc + 1
    Global.setVar("timerCounter", timerCounterFunc)
    return timerCounterFunc
end

function updateCommandCardSelection(a1,b2)
    selectedCommandCard[a1] = b2

    upgradeMenu()
end

function upgradeMenu()

    if selectedUnit != nil then
        availableUpgrades = cardInfo.unitCards[selectedUnit].availableUpgrades
        self.clearButtons()
        -- create Command hand


    else
        availableUpgrades = {}
    end

    selectedUpgrade = nil
    selectedUpgrade = {}


    upgradeSubMenu()

end

function upgradeSubMenu()
    for i=1, 7, 1 do
        buttonPos = templateMenu.buttonPositions[i]



        -- CREATE UPGRADE BUTTONS
        for a=1, 5,1 do
            if availableUpgrades[i] != nil then
                local selectedIndex = upgradeSelectionIndex[i] + a
                if availableUpgrades[i][selectedIndex] != nil then


                    local timerCounter = Global.getVar("timerCounter")
                    timerCounter = timerCounter + 1
                    Global.setVar("timerCounter", timerCounter)

                    _G["upgradeSubMenu".. timerCounter] = function() spawnUpgradeCard(availableUpgrades[i][selectedIndex],templateMenu.upgradeCardPos[i],i) end
                    upgradeClickFunction = "upgradeSubMenu"..timerCounter
                    upgradeLabel = availableUpgrades[i][selectedIndex].name
                    upgradeColor = {0.1764, 0.1764, 0.1764, 0.01}
                    upgradeFontColor = {0, 0, 0, 100}
                    upgradeFontsize = 160
                    if string.len(availableUpgrades[i][selectedIndex].name) > 12 then
                        upgradeFontsize = 160 - ((string.len(availableUpgrades[i][selectedIndex].name) - 12) * 7.2)
                        if upgradeFontsize < 70 then
                            upgradeFontsize = 70
                        end
                    end
                else
                    upgradeClickFunction = "dud"
                    upgradeLabel = " "
                    upgradeColor = {0.1764, 0.1764, 0.1764, 50}
                    upgradeFontColor = {0, 0, 0, 0}
                    upgradeFontsize = 160
                end
            else
                upgradeClickFunction = "dud"
                upgradeLabel = " "
                upgradeColor = {0.1764, 0.1764, 0.1764, 50}
                upgradeFontColor = {0, 0, 0, 0}
                upgradeFontsize = 160


            end

            self.createButton({
                click_function = upgradeClickFunction,
                function_owner = self,
                label          = upgradeLabel,
                position       = buttonPos[a],
                width          = 1340,
                height         = 380,
                font_size      = upgradeFontsize,
                rotation       = {0,180,0},
                color          = upgradeColor,
                font_color     = upgradeFontColor,
                scale          = {0.5, 0.5, 0.5}
            })

        end


        _G["nextUpgradeMenu"..i] = function() nextUpgradeMenu(i) end

        _G["prevUpgradeMenu"..i] = function() prevUpgradeMenu(i) end

        if availableUpgrades[i] != nil then
            if #availableUpgrades[i] > 5 then

                if upgradeSelectionIndex[i]<5 then
                    upClickFunction = "dud"
                    upFontColor = {0, 0, 0, 0}
                    upButtonColor = {0.1764, 0.1764, 0.1764, 50}

                    downClickFunction = "nextUpgradeMenu"..i
                    downFontColor = {0, 0, 0, 100}
                    downButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
                else
                    upClickFunction = "prevUpgradeMenu"..i
                    upFontColor = {0, 0, 0, 100}
                    upButtonColor = {0.1764, 0.1764, 0.1764, 0.01}

                    if (#availableUpgrades[i] - upgradeSelectionIndex[i]) < 6 then
                        downClickFunction = "dud"
                        downFontColor = {0, 0, 0, 0}
                        downButtonColor = {0.1764, 0.1764, 0.1764, 50}
                    else
                        downClickFunction = "nextUpgradeMenu"..i
                        downFontColor = {0, 0, 0, 100}
                        downButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
                    end

                end
            else
                upClickFunction = "dud"
                upFontColor = {0, 0, 0, 0}
                upButtonColor = {0.1764, 0.1764, 0.1764, 50}
                downClickFunction = "dud"
                downFontColor = {0, 0, 0, 0}
                downButtonColor = {0.1764, 0.1764, 0.1764, 50}
            end
        else
            upClickFunction = "dud"
            upFontColor = {0, 0, 0, 0}
            upButtonColor = {0.1764, 0.1764, 0.1764, 50}
            downClickFunction = "dud"
            downFontColor = {0, 0, 0, 0}
            downButtonColor = {0.1764, 0.1764, 0.1764, 50}
        end


        -- CREATE UP DOWN BUTTONS
        self.createButton({
            click_function = upClickFunction,
            function_owner = self,
            label          = "◄   ",
            position       = buttonPos[6],
            width          = 700,
            height         = 380,
            font_size      = 160,
            rotation       = {0,180,0},
            color          = upButtonColor,
            font_color     = upFontColor,
            scale          = {0.5, 0.5, 0.5}
        })
        self.createButton({
            click_function = downClickFunction,
            function_owner = self,
            label          = "    ►",
            position       = buttonPos[7],
            width          = 700,
            height         = 380,
            font_size      = 160,
            rotation       = {0,180,0},
            color          = downButtonColor,
            font_color     = downFontColor,
            scale          = {0.5, 0.5, 0.5}
        })


    end
end

function nextUpgradeMenu(selectionNumber)
    upgradeSelectionIndex[selectionNumber] = upgradeSelectionIndex[selectionNumber] + 5
    upgradeMenu()
end

function prevUpgradeMenu(selectionNumber)
    upgradeSelectionIndex[selectionNumber] = upgradeSelectionIndex[selectionNumber] - 5
    upgradeMenu()
end

function spawnUpgradeCard(cardData, cardPos, upgradeNumber)

    local originalUpgradeCards = getObjectFromGUID(cardInfo.upgradeCardsGUID)
    local upgradeCards = originalUpgradeCards.clone({ position = {0,-30,0} })
    local cardName = cardData.name
    local upgradeCardTable = upgradeCards.getObjects()

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

    local rot = self.getRotation()
    local pos = self.getPosition()

    local a = cardPos.c * math.cos(math.rad(cardPos.q + rot.y ))
    local b = cardPos.c * math.sin(math.rad(cardPos.q + rot.y ))

    pos.x = pos.x - a
    pos.z = pos.z + b
    pos.y = self.getPosition().y + 0.35

    upgradeCard.setRotation({0,rot.y+180,0})
    upgradeCard.setPosition(pos)
    upgradeCard.setVar("ptCost", cardData.ptCost)
    upgradeCard.setLock(false)
    upgradeCard.setScale({0.83,0.83,0.83})
    upgradeCardIndex[upgradeNumber] = cardData
    upgradeCardInstance[upgradeNumber] = upgradeCard

    local timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)

    _G["destroyUpgrade"..timerCounter] = function() destroyUpgradeCard(upgradeNumber) end
    upgradeCard.createButton({
        click_function = "destroyUpgrade"..timerCounter,
        function_owner = self,
        label          = "X",
        position       = {-0.95,0.5,-1.4},
        width          = 140,
        height         = 180,
        font_size      = 100,
        color          = {1,0,0},
        font_color     = {1,1,1},
        tooltip        = "Delete Upgrade Card"
    })

end

function destroyUpgradeCard(index)
    destroyObject(upgradeCardInstance[index])
    upgradeCardInstance[index] = nil
    upgradeCardIndex[index] = nil

end

function getListText()
    if selectedUnit != nil then
        returnTable = {}

        returnTable.unitName = cardInfo.unitCards[selectedUnit].fullName
        returnTable.upgrades = {}
        k = 1

        for i, entry in pairs(upgradeCardIndex) do
            if entry.name != nil then
                returnTable.upgrades[k] = {name = entry.name, varName = entry.varName}
                k = k + 1
            end
        end

        -- rank
        returnTable.rank = cardInfo.unitCards[selectedUnit].rank
        returnTable.varName = selectedUnit
        return returnTable
    else
        return nil
    end
end



function spawnMinis()


    if selectedUnit != nil then
        -- set unitNumber
        spos = translatePos(self.getPosition(),self.getRotation(),1.5620819440734, 52.543226290399+90)
        spos.y = self.getPosition().y + 0.45

        srot = {x=0,y=self.getRotation().y,z=0}


        spawnUnitIDToken(spos, srot, templateIndex)

        -- spawn minis
        for i, data in pairs(cardInfo.unitCards[selectedUnit].miniInfo) do

            -- math

            local rot = self.getRotation()
            local pos = self.getPosition()
            local c = listBuilder.miniSpawnPos[i].c
            local q = listBuilder.miniSpawnPos[i].q

            local a = c * math.cos(math.rad(q + rot.y))
            local b = c * math.sin(math.rad(q + rot.y))

            pos.x = pos.x - a
            pos.z = pos.z + b
            pos.y = 1

            local spawnedMini = spawnObject({
                type           = "Custom_Model",
                position       = pos,
                rotation       = {rot.x, rot.y + 180, rot.z},
                scale          = data.scale
            })
            spawnedMini.setCustomObject({
                mesh = data.mesh,
                collider = data.collider,
                diffuse = data[colorSide],
                type = 1,
                material = 3

            })
            spawnedMini.setColorTint(gameData.getTable("battlefieldTint"))

            local strColor = colorSide
            strColor = strColor:gsub("^%l", string.upper)

            spawnedMini.setName(strColor.. " ".. data.name)
            if i == 1 then
                local miniScript = "unitName = '"..selectedUnit.."'\ncolorSide = '"..colorSide.."'cardGUID = '"..unitCard.getGUID().."'\nunitID = "..templateIndex.."\n"..listBuilder.modelMiniScript
                spawnedMini.setLuaScript(miniScript)
                --spawnedMini.setVar("unitCount", unitCount)
                --spawnedMini.setVar("cardGUID", unitCard.getGUID())
                description = ""

                for n, upgrade in pairs(upgradeCardIndex) do
                    description = description .. upgrade.name .. "\n"
                end


                spawnedMini.setDescription(description)
            else
                spawnedMini.use_snap_points = false
            end

            l = i
        end
        -- spawn upgrade minis
        for i = 1, 4, 1 do
            if upgradeCardIndex[i] != nil and upgradeCardIndex[i].miniInfo!= nil then
                -- math
                l = l + 1
                local rot = self.getRotation()
                local pos = self.getPosition()
                local c = listBuilder.miniSpawnPos[l].c
                local q = listBuilder.miniSpawnPos[l].q

                local a = c * math.cos(math.rad(q + rot.y))
                local b = c * math.sin(math.rad(q + rot.y))

                pos.x = pos.x - a
                pos.z = pos.z + b
                pos.y = 1


                local spawnedMini = spawnObject({
                    type           = "Custom_Model",
                    position       = pos,
                    rotation       = {rot.x, rot.y + 180, rot.z},
                    scale          = upgradeCardIndex[i].miniInfo.scale
                })
                spawnedMini.setCustomObject({
                    mesh = upgradeCardIndex[i].miniInfo.mesh,
                    collider = upgradeCardIndex[i].miniInfo.collider,
                    diffuse = upgradeCardIndex[i].miniInfo[colorSide],
                    type = 1,
                    material = 3

                })
                spawnedMini.setColorTint(gameData.getTable("battlefieldTint"))
                local strColor = colorSide
                strColor = strColor:gsub("^%l", string.upper)

                spawnedMini.setName(strColor.." "..upgradeCardIndex[i].miniInfo.name)
                spawnedMini.use_snap_points = false
            end
        end

        -- spawn command token
        local commandType = unitInfo[selectedUnit].commandType

        local guid = unitInfo.tokenGUID[colorSide][commandType]

        local token = getObjectFromGUID(guid)

        copy({token})

        local pastedObj = paste()

        local tokenObj = pastedObj[1]

        local pos = unitInfo.tokenPosition[colorSide][commandType]
        local rot = unitInfo.tokenRotation[colorSide]

        tokenObj.setPosition(pos)
        tokenObj.setRotation(rot)
        tokenObj.setScale({0.38,1,0.38})

        tokenObj.setLuaScript(listBuilder.tokenScript)

        local strColor = colorSide

        strColor = strColor:gsub("^%l", string.upper)

        tokenObj.setName(strColor .. " " .. cardInfo.unitCards[selectedUnit].tokenName)
        tokenObj.setVar("unitName", selectedUnit)
        tokenObj.setVar("colorSide", colorSide)
        tokenObj.setLock(false)
    end
end

function getCommandCards()
    selectCommandCardsTable = {}
    if listBuilder.commandCards[selectedUnit] != nil then
        for i=1,3,1 do
            table.insert(selectCommandCardsTable, listBuilder.commandCards[selectedUnit].cards[i][selectedCommandCard[i]])
        end
    end
    return selectCommandCardsTable
end

function translatePos(originPos,originRot,distance, angle)
    local pos = originPos
    local rot = originRot

    local a = distance * math.cos(math.rad(angle + rot.y))
    local b = distance * math.sin(math.rad(angle + rot.y))

    pos.x = pos.x - b
    pos.z = pos.z - a

    return pos
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
                position       = {0,10,0},
                index          = entry.index
            })
            takenCard.deal(1, strColor)
            break
        end
    end

    destroyObject(commandCards)
end

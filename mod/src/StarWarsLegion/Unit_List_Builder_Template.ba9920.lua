#include !/common/Math

-- model template
function onLoad()
  if self.getName() != "Unit List Builder Template" then
    setUp()
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
    unitCardPage = 0
    unitCardRank = nil
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
    upgradeCardInstance = {}
    upgradeCardIndex = {}
    unitCardPage = 0
    unitCardRank = nil
    selectedUnit = nil

    upgradeSelectionIndex = {}
    for n=1, 7, 1 do
        upgradeSelectionIndex[n] = 0
    end

    for i,entry in pairs(templateMenu.mainMenu) do
        _G["mainMenu"..i] = function() unitSubMenu(entry.varName) end

        local fontSize = correctStringLength(entry.name)

        self.createButton({
            click_function = "mainMenu"..i,
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

function createNextUnitButton()
  self.createButton({
      click_function = "nextUnits",
      function_owner = self,
      label          = "►",
      position       = {-0.30, 0.28, 2.48-(6*0.35)},
      width          = 270,
      height         = 190,
      font_size      = 80,
      rotation       = {0,180,0},
      color          = {1,0,0},
      font_color     = {1,1,1},
      tooltip        = "View next page of unit cards"
  })
end

function nextUnits()
  unitCardPage = unitCardPage + 1
  unitSubMenu(unitCardRank)
end

function createPrevUnitButton()
  self.createButton({
      click_function = "prevUnits",
      function_owner = self,
      label          = "◄",
      position       = {2.13, 0.28, 2.48-(6*0.35)},
      width          = 270,
      height         = 190,
      font_size      = 80,
      rotation       = {0,180,0},
      color          = {1,0,0},
      font_color     = {1,1,1},
      tooltip        = "View previous page of unit cards"
  })
end

function prevUnits()
  unitCardPage = unitCardPage - 1
  unitSubMenu(unitCardRank)
end

function unitSubMenu(selectedRank)
    self.clearButtons()
    updateBackButton("mainMenu", "X", 0.01, "Go back to main menu")
    unitCardRank = selectedRank

    local unitCount = #templateMenu[selectedArmyFaction][selectedRank]
    local startIndex = unitCardPage * 6 + 1
    local endIndex = (unitCardPage + 1) * 6

    for i=startIndex, endIndex, startIndex do

        if templateMenu[selectedArmyFaction][selectedRank][i] != nil then
            local entry = templateMenu[selectedArmyFaction][selectedRank][i]

            _G["subMenu"..i] = function() spawnUnitCard(entry.varName) end

            local fontSize = correctStringLength(entry.name)
            local relativeIndex = i - (unitCardPage * 6)

            self.createButton({
                click_function = "subMenu"..i,
                function_owner = self,
                label          = entry.name,
                position       = {0.93, 0.28, 2.48-(relativeIndex*0.35)},
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

    if endIndex < unitCount then
      createNextUnitButton()
    end
    if startIndex > 1 then
      createPrevUnitButton()
    end

    upgradeMenu()
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

function updateCommandCardSelection(a1,b2)
    selectedCommandCard[a1] = b2

    upgradeMenu()
end

function upgradeMenu()
    if selectedUnit != nil then
        local unitCard = cardInfo.unitCards[selectedUnit]
        availableUpgrades = unitCard.availableUpgrades
        requiredUpgrades = unitCard.requiredUpgrades
        if requiredUpgrades == nil then
          requiredUpgrades = {}
        end
        self.clearButtons()
    else
        availableUpgrades = {}
        requiredUpgrades = {}
    end

    selectedUpgrade = nil
    selectedUpgrade = {}

    drawUpgradeMenu()
end

function drawUpgradeMenu()
    local availableUpgradeCount = #availableUpgrades
    local requiredUpgradeCount = #requiredUpgrades

    for i = 1, availableUpgradeCount, 1 do
      local buttonPosition = templateMenu.buttonPositions[i]

      for n = 1, 5, 1 do
        local upgradeClickFunction = "dud"
        local upgradeLabel = " "
        local upgradeColor = {0.1764, 0.1764, 0.1764, 50}
        local upgradeFontColor = {0, 0, 0, 0}
        local upgradeFontSize = 160
        local selectedIndex = upgradeSelectionIndex[i] + n
        if availableUpgrades[i] != nil and availableUpgrades[i][selectedIndex] != nil then
          upgradeClickFunction = "upgradeSubMenu"..self.getGUID()..":"..i..":"..n
          upgradeLabel = availableUpgrades[i][selectedIndex].name
          upgradeColor = {0.1764, 0.1764, 0.1764, 0.01}
          upgradeFontColor = {0, 0, 0, 100}
          if string.len(upgradeLabel) > 12 then
            upgradeFontSize = 160 - ((string.len(upgradeLabel) - 12) * 7.2)
            if upgradeFontSize < 70 then
              upgradeFontSize = 70
            end
          end
          _G[upgradeClickFunction] = function()
            spawnUpgradeCard(
              availableUpgrades[i][selectedIndex],
              templateMenu.upgradeCardPos[i],
              i
            ) 
          end
        end
        self.createButton({
          click_function = upgradeClickFunction,
          function_owner = self,
          label          = upgradeLabel,
          position       = buttonPosition[n],
          width          = 1340,
          height         = 380,
          font_size      = upgradeFontSize,
          rotation       = {0,180,0},
          color          = upgradeColor,
          font_color     = upgradeFontColor,
          scale          = {0.5, 0.5, 0.5}
        })
        
        _G["nextUpgradeMenu"..i] = function() nextUpgradeMenu(i) end
        _G["prevUpgradeMenu"..i] = function() prevUpgradeMenu(i) end

        local upClickFunction = "dud"
        local upFontColor = {0, 0, 0, 0}
        local upButtonColor = {0.1764, 0.1764, 0.1764, 50}
        local downClickFunction = upClickFunction
        local downFontColor = upFontColor
        local downButtonColor = upButtonColor
        if availableUpgrades[i] != nil and #availableUpgrades[i] > 5 then
          if upgradeSelectionIndex[i] < 5 then
            downClickFunction = "nextUpgradeMenu"..i
            downFontColor = {0, 0, 0, 100}
            downButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
          else
            upClickFunction = "prevUpgradeMenu"..i
            upFontColor = {0, 0, 0, 100}
            upButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
            if (#availableUpgrades[i] - upgradeSelectionIndex[i]) >= 6 then
              downClickFunction = "nextUpgradeMenu"..i
              downFontColor = {0, 0, 0, 100}
              downButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
            end
          end
        end
        -- CREATE UP DOWN BUTTONS
        self.createButton({
          click_function = upClickFunction,
          function_owner = self,
          label          = "◄   ",
          position       = buttonPosition[6],
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
          position       = buttonPosition[7],
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
    if requiredUpgradeCount > 0 then
      local startAt = availableUpgradeCount + 1
      local upIndex = 1
      for i = startAt, availableUpgradeCount + requiredUpgradeCount, 1 do
        spawnUpgradeCard(
          requiredUpgrades[upIndex],
          templateMenu.upgradeCardPos[i],
          i,
          true
        )
        upIndex = upIndex + 1
      end
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

function spawnUpgradeCard(cardData, cardPos, upgradeNumber, requiredUpgrade)
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

    if requiredUpgrade != true then
      local functionName = "destroyUpgrade" .. upgradeCard.getGUID()
      _G[functionName] = function() destroyUpgradeCard(upgradeNumber) end
      upgradeCard.createButton({
          click_function = functionName,
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

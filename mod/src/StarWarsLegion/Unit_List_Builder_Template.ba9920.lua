#include !/Deck
#include !/common/Math
#include !/data/CardInfo_new
#include !/data/MiniInfo

-- model template
function onLoad()
  if self.getName() != "Unit List Builder Template" then
    setUp()
  end

  -- Use deck data.
  _G.Deck = Deck:create()
end

function setUp()
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    battlefieldTint = gameData.getTable("battlefieldTint")
    templateMenu = Global.getTable("templateMenu")
    cardInfo = CardInfoClass:buildCardInfo()
    selectedArmyFaction = Global.getVar(colorSide.."SelectedArmyFaction")
    listBuilder = Global.getTable("listBuilder")
    miniInfo = Global.getTable("miniInfo")
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
        if selectedUnit.rank == "Commander" or selectedUnit.rank == "Operative"  then
            deckBuilderObj.call("removeCommander", selectedUnit.name:lower())
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

    -- these values are used to control upgrade pagination
    -- initialized at 0 and incremented by +/- 5 to move through "pages"
    upgradeSelectionIndex = {}
    for n=1, 7, 1 do
        upgradeSelectionIndex[n] = 0
    end

    for i, name in pairs({
      "Commander",
      "Operative",
      "Corps",
      "Special Forces",
      "Support",
      "Heavy",
    }) do
        _G["mainMenu"..i] = function() unitSubMenu(name:lower()) end
        local fontSize = correctStringLength(name)
        self.createButton({
            click_function = "mainMenu"..i,
            function_owner = self,
            label          = name,
            position       = {0.93, 0.28, 2.48-(i*0.35)},
            width          = 1010,
            height         = 190,
            font_size      = fontSize,
            rotation       = {0,180,0},
            color          = {0.1764, 0.1764, 0.1764, 0.01},
            font_color     = {0, 0, 0, 100},
            tooltip        = name.."Sub Menu"
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

    local unitList = cardInfo:getUnitsByFactionAndRank(selectedArmyFaction, selectedRank)
    local startIndex = unitCardPage * 6 + 1
    local endIndex = (unitCardPage + 1) * 6

    for i=startIndex, endIndex, startIndex do

        if unitList[i] != nil then
            local entry = unitList[i]

            _G["subMenu"..i] = function() spawnUnitCard(entry) end

            -- local maxNameLength = math.min(entry.name:len(), DISPLAY_NAME_CHAR_LIMIT)
            local nameToDisplay = entry.name
            if entry.displayName then nameToDisplay = entry.displayName end
            local fontSize = correctStringLength(nameToDisplay)
            local relativeIndex = i - (unitCardPage * 6)

            self.createButton({
                click_function = "subMenu"..i,
                function_owner = self,
                label          = nameToDisplay,
                position       = {0.93, 0.28, 2.48-(relativeIndex*0.35)},
                width          = 1010,
                height         = 190,
                font_size      = fontSize,
                rotation       = {0,180,0},
                color          = {0.1764, 0.1764, 0.1764, 0.01},
                font_color     = {0, 0, 0, 100},
                tooltip        = "Spawn ".. entry.name .." Unit Card"
            })
        else
            createDudMenuButton({0.93, 0.28, 2.48-(i*0.35)})
        end
    end

    if endIndex < #unitList then
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

function spawnUnitCard(unit)
  mainMenu()
  selectedUnit = unit
  unitCard = Deck:spawnUnitCard(selectedArmyFaction, selectedUnit.name)
  local pos = translatePos(self.getPosition(),self.getRotation(),1.5620819440734, 52.543226290399+90)
  pos.y = self.getPosition().y + 0.35

  unitCard.setPosition(pos)
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
  unitCard.setVar("ptCost", selectedUnit.ptCost)
  
  -- update deckBuilder
  if selectedUnit.rank == "Commander" or selectedUnit.rank == "Operative"  then
      deckBuilderObj.call("addCommander", selectedUnit.name:lower())
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
    if spawnedRequiredUpgrades != nil then
      for _, o in ipairs(spawnedRequiredUpgrades) do
        if o != nil then
          destroyObject(o)
        end
      end
    end
    spawnedRequiredUpgrades = {}

    if selectedUnit != nil then
        availableUpgradeSlots = selectedUnit.upgradeSlots
        requiredUpgrades = selectedUnit.requiredUpgrades
        if requiredUpgrades == nil then
          requiredUpgrades = {}
        end
        self.clearButtons()
    else
        availableUpgradeSlots = {}
        requiredUpgrades = {}
    end

    selectedUpgrade = nil
    selectedUpgrade = {}

    drawUpgradeMenu()
end

function drawUpgradeMenu()
    local buttonPositions = {
      {
        {-1.87, 0.28, 2.13},
        {-1.87, 0.28, 1.78},
        {-1.87, 0.28, 1.43},
        {-1.87, 0.28, 1.08},
        {-1.87, 0.28, 0.73},
        {-1.57, 0.28, 0.36},
        {-2.17, 0.28, 0.36},
      },
      {
        {1.87, 0.28, -0.58},
        {1.87, 0.28, -0.93},
        {1.87, 0.28, -1.28},
        {1.87, 0.28, -1.63},
        {1.87, 0.28, -1.98},
        {2.17, 0.28, -2.33},
        {1.57, 0.28, -2.33},
      },
      {
        {0, 0.28, -0.58},
        {0, 0.28, -0.93},
        {0, 0.28, -1.28},
        {0, 0.28, -1.63},
        {0, 0.28, -1.98},
        {0.3, 0.28, -2.33},
        {-0.3, 0.28, -2.33},
      },
      {
        {-1.87, 0.28, -0.58},
        {-1.87, 0.28, -0.93},
        {-1.87, 0.28, -1.28},
        {-1.87, 0.28, -1.63},
        {-1.87, 0.28, -1.98},
        {-1.57, 0.28, -2.33},
        {-2.17, 0.28, -2.33},
      },
      {
        {1.87, 0.28, -3.31},
        {1.87, 0.28, -3.66},
        {1.87, 0.28, -4.01},
        {1.87, 0.28, -4.36},
        {1.87, 0.28, -4.71},
        {2.17, 0.28, -5.06},
        {1.57, 0.28, -5.06},
      },
      {
        {0, 0.28, -3.31},
        {0, 0.28, -3.66},
        {0, 0.28, -4.01},
        {0, 0.28, -4.36},
        {0, 0.28, -4.71},
        {0.3, 0.28, -5.06},
        {-0.3, 0.28, -5.06},
      },
      {
        {-1.87, 0.28, -3.31},
        {-1.87, 0.28, -3.66},
        {-1.87, 0.28, -4.01},
        {-1.87, 0.28, -4.36},
        {-1.87, 0.28, -4.71},
        {-1.57, 0.28, -5.06},
        {-2.17, 0.28, -5.06},
      },
      {
        {0, 0.28, -6.5},
        {0, 0.28, -6.85},
      },
      {
        {-1.87, 0.28, -6.5},
        {-1.87, 0.28, -6.85},
      },
    }
    local upgradeCardPos = {
      -- q = horziontal offset?
      -- c = vertical offset?
      -- top right
      {q = 146.451578117502, c = 2.2437691503361},
      -- center left
      {q = -37.790038154384, c = 2.3663051367058},
      -- center middle
      {q = -90, c = 1.45},
      -- center right
      {q = -142.209961845616, c = 2.3663051367058},
      -- bottom left
      {q = -65.897765498839, c = 4.5792248252297},
      -- bottom middle
      {q = -90, c = 4.18},
      -- bottom right
      {q = -114, c = 4.5792248252297},
    }
    local availableUpgradeSlotCount = #availableUpgradeSlots
    local requiredUpgradeCount = #requiredUpgrades
    for i = 1, availableUpgradeSlotCount, 1 do
      local buttonPosition = buttonPositions[i]
      local upgradesList = cardInfo:getUpgradesByType(availableUpgradeSlots[i])
      local allowableUpgrades = selectedUnit:filterAllowedUpgrades(upgradesList)

      for n = 1, 5, 1 do
        local upgradeClickFunction = "dud"
        local upgradeLabel = " "
        local upgradeColor = {0.1764, 0.1764, 0.1764, 50}
        local upgradeFontColor = {0, 0, 0, 0}
        local upgradeFontSize = 160
        local selectedIndex = upgradeSelectionIndex[i] + n
        if availableUpgradeSlots[i] != nil and allowableUpgrades[selectedIndex] != nil then
          upgradeClickFunction = "upgradeSubMenu"..self.getGUID()..":"..i..":"..n
          upgradeLabel = allowableUpgrades[selectedIndex].name
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
              allowableUpgrades[selectedIndex],
              upgradeCardPos[i],
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
        if availableUpgradeSlots[i] != nil and #allowableUpgrades > 5 then
          if upgradeSelectionIndex[i] < 5 then
            downClickFunction = "nextUpgradeMenu"..i
            downFontColor = {0, 0, 0, 100}
            downButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
          else
            upClickFunction = "prevUpgradeMenu"..i
            upFontColor = {0, 0, 0, 100}
            upButtonColor = {0.1764, 0.1764, 0.1764, 0.01}
            if (#allowableUpgrades - upgradeSelectionIndex[i]) >= 6 then
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
      local startAt = availableUpgradeSlotCount + 1
      local upIndex = 1
      for i = startAt, availableUpgradeSlotCount + requiredUpgradeCount, 1 do
        local cardObj = cardInfo:getUpgradeByName(requiredUpgrades[upIndex])
        spawnUpgradeCard(
          cardObj,
          upgradeCardPos[i],
          i,
          true
        )
        upIndex = upIndex + 1
      end
      requiredUpgrades = {}
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
    local upgradeCard = Deck:spawnUpgradeCard(cardData.name)

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
    else
      table.insert(spawnedRequiredUpgrades, upgradeCard)
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

        returnTable.name = selectedUnit.name
        returnTable.upgrades = {}
        k = 1

        for i, entry in pairs(upgradeCardIndex) do
            if entry.name != nil then
                returnTable.upgrades[k] = entry.name
                k = k + 1
            end
        end

        -- rank
        returnTable.rank = selectedUnit.rank
        return returnTable
    else
        return nil
    end
end

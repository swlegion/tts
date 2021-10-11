require('!/Deck')

-- Defined via setLuaScript:
--   _G.selectedScenario

function onload(save_state)
    self.interactable = false
    listBuilder = Global.getTable("listBuilder")
    _G.Deck = Deck:create()

    battlefieldEntry = {}
    battlefieldEntry.clickFunction = {}
    battlefieldEntry.clickFunction[1] = "objectiveSubMenu"
    battlefieldEntry.clickFunction[2] = "deploymentSubMenu"
    battlefieldEntry.clickFunction[3] = "conditionsSubMenu"

    battlefieldEntry.labelString = {}
    battlefieldEntry.labelString[1] = "Objective"
    battlefieldEntry.labelString[2] = "Deployment"
    battlefieldEntry.labelString[3] = "Conditions"

    selectedCommanders = {}

    deckBuilderCommandCategories = {
      "1 Pips",
      "1 Pips: Contingencies",
      "2 Pips",
      "2 Pips: Contingencies",
      "3 Pips",
      "3 Pips: Contingencies"
    }

    resetCommandCards()

    -- Default selections. Can be changed by the user!
    battlefieldCardSelection = {
      objective = {
        "Key Positions",
        "Breakthrough",
        "Intercept The Transmissions",
        "Recover The Supplies",
      },
      deployment = {
        "Battle Lines",
        "The Long March",
        "Disarray",
        "Major Offensive",
      },
      conditions = {
        "Clear Conditions",
        "Limited Visibility",
        "Rapid Reinforcements",
        "Hostile Environment",
      },
    }

    resetButtons()
end


function resetCommandCards()
    commandCardSelection = {
      "Ambush",
      "Push",
      "Assault",
      "Standing Orders",
    }
    contingencyCardSelection = {}
end

function addCommander(selectedCommander)
    table.insert(selectedCommanders, selectedCommander)
    resetCommandCards()
    resetButtons()
end

function resetButtons()
    nilChoices()
    updateButtons()
end

function removeCommander(selectedCommander)
    for k, entry in pairs (selectedCommanders) do
        if entry ==  selectedCommander then
            table.remove(selectedCommanders, k)
            break
        end
    end
    resetCommandCards()
    resetButtons()
end

function nilChoices()
    selectionEntry = {}
    for i=1,11,1 do
        selectionEntry[i] = {}
        selectionEntry[i].entryName = ""
        selectionEntry[i].clickFunction = "dud"
        selectionEntry[i].fontSize = 160
        selectionEntry[i].color = {0.1764,0.1764,0.1764,50}
        selectionEntry[i].fontColor = {0,0,0,0}
    end
end

function updateButtons()
    self.clearButtons()
    resetCommandCardButtons()
    resetBattlefieldButtons()
    resetChoicesButtons()
end

function resetCommandCardButtons()
    for i=1,6,1 do

        _G["commandCardEntry"..i] = function() commandCardSubMenu(i) end

        local data = {
            click_function = "commandCardEntry"..i,
            function_owner = self,
            label = deckBuilderCommandCategories[i],
            position = {1.4, 0.28, 2.394-(i*0.354)},
            rotation = {0, 180, 0},
            scale = {0.5, 0.5, 0.5},
            width = 2040,
            height = 410,
            font_size = correctStringLength(deckBuilderCommandCategories[i]),
            color = {0.1764, 0.1764, 0.1764, 0.01},
            font_color = {0, 0, 0, 100},
            tooltip = ""
        }
        self.createButton(data)
    end
end

function resetBattlefieldButtons()
    for n=1,3,1 do
        local data = {
            click_function = battlefieldEntry.clickFunction[n],
            function_owner = self,
            label = battlefieldEntry.labelString[n],
            position = {1.4, 0.28, -0.336-(n*0.354)},
            rotation = {0, 180, 0},
            scale = {0.5, 0.5, 0.5},
            width = 2040,
            height = 410,
            font_size = 160,
            color = {0.1764, 0.1764, 0.1764, 0.01},
            font_color = {0, 0, 0, 100},
            tooltip = ""
        }
        self.createButton(data)
    end
end

function resetChoicesButtons()

    for i=1,11,1 do
        local choiceData = {
            click_function = selectionEntry[i].clickFunction,
            function_owner = self,
            label = selectionEntry[i].entryName,
            position = {-1.45, 0.28, 2.394-(i*0.354)},
            rotation = {0, 180, 0},
            scale = {0.5, 0.5, 0.5},
            width = 2040,
            height = 410,
            font_size = selectionEntry[i].fontSize,
            color = selectionEntry[i].color,
            font_color = selectionEntry[i].fontColor,
            tooltip = ""
        }
        self.createButton(choiceData)
    end
end

function commandCardSubMenu(numberSelection)
  nilChoices()

  -- PIP SELECTION
  local pipSelected = math.ceil(numberSelection / 2)
  local isContingencies = numberSelection % 2 == 0
  local selectedCards
  if isContingencies then
    selectedCards = contingencyCardSelection
  else
    selectedCards = commandCardSelection
  end

  local validCCs = Deck:getCommandsByFactionAndUnits(
    selectedFaction,
    selectedCommanders
  )

  local index = 1
  for _, potentialCC in ipairs(validCCs) do
    if potentialCC.pip == pipSelected then
      local availableCard = potentialCC.name
      local selected = false
      for _, card in ipairs(selectedCards) do
        if availableCard == card then
          selected = true
          break
        end
      end
      _G["choiceSubMenu"..index] = function() 
        selectCommandCard(isContingencies, availableCard, numberSelection)
      end
      local aColor = {0.1764,0.1764,0.1764,0.01}
      if selected then
        aColor = {0,1,1,0.5}
      end
      local aFontColor = {0,0,0,100}
      if selected then
        aFontColor = {0,0,0,2}
      end
      setChoiceAttributes(
        index,
        availableCard,
        "choiceSubMenu"..index,
        aColor,
        aFontColor
      )
      index = index + 1
    end
  end

  updateButtons()
end

function objectiveSubMenu()
    battlefieldCardSubMenu("objective")
end

function deploymentSubMenu()
    battlefieldCardSubMenu("deployment")
end

function conditionsSubMenu()
    battlefieldCardSubMenu("conditions")
end

function battlefieldCardSubMenu(selectedType)
  nilChoices()

  j = 1
  for i, entry in ipairs(Deck:getBattleCardNamesByType(selectedType, selectedScenario)) do
    _G["choiceSubMenu"..i] = function() 
      toggleBattlefieldCard(selectedType, entry)
    end
    acolor = {0.1764,0.1764,0.1764,0.01}
    afontColor = {0,0,0,100}

    for _, entryChoice in ipairs(battlefieldCardSelection[selectedType]) do
      if entryChoice:lower() == entry:lower() then
        acolor = {0,1,1,0.5}
        afontColor = {0,0,0,2}
        break
      else
        acolor = {0.1764,0.1764,0.1764,0.01}
        afontColor = {0,0,0,100}
      end
    end

    setChoiceAttributes(j, entry, "choiceSubMenu"..i, acolor, afontColor)
    j = j + 1
  end

  updateButtons()
end

function setChoiceAttributes(numberSelect, entryName, clickFunction, color, fontColor)

    selectionEntry[numberSelect].entryName = entryName
    selectionEntry[numberSelect].clickFunction = clickFunction

    selectionEntry[numberSelect].fontSize = correctStringLength(entryName)

    selectionEntry[numberSelect].color = color
    selectionEntry[numberSelect].fontColor = fontColor
end

function selectCommandCard(isContingencies, selectedCard, subMenuIndex)
    local selectedCards

    if isContingencies then
      selectedCards = contingencyCardSelection
    else
      selectedCards = commandCardSelection
    end

    for i, n in ipairs(selectedCards) do
      if n == selectedCard then
        table.remove(selectedCards, i)
        commandCardSubMenu(subMenuIndex)
        return
      end
    end

    table.insert(selectedCards, selectedCard)
    commandCardSubMenu(subMenuIndex)
end

function toggleBattlefieldCard(battlefieldCardType, selectedBattlefieldCard)
    noCardFound = true
    for i, entry in pairs (battlefieldCardSelection[battlefieldCardType]) do
        if entry ==  selectedBattlefieldCard then
            noCardFound = false
            table.remove(battlefieldCardSelection[battlefieldCardType], i)
            break
        else
            noCardFound = true
        end
    end
    if noCardFound == true then
        table.insert(battlefieldCardSelection[battlefieldCardType], selectedBattlefieldCard)
    end

    battlefieldCardSubMenu(battlefieldCardType)
end

function dud()
end

function correctStringLength(measuredString)
    if string.len(measuredString) > 21 then
        local returnLength = 160 - ((string.len(measuredString) - 22) * 5.5)
        return returnLength
    else
        return 160
    end
end

function switchBattleDeck(params)
  if not params or not params.name then
    return
  end
  _G.selectedScenario = params.name
  -- TODO: Make configurable as defaults.
  if params.name:lower() == 'standard' then
    battlefieldCardSelection = {
      objective = {
        "Key Positions",
        "Breakthrough",
        "Intercept The Transmissions",
        "Recover The Supplies",
      },
      deployment = {
        "Battle Lines",
        "The Long March",
        "Disarray",
        "Major Offensive",
      },
      conditions = {
        "Clear Conditions",
        "Limited Visibility",
        "Rapid Reinforcements",
        "Hostile Environment",
      },
    }
  elseif params.name:lower() == 'skirmish' then
    battlefieldCardSelection = {
      objective  = {
        "Breach",
        "Control",
        "Elimination",
        "Pivotal Positions",
      },
      deployment = {
        "Battle Lines",
        "Faceoff",
        "Flanking Positions",
        "Meeting Engagement",
      },
      conditions = {
        "War Weary",
        "Improvised Defenses",
        "Dawn",
        "Clear Conditions",
      },
    }
  else
    battlefieldCardSelection = {
      objective  = {},
      deployment = {},
      conditions = {},
    }
  end
  resetButtons()
  updateButtons()
end

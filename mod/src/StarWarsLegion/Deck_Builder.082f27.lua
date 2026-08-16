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
    battlefieldCardSelection = defaultBattlefieldSelection(selectedScenario)

    resetButtons()
end

-- The deck builder used to start with twelve cards already selected, written
-- out by hand, one list per scenario. Every one of them had drifted: none of
-- the twelve names under "standard" exists in the standard scenario, and none
-- of the twelve under "skirmish" exists in skirmish. Cards the scenario does
-- not have still spawn - as an unrecognized card each - so a freshly opened
-- deck builder produced twelve of those on top of whatever was actually
-- picked.
--
-- Nothing is selected to begin with now, which is what blitz already did and
-- what the player expects: pick nine cards, get nine cards.
function defaultBattlefieldSelection(_scenario)
  return {
    objective  = {},
    deployment = {},
    conditions = {},
  }
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

-- The eleven choice rows are printed on the model, so the buttons cannot be
-- spaced any other way and a longer list has to be paged rather than squeezed.
CHOICE_ROWS = 11

-- Half-width pager buttons on the last row. The rows are printed on the model,
-- so they cannot be measured from the script - but the highlight drawn on a
-- selected row can: it is a button of width 2040 and it renders exactly two
-- local units wide, which fixes the scale at 1020 per unit.
--
-- A row is therefore 2.0 across and an exact half would be 1020 wide at an
-- offset of 0.5. The pair leaves a gutter of 0.4 between them instead, which
-- costs each button half the gutter on its inner edge and moves its centre out
-- by a quarter of it, so the outer edges still line up with the row.
PAGER_WIDTH = 816
PAGER_OFFSET = 0.6

function nilChoices()
    selectionEntry = {}
    for i=1,CHOICE_ROWS,1 do
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

    for i=1,CHOICE_ROWS,1 do
        if selectionEntry[i].pager then
            -- The last row is printed as two halves on the model, so the pager
            -- gets one button in each rather than one straddling both.
            for _, half in ipairs(selectionEntry[i].pager) do
                self.createButton({
                    click_function = half.clickFunction,
                    function_owner = self,
                    label = half.entryName,
                    position = {-1.45 + half.offset, 0.28, 2.394-(i*0.354)},
                    rotation = {0, 180, 0},
                    scale = {0.5, 0.5, 0.5},
                    width = PAGER_WIDTH,
                    height = 410,
                    font_size = 160,
                    color = {1, 0.647, 0, 0.5},
                    font_color = {0, 0, 0, 2},
                    tooltip = ""
                })
            end
        else
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

-- The list is longer than the panel for the standard conditions - fourteen
-- cards for eleven rows - and every entry past the eleventh used to index past
-- the end of selectionEntry, so opening that submenu errored out and drew
-- nothing at all. The last row becomes a pager when the list does not fit.
function battlefieldCardSubMenu(selectedType, page)
  local entries = Deck:getBattleCardNamesByType(selectedType, selectedScenario)
  nilChoices()

  local perPage = CHOICE_ROWS
  local pages = 1
  if #entries > CHOICE_ROWS then
    perPage = CHOICE_ROWS - 1
    pages = math.ceil(#entries / perPage)
  end
  page = page or 1
  if page > pages then
    page = 1
  end

  j = 1
  for i = (page - 1) * perPage + 1, math.min(page * perPage, #entries) do
    local entry = entries[i]
    _G["choiceSubMenu"..j] = function()
      toggleBattlefieldCard(selectedType, entry, page)
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

    setChoiceAttributes(j, entry, "choiceSubMenu"..j, acolor, afontColor)
    j = j + 1
  end

  if pages > 1 then
    local previousPage = (page - 2) % pages + 1
    local nextPage = page % pages + 1
    _G.choicePagePrev = function()
      battlefieldCardSubMenu(selectedType, previousPage)
    end
    _G.choicePageNext = function()
      battlefieldCardSubMenu(selectedType, nextPage)
    end
    selectionEntry[CHOICE_ROWS].pager = {
      { entryName = "< PREV", clickFunction = "choicePagePrev", offset =  PAGER_OFFSET },
      { entryName = "NEXT >", clickFunction = "choicePageNext", offset = -PAGER_OFFSET },
    }
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

function toggleBattlefieldCard(battlefieldCardType, selectedBattlefieldCard, page)
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

    battlefieldCardSubMenu(battlefieldCardType, page)
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
  battlefieldCardSelection = defaultBattlefieldSelection(params.name)
  resetButtons()
  updateButtons()
end

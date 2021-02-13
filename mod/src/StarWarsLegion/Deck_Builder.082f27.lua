function onLoad(save_state)
    --self.interactable = false
    listBuilder = Global.getTable("listBuilder")
    setUpCards = Global.getTable("setUpCards")

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
    selectedCommanders[1] = "neutral"
    selectedCommanders[2] = "neutralAltArt"

    if selectedFaction == "imperial" then
        addCommander("neutralImperial")
    elseif selectedFaction == "rebel" then
        addCommander("neutralRebel")
    elseif selectedFaction == "separatist" then
        addCommander("neutralSeparatist")
    elseif selectedFaction == "republic" then
        addCommander("neutralRepublic")
    end

    resetCommandCards()

    -- Default selections. Can be changed by the user!
    battlefieldCardSelection = {}
    battlefieldCardSelection.objective = {"Key Positions", "Breakthrough", "Intercept the Transmissions", "Recover the Supplies"}
    battlefieldCardSelection.deployment = {"Battle Lines", "The Long March", "Disarray", "Major Offensive"}
    battlefieldCardSelection.conditions = {"Clear Conditions", "Limited Visibility", "Rapid Reinforcements", "Hostile Environment"}

    resetButtons()
end


function resetCommandCards()
    commandCardSelection = {}
    commandCardSelection[1] = "Ambush"
    commandCardSelection[2] = "Ambush"
    commandCardSelection[3] = "Push"
    commandCardSelection[4] = "Push"
    commandCardSelection[5] = "Assault"
    commandCardSelection[6] = "Assault"
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
            label = commandCardSelection[i],
            position = {1.4, 0.28, 2.394-(i*0.354)},
            rotation = {0, 180, 0},
            scale = {0.5, 0.5, 0.5},
            width = 2040,
            height = 410,
            font_size = correctStringLength(commandCardSelection[i]),
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
    local pipSelected = math.ceil(numberSelection/2)

    local n = 1
    for i, selectedCommander in pairs(selectedCommanders) do

        -- GET AVAILABLE CARD
        if listBuilder.commandCards[selectedCommander].cards != nil then
            local availableCard = listBuilder.commandCards[selectedCommander].cards[pipSelected]

            -- SET FUNCTION NAME
            _G["choiceSubMenu"..n] = function() selectCommandCard(numberSelection, availableCard) end

            if commandCardSelection[numberSelection] == availableCard then
                acolor = {0,1,1,0.5}
                afontColor = {0,0,0,2}
            else
                acolor = {0.1764,0.1764,0.1764,0.01}
                afontColor = {0,0,0,100}
            end

            setChoiceAttributes(n, availableCard, "choiceSubMenu"..n, acolor, afontColor)
        end
        n = n + 1
        if listBuilder.commandCards[selectedCommander].cards2 != nil then
            local availableCard = listBuilder.commandCards[selectedCommander].cards2[pipSelected]

            -- SET FUNCTION NAME
            _G["choiceSubMenu"..n] = function() selectCommandCard(numberSelection, availableCard) end

            if commandCardSelection[numberSelection] == availableCard then
                acolor = {0,1,1,0.5}
                afontColor = {0,0,0,2}
            else
                acolor = {0.1764,0.1764,0.1764,0.01}
                afontColor = {0,0,0,100}
            end

            setChoiceAttributes(n, availableCard, "choiceSubMenu"..n, acolor, afontColor)
            n = n + 1
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
    for i, entry in pairs(setUpCards[selectedType]) do
        _G["choiceSubMenu"..i] = function() toggleBattlefieldCard(selectedType, entry.name) end
        acolor = {0.1764,0.1764,0.1764,0.01}
        afontColor = {0,0,0,100}

        for n, entryChoice in pairs (battlefieldCardSelection[selectedType]) do
            if entryChoice ==  entry.name then
                acolor = {0,1,1,0.5}
                afontColor = {0,0,0,2}
                break
            else
                acolor = {0.1764,0.1764,0.1764,0.01}
                afontColor = {0,0,0,100}
            end
        end


        setChoiceAttributes(j, entry.name, "choiceSubMenu"..i, acolor, afontColor)
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

function selectCommandCard(commandCardNumber, selectedCard)
    commandCardSelection[commandCardNumber] = selectedCard

    commandCardSubMenu(commandCardNumber)
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

function onLoad(save_state)
    -- intialize
    self.interactable = false
    listBuilder = Global.getTable("listBuilder")
    gameController = Global.getTable("gameController")

    optionButton = getObjectFromGUID("13e1d5")

    deckZone = getObjectFromGUID(listBuilder.blueDeckZoneGUID)
    deckMount = getObjectFromGUID(listBuilder.blueDeckMountGUID)
    gameControllerObj = getObjectFromGUID(gameController.objGUID)

    setUp()
end

function setUp()
    clearButton("objective")
    createOptionButton("checkDeck", "Battle Deck", "Define Battlefield", {0,0.913,1})
end

function clearButton(optionSelection)
    self.clearButtons()
    optionButton.clearButtons()
    optionButton.setColorTint({0,0,0})
end

function createOptionButton(optionClickFunction, optionLabel, optionToolTip, tint)

    _G["deckMountButton"] = function()
        optionButton.AssetBundle.playTriggerEffect(0)
        _G[optionClickFunction]()
    end
    self.createButton({
        click_function = "deckMountButton", function_owner = self, label = optionLabel, position = {-0.5, 0.3, -1.95}, scale = {0.5, 0.5, 0.5}, width = 2500, height = 600, font_size = 300, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100},tooltip = optionToolTip
    })

    optionButton.createButton({
        click_function = "deckMountButton", function_owner = self, label = "", position = {0, 0.65, 0}, width = 1400, height = 1400, font_size = 1100, color = {1,1,1,0.01},font_color = {1,1,1,100}, tooltip = optionToolTip, alignment = 3
    })

    optionButton.setColorTint(tint)
end

function checkDeck()
    local deckObjs = deckZone.getObjects()
    local gotDeck = false
    for i, obj in pairs(deckObjs) do
        if obj != deckMount then
            battleDeckObj = obj
            gotDeck = true
        end
    end

    if gotDeck == true then
        gameControllerObj.call("defineBattlefieldMenu", battleDeckObj)
    else
        broadcastToAll("No Battlefield Deck. Insert Battlefield Deck to Blue Player Deck Mount to Define Battlefield",{1,1,1})
    end
end

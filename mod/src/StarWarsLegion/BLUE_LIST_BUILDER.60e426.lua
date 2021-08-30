#include !/common/Math
#include !/data/CardInfo_new
#include !/data/MiniInfo
#include !/ListBuilder

function onLoad()
    onLoadShared(
      "blue",
      -- List Builder Menu
      {
        getObjectFromGUID("58f562"),
        getObjectFromGUID("bcaa6a"),
        getObjectFromGUID("d01adc"),
        getObjectFromGUID("887737"),
      },
      -- List Builder Buttons
      {
        getObjectFromGUID("e5ab6a"),
        getObjectFromGUID("16651c"),
        getObjectFromGUID("5fd41f"),
        getObjectFromGUID("e1e76b"),
      },
      -- Back Button
      getObjectFromGUID("002439"),
      -- Data Disk Mount
      getObjectFromGUID("87a622")
    )

    -- INIT
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    battlefieldTint = gameData.getTable("battlefieldTint")
    listBuilder = Global.getTable("listBuilder")
    cardZone = getObjectFromGUID(listBuilder[colorZone .. "ZoneGUID"])
    ptCounter = getObjectFromGUID(listBuilder[colorZone.."CounterGUID"])
    colorSide = colorZone
    battlefieldTable = getObjectFromGUID(Global.getVar("battlefieldTable"))
    cardInfo = CardInfoClass:buildCardInfo()
    templateMenu = Global.getTable("templateMenu")
    miniInfo = Global.getTable("miniInfo")
    unitIDTokenBag = getObjectFromGUID(Global.getVar("unitIDTokenBagGUID"))
    commandTokenData = Global.getTable("commandTokenData")
    commandTokenTrayData = Global.getTable("commandTokenTrayData")

    gameController = Global.getTable("gameController")
    objectiveCards = getObjectFromGUID(gameController.objectiveCardsGUID)
    deploymentCards = getObjectFromGUID(gameController.deploymentCardsGUID)
    conditionsCards = getObjectFromGUID(gameController.conditionsCardsGUID)

    deckMount = getObjectFromGUID(listBuilder[colorSide.."DeckMountGUID"])
    deckZone = getObjectFromGUID(listBuilder[colorSide.."DeckZoneGUID"])

    mainMenu()
end

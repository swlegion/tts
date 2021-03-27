#include !/common/Math
#include !/data/CardInfo_new
#include !/data/MiniInfo
#include !/ListBuilder

function onLoad()
    onLoadShared(
      "red",
      -- List Builder Menu
      {
        getObjectFromGUID("9ef6b1"),
        getObjectFromGUID("5e6794"),
        getObjectFromGUID("93647c"),
        getObjectFromGUID("b1c973"),
      },
      -- List Builder Buttons
      {
        getObjectFromGUID("909b03"),
        getObjectFromGUID("1b5cc8"),
        getObjectFromGUID("a39e50"),
        getObjectFromGUID("1faf70"),
      },
      -- Back Button
      getObjectFromGUID("d323a0"),
      -- Data Disk Mount
      getObjectFromGUID("ace9b9")
    )

    -- INIT
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    battlefieldTint = gameData.getTable("battlefieldTint")
    listBuilder = Global.getTable("listBuilder")
    cardZone = getObjectFromGUID(listBuilder[colorZone .. "ZoneGUID"])
    ptCounter = getObjectFromGUID(listBuilder[colorZone.."CounterGUID"])
    colorSide = colorZone
    battlefieldTable = getObjectFromGUID(Global.getVar("battlefieldTable"))
    -- cardInfo = Global.getTable("cardInfo")
    cardInfo = CardInfoClass:buildCardInfo()
    templateMenu = Global.getTable("templateMenu")
    miniInfo = Global.getTable("miniInfo")
    -- unitInfo = Global.getTable("unitInfo")
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

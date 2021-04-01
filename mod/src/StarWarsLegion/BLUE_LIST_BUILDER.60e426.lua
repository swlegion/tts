#include !/common/Math
#include !/data/CardInfo_new
#include !/data/MiniInfo
#include !/ListBuilder
function ga_track(data)
  local url =  "http://www.google-analytics.com/collect"
  local payload = {
    v   = "1",
    tid = "UA-192712398-2",
    cid = Global.getVar("CCID"),
    uid = Global.getVar("UUID"),
  }
  for k, v in pairs(data) do
    payload[tostring(k)] = tostring(v)
  end
  WebRequest.post(url, payload)
end

function ga_event(category, action, label, value)
  local data = {
    t   = "event",
    ec  = category,
    ea  = action,
  }
  if label ~= nil then
    data["el"] = label
    if value ~=nil then
      data["ev"] = value
    end
  end
  ga_track(data)
end

function ga_view(screen, title)
  local data = {
    t   = "pageview",
    dp  = screen,
  }
  if title ~= nil then
    data["dt"] = title
  end
  ga_track(data)
end

function ga_timing(category, variable, time, label)
  ga_track({
    t   = "timing",
    utc = category,
    utv = variable,
    utt = time,
    utl = label,
  })
end

function ga_exception(description, is_fatal)
  if is_fatal == true then
    is_fatal = 1
  else
    is_fatal = 0
  end
  ga_track({
    t   = "exception",
    exd = description,
    exf = is_fatal,
  })
end

#include !/Analytics

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

    allBattlefieldCards = getObjectFromGUID(gameController.battlefieldCardsGUID)

    deckMount = getObjectFromGUID(listBuilder[colorSide.."DeckMountGUID"])
    deckZone = getObjectFromGUID(listBuilder[colorSide.."DeckZoneGUID"])

    mainMenu()
end

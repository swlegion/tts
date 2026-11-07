require('!/data/RulesLibrary')

-- The rules panel: a control panel that picks which document each lectern
-- shows. It is a clone of the game controller's hardware -- same console mesh,
-- same five label plates, same square buttons, same BACK -- so it behaves and
-- reads like the panels already on the table, and no new asset was needed.
--
-- Two screens, the way the game controller's menus already work:
--   documents  five plates, one per document
--   lecterns   which lectern to send it to, plus the language
--
-- The lecterns carry no menu of their own. This panel reads what each one is
-- showing straight out of its serialised data, and writes the swap back the
-- same way.

local PLATE_GUIDS = { 'e0d002', 'e0d003', 'e0d004', 'e0d005', 'e0d006' }
local BUTTON_GUIDS = { 'e0d007', 'e0d008', 'e0d009', 'e0d00a', 'e0d00b' }
local BACK_GUID = 'e0d00c'

-- The lecterns are found by the mark in their GMNotes rather than by GUID.
-- Swapping a document means destroying and respawning the object, which can
-- hand it a fresh GUID; GMNotes travel with the serialised data and do not
-- change. Nearest the panel is lectern 1, which is the order they read in.
local LECTERN_MARK = '^isq%-lectern%-(%d+)$'

-- The three lecterns take the first rows, the two languages the rest.
local LECTERN_ROWS = 3
local LANGUAGE_ROW_FIRST = LECTERN_ROWS + 1
local LANGUAGE_ROWS = { { code = 'en', label = 'VO' }, { code = 'fr', label = 'VF' } }

local TURQUOISE = { 0, 0.913, 1 }
local AMBER = { 1, 0.647, 0 }
local OFF = { 0, 0, 0 }

local plates, buttons, backButton, lecterns

-- The document waiting to be sent, and the language it will be sent in. The
-- language persists between choices, so a French table sets it once.
local pending = nil
local language = 'en'

local function documentTitle(key)
  for _, doc in ipairs(RULES_LIBRARY) do
    if doc.key == key then return doc.title end
  end
  return key
end

-- Rebuilt on demand, because a lectern is a different object after each swap.
local function findLecterns()
  lecterns = {}
  for _, obj in ipairs(getAllObjects()) do
    local index = tonumber(string.match(obj.getGMNotes() or '', LECTERN_MARK))
    if index then lecterns[index] = obj end
  end
end

-- The url lives in the object's serialised data. getCustomObject returns an
-- empty table on a Custom PDF, so this is the only place it can be read.
local function lecternUrl(lectern)
  if not lectern then return nil end
  local ok, data = pcall(function() return JSON.decode(lectern.getJSON()) end)
  if ok and data and data.CustomPDF then return data.CustomPDF.PDFUrl end
  return nil
end

-- What a lectern is showing, named the way the document list names it.
local function lecternHolds(index)
  local choice = RULES_LIBRARY_BY_URL[lecternUrl(lecterns[index]) or '']
  return choice and choice.label or nil
end

-- Guarded throughout: a missing plate should leave the rest of the panel
-- working rather than abort the load handler and take the whole menu with it.
local function clearPanel()
  for _, plate in ipairs(plates) do
    if plate then plate.clearButtons() end
  end
  for _, button in ipairs(buttons) do
    if button then
      button.clearButtons()
      button.setColorTint(OFF)
    end
  end
  if backButton then
    backButton.clearButtons()
    backButton.setColorTint(OFF)
  end
end

-- Draws one row: the label on its plate, and the square button beside it.
-- Both trigger the same callback, exactly as the game controller does it.
local function row(index, callbackName, label, tooltip, tint)
  local plate = plates[index]
  local button = buttons[index]
  if not plate or not button then return end

  _G['rulesPanelRow' .. index] = function()
    button.AssetBundle.playTriggerEffect(0)
    _G[callbackName](index)
  end

  -- The plates are narrow, so long labels are stepped down rather than clipped.
  local fontSize = 400
  if string.len(label) >= 24 then
    fontSize = 400 - ((string.len(label) - 22) * 8)
  end

  plate.createButton({
    click_function = 'rulesPanelRow' .. index,
    function_owner = self,
    label          = label,
    tooltip        = tooltip,
    position       = { -0.35, 0.3, 0 },
    scale          = { 0.5, 0.5, 0.5 },
    width          = 4200,
    height         = 600,
    font_size      = fontSize,
    color          = { 0.7573, 0.7573, 0.7573, 0.01 },
    font_color     = { 0, 0, 0, 100 },
  })

  button.createButton({
    click_function = 'rulesPanelRow' .. index,
    function_owner = self,
    label          = '',
    tooltip        = tooltip,
    position       = { 0, 0.65, 0 },
    width          = 1400,
    height         = 1400,
    font_size      = 1100,
    color          = { 1, 1, 1, 0.01 },
    font_color     = { 1, 1, 1, 100 },
    alignment      = 3,
  })

  button.setColorTint(tint or TURQUOISE)
end

local function back(callbackName, tooltip)
  if not backButton then return end
  _G['rulesPanelBack'] = function()
    backButton.AssetBundle.playTriggerEffect(0)
    _G[callbackName]()
  end
  backButton.createButton({
    click_function = 'rulesPanelBack',
    function_owner = self,
    label          = 'BACK',
    tooltip        = tooltip,
    position       = { 0, 0.65, 0 },
    scale          = { 1, 1, 1.4 },
    width          = 1500,
    height         = 2000,
    font_size      = 400,
    color          = { 0.7573, 0.7573, 0.7573, 0.01 },
    font_color     = { 0, 0, 0, 100 },
  })
  backButton.setColorTint({ 1, 0, 0 })
end

-- Screen one: the documents.
function rulesPanelDocuments()
  pending = nil
  clearPanel()
  for index, doc in ipairs(RULES_LIBRARY) do
    row(index, 'rulesPanelChooseDocument', doc.title,
      'Send ' .. doc.title .. ' to a lectern')
  end
end

function rulesPanelChooseDocument(index)
  local doc = RULES_LIBRARY[index]
  if not doc then return end
  pending = doc.key
  rulesPanelTargets()
end

-- Screen two: where to send it, and in which language. The three lecterns
-- report what they are holding so nothing is overwritten blind.
function rulesPanelTargets()
  clearPanel()
  findLecterns()
  for index = 1, LECTERN_ROWS do
    local holds = lecternHolds(index) or 'empty'
    row(index, 'rulesPanelSend', 'Lectern ' .. index .. '  -  ' .. holds,
      'Show ' .. documentTitle(pending) .. ' here, replacing ' .. holds)
  end

  for offset, entry in ipairs(LANGUAGE_ROWS) do
    row(LANGUAGE_ROW_FIRST + offset - 1, 'rulesPanelSetLanguage', entry.label,
      entry.code == 'en' and 'Original English version'
                          or 'French version, Iron Squadron translation',
      language == entry.code and AMBER or OFF)
  end

  back('rulesPanelDocuments', 'Back to the document list')
end

function rulesPanelSetLanguage(index)
  local entry = LANGUAGE_ROWS[index - LANGUAGE_ROW_FIRST + 1]
  if not entry then return end
  language = entry.code
  rulesPanelTargets()
end

-- Swapping a document means rebuilding the object: setCustomObject is inert on
-- a Custom PDF, so the only way through is to patch the serialised data and
-- spawn it again. The panel does it rather than the lectern, because
-- destroyObject cancels the timers of the script that called it -- a lectern
-- respawning itself would kill its own spawn before it ran.
local function swap(lectern, choice)
  local data = JSON.decode(lectern.getJSON())
  if not (data and data.CustomPDF) then return false end
  if data.CustomPDF.PDFUrl == choice.url then return false end
  data.CustomPDF.PDFUrl = choice.url
  data.Nickname = choice.label
  local json = JSON.encode(data)
  destroyObject(lectern)
  -- A frame's grace so the old object is gone and its GUID is free again;
  -- if TTS hands out a new one anyway, GMNotes still identify the lectern.
  Wait.frames(function()
    spawnObjectJSON({ json = json })
    Wait.frames(findLecterns, 1)
  end, 1)
  return true
end

function rulesPanelSend(index)
  findLecterns()
  local lectern = lecterns[index]
  if not lectern then
    broadcastToAll('Lectern ' .. index .. ' is missing from the table.', { 1, 0.5, 0.5 })
    return
  end

  local wanted, fallback = nil, nil
  for _, choice in ipairs(RULES_LIBRARY_CHOICES) do
    if choice.key == pending then
      if choice.language == language then wanted = choice end
      fallback = fallback or choice
    end
  end
  local choice = wanted or fallback
  if not choice then return end

  if swap(lectern, choice) then
    broadcastToAll(choice.label .. ' on lectern ' .. index, { 0.8, 0.9, 1 })
  else
    broadcastToAll('Lectern ' .. index .. ' already shows ' .. choice.label,
      { 0.8, 0.8, 0.8 })
  end
  rulesPanelDocuments()
end

function onLoad()
  -- Indexed rather than appended: getObjectFromGUID returns nil for anything
  -- missing, table.insert refuses a nil, and appending would renumber every
  -- plate after the gap so row three would draw on plate four.
  plates, buttons = {}, {}
  for index, guid in ipairs(PLATE_GUIDS) do plates[index] = getObjectFromGUID(guid) end
  for index, guid in ipairs(BUTTON_GUIDS) do buttons[index] = getObjectFromGUID(guid) end
  backButton = getObjectFromGUID(BACK_GUID)
  findLecterns()

  -- Imposed, never toggled: undoing reruns this handler with the state of the
  -- snapshot, so anything that flipped here would flip back on the next undo.
  rulesPanelDocuments()
end

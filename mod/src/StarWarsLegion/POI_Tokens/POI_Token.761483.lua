rangeKey = "poi"

require('!/RangeRulers')

-- each token must define 'rangeKey' with key listed below

-- Token keys in RangeRulers Table
-- smokeToken = 18.8mm diameter (range 1)
-- token = 25.1mm diameter (range 1)
-- poi = 50.8mm diameter (range 0.5 aka 3in)

function onLoad()
  rangeOn = false
  createButton({0, 0, 0})
  createButton({0, 0, 180})
  addSilhouetteButton()
end

function createButton(rotation)
  local gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
  local btnTint = gameData.getTable("battlefieldTint")
  self.createButton({
    click_function = "toggleRangeRuler",
    function_owner = self,
    label = "R",
    tooltip = "Spawn Range Ruler",
    position = {-0.2, 0.1, 1.15},
    rotation = rotation,
    width = 230,
    height = 180,
    font_size = 100,
    color= {btnTint["r"], btnTint["g"], btnTint["b"], 0.7},
    font_color= {1, 1, 1, 100}
  })
end

function onDestroy()
  clearRangeRuler()
end

function toggleRangeRuler()
  clearRangeRuler()
  rangeOn = not rangeOn
  if rangeOn then
    spawnTokenRangeRuler()
  end
end

function clearRangeRuler()
  if rangeRuler then
    destroyObject(rangeRuler)
    rangeRuler = nil
  end
end

function spawnTokenRangeRuler()
  local rangeRulerTable = getRangeRulerLinks()
  local tokenRulerBundle = rangeRulerTable[rangeKey]
  spawnRangeRuler(self, tokenRulerBundle)
end


function addSilhouetteButton()
    local gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))
    local btnTint = gameData.getTable("battlefieldTint")
    btnData = {
      click_function = "toggleSilhouettes",
      function_owner = self,
      label = "SIL",
      tooltip = "Toggle silhouettes on this unit",
      position = {0.2, 0.1, 1.15},
      width = 230,
      height = 180,
      font_size = 100,
      color= {btnTint["r"], btnTint["g"], btnTint["b"], 0.7},
      font_color= {1, 1, 1, 100}
    }
    self.createButton(btnData)
  end    

  function toggleSilhouettes()
    if silhouetteState then
      clearSilhouette()
    else
      showSilhouette()
    end
  end
  
  -- Loops through all minis in the unit
  -- Removes all attachments and destroys the first one
  -- The silhouette should be the only attachment, so this should be safe to do
  function clearSilhouette()
    local silToDestroy = self.removeAttachments()[1]
    silToDestroy.destruct()
    silhouetteState = false
  end
  
  -- Loops through all minis in the unit
  -- Spawns a silhouette at the pos and rot of each one
  -- and attaches them using the new attachment feature
  function showSilhouette()
    local pos = self.getPosition()
    local rot = self.getRotation()
    local newSilhouette = spawnSilhouette(self, pos, rot)
    silhouetteState = true
  end
  
  function spawnSilhouette(obj, pos, rot)
    local globals = Global.getTable("templateInfo")
    local scale = 2.0
    local height = 3.0
    local offset = 0.0
    local silhouetteData = "http://cloud-3.steamusercontent.com/ugc/5063766435505471684/D97103C9FFB76016DDF9CE66A7622BDB3E810160/"
    if obj ~= nil then
      local objUp = obj.getTransformUp()
      local offsetVector = Vector.new(objUp.x * offset, objUp.y * offset, objUp.z * offset)
      pos = { pos.x + offsetVector.x, pos.y + offsetVector.y, pos.z + offsetVector.z }
    end
    
  
    local silhouette = spawnObject({
      type = "Custom_AssetBundle",
      position = pos,
      rotation = rot,
      scale = {scale,height,scale}
    })
    silhouette.setCustomObject({
        assetbundle = silhouetteData,
        material = 3
    })
    silhouette.setColorTint({1.0,0.56,0.17,0.3})
    if obj ~= nil then
      obj.addAttachment(silhouette)
    end
    return silhouette
  end
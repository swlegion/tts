position = {x = -25.4028015136719, y = 1.4477014541626, z = -14.9005193710327}
rotation = {x = -0.000304694869555533, y = 180.008102416992, z = 7.81823182478547E-05}

scripted = true
position = {x = -25.4028015136719, y = 1.4477014541626, z = -14.9005279541016}
rotation = {x = -0.000301350111840293, y = 180.008270263672, z = 8.95557677722536E-05}

scripted = true
position = {x = -25.4028015136719, y = 1.44191324710846, z = -14.9005193710327}
rotation = {x = -0.00167207431513816, y = 180.008102416992, z = -1.47594300869969E-05}

board_6x3 = "http://cloud-3.steamusercontent.com/ugc/785234780859015647/B98B08E01F9F286630AE190B71A63A3BDD6F3E42/"
board_3x3 = "http://cloud-3.steamusercontent.com/ugc/1861690318337394165/88B0AA7DAF539875A19C1A86867E9922F01FBE07/"
board_6x4 = "http://cloud-3.steamusercontent.com/ugc/1861690318337395348/1A2942C470A2BF34712B4FFBAA535F4091D8BD7A/"

scripted = true
function onload(save_state)
    urlString = ""
    gameData = getObjectFromGUID(Global.getVar("gameDataGUID"))

    Wait.frames(function() setBattlefieldObj() end, 30)

    self.createButton({
        click_function = "setBaseTint", function_owner = self, label = "Set base\ntint color", position = {0.1, 0.300000011920929, 1.3}, scale = {0.5, 0.5, 0.5}, width = 2000, height = 900, font_size = 400, color = {1, 0.9547, 0, 1}, tooltip = "Set base tint color"
    })

    self.createInput({

        input_function = "inputValue", function_owner = self, label = "Battlefield Image URL", position = {3.4, 0.3, -0.2}, scale = {0.5, 0.5, 0.5}, width = 4000, height = 500, font_size = 400, tooltip = "Battlefield Image URL", alignment = 3, value = "Battlefield Image URL"
    })

    self.createButton({
        click_function = "spawn6x3", function_owner = self, label = "Create 6x3", position = {3.4, 0.3, 0.4}, scale = {0.5, 0.5, 0.5}, width = 4000, height = 400, font_size = 300, tooltip = "Create 6x3 board with provided Image"
    })

    self.createButton({
        click_function = "spawn3x3", function_owner = self, label = "Create 3x3", position = {3.4, 0.3, 1.0}, scale = {0.5, 0.5, 0.5}, width = 4000, height = 400, font_size = 300, tooltip = "Create 3x3 board with provided Image"
    })

    self.createButton({
        click_function = "spawn6x4", function_owner = self, label = "Create 6x4", position = {3.4, 0.3, 1.6}, scale = {0.5, 0.5, 0.5}, width = 4000, height = 400, font_size = 300, tooltip = "Create 6x4 board with provided Image"
    })
end

function setBattlefieldObj()
    local allObjs = getAllObjects()
    for i, obj in pairs(allObjs) do
        if obj.getName() == "BATTLEFIELD" then
            battlefieldObj = obj
            break
        end
    end
end

function inputValue(obj, color, urlInput, stillEditing)
    if not stillEditing then
        urlString = urlInput
    end
end

function spawn6x3()
   setBattlefieldImage(board_6x3)
end

function spawn3x3()
   setBattlefieldImage(board_3x3)
end

function spawn6x4()
   setBattlefieldImage(board_6x4)
end

function setBattlefieldImage(targetMesh)
    battlefieldObj.setCustomObject({
        mesh = targetMesh,
        collider = targetMesh,
        diffuse = urlString,
        type = 0,
        material = 3})
    battlefieldObj.reload()
end

function dud()
end

function setBaseTint()
    battlefieldTint = self.getColorTint()
    Global.setTable("battlefieldTint", battlefieldTint)
    enterTintData(gameData, "battlefieldTint", battlefieldTint)
    broadcastToAll("Mini Base tint set!", {1,1,1})
end

function enterTintData(obj, dataString, tintTable)
    local tintString =  "{r = "..tintTable.r..", g = "..tintTable.g..", b = "..tintTable.b.."}"
    enterData(obj, dataString, tintString)
    obj.setTable(dataString, tintTable)
end

function enterData(obj, dataString, newValue)
    dataScript = obj.getLuaScript()
    dataString = dataString .. " = "
    local stringStart = 0
    local valueStart = 0
    stringStart, valueStart = string.find(dataScript, dataString)
    valueStart = valueStart

    local valueEnd = 0
    local valueNil = 0
    valueEnd, valueNil = string.find(dataScript, "\n", valueStart)
    valueEnd = valueEnd

    local newDataScript = string.sub(dataScript, 1, valueStart).. newValue .. string.sub(dataScript, valueEnd)

    obj.setLuaScript(newDataScript)
end














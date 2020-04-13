function onLoad(save_state)
    self.interactable = false
    colorSide = "blue"
    splitButton = getObjectFromGUID("af10b9")
    stackButton = getObjectFromGUID("ff8c41")
    shuffleButton = getObjectFromGUID("25c9b2")

    -- init
    strColor = colorSide:gsub("^%l", string.upper)
    commandTokenTrayData = Global.getTable("commandTokenTrayData")
    trayZone = getObjectFromGUID(commandTokenTrayData[colorSide].trayZoneGUID)
    commandStack = getObjectFromGUID(commandTokenTrayData[colorSide].stack)

    splitButton.createButton({
        click_function = "splitTokens",
        function_owner = self,
        label = "SPLIT",
        tooltip = "Separate shuffled Command Tokens to their respective ranks",
        position = {0, 0.7, 0},
        scale = {0.6, 1, 1},
        width = 2100, height = 1400, font_size = 600, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}
    })

    stackButton.createButton({
        click_function = "stackTokens",
        function_owner = self,
        label = "STACK",
        tooltip = "Form Command Token stack and shuffle",
        position = {0, 0.7, 0},
        scale = {0.6, 1, 1},
        width = 2100, height = 1400, font_size = 600, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}
    })

    shuffleButton.createButton({
        click_function = "shuffleTokens",
        function_owner = self,
        label = "SHUFFLE",
        tooltip = "Shuffle Command Tokens",
        position = {0, 0.7, 0},
        scale = {0.6, 1, 1},
        width = 2100, height = 1400, font_size = 600, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}
    })

end

function splitTokens()
    splitButton.AssetBundle.playTriggerEffect(0)

    local commandStackObjs = commandStack.getObjects()
    local commandStackPos = commandStack.getPosition()
    if #commandStackObjs != 0 then
        for i, obj in pairs(commandStackObjs) do
            commandStackPos.y = commandStackPos.y + 0.4
            local drawnObj = commandStack.takeObject({
                position       = commandStackPos,
                callback       = "setTokenPosDelay",
                callback_owner = self,
                params         = {i},
                smooth         = false
            })
            drawnObj.setLock(true)
        end
    else

        if Player[strColor].seated then
            broadcastToColor("No Tokens in Command Stack", strColor, {1,1,1})
        else
            broadcastToAll("No Tokens in Command Stack", {1,1,1})
        end
    end


end

function setTokenPosDelay(obj, index)

    refreshTimer()
    Timer.create({
        identifier     = "setTokenPos"..timerCounter,
        function_name  = "setTokenPos",
        function_owner = self,
        parameters     = {obj,index[1]},
        delay          = 0.1
    })
end

function setTokenPos(delayVars)
    local obj = delayVars[1]
    local index = delayVars[2]

    if obj.getVar("isAToken") == true then
        obj.setLock(false)
        local commandType = obj.getVar("commandType")
        local commandTray = getObjectFromGUID(commandTokenTrayData[colorSide][commandType])
        local pos = commandTray.getPosition()
        pos.y = pos.y + 0.5 +(0.2 * index)
        local rot = self.getRotation()
        rot.y = rot.y - 90

        obj.setPositionSmooth(pos, false, false)
        obj.setRotation(rot)

    else
        obj.setLock(false)
    end
end



function stackTokens()
    stackButton.AssetBundle.playTriggerEffect(0)
    local trayZoneObjs = trayZone.getObjects()

    if #trayZoneObjs >1 then
        for _, obj in pairs(trayZoneObjs) do
            if obj != commandStack then
                commandStack.putObject(obj)
            end
        end
        commandStack.shuffle()

    else


        if Player[strColor].seated then
            broadcastToColor("No Command Tokens in Tray", strColor, {1,1,1})
        else
            broadcastToAll("No Command Tokens in Tray", {1,1,1})
        end
    end
    commandStack.call("updateStack")
end

function shuffleTokens()
    shuffleButton.AssetBundle.playTriggerEffect(0)
    commandStack.call("updateStack")
    if #commandStack.getObjects() > 0 then
        commandStack.shuffle()
        if Player[strColor].seated then
            broadcastToColor("Shuffling Command Stack", strColor, {1,1,1})
        else
            broadcastToAll("Shuffling Command Stack", {1,1,1})
        end

    else
        if Player[strColor].seated then
            broadcastToColor("No Tokens in Command Stack", strColor, {1,1,1})
        else
            broadcastToAll("No Tokens in Command Stack", {1,1,1})
        end

    end

end

function refreshTimer()
    timerCounter = Global.getVar("timerCounter")
    timerCounter = timerCounter + 1
    Global.setVar("timerCounter", timerCounter)
end

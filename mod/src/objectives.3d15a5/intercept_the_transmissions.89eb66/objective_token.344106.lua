position = {x = 49.8345527648926, y = 0.941939771175385, z = 15.7342796325684}
rotation = {x = 0.00137930607888848, y = 150.009719848633, z = -0.000795437605120242}

scripted = true

function onLoad(save_state)
    rangeOn = false
    self.createButton({
        click_function = "toggleRangeRuler",
        function_owner = self,
        label = "R",
        position = {0, 0.1, 0.7},
        scale = {0.5, 0.5, 0.5},
        width = 400, height = 300,
        font_size = 200, color = {0, 0, 0, 0.8},
        font_color = {0.1212, 0.8127, 0, 1}
    })
end

function onDestroy()
    clearRangeRuler()
end

function toggleRangeRuler()
    if rangeOn then
        clearRangeRuler()
        rangeOn = false
    else
        clearRangeRuler()
        spawnRangeRuler()
        rangeOn = true
    end
end

function clearRangeRuler()
    if rangeRuler != nil then
        destroyObject(rangeRuler)
    end
end

function spawnRangeRuler()

    basePos = self.getPosition()
    baseRot = self.getRotation()


    baseAddition = 1.06299 / 2

    rangeRuler = spawnObject({
        type = "Custom_Model",
        position = basePos,
        rotation = {0, baseRot.y, 0},
        scale = {6 + baseAddition, 3, 6 + baseAddition}
    })
    rangeRuler.setCustomObject({
        type = 0,
        mesh = "http://cloud-3.steamusercontent.com/ugc/785234780862835239/0858A62DF9F9E7DCB49B641E4938111697E4F3D4/",
        collider = "http://cloud-3.steamusercontent.com/ugc/785234780862865411/C2B5E8CA63651BE485909340212736C0A68C2754/",
        material = 1,
    })

    rangeRuler.setLock(true)
    rangeRuler.setName("Range Ruler")
    rangeRuler.setColorTint({0.7, 0.7, 0.7})

    luaScript = "targetGUID = '"..self.getGUID().."'\nfunction onFixedUpdate()\nif targetGUID != nil then\ntargetObj = getObjectFromGUID(targetGUID)\nself.setPosition(targetObj.getPosition())\nself.setRotation(targetObj.getRotation())\nend\nend"
    rangeRuler.setLuaScript(luaScript)
end











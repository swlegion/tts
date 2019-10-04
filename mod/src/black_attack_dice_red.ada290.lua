--Runs on load, creates button and makes sure the lockout is off
function onload()
    self.interactable = false
    data = {click_function = "buttonPress", function_owner = self, label = "",
    position = {0, 0.65, 0}, width = 1400, height = 1400, font_size = 1100, color = {1,1,1,0.01},
    font_color = {1,1,1,100}, tooltip = "Spawn Black Attack Dice", alignment = 3}

    self.createButton(data)
    dieRollerInfo = Global.getTable("dieRollerInfo")
    dieRoller = getObjectFromGUID(dieRollerInfo.redDieRollerGUID)
end


function buttonPress()
    self.AssetBundle.playTriggerEffect(0) --triggers animation/sound
    dieRoller.call("spawnBlackAttackDice")
end

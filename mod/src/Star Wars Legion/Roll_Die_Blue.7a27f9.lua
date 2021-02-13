--Runs on load, creates button and makes sure the lockout is off
function onload()
    self.interactable = false
    local data =
    self.createButton({click_function = "buttonPress", function_owner = self, label = "ROLL", position = {0, 0.65, 0}, width = 1400, height = 1400, font_size = 500, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = "Roll Die"})
    dieRollerInfo = Global.getTable("dieRollerInfo")

    dieRoller = getObjectFromGUID(dieRollerInfo.blueDieRollerGUID)
end


function buttonPress()
    self.AssetBundle.playTriggerEffect(0) --triggers animation/sound
    dieRoller.call("rollDie")
end

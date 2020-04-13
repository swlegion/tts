function onload()
    self.interactable = false
    self.createButton({click_function = "buttonPress", function_owner = self, label = "CLEAR", position = {0, 0.65, 0}, scale = {1, 1, 0.7}, width = 1500, height = 2000, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = "Clear Die"})

    dieRollerInfo = Global.getTable("dieRollerInfo")
    dieRoller = getObjectFromGUID(dieRollerInfo.blueDieRollerGUID)
end


function buttonPress()
    self.AssetBundle.playTriggerEffect(0) --triggers animation/sound
    dieRoller.call("clearDie")
end

function onLoad(save_state)
    self.interactable = false

    -- defaults
    battlefieldZone = getObjectFromGUID(Global.getVar("battlefieldZoneGUID"))
    aimBag = getObjectFromGUID(Global.getVar("aimBagGUID"))
    dodgeBag = getObjectFromGUID(Global.getVar("dodgeBagGUID"))
    standbyBag = getObjectFromGUID(Global.getVar("standbyBagGUID"))
    ionBag = getObjectFromGUID(Global.getVar("ionBagGUID"))
    suppressionBag = getObjectFromGUID(Global.getVar("suppressionBagGUID"))
    unitInfo = Global.getTable("unitInfo")

    assetButton = getObjectFromGUID("406a41")



    assetButton.createButton({
            click_function = "removeSuppression", function_owner = self, label = "", position = {0, 0.65, 0}, scale = {1, 1, 0.7}, width = 1500, height = 2000, font_size = 400, color = {0.7573, 0.7573, 0.7573, 0.01}, font_color = {0, 0, 0, 100}, tooltip = "Remove one suppression token from each suppression stack in the Battlefield"
    })

end




function removeSuppression()
        assetButton.AssetBundle.playTriggerEffect(0)
    local allObjects = nil
    local allObjects = battlefieldZone.getObjects()

    a = 1


    if allObjects != nil then
        for i, obj in pairs(allObjects) do
            if obj.getName() == "Suppression Token" then

                if obj.getQuantity() > 0 then
                    local takenObj = obj.takeObject({
                        top = true
                    })
                    takenObj.setRotation({0,0,0})
                    takenObj.setPositionSmooth({suppressionBag.getPosition().x, suppressionBag.getPosition().y + a, suppressionBag.getPosition().z})
                else
                    obj.setRotation({0,0,0})
                    obj.setPositionSmooth({suppressionBag.getPosition().x, suppressionBag.getPosition().y + a, suppressionBag.getPosition().z})
                end
                a = a + 1.5
            end
        end
    end
end

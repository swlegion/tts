
-- TEMPLATE B
function onLoad(save_state)


    -- info


    if self.getName() != "Model Template B" then
        templateInfo = Global.getTable("templateInfo")
        

        aStart = templateInfo.aStart[unitInfo.baseSize][unitInfo.selectedSpeed]

        -- DEFAULT VALUES
        pickedUp = false
        templatePos = self.getPosition()
        --self.setName("Movement Template Speed "..unitInfo.selectedSpeed)

    end


    self.use_gravity = false
    self.drag = 1000
    self.angular_drag = 1000
    self.setVelocity({0,0,0})
    self.setAngularVelocity({0,0,0})

    --self.setName("Movement Template")

end

function onPickedUp(player_color)

    clickPlayerColor = player_color
    pickedUp = true


    startLuaCoroutine(self, "turnToCursor")

end

function onDropped(player_color)
    pickedUp = false
    positionTemplate()
    Global.setVar("highestPoint", 0)

end

function turnToCursor()
    aRot = templateA.getTable("templateRot")
    bRot = self.getRotation()
    baseRot2 = aRot.y - 180
    objPos = templateA.getTable("templatePos")
    templateRot = self.getRotation()




    while (pickedUp == true) do
        positionTemplate()
        coroutine.yield(0)
    end


    return 1
end

function positionTemplate()

        local mouseX = Player[clickPlayerColor].getPointerPosition().x
        local mouseZ = Player[clickPlayerColor].getPointerPosition().z
        local mouseY = Player[clickPlayerColor].getPointerPosition().y
        local lastY = templateRot.y




        local a = objPos.x-mouseX
        local b = objPos.z-mouseZ

        local q = math.deg(math.atan2(a, b))



        q = math.deg(math.atan2(a, b))



        self.setPosition({x = objPos.x, y = mouseY, z = objPos.z })
        templateA.setTable("templatePos", self.getPosition())
        templateA.setPosition({x = templateA.getPosition().x, y = self.getPosition().y, z = templateA.getPosition().z })

        --- convert baseRot to q same scale--
        if baseRot2 > 180 then
            baseRot2 = baseRot2 - 360
        end

        if baseRot2 > -90 and baseRot2 < 90 then
            if q < baseRot2 + 90 and q > baseRot2 - 90 then
                templateRot.y = q
                self.setRotation({0,templateRot.y,0})

            else
                self.setRotation({0,lastY,0})
            end

        elseif baseRot2 > 90 then
            if q > baseRot2 - 90 or q < baseRot2 - 270 then
                templateRot.y = q
                self.setRotation({0,templateRot.y,0})
            else
                self.setRotation({0,lastY,0})
            end
        elseif baseRot2 < -90 then
            if q < baseRot2 + 90 or q > baseRot2 + 270 then
                templateRot.y = q
                self.setRotation({0,templateRot.y,0})
            else
                self.setRotation({0,lastY,0})
            end
        end


        self.setVelocity({0,0,0})
        self.setAngularVelocity({0,0,0})
end

function onCollisionStay(collision_info)
    if templateA.getTable("templatePos") != nil then
        self.setPosition(templateA.getTable("templatePos"))

        --self.setRotation(templateA.getTable("templateBRot"))
    end
    self.setRotation({x = 0,y = self.getRotation().y,z = 0})
    stopObject()
end

function stopObject()
    self.use_gravity = false
    self.drag = 1000
    self.angular_drag = 1000
    self.setVelocity({0,0,0})
    self.setAngularVelocity({0,0,0})
end

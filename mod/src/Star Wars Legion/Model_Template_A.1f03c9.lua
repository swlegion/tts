
-- TEMPLATE A
function onLoad(save_state)

    -- info
    if self.getName() != "Model Template A" then
        templateInfo = Global.getTable("templateInfo")

        aStart = templateInfo.aStart[unitInfo.baseSize][unitInfo.selectedSpeed]


        --self.setName("Movement Template Speed "..unitInfo.selectedSpeed)

        -- DEFAULT VALUES
        pickedUp = false
        stopObject()

        enterPos = self.getPosition()


        --setHigh = true
        templatePos = self.getPosition()
        templateRot = self.getRotation()

        templateBRot = {x = 0,y = templateRot.y+180,z=0}
    end

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

    -- math
    originalARotation = self.getRotation().y
    originalBRotation = templateB.getRotation().y
    rotationDifference = originalBRotation - originalARotation


    while (pickedUp == true) do
        positionTemplate()
        -- yield coroutine
        coroutine.yield(0)

    end

    return 1
end

function positionTemplate()

        local mouseX = Player[clickPlayerColor].getPointerPosition().x
        local mouseZ = Player[clickPlayerColor].getPointerPosition().z
        local mouseY = Player[clickPlayerColor].getPointerPosition().y

        -- math
        local a = basePos.x-mouseX
        local b = basePos.z-mouseZ

        local q = math.deg(math.atan2(a, b))
        -- set rotation and rotation
        self.setRotation({x = 0, y = q+180, z = 0})
        templateRot = self.getRotation()

        local a2 = aStart*math.cos(math.atan2(b, a))
        local b2 = aStart*math.sin(math.atan2(b, a))

        templatePos = {x = basePos.x-a2, y = mouseY, z = basePos.z-b2}
        templateBRot = {x = 0,y = templateRot.y+rotationDifference,z=0}

        self.setPosition(templatePos)

        templateB.setPosition(self.getPosition())
        templateB.setRotation(templateBRot)

        -- stop velocity
        self.setVelocity({0,0,0})
        self.setAngularVelocity({0,0,0})
        templateB.setVelocity({0,0,0})
        templateB.setAngularVelocity({0,0,0})
end

function onCollisionEnter(collision_info)
    -- collision_info table:
    --   collision_object    Object
    --   contact_points      Table     {Vector, ...}
    --   relative_velocity   Vector
    self.setPosition(templatePos)
    self.setRotation(templateRot)
    stopObject()
end

function onCollisionStay(collision_info)
    if templatePos != nil then
        self.setPosition(templatePos)
        self.setRotation({0,templateRot.y,0})
    end
    stopObject()
end

function stopObject()
    self.use_gravity = false
    self.drag = 1000
    self.angular_drag = 1000
    self.setVelocity({0,0,0})
    self.setAngularVelocity({0,0,0})
end

function onLoad(save_state)
    updateStack()
end

function onObjectLeaveContainer(container, leave_object)
    if container == self then
        updateStack()
    end
end

function updateStack()
    local tokenObjs = self.getObjects()
    if #tokenObjs == 0 then
        self.setColorTint({65/255,88/255,114/255})
        self.setScale({1,1,1})
    else
        self.setScale({1,#tokenObjs,1})
        self.setColorTint({1,1,1})
    end
end

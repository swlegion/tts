-- REAL
function onLoad(save_state)
    self.interactable = false
    self.setLock(true)
end

function onDestroy()
    newTable = self.clone({
        position     = self.getPosition(),
        snap_to_grid = false,
    })

    newTable.setPosition(self.getPosition())
end

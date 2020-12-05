function onLoad(save_state)
    checkState()
end

function prevState()
    self.setState(stateNumber - 1)
    checkState()
end

function nextState()
    self.setState(stateNumber + 1)
    checkState()
end

function checkState()
    self.clearButtons()
    stateNumber = self.getStateId()

    if stateNumber > 1 then
        local data = {click_function = "prevState", function_owner = self, label = "<", position = {-0.95, 0.1, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 500, font_size = 400, color = {0.1498, 0.1498, 0.1498, 1}, font_color = {1, 1, 1, 1}}

        self.createButton(data)
    end

    if stateNumber < 6 then
        local data = {click_function = "nextState", function_owner = self, label = ">", position = {0.95, 0.1, 0}, scale = {0.5, 0.5, 0.5}, width = 400, height = 500, font_size = 400, color = {0.1498, 0.1498, 0.1498, 1}, font_color = {1, 1, 1, 1}}

        self.createButton(data)
    end
end











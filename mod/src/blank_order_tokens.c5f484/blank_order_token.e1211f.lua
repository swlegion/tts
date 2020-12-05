--[[ Blank Order Token --]]
local operative_marker_token_bag_GUID = "125746"
local unit_info_table = Global.getTable("unitInfo")
local unit_card_info_table = Global.getTable("cardInfo")
local list_builder_table = Global.getTable("listBuilder")
local command_token_data_table = Global.getTable("commandTokenData")
local held_by_color = nil

function onLoad()
    self.setDescription(
        "Select this token, the existing order token and all the minis of the unit before clicking a button."
    )

    held_by_color = self.held_by_color

    Wait.condition(
        function()
            if held_by_color == "Blue" then
                -- Flip the token to the blue side.
                self.setRotation({180, 0, 0})
            end
            create_buttons()
        end,
        function()
            return self.resting
        end
    )
end

--[[ Create buttons on each side of the token --]]
function create_buttons()
    -- Red Side Buttons
    self.createButton(
        {
            click_function = "assign_unit_to_this_token",
            function_owner = self,
            label = "Assign",
            position = {0, 0.05, -0.3},
            width = 500,
            height = 100
        }
    )

    self.createButton(
        {
            click_function = "promote_new_commander",
            function_owner = self,
            label = "Promote",
            position = {0, 0.05, 0},
            width = 500,
            height = 100
        }
    )

    self.createButton(
        {
            click_function = "assign_covert_ops",
            function_owner = self,
            label = "Covert Ops",
            position = {0, 0.05, 0.3},
            width = 500,
            height = 100
        }
    )

    -- Blue Side Buttons
    self.createButton(
        {
            click_function = "assign_unit_to_this_token",
            function_owner = self,
            label = "Assign",
            position = {0, -0.05, 0.3},
            rotation = {180, 0, 0},
            width = 500,
            height = 100
        }
    )

    self.createButton(
        {
            click_function = "promote_new_commander",
            function_owner = self,
            label = "Promote",
            position = {0, -0.05, 0},
            rotation = {180, 0, 0},
            width = 500,
            height = 100
        }
    )

    self.createButton(
        {
            click_function = "assign_covert_ops",
            function_owner = self,
            label = "Covert Ops",
            position = {0, -0.05, -0.3},
            rotation = {180, 0, 0},
            width = 500,
            height = 100
        }
    )
end

--[[ Determine the unit and set up the required Order Token --]]
function assign_unit_to_this_token(token, color, alt_click)
    if not is_player_permitted(color) then
        broadcastToColor("Only the Blue or Red Player can do this.", color, {r = 1, g = 0, b = 0})
        return
    end

    local objects = Player[color].getSelectedObjects()

    for _, object in ipairs(objects) do
        if object.getGUID() ~= self.getGUID() then
            if object.getVar("unitName") and object.getTable("miniGUIDs") then
                local unit_name = object.getVar("unitName")
                local unit_command_type = unit_info_table[unit_name].commandType
                local unit_token_name = unit_card_info_table.unitCards[unit_name].tokenName

                update_token(unit_name, unit_command_type, unit_token_name, color)
            end
        end
    end
end

--[[  Changes a unit's rank to "Commander" and spawns the "Commander" token--]]
function promote_new_commander(token, color, alt_click)
    local unit_leader_mini = promote_unit("Commander", color)

    if unit_leader_mini then
        spawn_commander_token(unit_leader_mini)
    end
end

--[[  Changes a unit's rank to "Operative" and spawns the "Operative Marker" token--]]
function assign_covert_ops(token, color, alt_click)
    local unit_leader_mini = promote_unit("Operative", color)

    if unit_leader_mini then
        spawn_operative_marker_token(unit_leader_mini)
    end
end

--[[ Determine the unit, promote to Rank, replace the Order Token --]]
function promote_unit(rank, color)
    if not is_player_permitted(color) then
        broadcastToColor("Only the Blue or Red Player can do this.", color, {r = 1, g = 0, b = 0})
        return
    end

    local unit_name = ""
    local unit_command_type = ""
    local new_unit_command_type = ""
    local unit_token_name = ""
    local order_token_to_delete = nil
    local unit_leader_mini = nil

    local objects = Player[color].getSelectedObjects()

    for _, object in ipairs(objects) do
        if object.getGUID() ~= self.getGUID() then
            -- If Order Token
            if object.getVar("unitName") and object.getVar("commandType") then
                order_token_to_delete = object
            end

            -- If Unit Leader Mini
            if object.getVar("unitName") and object.getTable("miniGUIDs") then
                -- Set up the new Order Token.
                unit_name = object.getVar("unitName")
                unit_command_type = unit_info_table[unit_name].commandType
                new_unit_command_type = unit_command_type:match("^%l+") .. rank
                unit_token_name =
                    new_unit_command_type:match("^%l+"):gsub("^%l", string.upper) .. " " .. rank .. " Command Token"
                unit_leader_mini = object
            end
        end
    end

    if unit_leader_mini then
        update_token(unit_name, new_unit_command_type, unit_token_name, color)

        if order_token_to_delete then
            destroyObject(order_token_to_delete)
        end
    else
        broadcastToColor("Could not determine unit leader mini.", color, {r = 1, g = 0, b = 0})
    end

    return unit_leader_mini
end

--[[ Turns this token into the required Order Token --]]
function update_token(unit_name, unit_command_type, unit_token_name, color)
    -- Set Custom Object properties.
    self.setCustomObject(
        {
            mesh = command_token_data_table.mesh,
            collider = command_token_data_table.collider,
            diffuse = command_token_data_table[color:lower()][unit_command_type],
            type = 0,
            material = 3
        }
    )

    -- Rotate the Blue token
    if color == "Blue" then
        self.setRotation({0, 0, 0})
    end

    -- Set object properties
    self.setName(color .. " " .. unit_token_name)
    self.setDescription("")

    -- Set the objects script.
    local luaScript =
        "unitName = '" ..
        unit_name ..
            "'\ncommandType = '" ..
                unit_command_type .. "'\ncolorSide = '" .. color:lower() .. "'\n" .. list_builder_table.tokenScript

    self.setLuaScript(luaScript)
    self.reload()
end

--[[ Grab a "Commander" token and place it next to the specified object --]]
function spawn_commander_token(object)
    base_position = object.getPosition()
    base_rotation = object.getRotation()

    local q = math.rad(base_rotation.y + 50)
    local a = 1 * math.cos(q)
    local b = 1 * math.sin(q)

    command_token_bag = getObjectFromGUID("6e5671")
    command_token_bag.takeObject(
        {
            position = {base_position.x + b, base_position.y + 1, base_position.z + a},
            rotation = {0, base_rotation.y, 0}
        }
    )
end

--[[ Grab a "Operative Marker" token and place it on the object --]]
function spawn_operative_marker_token(unit_leader_mini)
    unit_card = getObjectFromGUID(unit_leader_mini.getVar("cardGUID"))
    base_position = unit_card.getPosition()
    base_rotation = unit_card.getRotation()

    local q = math.rad(base_rotation.y + 50)
    local a = 1 * math.cos(q)
    local b = 1 * math.sin(q)

    -- Token needs to be rotated and flipped depending on color.
    if unit_leader_mini.getVar("colorSide") == "red" then
        base_rotation.y = 0
        base_rotation.z = 180
    elseif unit_leader_mini.getVar("colorSide") == "blue" then
        base_rotation.z = 0
    end

    command_token_bag = getObjectFromGUID(operative_marker_token_bag_GUID)
    command_token_bag.takeObject(
        {
            position = {base_position.x + b, base_position.y + 1, base_position.z + a},
            rotation = {0, base_rotation.y, base_rotation.z}
        }
    )
end

--[[ Return true if the Player color is permitted. --]]
function is_player_permitted(color)
    if color == "Blue" or color == "Red" then
        return true
    else
        return false
    end
end



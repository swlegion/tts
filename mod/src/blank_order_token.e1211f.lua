--[[ Blank Order Token --]]
local unit_info_table = Global.getTable("unitInfo")
local unit_card_info_table = Global.getTable("cardInfo")
local list_builder_table = Global.getTable("listBuilder")
local command_token_data_table = Global.getTable("commandTokenData")

function onLoad()
    create_buttons()
end

function create_buttons()
    self.createButton(
        {
            click_function = "assign_unit_to_this_token",
            function_owner = self,
            label = "Assign",
            position = {0, 0.05, -0.2},
            width = 500,
            height = 100
        }
    )

    self.createButton(
        {
            click_function = "promote_new_commander",
            function_owner = self,
            label = "Promote",
            position = {0, 0.05, 0.2},
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

    if #objects ~= 2 then
        broadcastToColor(
            "You must select this token AND the unit leader mini.\n (Use Ctrl+Left Click to select objects)",
            color,
            {r = 1, g = 0, b = 0}
        )
        return
    end

    for _, object in ipairs(objects) do
        if object.getGUID() ~= self.getGUID() then
            if object.getVar("unitName") and not object.getVar("commandType") then
                local unit_name = object.getVar("unitName")
                local unit_command_type = unit_info_table[unit_name].commandType
                local unit_token_name = unit_card_info_table.unitCards[unit_name].tokenName

                update_token(unit_name, unit_command_type, unit_token_name, color)
            end
        end
    end
end

--[[ Determine the unit, promote to Commander Rank and replace the Order Token --]]
function promote_new_commander(token, color, alt_click)
    if not is_player_permitted(color) then
        broadcastToColor("Only the Blue or Red Player can do this.", color, {r = 1, g = 0, b = 0})
        return
    end

    local objects = Player[color].getSelectedObjects()

    if #objects ~= 3 then
        broadcastToColor(
            "You must select this token AND the unit leader mini AND the units existing Order Token.\n(Use Ctrl+Left Click to select objects)",
            color,
            {r = 1, g = 0, b = 0}
        )
        return
    end

    for _, object in ipairs(objects) do
        if object.getGUID() ~= self.getGUID() then
            if object.getVar("unitName") then
                -- If this is the existing Order Token then destroy it.
                if object.getVar("commandType") then
                    destroyObject(object)
                else
                    -- Set up the new Order Token.
                    local unit_name = object.getVar("unitName")
                    local unit_command_type = unit_info_table[unit_name].commandType
                    local new_unit_command_type = unit_command_type:match("^%l+") .. "Commander"
                    local unit_token_name =
                        new_unit_command_type:match("^%l+"):gsub("^%l", string.upper) ..
                        " Commander Command Token (Promoted)" -- unit_card_info_table.unitCards[unit_name].tokenName

                    update_token(unit_name, new_unit_command_type, unit_token_name, color)
                    spawn_commander_token(object)
                end
            end
        end
    end
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

--[[ Grab a Commander Token from the bag and place it next to the specified object --]]
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

--[[ Return true if the Player color is permitted. --]]
function is_player_permitted(color)
    if color == "Blue" or color == "Red" then
        return true
    else
        return false
    end
end

--[[ Blank Order Token --]]
local operative_marker_token_bag_GUID = "125746"
local list_builder_table = Global.getTable("listBuilder")
local command_token_data_table = Global.getTable("commandTokenData")
local held_by_color = nil

function onload()
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
    local assignTooltip = "Create a new order token with the same rank as the selected unit leader"
    local promoteTooltip = "Create a new Commander order token and change the selected unit leader's rank to Commander"
    local covertOpsTooltip = "Create a new Operative order token and change the selected unit leader's rank to Operative"

    -- Red Side Buttons
    self.createButton(
        {
            click_function = "assign_unit_to_this_token",
            function_owner = self,
            label = "Assign",
            tooltip = assignTooltip,
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
            tooltip = promoteTooltip,
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
            tooltip = covertOpsTooltip,
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
            tooltip = assignTooltip,
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
            tooltip = promoteTooltip,
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
            tooltip = covertOpsTooltip,
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
        update_token(
          object.getVar("commandType"),
          object.getVar("commandName"),
          color,
          object.getVar("baseSize"),
          object.getVar("selectedSpeed")
        )
        break
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

    local unit_command_type = ""
    local new_unit_command_type = ""
    local unit_token_name = ""
    local order_token_to_delete = nil
    local unit_leader_mini = nil
    local baseSize
    local selectedSpeed

    local objects = Player[color].getSelectedObjects()

    for _, object in ipairs(objects) do
        if object.getGUID() ~= self.getGUID() then
            -- If Order Token
            if object.getVar("unitName") and object.getVar("isAToken") then
                order_token_to_delete = object
            end

            -- If Unit Leader Mini
            if object.getVar("unitName") and object.getTable("miniGUIDs") then
                -- Set up the new Order Token.
                unit_command_type = object.getVar("commandType")
                baseSize = object.getVar("baseSize")
                selectedSpeed = object.getVar("selectedSpeed")
                new_unit_command_type = unit_command_type:match("^%l+") .. rank
                unit_token_name = object.getVar("commandName")
                unit_leader_mini = object

                -- Change the unit's rank
                local unitData = object.getTable("unitData")
                unitData.commandType = new_unit_command_type
                object.setTable("unitData", unitData)
            end
        end
    end

    if unit_leader_mini then
      update_token(
        new_unit_command_type,
        unit_token_name,
        color,
        baseSize,
        selectedSpeed
      )

      if order_token_to_delete then
        destroyObject(order_token_to_delete)
      end
    else
      broadcastToColor("Could not determine unit leader mini.", color, {r = 1, g = 0, b = 0})
    end

    return unit_leader_mini
end

--[[ Turns this token into the required Order Token --]]
function update_token(
  unit_command_type,
  unit_token_name,
  color,
  baseSize,
  selectedSpeed
)
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
    self.setName(unit_token_name)
    self.setDescription("")

    -- Set the objects script.
    local luaScript = string.format(
      "unitData = {" ..
      "  baseSize      = [[%s]],\n" ..
      "  colorSide     = [[%s]],\n" ..
      "  commandType   = [[%s]],\n" ..
      "  fixedArc      = %s,\n" ..
      "  fixedMove     = %s,\n" ..
      "  selectedSpeed = %s,\n" ..
      "  strafeMove    = %s,\n" ..
      "}\n\n",
      baseSize,
      color:lower(),
      unit_command_type,
      tostring(baseSize ~= "small"),
      tostring(baseSize ~= "small"),
      tostring(selectedSpeed),
      tostring(baseSize ~= "small")
    )
    self.setLuaScript(luaScript .. list_builder_table.tokenScript)
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






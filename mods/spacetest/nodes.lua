minetest.register_node("spacetest:wall", {
    description = "Wall",
    tiles = {"wall.png"},
    groups = {cracky = 3, gravity = 1, gravblock = 1},
    sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:grating", {
    description = "Grating",
    drawtype = "allfaces",
    tiles = {"grating.png"},
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel",
    sunlight_propagates = true,
    groups = {cracky = 3, gravity = 1},
    sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:grating_wired", {
    description = "Grating Wired",
    drawtype = "allfaces",
    tiles = {"grating_wired.png"},
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel",
    sunlight_propagates = true,
    groups = {cracky = 3, gravity = 1, not_in_creative_inventory = 1},
    sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:floor", {
    description = "Gravity Floor",
    tiles = {"floor.png", "wall.png"},
    groups = {cracky = 3, gravity = 3, gravblock = 1},
    sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:glass", {
    description = "Glass",
    drawtype = "glasslike_framed_optional",
    tiles = {"glass.png"},
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel",
    sunlight_propagates = true,
    is_ground_content = false,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
})

minetest.register_node("spacetest:light", {
    description = "Light",
    drawtype = "mesh",
    tiles = {{
        name = "light.png",
    }},
    mesh = "light.obj",
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    walkable = false,
    liquids_pointable = false,
    light_source = 12,
    groups = {choppy=2, flammable=1, attached_node=1, torch=1},
    selection_box = {
        type = "wallmounted",
        wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
    },
    on_rotate = false
})

minetest.register_node("spacetest:solar_panel", {
  description = "Solar Panel",
  drawtype = "normal",
  tiles = {
    "solar_panel.png",
    "grating.png",
    "grating.png",
    "grating.png",
    "wall_power_connector.png",
    "wall_power_connector.png"
  },
  groups = {cracky = 3, gravity = 1, powery = 1},
  connect_sides = {"front", "back"},
  paramtype2 = "facedir",
  sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:vent", {
  description = "Vent",
  tiles = {
    "wall_vent_connector.png",
    "vent.png",
    "wall.png",
    "wall.png",
    "wall.png",
    "wall.png",
  },
  groups = {cracky = 3, gravity = 1, venty = 1},
  sounds = spacetest.node_sound_defaults(),
  connect_sides = {"top"},
  on_rightclick = function(pos, node, player, pointed_thing)
    local spec = table.concat({
      "size[6,3]",
      "real_coordinates[true]",
      "button[1.5,2;3,0.8;activate;Activate]",
    }, "")
    minetest.show_formspec(player:get_player_name(), "vent_form", spec)
  end,
})

minetest.register_node("spacetest:battery", {
  description = "Battery",
  tiles = {
    "wall.png",
    "wall.png",
    "battery.png",
    "battery.png",
    "wall_power_connector.png",
    "battery.png",
  },
  paramtype2 = "facedir",
  groups = {cracky = 3, gravity = 1, powery = 1},
  sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:airlock_over", {
    description = "Airlock Over",
    drawtype = "mesh",
    tiles = {{
        name = "door.png",
    }},
    mesh = "airlock.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, gravity = 1, not_in_creative_inventory = 1},
    sounds = spacetest.node_sound_defaults(),
    on_rightclick = function(pos, node, clicker)
      local p = {x=pos.x, y=pos.y-1, z=pos.z}
      local n = minetest.get_node(p)
      local ref = minetest.registered_nodes[n.name]
      ref.on_rightclick(p, n, clicker)
    end
})

minetest.register_node("spacetest:airlock_base", {
    description = "Airlock Base",
    drawtype = "mesh",
    tiles = {{
        name = "door.png",
    }},
    mesh = "airlock.obj",
    groups = {cracky = 3, gravity = 1, not_in_creative_inventory = 1},
    paramtype2 = "facedir",
    sounds = spacetest.node_sound_defaults(),
    on_rightclick = function(pos, node, clicker)
      local over_pos = {x=pos.x, y=pos.y+1, z=pos.z}
      local facing = node.param2
      minetest.swap_node(pos, {name = "spacetest:airlock_open_base"})
      minetest.swap_node(over_pos, {name = "spacetest:airlock_open_over"})
      minetest.after(3, function()
        minetest.swap_node(pos, {
          name = "spacetest:airlock_base",
          param2 = facing})
        minetest.swap_node(over_pos, {
          name = "spacetest:airlock_over",
          param2 = facing})
      end)
    end,
})

minetest.register_node("spacetest:airlock_open_base", {
    description = "Airlock Open base",
    drawtype = "airlike",
    groups = {not_in_creative_inventory = 1, cracky = 1},
    sounds = spacetest.node_sound_defaults(),
    sunlight_propagates = true,
    walkable = false,
})

minetest.register_node("spacetest:airlock_open_over", {
    description = "Airlock Open Over",
    drawtype = "airlike",
    groups = {not_in_creative_inventory = 1, cracky = 1},
    sounds = spacetest.node_sound_defaults(),
    sunlight_propagates = true,
    walkable = false,
})

minetest.register_node("spacetest:terminal", {
  description = "Terminal",
  drawtype = "mesh",
  mesh = "terminal.obj",
  tiles = {{
    name = "computer.png"
  }},
  groups = {cracky = 3},
  paramtype2 = "facedir",
  sunlight_propagates = true,
  light_source = 3,
})

minetest.register_node("spacetest:wall_controller", {
  description = "Controller",
  tiles = {
    "wall.png", "wall.png",
    "wall.png", "wall.png",
    "wall_power_connector.png",
    "wall_controller.png"
  },
  paramtype2 = "facedir",
  connect_sides = {"back"},
  groups = {cracky = 3, gravity = 1, powery = 1},
})

minetest.register_node("spacetest:wall_power_connector", {
  description = "Power Connector Wall",
  tiles = {
    "wall_power_connector.png",
    "wall_power_connector.png",
    "wall_power_connector.png",
    "wall_power_connector.png",
    "wall_power_connector.png",
    "wall_power_connector.png"
  },
  paramtype2 = "facedir",
  groups = {cracky = 3, gravity = 1, powery = 1},
})

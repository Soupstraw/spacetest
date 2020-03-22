minetest.register_node("spacetest:wall", {
    description = "Wall",
    tiles = {"wall.png"},
    groups = {cracky = 3, gravity = 1, gravblock = 1},
    sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:grating", {
    description = "Grating",
    drawtype = "glasslike_framed_optional",
    tiles = {"grating.png"},
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel",
    sunlight_propagates = true,
    groups = {cracky = 3, gravity = 1},
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
    inventory_image = "light.png",
    wield_image = "light.png",
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
    tiles = {"solar_panel.png", "grating.png"},
    groups = {cracky = 3, gravity = 1, gravblock = 1},
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
    groups = {cracky = 3, gravity = 1},
    sounds = spacetest.node_sound_defaults(),
})

minetest.register_node("spacetest:battery", {
    description = "Battery",
    tiles = {
      "wall.png",
      "wall.png",
      "battery.png",
      "battery.png",
      "battery.png",
      "battery.png",
    },
    groups = {cracky = 3, gravity = 1},
    sounds = spacetest.node_sound_defaults(),
})

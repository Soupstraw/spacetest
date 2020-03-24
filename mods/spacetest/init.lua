
spacetest = {}

function spacetest.node_sound_defaults()
    table = table or {}
    table.footstep = table.footstep or
            {name = "", gain = 1.0}
    table.dug = table.dug or
            {name = "default_dug_node", gain = 0.25}
    table.place = table.place or
            {name = "default_place_node_hard", gain = 1.0}
    return table
end

minetest.register_on_joinplayer(function(player)
    player:set_sky(nil, "skybox", {
      "space.png",
      "space.png",
      "space.png",
      "space.png",
      "space.png",
      "space.png",
    }, false)
end)

minetest.register_globalstep(function(dtime)
    for _,player in ipairs(minetest.get_connected_players()) do
        -- Gravity is always on in creative
        if creative.is_enabled_for(player) then
          player:set_physics_override({
              speed = 1,
              gravity = 1,
          })
          goto continue
        end

        local pos = player:get_pos()
        local rc = minetest.raycast(pos, vector.add(pos, vector.new(0, -10, 0)), false, false):next()
        if rc == nil then
            player:set_physics_override({
                speed = 0,
                gravity = 0,
            })
        else
            local node_pos = rc.under
            local node = minetest.registered_nodes[minetest.get_node(node_pos).name]
            local grav = node.groups.gravity
            if grav >= vector.distance(node_pos, pos) then
                player:set_physics_override({
                    speed = grav/3,
                    gravity = 1,
                })
            else
                player:set_physics_override({
                    speed = 0,
                    gravity = 0,
                })
            end
        end
        ::continue::
    end
    -- Set time to midnight
    minetest.set_timeofday(0.0)
end)

local spacetest_path = minetest.get_modpath("spacetest")

dofile(spacetest_path.."/nodes.lua")
dofile(spacetest_path.."/items.lua")
dofile(spacetest_path.."/pipes.lua")

atmos = {}

atmos.flood = function(pos, idx, steps)
  local node = minetest.get_node(pos)
  local meta = minetest.get_meta(pos)
  if node.name ~= "air" or meta:get_int("air_zone") ~= 0 or steps <= 0 then
    return
  end
  meta:set_int("air_zone", idx)
  atmos.flood({x=pos.x-1, y=pos.y, z=pos.z}, idx, steps-1)
  atmos.flood({x=pos.x+1, y=pos.y, z=pos.z}, idx, steps-1)
  atmos.flood({x=pos.x, y=pos.y-1, z=pos.z}, idx, steps-1)
  atmos.flood({x=pos.x, y=pos.y+1, z=pos.z}, idx, steps-1)
  atmos.flood({x=pos.x, y=pos.y, z=pos.z-1}, idx, steps-1)
  atmos.flood({x=pos.x, y=pos.y, z=pos.z+1}, idx, steps-1)
end

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
  after_place_node = function(pos, placer)
    local meta = minetest.get_meta(pos)
    meta:set_string(
      "formspec",
      "size[6,3]"..
      "real_coordinates[true]"..
      "button[1.5,2;3,0.8;activate;Activate]")
  end,
  on_receive_fields = function(pos, formname, fields, player)
    if fields.activate then
      atmos.flood({x=pos.x, y=pos.y-1, z=pos.z}, 1, 22)
    end
  end
})

minetest.register_craftitem("spacetest:atmos_anal", {
  description = "Atmospheric Analyzer",
  inventory_image = "atmos_anal.png",
  on_place = function(itemstack, placer, pointed_thing)
    local pos = vector.round(placer:get_pos())
    local name = placer:get_player_name()
    minetest.chat_send_player(name, dump(pos))
    minetest.chat_send_player(name, "Air zone: "..dump(minetest.get_meta(pos):get_int("air_zone")))
    return itemstack
  end,
})


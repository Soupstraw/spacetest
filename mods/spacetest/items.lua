minetest.register_craftitem("spacetest:airlock", {
    description = "Airlock",
    inventory_image = "airlock.png",
    on_place = function(itemstack, placer, pointed_thing)
      if not pointed_thing.type == "node" then
        return itemstack
      end

      local pos_base = pointed_thing.above
      local pos_over = {
        x = pos_base.x,
        y = pos_base.y + 1,
        z = pos_base.z }
      local base_def = minetest.registered_nodes[minetest.get_node(pos_base).name]
      local over_def = minetest.registered_nodes[minetest.get_node(pos_over).name]
      if base_def.buildable_to and
         over_def.buildable_to then
        minetest.set_node(pos_base, 
          {name = "spacetest:airlock_base",
           param2 = minetest.dir_to_facedir(placer:get_look_dir())})
        minetest.set_node(pos_over, {
           name = "spacetest:airlock_over",
           param2 = minetest.dir_to_facedir(placer:get_look_dir())})
      end
    end
})

minetest.register_craftitem("spacetest:wire", {
  description = "Wire",
  inventory_image = "wire.png",
  on_place = function(itemstack, placer, pointed_thing)
    if not pointed_thing.type == "node" then
      return itemstack
    end
    
    local node = minetest.get_node(pointed_thing.under)
    if node.name == "spacetest:grating" then
      minetest.swap_node(pointed_thing.under, {name = "spacetest:grating_wired"})
      itemstack:take_item(1)
    end
    return itemstack
  end,
})


minetest.register_craftitem("spacetest:wirecutter", {
  description = "Wire Cutter",
  inventory_image = "wirecutters.png",
  on_place = function(itemstack, placer, pointed_thing)
    if not pointed_thing.type == "node" then
      return itemstack
    end
    
    local node = minetest.get_node(pointed_thing.under)
    if node.name == "spacetest:grating_wired" then
      minetest.swap_node(pointed_thing.under, {name = "spacetest:grating"})
    end
  end,
})

minetest.register_craftitem("spacetest:airlock", {
    description = "airlock",
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

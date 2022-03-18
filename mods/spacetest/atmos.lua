local chunksize = 16
local atmos = {}
local chunks_per_update = 16
local update_interval = 2.0
local last_update = 0
local data_buffer = {}
local param_buffer = {}

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

minetest.register_globalstep(function(dtime)
  last_update = last_update + dtime
  if last_update >= update_interval then
    last_update = 0
    for chunk_s,_ in pairs(atmos) do
      local chunkpos = deserialize_vec(chunk_s)
      print(dump(chunkpos))
      local pmin = vector.new(
        chunkpos.x * chunksize - 1, 
        chunkpos.y * chunksize - 1, 
        chunkpos.z * chunksize - 1
      )
      local pmax = vector.new(
        chunkpos.x * chunksize + chunksize,
        chunkpos.y * chunksize + chunksize,
        chunkpos.z * chunksize + chunksize
      )
      local vmanip = minetest.get_voxel_manip()
      local qmin,qmax = vmanip:read_from_map(pmin, pmax)
      print("qmin: ", dump(qmin))
      print("qmax: ", dump(qmax))
      vmanip:get_data(data_buffer)
      local varea = VoxelArea:new{
        MinEdge = qmin,
        MaxEdge = qmax
      }
      for z,y,x in varea:iterp(pmin, pmax) do

      end
      vmanip:write_to_map(false)
    end
  end
end)

function split (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function serialize_vec(vec)
  return vec.x.." "..vec.y.." "..vec.z
end

function deserialize_vec(vec_s)
  local comps = split(vec_s)
  return vector.new(
    tonumber(comps[1]),
    tonumber(comps[2]),
    tonumber(comps[3])
  )
end

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
  local chunkpos = vector.new(
    math.floor(pos.x / chunksize),
    math.floor(pos.y / chunksize),
    math.floor(pos.z / chunksize)
  )
  atmos[serialize_vec(chunkpos)] = true
end)

function mk_airgen_formspec(meta)
  return [[
    formspec_version[4]
    size[16,6]
    position[0.5,0.5]
    label[0.375,0.5;Air generator]
    label[0.5,2;Current pressure: ]
    label[0.625,2.75;]]..
    meta:get_float("target_pressure")..[[ kPa]
    field[0.5,4.0;10.0,1.0;target_pressure;Target Pressure (kPa):;]]..
    meta:get_float("target_pressure").."]"
end

minetest.register_node("spacetest:airgen", {
  description = "Air emitter",
  tiles = {
    "wall_vent_connector.png",
    "airgen.png",
    "airgen.png",
    "airgen.png",
    "airgen.png",
    "airgen.png"
  },
  groups = {cracky = 3, gravity = 1, venty = 1},
  connect_sides = {"top"},
  after_place_node = function(pos, placer)
    local meta = minetest.get_meta(pos)
    meta:set_float("target_pressure", 0)
    meta:set_string("formspec", mk_airgen_formspec(meta))
  end,
  on_receive_fields = function(pos, formname, fields, player)
    local meta = minetest.get_meta(pos)
    print(dump(fields))
    if fields.target_pressure then
      meta:set_float("target_pressure", fields.target_pressure)
    end
    meta:set_string("formspec", mk_airgen_formspec(meta))
  end
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
  after_place_node = function(pos, placer)
    local meta = minetest.get_meta(pos)
    meta:set_string(
      "formspec",
      "size[6,3]"..
      "real_coordinates[true]"..
      "button[1.5,2;3,0.8;activate;Activate]")
  end,
  on_receive_fields = function(pos, formname, fields, player)
  end
})

minetest.register_craftitem("spacetest:atmos_anal", {
  description = "Atmospheric Analyzer",
  inventory_image = "atmos_anal.png",
  on_place = function(itemstack, placer, pointed_thing)
  end,
})


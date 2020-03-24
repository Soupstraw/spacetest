pipes = {}

function permgen (a, n)
  if n == 0 then
    printResult(a)
  else
    for i=1,n do
      -- put i-th element as the last one
      a[n], a[i] = a[i], a[n]
      -- generate all permutations of the other elements
      permgen(a, n - 1)
      -- restore i-th element
      a[n], a[i] = a[i], a[n]
    end
  end
end

function pipes.register_pipe(name, def)
  local r = def.radius
  def.drawtype = "nodebox"
  def.node_box = {
    type = "connected",
    fixed          = {-r  , -r  , -r  , r  , r  , r  },
    connect_right  = {0   , -r  , -r  , 0.5, r  , r  },
    connect_top    = {-r  , 0   , -r  , r  , 0.5, r  },
    connect_back   = {-r  , -r  , 0   , r  , r  , 0.5},
    connect_left   = {-0.5, -r  , -r  , 0  , r  , r  },
    connect_bottom = {-r  , -0.5, -r  , r  , 0  , r  },
    connect_front  = {-r  , -r  , -0.5, r  , r  , 0  },
  }
  minetest.register_node(name, def)
end

pipes.register_pipe("spacetest:power_tube", {
  description = "Power Tube",
  tiles = {"pipe_power.png"},
  groups = {cracky = 3, powery = 1},
  connects_to = {"group:powery"},
  paramtype = "light",
  paramtype2 = "glasslikeliquidlevel",
  sunlight_propagates = true,
  radius = 0.05,
})

pipes.register_pipe("spacetest:vent_tube", {
  description = "Vent",
  tiles = {"pipe_vent.png"},
  groups = {cracky = 3, venty = 1},
  connects_to = {"group:venty"},
  paramtype = "light",
  paramtype2 = "glasslikeliquidlevel",
  sunlight_propagates = true,
  radius = 0.2,
})


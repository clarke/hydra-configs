-- placer.lua v2014.07.08
-- clarke@carfoo.com

-- Resolutions:
--
-- iMac 27"
-- 2560 x 1440
--
-- MBA 13"
-- 1440 x 900
--
-- MBA 11"
-- 1366 x 768

ext.placer       = {}
ext.placer.specs = {}

ext.placer.totalwidth  = 0
ext.placer.totalheight = 0

ext.placer.devices = {
  {
    name = "imac27",
    w    = 2560,
    h    = 1440
  },
  {
    name = "mba13",
    w    = 1440,
    h    = 900
  },
  {
    name = "mba11",
    w    = 1366,
    h    = 768
  }
}
ext.placer.device_name = ""

function ext.placer.setresolution()
  s = screen.mainscreen()
  d = s:frame_without_dock_or_menu()

  ext.placer.totalwidth  = d.w
  ext.placer.totalheight = d.h

  for i=1, #ext.placer.devices do
    if d.w == ext.placer.devices[i].w then
      ext.placer.device_name = ext.placer.devices[i].name
    end
  end
end
-- Set the resolution at load time
ext.placer.setresolution()

-- Place the focused window in a specific location and at a specific size
function ext.placer.setfocusedwindow(topleft, size)
  local win = window.focusedwindow()

  ext.placer.placewindow(win, topleft, size)
end

-- Helper to place a window in a specific location and at a specific size
function ext.placer.placewindow(win, topleft, size)
  win:settopleft(topleft)
  win:setsize(size)
end

-- Helper to place a window with an offset from a pre-defined spec
function ext.placer.placewithoffset(name, spec, offset)
  -- Make a deep copy so we don't modify the original spec
  local tl = {}
  local s  = {}

  for k,v in pairs(spec.topleft) do tl[k] = v end

  for k,v in pairs(spec.size) do s[k] = v end

  if offset.x then
    tl.x = tl.x + offset.x
  end

  if offset.y then
    tl.y = tl.y + offset.y
  end

  if offset.h then
    s.h = s.h + offset.h

    if spec.topleft.y + spec.size.h + offset.h > ext.placer.totalheight then
      tl.y = spec.topleft.y - offset.h
    elseif spec.topleft.y + spec.size.h - offset.h < ext.placer.totalheight then
      s.h = spec.size.h + offset.h
    end
  end

  if offset.w then
    s.w = s.w + offset.w
    if tl.x + s.w + offset.w > ext.placer.totalwidth then
      tl.x = tl.x - offset.w
    end
  end

  ext.placer.placeapplicationwindows(name, {topleft = tl, size = s})
end

-- Places a named application in certain specs (location)
function ext.placer.placeapplicationwindows(name, specs)
  ext.placer.placeapplicationwindowswithexclusion(name, nil, specs)
end

-- Places a named application in certain specs (location), but allows
-- for a named window to be excluded
function ext.placer.placeapplicationwindowswithexclusion(name, exclusion, specs)
  app = ext.appfinder.app_from_name(name)
  if app then
    local allwindows = app:allwindows()
    local placed = #specs
    for i=1, #allwindows do
      local win = allwindows[i]

      if exclusion == nil or win:title() ~= exclusion then
        -- If specs is an array, loop through them one at a time,
        -- otherwise just use the single one that was passed in.
        -- If specs is an array and we are looping and run out
        -- of elements, just use the last one over and over
        -- until we're done.
        --
        -- NOTE: Windows are processed in reverse order of how
        -- they were opened.
        if placed > 0 then
          local s = specs[placed]
          ext.placer.placewindow(win, s.topleft, s.size)

          if placed > 1 then
            placed = placed - 1
          end
        else
          ext.placer.placewindow(win, specs.topleft, specs.size)
        end
      end
    end
  end
end

-- Places the window on the left half of the screen
ext.placer.specs.left_half = {
  topleft = {x=0, y=0},
  size    = {w=(.5*ext.placer.totalwidth), h=ext.placer.totalheight}
}
function ext.placer.left_half()
  ext.placer.setfocusedwindow(
    ext.placer.specs.left_half.topleft,
    ext.placer.specs.left_half.size
  )
end

-- Places the window on the right half of the screen
ext.placer.specs.right_half = {
  topleft = {x=(.5*ext.placer.totalwidth), y=0},
  size    = {w=(.5*ext.placer.totalwidth), h=ext.placer.totalheight}
}
function ext.placer.right_half()
  ext.placer.setfocusedwindow(
    ext.placer.specs.right_half.topleft,
    ext.placer.specs.right_half.size
  )
end

-- Places the window on top half of the screen
ext.placer.specs.top_half = {
  topleft = {x=0, y=0},
  size    = {w=ext.placer.totalwidth, h=(.5*ext.placer.totalheight)}
}
function ext.placer.top_half()
  ext.placer.setfocusedwindow(
    ext.placer.specs.top_half.topleft,
    ext.placer.specs.top_half.size
  )
end

-- Places the window on bottom half of the screen
ext.placer.specs.bottom_half = {
  topleft = {x=0, y=(.5*ext.placer.totalheight)},
  size    = {w=ext.placer.totalwidth, h=(.5*ext.placer.totalheight)}
}
function ext.placer.bottom_half()
  ext.placer.setfocusedwindow(
    ext.placer.specs.bottom_half.topleft,
    ext.placer.specs.bottom_half.size
  )
end

-- Places the window on top left quarter of the screen
ext.placer.specs.top_left_quarter = {
  topleft = {x=0, y=0},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.top_left_quarter()
  ext.placer.setfocusedwindow(
    ext.placer.specs.top_left_quarter.topleft,
    ext.placer.specs.top_left_quarter.size
  )
end

-- Places the window on bottom left quarter of the screen
ext.placer.specs.bottom_left_quarter = {
  topleft = {x=0, y=(.5*ext.placer.totalheight)},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.bottom_left_quarter()
  ext.placer.setfocusedwindow(
    ext.placer.specs.bottom_left_quarter.topleft,
    ext.placer.specs.bottom_left_quarter.size
  )
end

-- Places the window on top right quarter of the screen
ext.placer.specs.top_right_quarter = {
  topleft = {x=(.5*ext.placer.totalwidth), y=0},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.top_right_quarter()
  ext.placer.setfocusedwindow(
    ext.placer.specs.top_right_quarter.topleft,
    ext.placer.specs.top_right_quarter.size
  )
end

-- Places the window on bottom right quarter of the screen
ext.placer.specs.bottom_right_quarter = {
  topleft = {x=(.5*ext.placer.totalwidth), y=(.5*ext.placer.totalheight)},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.bottom_right_quarter()
  ext.placer.setfocusedwindow(
    ext.placer.specs.bottom_right_quarter.topleft,
    ext.placer.specs.bottom_right_quarter.size
  )
end

-- Places the window on top center of the screen
ext.placer.specs.top_center = {
  topleft = {x=(.25*ext.placer.totalwidth), y=0},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.top_center()
  ext.placer.setfocusedwindow(
    ext.placer.specs.top_center.topleft,
    ext.placer.specs.top_center.size
  )
end

-- Places the window on bottom center of the screen
ext.placer.specs.bottom_center = {
  topleft = {x=(.25*ext.placer.totalwidth), y=(.5*ext.placer.totalheight)},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.bottom_center()
  ext.placer.setfocusedwindow(
    ext.placer.specs.bottom_center.topleft,
    ext.placer.specs.bottom_center.size
  )
end

-- Places the window on the full screen
ext.placer.specs.full_screen = {
  topleft = {x=0, y=0},
  size    = {w=ext.placer.totalwidth, h=ext.placer.totalheight}
}
function ext.placer.full_screen()
  ext.placer.setfocusedwindow(
    ext.placer.specs.full_screen.topleft,
    ext.placer.specs.full_screen.size
  )
end

-- Places the window centered on the screen
ext.placer.specs.centered = {
  topleft = {x=(.25*ext.placer.totalwidth), y=(.15*ext.placer.totalheight)},
  size    = {w=(.5*ext.placer.totalwidth), h=(.7*ext.placer.totalheight)}
}
function ext.placer.centered()
  ext.placer.setfocusedwindow(
    ext.placer.specs.centered.topleft,
    ext.placer.specs.centered.size
  )
end

-- Places the window centered on the screen and makes it small
ext.placer.specs.centered_small = {
  topleft = {x=(.25*ext.placer.totalwidth), y=(.25*ext.placer.totalheight)},
  size    = {w=(.5*ext.placer.totalwidth), h=(.5*ext.placer.totalheight)}
}
function ext.placer.centered_small()
  ext.placer.setfocusedwindow(
    ext.placer.specs.centered_small.topleft,
    ext.placer.specs.centered_small.size
  )
end

-- Places the window centered on the screen and makes it tall
ext.placer.specs.centered_tall = {
  topleft = {x=(.15*ext.placer.totalwidth), y=0},
  size    = {w=(.7*ext.placer.totalwidth), h=ext.placer.totalheight}
}
function ext.placer.centered_tall()
  ext.placer.setfocusedwindow(
    ext.placer.specs.centered_tall.topleft,
    ext.placer.specs.centered_tall.size
  )
end

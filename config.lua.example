ext.config = {}

-- Application Configuration
--
-- This is where you can configure the behavior of individual applications.
-- Options:
--   title: The title of the application window (required)
--   hidden: If set to true, the application will be set to hidden (default: false)
--   autostart: If set to true, the application will be started when
--              launchdefaultapplications is run (default: false)
--   locations: Where on the screen to place the application windows (required)
--              The keys are selected based on the screen resolution. If no
--              resolutions are matched, or if no other resolutions are specified,
--              the default setting is used.
--
--              Currently understood resolutions:
--                  imac27
--                  mba13
--                  mba11
--
--              This is a table with topleft and size tables.
--              Example:
--                  {
--                    topleft = {x=0, y=0},
--                    size    = {w=50, h=100}
--                  }
--
--              topleft: the location of the top left corner of the window
--                  x: x coordinate
--                  y: y coordinate
--              size: the size in pixels of the window
--                  w: width
--                  h: height
--
--              locations can also be an array of tables, in which case the
--              dimensions will be applied in the order that the windows were
--              opened.


ext.config.applications = {
  {
    title     = "Mail",
    hidden    = true,
    autostart = true,
    locations = {
      default = ext.placer.specs.centered,
      mba11 = ext.placer.specs.full_screen,
      mba13 = ext.placer.specs.full_screen
    }
  },
  {
    title     = "iTerm",
    hidden    = false,
    autostart = true,
    locations = {
      default = {
        ext.placer.specs.left_half,
        ext.placer.specs.right_half
      },
      mba11   = ext.placer.specs.full_screen,
      mba13   = ext.placer.specs.full_screen
    }
  },
  {
    title     = "Google Chrome",
    hidden    = false,
    autostart = false,
    locations = {
      default = ext.placer.specs.centered_tall,
      mba11   = ext.placer.specs.full_screen,
      mba13   = ext.placer.specs.full_screen
    }
  }
}

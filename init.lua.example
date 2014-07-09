require "placer"
require "appfinder"
require "config"

hydra.alert "Hydra, at your service."

autolaunch.set(true)

menu.show(function()
    return {
      {title = "About Hydra", fn = hydra.showabout},
      {title = "-"},
      {title = "Quit", fn = os.exit},
    }
end)

local mash    = {"cmd", "alt", "ctrl"}
local ctrlcmd = {"ctrl", "cmd"}

defaultapplications = ext.config.applications

-- Position windows on a single screen
local function positionwindows()
  hydra.alert("Positioning Windows", 0.75)

  if defaultapplications == nil then
    hydra.alert("No applications configured")
    return
  end

  for i=1, #defaultapplications do
    a = defaultapplications[i]

    -- Check for any device-specific locations
    loc = a.locations[ext.placer.device_name]

    if loc == nil then
      loc = a.locations.default
    end

    if a.exclusion then
      ext.placer.placeapplicationwindowswithexclusion(a.title, a.exclusion, loc)
    else
      ext.placer.placeapplicationwindows(a.title, loc)
    end

    if a.hidden then
      app = ext.appfinder.app_from_name(a.title)
      if app then
        app:hide()
      end
    end
  end
end
hotkey.bind(ctrlcmd, '1', positionwindows)

local function launchdefaultapplications()
  for i=1, #defaultapplications do
    a = defaultapplications[i]

    if a.autostart then
      application.launchorfocus(defaultapplications[i].title)
    end
  end

  positionwindows()
end
hotkey.bind(mash, '1', launchdefaultapplications)

hotkey.bind(mash, 'X', logger.show)
hotkey.bind(mash, "R", repl.open)

hotkey.bind(ctrlcmd, "L", ext.placer.right_half)
hotkey.bind(ctrlcmd, "H", ext.placer.left_half)
hotkey.bind(ctrlcmd, "K", ext.placer.top_half)
hotkey.bind(ctrlcmd, "J", ext.placer.bottom_half)
hotkey.bind(ctrlcmd, "O", ext.placer.full_screen)
hotkey.bind(ctrlcmd, "G", ext.placer.centered)
hotkey.bind(ctrlcmd, "Y", ext.placer.centered_small)
hotkey.bind(ctrlcmd, "P", ext.placer.centered_tall)

hotkey.bind(ctrlcmd, "U", ext.placer.top_left_quarter)
hotkey.bind(ctrlcmd, "N", ext.placer.bottom_left_quarter)
hotkey.bind(ctrlcmd, "I", ext.placer.top_right_quarter)
hotkey.bind(ctrlcmd, "M", ext.placer.bottom_right_quarter)

updates.check()

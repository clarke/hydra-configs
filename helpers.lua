-- ext.helpers v2014.07.09
--
-- This is a set of helper functions

ext.helpers = {}

local defaultapplications = ext.config.applications

-- This function positions windows based on the configuration in config.lua
function ext.helpers.positionwindows()
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

-- This function launches the applications in config.lua which have
-- autostart=true and places them in the configured position.
function ext.helpers.launchdefaultapplications()
  for i=1, #defaultapplications do
    a = defaultapplications[i]

    if a.autostart then
      application.launchorfocus(defaultapplications[i].title)
    end
  end

  ext.helpers.positionwindows()
end

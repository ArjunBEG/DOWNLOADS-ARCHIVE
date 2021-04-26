--
-- Fix Slack's channel switching.
-- This rebinds ctrl-tab and ctrl-shift-tab back to switching channels,
-- which is what they did before the Teams update.
--
-- Slack only provides alt+up/down for switching channels, (and the cmd-t switcher,
-- which is buggy) and have 3 (!) shortcuts for switching teams, most of which are
-- the usual tab switching shortcuts in every other app.
--
local ctrlTab = hotkey.new({"ctrl"}, "tab", function()
  hs.eventtap.keyStroke({"alt"}, "Down")
end)
local ctrlShiftTab = hotkey.new({"ctrl", "shift"}, "tab", function()
  hs.eventtap.keyStroke({"alt"}, "Up")
end)
slackWatcher = hs.application.watcher.new(function(name, eventType, app)
  if eventType ~= hs.application.watcher.activated then return end
  if name == "Slack" then
    ctrlTab:enable()
    ctrlShiftTab:enable()
  else
    ctrlTab:disable()
    ctrlShiftTab:disable()
  end
end)

-- If you re-init config often, be sure to stop() this before starting or you will
-- have multiple application watchers running at once.
slackWatcher.start()
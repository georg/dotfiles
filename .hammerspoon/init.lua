require "clipboard"

local grid = require "hs.grid"

local mash = {"cmd", "alt", "ctrl"}
local mashShift = {"shift", "alt", "ctrl"}

hs.window.animationDuration = 0

hs.hotkey.bind(mash, "C", function()
  hs.window.focusedWindow():moveToUnit({x=0.125, y=0.125, w=0.75, h=0.75})
end)

hs.hotkey.bind(mash, 'M', grid.maximizeWindow)
hs.hotkey.bind(mash, 'Left', function()
  hs.window.focusedWindow():moveToUnit(hs.layout.left50)
end)
hs.hotkey.bind(mash, 'Right', function()
  hs.window.focusedWindow():moveToUnit(hs.layout.right50)
end)
hs.hotkey.bind(mash, 'Up', function()
  hs.window.focusedWindow():moveToUnit({x=0, y=0, w=1, h=0.5})
end)
hs.hotkey.bind(mash, 'Down', function()
  hs.window.focusedWindow():moveToUnit({x=0, y=0.5, w=1, h=0.5})
end)
hs.hotkey.bind(mashShift, 'Left', function()
  hs.window.focusedWindow():moveOneScreenEast()
end)
hs.hotkey.bind(mashShift, 'Right', function()
  hs.window.focusedWindow():moveOneScreenWest()
end)
hs.hotkey.bind(mash, 'S', function()
  local snapshot = hs.window.focusedWindow():snapshot()
end)
hs.hotkey.bind(mash, 'L', function()
  hs.caffeinate.lockScreen()
end)

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:updateRepo('default')

local mash = {"cmd", "alt", "ctrl"}
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = {mash, "up"},
  right = {mash, "right"},
  down = {mash, "down"},
  left = {mash, "left"},
  fullscreen = {mash, "c"},
})

spoon.SpoonInstall:andUse('TextClipboardHistory', {
  config = {
    paste_on_select = true,
  },
  hotkeys = {
    show_clipboard = {mash, "v"},
  },
  start = true,
})

hs.hotkey.bind(mash, 'L', function()
  hs.caffeinate.lockScreen()
end)

spoon.SpoonInstall:andUse('URLDispatcher', {
  config = {
    url_patterns = {
      { "https?://.*.google.com", "com.google.Chrome" },
      { "https?://.*.slack.com", "com.slack.Slack" },
    },
    default_handler = "com.apple.Safari",
  },
  start = true,
})


hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:updateRepo('default')

hs.window.animationDuration = 0
local mash = {"cmd", "alt", "ctrl"}
spoon.SpoonInstall:andUse('MiroWindowsManager', {
  hotkeys = {
    up = {mash, "up"},
    right = {mash, "right"},
    down = {mash, "down"},
    left = {mash, "left"},
    fullscreen = {mash, "c"},
  },
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
    default_handler = "org.mozilla.Firefox",
  },
  start = true,
})


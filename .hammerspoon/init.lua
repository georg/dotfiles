hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:updateRepo("default")

local mash = { "cmd", "alt", "ctrl" }
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
	up = { mash, "up" },
	right = { mash, "right" },
	down = { mash, "down" },
	left = { mash, "left" },
	fullscreen = { mash, "c" },
})

hs.hotkey.bind(mash, "S", function()
	hs.window.focusedWindow():setSize(1024, 768)
end)

hs.hotkey.bind(mash, "L", function()
	hs.caffeinate.lockScreen()
end)

hs.hotkey.bind(mash, "G", function()
	hs.application.launchOrFocus("Ghostty")
end)

hs.hotkey.bind(mash, "O", function()
	local win = hs.window.focusedWindow()
	if win then
		win:moveToScreen(win:screen():next())
	end
end)

hs.hotkey.bind(mash, "M", function()
	local win = hs.window.focusedWindow()
	if not win then return end
	local screenFrame = win:screen():frame()

	local windowSizes = {1, 4/3, 2}
	local height = screenFrame.h / 3
	local frame = win:frame()

	local function approxEqual(a, b)
		return math.abs(a - b) < 2
	end

	local nextSize = windowSizes[1]
	for i = 1, #windowSizes do
		local expectedW = screenFrame.w / windowSizes[i]
		local expectedX = screenFrame.x + (screenFrame.w - expectedW) / 2
		if approxEqual(frame.x, expectedX) and
		   approxEqual(frame.w, expectedW) and
		   approxEqual(frame.y, screenFrame.y) then
			nextSize = windowSizes[(i % #windowSizes) + 1]
			break
		end
	end

	local newW = screenFrame.w / nextSize
	frame.w = newW
	frame.x = screenFrame.x + (screenFrame.w - newW) / 2
	frame.y = screenFrame.y
	frame.h = height

	win:setFrameInScreenBounds(frame)
end)

-- Paste external IP address
hs.hotkey.bind(mash, "I", function()
	local handle = io.popen("dig +short myip.opendns.com @resolver1.opendns.com")
	local result = handle:read("*a"):gsub("^%s*(.-)%s*$", "%1")
	handle:close()
	hs.pasteboard.setContents(result)
	hs.eventtap.keyStroke({"cmd"}, "v")
end)

local function moveAppToDeskPad(appName, ratio)
	local app = hs.application.find(appName)
	if app then
		local win = app:mainWindow()
		if win then
			local screens = hs.screen.allScreens()
			if #screens > 1 then
				local screen = screens[2]
				win:moveToScreen(screen)
				if ratio == 1 then
					win:maximize()
				else
					win:setSize(screen:frame().w * ratio, screen:frame().h * ratio)
					win:centerOnScreen()
				end
			end
		end
	end
end

-- Start/Stop DeskPad
hs.hotkey.bind(mash, "D", function()
	local app = hs.application.find("DeskPad")
	if app then
		app:kill()
	else
		hs.application.launchOrFocus("DeskPad")
		hs.timer.waitUntil(
			function()
				return #hs.screen.allScreens() > 1
			end,
			function()
				moveAppToDeskPad("Safari", 1)
				moveAppToDeskPad("Ghostty", 0.75)
				moveAppToDeskPad("Code", 1)
			end
		)
	end
end)

spoon.SpoonInstall:andUse("URLDispatcher", {
	config = {
		url_patterns = {
			{ "https?://.*.google.com", "com.google.Chrome" },
			{ "https?://.*.slack.com", "com.slack.Slack" },
		},
		default_handler = "com.apple.Safari",
	},
	start = true,
})

-- spoon.SpoonInstall:andUse('Cherry')

-- Function to calculate the number of working days (Monday to Friday) until a specific date
local function workingDaysUntil(targetYear, targetMonth, targetDay)
	local now = os.time()
	local targetDate = os.time({ year = targetYear, month = targetMonth, day = targetDay })
	local daysLeft = 0

	-- Iterate over each day until the target date
	while now <= targetDate do
		local dayOfWeek = os.date("*t", now).wday
		-- Check if it's a weekday (Monday to Friday)
		if dayOfWeek >= 2 and dayOfWeek <= 6 then
			daysLeft = daysLeft + 1
		end
		-- Move to the next day
		now = now + 24 * 60 * 60
	end

	return daysLeft
end

-- Function to update the status bar
local function updateStatusBar()
	local days = workingDaysUntil(2024, 10, 9)
	local message = "🚀" .. days
	statusBar:setTitle(message)
end

-- Create a status bar item
-- statusBar = hs.menubar.new()

-- Set an initial value
-- updateStatusBar()

-- Update the status bar every minute
-- hs.timer.doEvery(60, updateStatusBar)

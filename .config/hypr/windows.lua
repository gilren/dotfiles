local vars = require("vars")

-- =====================
-- Match groups
-- =====================
local im = [[^([Dd]iscord|[Ww]ebCord|[Vv]esktop|chrome-discord\.com.*)$]]
local games = [[^(steam_app_\d+)$]]
local gamestore = [[^([Ss]team)$]]
local video = [[^([Mm]pv|vlc)$]]
local settings = [[^(gnome-disks|xdg-desktop-portal-gtk|nvidia-settings)$]]
local floatapps = [[(com.powers.Wiremix|org.gnome.NautilusPreviewer|com.gabm.satty|About|TUI.float)]]

-- =====================
-- Layer rules
-- =====================
hl.layer_rule({ match = { namespace = "(selection|walker)" }, no_anim = true })

-- =====================
-- General window rules
-- =====================
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

-- =====================
-- Tags
-- =====================
hl.window_rule({ match = { class = im }, tag = "+im" })
hl.window_rule({ match = { class = games }, tag = "+games" })
hl.window_rule({ match = { class = gamestore }, tag = "+gamestore" })
hl.window_rule({ match = { class = video }, tag = "+multimedia_video" })
hl.window_rule({ match = { class = settings }, tag = "+settings" })
hl.window_rule({ match = { title = "^(ROG Control)$" }, tag = "+settings" })

-- =====================
-- Tag overrides
-- =====================
hl.window_rule({ match = { tag = "multimedia_video*" }, no_blur = true, opacity = "1.0" })
hl.window_rule({ match = { tag = "games*" }, no_blur = true, fullscreen = true })

-- =====================
-- App tweaks
-- =====================
hl.window_rule({ match = { title = "^(SpeedCrunch)$" }, max_size = { 950, 560 } })
hl.window_rule({ match = { class = "^(love)$" }, move = "onscreen 100%-w-10" })
hl.window_rule({ match = { class = "^(kitty|Code)$" }, opacity = "0.75" })

-- =====================
-- Workspaces
-- =====================
hl.workspace_rule({ workspace = "1", monitor = vars.m1, persistent = true, default = true })
hl.workspace_rule({ workspace = "2", monitor = vars.m1, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = vars.m1 })
hl.workspace_rule({ workspace = "4", monitor = vars.m1 })

hl.workspace_rule({ workspace = "5", monitor = vars.m2, persistent = true, default = true })
hl.workspace_rule({ workspace = "6", monitor = vars.m2, persistent = true })

hl.workspace_rule({ workspace = "7", monitor = vars.m3, persistent = true, default = true })
hl.workspace_rule({ workspace = "8", monitor = vars.m3, persistent = true })
hl.workspace_rule({ workspace = "9", monitor = vars.m3 })

-- =====================
-- Workspace assignment
-- =====================
hl.workspace_rule({ workspace = "9", layout_opts = { orientation = "top" } })

-- =====================
-- Workspace assignment
-- =====================
hl.window_rule({ match = { class = "^(Code)$" }, workspace = "1" })
hl.window_rule({ match = { tag = "gamestore*" }, workspace = "3" })
hl.window_rule({ match = { tag = "games*" }, workspace = "4" })
hl.window_rule({ match = { tag = "multimedia_video*" }, workspace = "6" })
hl.window_rule({ match = { tag = "im*" }, workspace = "7 silent" })
hl.window_rule({ match = { class = "^([Ss]potify)$" }, workspace = "8 silent" })

-- =====================
-- Floating windows
-- =====================
hl.window_rule({ match = { tag = "settings*" }, float = true, center = true })
hl.window_rule({ match = { title = "Steam Settings*" }, float = true, center = true, size = { 1300, 780 } })
hl.window_rule({ match = { title = "^(Picture-in-Picture|SpeedCrunch)$" }, float = true })
-- Float Firefox DevTools windows (initialTitle is empty at creation, unlike normal tabs).
hl.window_rule({ match = { class = "firefox", title = "^$" }, float = true, size = { 1300, 780 } })

hl.window_rule({
	match = { title = "^(Add Folder to Workspace|Save As)$" },
	float = true,
	center = true,
	size = { "(monitor_w*0.7)", "((monitor_h-30)*0.6)" },
})
hl.window_rule({
	match = { initial_title = "(Open Files)" },
	float = true,
	size = { "(monitor_w*0.7)", "((monitor_h-30)*0.6)" },
})
hl.window_rule({ match = { tag = "floating-window" }, float = true, center = true, size = { 875, 600 } })

hl.window_rule({ match = { class = floatapps }, tag = "+floating-window" })

local diffnav_windows = {}

hl.on("window.title", function(w)
	local id = w.address

	if w.class == "kitty" and w.title == "git diff" then
		if not w.floating then
			diffnav_windows[id] = true

			hl.dispatch(hl.dsp.window.float({
				action = "enable",
				window = w,
			}))
			hl.dispatch(hl.dsp.window.resize({
				x = 2048,
				y = 1152,
				window = w,
			}))
			hl.dispatch(hl.dsp.window.center({
				window = w,
			}))
		end

		return
	end

	if diffnav_windows[id] and w.class == "kitty" then
		diffnav_windows[id] = nil

		hl.dispatch(hl.dsp.window.float({
			action = "disable",
		}))
	end
end)

-- =====================
-- Sizes
-- =====================
hl.window_rule({ match = { tag = "settings*" }, size = { "(monitor_w*0.7)", "((monitor_h-30)*0.7)" } })

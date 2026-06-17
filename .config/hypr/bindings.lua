local vars = require("vars")

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more.
hl.bind("SUPER + return", hl.dsp.exec_cmd(vars.terminal))

hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("restart-app waybar"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("speedcrunch"), { description = "Calculator" })

-- hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy]]))

-- =====================
-- Clipboard
-- =====================
hl.bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }), { description = "Universal copy" })
hl.bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }), { description = "Universal paste" })
hl.bind("SUPER + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }), { description = "Universal cut" })
hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd("launch-walker -m clipboard"), { description = "Clipboard manager" })

-- =====================
-- Media
-- =====================
-- Laptop multimedia keys for volume and LCD brightness (with OSD).
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(vars.osdclient .. " --output-volume raise"), { locked = true, repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(vars.osdclient .. " --output-volume lower"), { locked = true, repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(vars.osdclient .. " --output-volume mute-toggle"), { locked = true, repeating = true, description = "Mute" })

-- Precise 1% multimedia adjustments with Alt modifier.
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(vars.osdclient .. " --output-volume +1"), { locked = true, repeating = true, description = "Volume up precise" })
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd(vars.osdclient .. " --output-volume -1"), { locked = true, repeating = true, description = "Volume down precise" })

-- Requires playerctl.
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(vars.osdclient .. " --playerctl next"), { locked = true, description = "Next track" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(vars.osdclient .. " --playerctl play-pause"), { locked = true, description = "Pause" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(vars.osdclient .. " --playerctl play-pause"), { locked = true, description = "Play" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(vars.osdclient .. " --playerctl previous"), { locked = true, description = "Previous track" })

-- =====================
-- Tiling
-- =====================
-- Close windows
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprland-window-close-all"), { description = "Close all windows" })

-- Control tiling
hl.bind("SUPER + backslash", hl.dsp.layout("orientationcycle top left"), { description = "Change workspace orientation" })

hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle window floating/tiling" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Full screen" })
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }), { description = "Tiled full screen" })
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Full width" })
hl.bind("SUPER + O", hl.dsp.exec_cmd("hyprland-window-pop"), { description = "Pop window out (float & pin)" })

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }), { description = "Move window focus left" })
hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }), { description = "Move window focus right" })
hl.bind("SUPER + j", hl.dsp.focus({ direction = "u" }), { description = "Move window focus up" })
hl.bind("SUPER + k", hl.dsp.focus({ direction = "d" }), { description = "Move window focus down" })

hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }), { description = "Move window focus left" })
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }), { description = "Move window focus right" })
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }), { description = "Move window focus up" })
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }), { description = "Move window focus down" })

-- Switch workspaces with SUPER + [1-9]
hl.bind("SUPER + code:10", hl.dsp.focus({ workspace = 1 }), { description = "Switch to workspace 1" })
hl.bind("SUPER + code:11", hl.dsp.focus({ workspace = 2 }), { description = "Switch to workspace 2" })
hl.bind("SUPER + code:12", hl.dsp.focus({ workspace = 3 }), { description = "Switch to workspace 3" })
hl.bind("SUPER + code:13", hl.dsp.focus({ workspace = 4 }), { description = "Switch to workspace 4" })
hl.bind("SUPER + code:14", hl.dsp.focus({ workspace = 5 }), { description = "Switch to workspace 5" })
hl.bind("SUPER + code:15", hl.dsp.focus({ workspace = 6 }), { description = "Switch to workspace 6" })
hl.bind("SUPER + code:16", hl.dsp.focus({ workspace = 7 }), { description = "Switch to workspace 7" })
hl.bind("SUPER + code:17", hl.dsp.focus({ workspace = 8 }), { description = "Switch to workspace 8" })
hl.bind("SUPER + code:18", hl.dsp.focus({ workspace = 9 }), { description = "Switch to workspace 9" })
hl.bind("SUPER + code:19", hl.dsp.focus({ workspace = 10 }), { description = "Switch to workspace 10" })

-- Move active window to a workspace with SUPER + SHIFT + [1-9]
hl.bind("SUPER + SHIFT + code:10", hl.dsp.window.move({ workspace = 1 }), { description = "Move window to workspace 1" })
hl.bind("SUPER + SHIFT + code:11", hl.dsp.window.move({ workspace = 2 }), { description = "Move window to workspace 2" })
hl.bind("SUPER + SHIFT + code:12", hl.dsp.window.move({ workspace = 3 }), { description = "Move window to workspace 3" })
hl.bind("SUPER + SHIFT + code:13", hl.dsp.window.move({ workspace = 4 }), { description = "Move window to workspace 4" })
hl.bind("SUPER + SHIFT + code:14", hl.dsp.window.move({ workspace = 5 }), { description = "Move window to workspace 5" })
hl.bind("SUPER + SHIFT + code:15", hl.dsp.window.move({ workspace = 6 }), { description = "Move window to workspace 6" })
hl.bind("SUPER + SHIFT + code:16", hl.dsp.window.move({ workspace = 7 }), { description = "Move window to workspace 7" })
hl.bind("SUPER + SHIFT + code:17", hl.dsp.window.move({ workspace = 8 }), { description = "Move window to workspace 8" })
hl.bind("SUPER + SHIFT + code:18", hl.dsp.window.move({ workspace = 9 }), { description = "Move window to workspace 9" })
hl.bind("SUPER + SHIFT + code:19", hl.dsp.window.move({ workspace = 10 }), { description = "Move window to workspace 10" })

-- Swap active window with the one next to it with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.swap({ direction = "l" }), { description = "Swap window to the left" })
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }), { description = "Swap window to the right" })
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window up" })
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.swap({ direction = "d" }), { description = "Swap window down" })

-- Cycle through applications on active workspace
hl.bind("ALT + TAB", hl.dsp.window.cycle_next({}), { description = "Cycle to next window" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }), { description = "Cycle to prev window" })

-- Resize active window
hl.bind("SUPER + CTRL + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { description = "Expand window left" })
hl.bind("SUPER + CTRL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { description = "Shrink window left" })
hl.bind("SUPER + CTRL + j", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { description = "Shrink window up" })
hl.bind("SUPER + CTRL + k", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { description = "Expand window down" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- =====================
-- Utilities
-- =====================
-- Menus
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("launch-walker"), { description = "Launch apps" })
hl.bind("SUPER + CTRL + E", hl.dsp.exec_cmd("launch-walker -m symbols"), { description = "Emoji picker" })
hl.bind("SUPER + D", hl.dsp.exec_cmd(vars.terminal .. " -e lazydocker"), { description = "Lazy Docker" })

-- Aesthetics
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("theme-bg-next"), { description = "Next background in theme" })
hl.bind("SUPER + SHIFT + CTRL + SPACE", hl.dsp.exec_cmd("menu theme"), { description = "Theme menu" })

-- Captures
hl.bind("PRINT", hl.dsp.exec_cmd("cmd-screenshot smart clipboard"), { description = "Screenshot to clipboard" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("cmd-screenshot"), { description = "Screenshot with editing" })
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("menu screenrecord"), { description = "Screenrecording" })
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color picker" })

-- Other
hl.bind("SUPER + B", hl.dsp.exec_cmd("compile"), { description = "Compile C project" })

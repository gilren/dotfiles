-- Hyprland 0.55+ Lua draft conversion.
-- Inactive on purpose: this file lives under lua-preview/ instead of ~/.config/hypr/hyprland.lua.
-- Run explicitly with `Hyprland --config ~/.config/hypr/lua-preview/hyprland.lua` when testing.

require("vars")
require("monitors")
require("autostart")
require("envs")
require("looknfeel")
require("input")
require("bindings")
require("windows")

-- Keep this last to mirror `source = ~/.config/themes/current/theme/hyprland.conf`.
require("theme-current")

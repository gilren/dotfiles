local M = {}

M.terminal = "uwsm-app -- kitty"

M.m1 = "DP-1"
M.m2 = "DP-2"
M.m3 = "DP-4"

-- Only display the OSD on the currently focused monitor.
M.osdclient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]

return M

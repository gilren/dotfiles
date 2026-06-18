local vars = require("vars")

hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm-app -- hypridle")
	hl.exec_cmd("uwsm-app -- mako")
	hl.exec_cmd("uwsm-app -- waybar")
	hl.exec_cmd("uwsm-app -- swaybg -i ~/.config/themes/current/background -m fill")
	hl.exec_cmd("uwsm-app -- swayosd-server")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	-- hl.exec_cmd("cmd-first-run")
	hl.exec_cmd("uwsm-app -- elephant")
	hl.exec_cmd("uwsm-app -- walker --gapplication-service")

	-- Slow app launch fix -- set systemd vars.
	hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")

	hl.exec_cmd(vars.terminal, { workspace = "1 silent" })
	hl.exec_cmd("uwsm-app -- firefox")
	hl.exec_cmd("uwsm-app -- flatpak run com.spotify.Client")
	hl.exec_cmd("uwsm-app -- vesktop")
end)

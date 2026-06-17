local activeBorderColor = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }
local inactiveBorderColor = "rgba(595959aa)"

-- https://wiki.hyprland.org/Configuring/Variables/#general
hl.config({
  general = {
    -- No gaps between windows or borders.
    gaps_in = 3,
    gaps_out = 6,
    border_size = 1,

    col = {
      active_border = activeBorderColor,
      inactive_border = inactiveBorderColor,
    },

    resize_on_border = true,
    allow_tearing = false,

    -- Use master layout instead of dwindle.
    layout = "master",
  },

  -- https://wiki.hyprland.org/Configuring/Variables/#decoration
  decoration = {
    -- Use round window corners.
    -- rounding = 8,

    active_opacity = 1,
    inactive_opacity = 1,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      xray = true,
      special = true,
      vibrancy = 0.2696,
    },
  },

  animations = {
    enabled = false,
  },
})

hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "overshot" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "default", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "default", style = "slidefadevert 20%" })

-- https://wiki.hypr.land/Configuring/Dwindle-Layout/
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this.
  },

  master = {
    -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more.
    new_status = "slave",
  },

  -- https://wiki.hyprland.org/Configuring/Variables/#misc
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    focus_on_activate = true,
    anr_missed_pings = 3,
    on_focus_under_fullscreen = 1,
  },

  -- https://wiki.hypr.land/Configuring/Variables/#cursor
  cursor = {
    hide_on_key_press = true,
  },
})

local vars = require("vars")

-- See https://wiki.hyprland.org/Configuring/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors
-- Format: hl.monitor({ output = ..., mode = ..., position = ..., scale = ... })

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
-- hl.env("GDK_SCALE", "2")
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- Good compromise for 27" or 32" 4K monitors (but fractional!)
-- hl.env("GDK_SCALE", "1.75")
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.666667 })

-- Straight 1x setup for low-resolution displays like 1080p or 1440p.
hl.env("GDK_SCALE", "1")

hl.monitor({ output = vars.m1, mode = "2560x1440@165", position = "0x0", scale = 1 })
hl.monitor({ output = vars.m2, mode = "preferred", position = "-2560x0", scale = 1 })
hl.monitor({ output = vars.m3, mode = "preferred", position = "2560x-500", scale = 1, transform = 3 })

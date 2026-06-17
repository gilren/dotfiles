# My dotfiles

This is my collection of dotfiles for a customized Arch Linux desktop environment using Hyprland on Wayland.

I started with [Arch Linux](https://archlinux.org/) and got into ricing, I was running Arch for a couple of months but I wanted to try [Omarchy](https://github.com/basecamp/omarchy) for a bit.

Realised pretty quickly that I didn’t like a lot of the decisions, keybinds or pre-installed apps. Rather than fighting with it by tinkering with the provided config files, I decided to go back to Arch and take only what I liked from Omarchy:
- Config structure
- **[Unified clipboard](https://learn.omacom.io/2/the-omarchy-manual/105/universal-clipboard)**
- **[Capture](https://learn.omacom.io/2/the-omarchy-manual/53/hotkeys#capture)**
- **[Quick Emojis](https://learn.omacom.io/2/the-omarchy-manual/53/hotkeys#quick-emojis)**
- **[Themes & Theme switcher](https://learn.omacom.io/2/the-omarchy-manual/52/themes)**
- **[Elephant custom menus](https://github.com/abenz1267/elephant)**
- **[Walker](https://github.com/abenz1267/walker)**
- **[Nautilus](https://gitlab.gnome.org/GNOME/nautilus)**

The setup has configurations for:

- **[Hyprland](https://github.com/hyprwm/Hyprland)** (with Hyprlock, Hypridle) + **[Waybar](https://github.com/Alexays/Waybar)** + **[Mako](https://github.com/emersion/mako)** + **[SwayOSD](https://github.com/ErikReider/SwayOSD)**
- **[Neovim](https://github.com/neovim/neovim)**, **[VSCode](https://github.com/microsoft/vscode)** (theme)
- **[Kitty](https://github.com/kovidgoyal/kitty)**, **[Tmux](https://github.com/tmux/tmux)**
- **[UWSM](https://github.com/Vladimir-csp/uwsm)** — systemd Wayland session manager
- Theme templates for Bat, Delta, FZF, Hyprland, Hyprlock, Kitty, Mako, Walker,
  Waybar, btop, SwayOSD, SpeedCrunch, VSCode, Neovim, and Pi

## Theme System

Themes live under `.config/themes/available/<name>/`. Running `theme-set <name>`
renders `.config/themes/config/*.tpl`, swaps `.config/themes/current/theme/`,
updates symlinks for Bat/Delta/FZF/Pi, rebuilds Bat cache, changes wallpaper, and
reloads desktop components.

## Shell Plugins/Setup

- **[Zsh](https://github.com/zsh-users/zsh)** shell
  - **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**
  - **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**
- **[starship](https://github.com/starship/starship)** prompt

## CLI Tools

- **[Btop](https://github.com/aristocratos/btop)** system monitor
- **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** system info
- **[LazyDocker](https://github.com/jesseduffield/lazydocker)** Docker TUI
- **[Lazygit](https://github.com/jesseduffield/lazygit)** + **[Delta](https://github.com/dandavison/delta)** git TUI with side-by-side diffs
- **[Bat](https://github.com/sharkdp/bat)** syntax highlighting with current theme cache
- **[FZF](https://github.com/junegunn/fzf)** fuzzy finder
- **[Imv](https://github.com/eXeC64/imv)** image viewer
- **[Diffnav](https://github.com/AndrewRadev/diffnav)** vim-based diff navigation through Delta

## Custom Scripts

A collection of CLI tools in `.local/bin/`:

- **Screen tools** — `cmd-screenshot`, `cmd-screenrecord`, `cmd-present`
- **Theme switcher** — `theme-list`, `theme-set`, `theme-refresh`, `theme-bg-next`, etc. (renders dynamic `.tpl` configs)
- **Hyprland helpers** — `hyprland-window-close-all`, `hyprland-window-pop`,
  `lock-screen`, `launch-walker`, `restart-app`
- **Keyboard** — `keymap` (draws keyboard layouts), `qmk` (firmware flashing)
- **Launcher** — `menu`, `launch-webapp`, `refresh-applications`

## Agent Helpers

Local agent skills live in `.agents/skills/`; Pi-loadable symlinks live in
`.pi/agent/skills/`. Current local skills include debugging, TDD, triage, PRD / issue
creation, architecture review, teaching, and handoff helpers.

## Inspired by

- [Dillon Mulroy](https://github.com/dmmulroy/.dotfiles)
- [Josean Martinez](https://github.com/josean-dev/dev-environment-files)
- [Omarchy](https://github.com/basecamp/omarchy)


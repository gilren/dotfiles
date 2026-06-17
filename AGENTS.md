# AGENTS.md - Dotfiles Configuration Repository

This is a dotfiles repository containing system configuration files, shell scripts, and theming tools for a Hyprland-based Linux desktop environment. Hyprland config is modular Lua (Hyprland 0.55+ style) rather than legacy `.conf` includes.

## Repository Structure

- `.config/` - Application configurations (Hyprland Lua modules, Waybar, Neovim,
  Kitty, Tmux, Mako, Walker, btop, fastfetch, lazygit, lazydocker, fzf, delta,
  diffnav, bat, starship, git, imv, elephant, uwsm, nautilus, qmk, systemd,
  autostart, environment.d, mpv, etc.)
- `.config/themes/` - Theming system with template processing and theme switching
  (backgrounds, colors, icons, neovim, vscode, kitty, hyprland, hyprlock, mako,
  walker, swayosd, speedcrunch, Pi, etc.)
  See [Theme System](#theme-system) below for details.
- `.config/mimeapps.list` - Default application associations
- `.local/bin/` - User scripts (bash) and CLI tools (bash, python)
- `.pi/` - Pi coding agent configuration (sessions, skills, todos)
- `.agents/` - Agent skills (caveman, diagnose, handoff, tdd, etc.)

## Build/Lint/Test Commands

This is primarily a configuration repository with shell scripts. There is no formal build system.

## Theme System

### Overview

Every theme is a directory under `.config/themes/available/<name>/` containing:
- `colors.toml` — defines 16 ANSI colors + `accent`, `foreground`, `background`, etc.
- `backgrounds/` — wallpaper images
- `neovim.lua`, `vscode.json`, `icons.theme` — app-specific static configs
- `preview.png` — screenshot for theme switcher

Switching a theme runs `theme-set <name>` (`.local/bin/theme-set`):
1. Copy theme dir to `current/next-theme/`
2. Run `theme-set-templates` to process `.tpl` files → configs
3. Swap `next-theme` → `current/theme/`
4. Symlink generated configs for bat, delta, fzf, and Pi
5. Rebuild `bat cache --build`
6. Reload Hyprland, waybar, swayosd, kitty, mako, btop, opencode, speedcrunch, etc.

### Template Processing (`theme-set-templates`)

Located at `.local/bin/theme-set-templates`. Processes `.tpl` files in
`.config/themes/config/` using sed-based substitution against the theme's
`colors.toml`. Supports three template syntaxes:

| Syntax | Example | Resolution |
|--------|---------|------------|
| `{{ variable }}` | `{{ background }}` | Direct hex value from colors.toml, e.g. `#1e1e2e` |
| `{{ variable_rgb }}` | `{{ background_rgb }}` | RGB tuple, e.g. `30,30,46` |
| `{{ mix(fg, bg, weight) }}` | `{{ mix(color1, background, 10) }}` | Blends two hex colors at `weight`% (0 = all bg, 100 = all fg) |

**Important**: `mix()` is resolved at template-processing time by scanning
each `.tpl` for `{{ mix(...) }}` patterns, computing the blend via
`mix_colors()` in bash, and adding a sed substitution for each unique
mix expression found.

### Color Convention

The `colors.toml` follows a standard 16-color ANSI palette:
- `color0`-`color7` — standard terminal colors (black, red, green,
  yellow, blue, magenta, cyan, white)
- `color8`-`color15` — bright variants
- `accent` — primary highlight color (used for cursors, borders, hunk headers)
- `foreground`, `background` — base text and background
- `cursor`, `selection_foreground`, `selection_background` — selection colors

### Generated Configs (`.tpl` → rendered)

| Template | Output | Purpose |
|----------|--------|---------|
| `bat.tmTheme.tpl` | `bat.tmTheme` | Sublime syntax theme for bat (synced via `bat cache --build`) |
| `delta.gitconfig.tpl` | `delta.gitconfig` | Delta diff pager config (symlinked to `~/.config/delta/current.gitconfig`) |
| `kitty.conf.tpl` | `kitty.conf` | Terminal colors |
| `waybar.css.tpl` | `waybar.css` | Waybar bar styling |
| `hyprland.lua.tpl` | `hyprland.lua` | Hyprland Lua theme colors |
| `hyprlock.conf.tpl` | `hyprlock.conf` | Lock screen colors |
| `fzf.sh.tpl` | `fzf.sh` | Fzf preview colors |
| `mako.ini.tpl` | `mako.ini` | Notification daemon colors |
| `walker.css.tpl` | `walker.css` | Application launcher styling |
| `btop.theme.tpl` | `btop.theme` | System monitor theme |
| `swayosd.css.tpl` | `swayosd.css` | On-screen display styling |
| `speedcrunch.json.tpl` | `speedcrunch.json` | Calculator theme |
| `hyprland-preview-share-picker.css.tpl` | `hyprland-preview-share-picker.css` | Hyprland xdg-desktop-portal picker styling |
| `pi.json.tpl` | `pi.json` | Pi coding agent theme |

### Delta + Bat + Diffnav Integration

Delta uses bat for syntax highlighting of diff context lines (`zero-style = syntax`).
To ensure syntax colors match the current theme:
1. `bat.tmTheme.tpl` generates a Sublime `.tmTheme` file with syntax colors
   derived from `colors.toml`
2. `theme-set` symlinks it to `~/.config/bat/themes/current.tmTheme`
3. bat config uses `--theme="current"`
4. Delta's `syntax-theme = current` tells delta to load this theme
5. `bat cache --build` rebuilds the theme cache on every theme switch

Diffnav spawns delta as a subprocess (with `exec.Command("delta", args...)`)
which reads its config from git config (`include.path=~/.config/delta/current.gitconfig`).

### Key Files Reference

| File | Role |
|------|------|
| `.local/bin/theme-set` | Theme switch entry point |
| `.local/bin/theme-set-templates` | Template processor (sed-based) |
| `.config/themes/available/*/colors.toml` | Color definitions per theme |
| `.config/themes/config/*.tpl` | Application config templates |
| `.config/themes/current/theme/` | Active theme's rendered configs |
| `.config/themes/current/theme.name` | Active theme name (plain text) |
| `.config/hypr/hyprland.lua` | Hyprland Lua entry point |
| `.config/hypr/vars.lua` | Shared Hyprland variables (terminal, monitors, OSD helper) |
| `.config/hypr/theme-current.lua` | Current generated Hyprland theme snapshot |

## Hyprland Lua Configuration

Hyprland config lives in `.config/hypr/*.lua`. `hyprland.lua` is the entry point
and loads focused modules (`vars`, `monitors`, `autostart`, `envs`, `looknfeel`,
`input`, `bindings`, `windows`, then `theme-current`). Keep `theme-current` last
so generated theme colors override base border colors.

Use Hyprland's Lua helpers consistently (`hl.config`, `hl.bind`, `hl.window_rule`,
`hl.workspace_rule`, `hl.monitor`, `hl.env`, etc.). Shared values belong in
`vars.lua`; theme-derived values belong in `.config/hypr/theme-current.lua` and
its matching template `.config/themes/config/hyprland.lua.tpl`.

## Shell Script Linting

```bash
# Check shell scripts with shellcheck
shellcheck .zshrc .bashrc .zshenv
shellcheck .local/bin/cmd-* .local/bin/compile .local/bin/hyprland-*
shellcheck .local/bin/launch-* .local/bin/lock-screen .local/bin/menu
shellcheck .local/bin/refresh-applications .local/bin/restart-*
shellcheck .local/bin/theme-*

# Format shell scripts
shfmt -w .zshrc .bashrc .zshenv
shfmt -w .local/bin/cmd-* .local/bin/compile .local/bin/hyprland-*
shfmt -w .local/bin/launch-* .local/bin/lock-screen .local/bin/menu
shfmt -w .local/bin/refresh-applications .local/bin/restart-*
shfmt -w .local/bin/theme-*

# Check Python scripts (keymap, qmk)
ruff check .local/bin/keymap .local/bin/qmk
```

### General Validation

```bash
# Validate JSON/YAML configs
yq eval '.' .config/walker/config.toml
jq . .config/fastfetch/config.jsonc

# Check for common issues
grep -r 'TODO\|FIXME' --include='*.sh' --include='*.py' --include='*.lua' .
```

## Code Style Guidelines

### General Principles

- Make minimal, surgical changes to existing configurations
- Prefer consistency with surrounding code over "best practices"
- Add comments only when the intent is genuinely unclear

### Shell Scripts (.sh, .zshrc, .zshenv, .bashrc)

- Use `#!/bin/bash` shebang (actual convention in this repo; `#!/usr/bin/env bash`
  is also acceptable for portability)
- Use `set -euo pipefail` for error safety
- Quote all variable expansions: `"$VAR"` not `$VAR`
- Use `[[ ]]` for conditionals, not `[ ]`
- Prefer `local` variables in functions
- Use `readonly` for constants
- Avoid subshells when possible: use `${var//pattern/}` over `$(echo "$var" | sed ...)`

### Configuration Files

- YAML: 2-space indentation, use anchors (`&anchor`) for repeated values
- JSON: JSONC (JSON with comments) is allowed
- Lua: keep Hyprland modules small and loaded from `hyprland.lua`
- Templates: Use `.tpl` extension, follow template language syntax
- Comments: Prefix with `#` for YAML/shell, `--` for Lua, `//` for JSONC

### Naming Conventions

- Shell functions: `snake_case` (e.g., `check_dependency`)
- Config files: `kebab-case` or `snake_case` per tool convention
- Scripts in `.local/bin/`: descriptive, lowercase, hyphenated (e.g., `theme-set`)

### Error Handling

- Shell: Use `set -e` and explicit error messages
- Config: Validate at load time, fail loudly with clear messages

### Imports and Dependencies

- Shell: Source files in order (vars, helpers, main logic)
- Keep dependencies minimal - this is a personal dotfiles repo

## Git Guidelines

- Commit messages: concise, imperative mood
- **Never** add AI assistants (Claude, Copilot, etc.) to attribution
- `gh` CLI available for GitHub operations
- **Only commit when explicitly told to** — never stage, commit, or push
  without the user saying so. Keep changes in working tree until asked.

## Testing Philosophy

- Write tests that verify correct behavior
- Failing tests are acceptable when they expose genuine bugs
- For shell scripts: manual testing is often sufficient

## Skills

Skills live under `.agents/skills/`. Each is a directory with a `SKILL.md` that
provides specialized instructions for a specific task. Pi-loadable local skills
are symlinked into `.pi/agent/skills/` (for example `teach`). The `pi` agent loads
them on demand when their description matches the task.

### Available Skills

| Skill | Purpose |
|-------|---------|
| `building-native-ui` | Building Expo apps with React Native + Expo Router |
| `caveman` | Ultra-compressed communication mode (minimal tokens) |
| `diagnose` | Structured diagnosis loop for hard bugs / regressions |
| `expo-cicd-workflows` | EAS workflow YAML for Expo CI/CD |
| `expo-tailwind-setup` | Tailwind CSS v4 setup with NativeWind v5 |
| `grill-me` | Stress-test a plan through Socratic interview |
| `grill-with-docs` | Grill + align with domain docs (CONTEXT.md, ADRs) |
| `handoff` | Compact conversation into a handoff document |
| `improve-codebase-architecture` | Refactoring and architecture improvement |
| `native-data-fetching` | Network requests, React Query, caching, offline |
| `prototype` | Build throwaway prototypes for design exploration |
| `setup-matt-pocock-skills` | Configure repo context for issue/triage/domain-doc skills |
| `tdd` | Red-green-refactor test-driven development |
| `teach` | Teach a skill/concept using lessons and learning records |
| `to-issues` | Break plans into vertical-slice issues |
| `to-prd` | Convert conversation context into PRD |
| `triage` | Issue triage through state machine |
| `upgrading-expo` | Expo SDK upgrade guidance |
| `write-a-skill` | Create new agent skills |
| `zoom-out` | Explain broader context for unfamiliar code |

### Todos

Tracked in `.pi/todos/` (file-based). Use the `todo` tool to list, claim, update,
and close todos.

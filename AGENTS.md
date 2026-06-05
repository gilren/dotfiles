# AGENTS.md - Dotfiles Configuration Repository

This is a dotfiles repository containing system configuration files, shell scripts, and theming tools for a Hyprland-based Linux desktop environment.

## Repository Structure

- `.config/` - Application configurations (Hyprland, Waybar, Neovim, Kitty, Tmux,
  Mako, Walker, btop, fastfetch, lazygit, lazydocker, fzf, delta, diffnav, bat,
  starship, git, imv, elephant, uwsm, nautilus, qmk, systemd, autostart,
  environment.d, mpv, etc.)
- `.config/themes/` - Theming system with template processing and theme switching
  (backgrounds, colors, icons, neovim, vscode, kitty, hyprland, mako, walker, etc.)
- `.config/mimeapps.list` - Default application associations
- `.local/bin/` - User scripts (bash) and CLI tools (bash, python)
- `.pi/` - Pi coding agent configuration (sessions, skills, todos)
- `.agents/` - Agent skills (caveman, diagnose, handoff, tdd, etc.)

## Build/Lint/Test Commands

This is primarily a configuration repository with shell scripts. There is no formal build system.

### Shell Script Linting

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
- Templates: Use `.tpl` extension, follow template language syntax
- Comments: Prefix with `#` for YAML/shell, `//` for JSONC

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

## Testing Philosophy

- Write tests that verify correct behavior
- Failing tests are acceptable when they expose genuine bugs
- For shell scripts: manual testing is often sufficient

## Skills

Skills live under `.agents/skills/`. Each is a directory with a `SKILL.md` that
provides specialized instructions for a specific task. The `pi` agent loads them
on demand when their description matches the task.

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
| `tdd` | Red-green-refactor test-driven development |
| `to-issues` | Break plans into vertical-slice issues |
| `to-prd` | Convert conversation context into PRD |
| `triage` | Issue triage through state machine |
| `upgrading-expo` | Expo SDK upgrade guidance |
| `write-a-skill` | Create new agent skills |

### Todos

Tracked in `.pi/todos/` (file-based). Use the `todo` tool to list, claim, update,
and close todos.

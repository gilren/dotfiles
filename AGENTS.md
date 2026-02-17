# AGENTS.md - Dotfiles Configuration Repository

This is a dotfiles repository containing system configuration files, shell scripts, and theming tools for a Hyprland-based Linux desktop environment.

## Repository Structure

- `.config/` - Application configurations (Hyprland, Kitty, Tmux, Mako, etc.)
- `.local/bin/` - User scripts and CLI tools
- `.config/themes/` - Theming system with template processing
- `.config/opencode/` - OpenCode agent configuration

## Build/Lint/Test Commands

This is primarily a configuration repository with shell scripts. There is no formal build system.

### Shell Script Linting

```bash
# Check shell scripts with shellcheck
shellcheck .zshrc .bashrc .local/bin/*
shellcheck .config/opencode/tool/ast-grep.ts  # TypeScript

# Format shell scripts
shfmt -w .zshrc .bashrc .local/bin/*
```

### General Validation

```bash
# Validate JSON/YAML configs
yq --version && yq eval '.' .config/walker/config.toml
jq . .config/fastfetch/config.jsonc

# Check for common issues
grep -r 'TODO\|FIXME' --include='*.sh' --include='*.ts' .
```

## Code Style Guidelines

### General Principles

- Make minimal, surgical changes to existing configurations
- Prefer consistency with surrounding code over "best practices"
- Add comments only when the intent is genuinely unclear

### Shell Scripts (.sh, .zshrc, .bashrc)

- Use `#!/usr/bin/env bash` or `#!/usr/bin/env zsh` shebang
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

## Specialized Subagents

- **Oracle**: Code review, architecture, debugging
- **Librarian**: Understanding libraries, exploring repos
- **Overseer**: Task management, milestone tracking

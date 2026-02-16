# XDG defaults (fallback if XDG_* vars not set)
export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Derived paths
export SCREENSHOT_DIR="${SCREENSHOT_DIR:-$XDG_PICTURES_DIR/Screenshots}"
export SCREENRECORD_DIR="${SCREENRECORD_DIR:-$XDG_VIDEOS_DIR/Screencasts}"

# PATH
export PATH="$HOME/.local/bin:/usr/local/bin:$HOME/.bun/bin:$PATH"

# Editor
export VISUAL=nvim
export EDITOR=nvim

# Zsh
export ZSH="$HOME/.oh-my-zsh"

# FZF
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

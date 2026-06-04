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
export PATH="$HOME/.local/bin:$PATH:/usr/local/bin:$HOME/.bun/bin:$HOME/.cache/.bun/bin:/opt/cuda/bin:$HOME/go/bin"

# CUDA
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# Editor
export VISUAL=nvim
export EDITOR=nvim

# FZF
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Android
export CAPACITOR_ANDROID_STUDIO_PATH="/opt/android-studio/bin/studio.sh"
export JAVA_HOME="/opt/android-studio/jbr/"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$JAVA_HOME/bin

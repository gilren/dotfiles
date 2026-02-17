# Zsh plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history setup 
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
[ -f ~/.config/fzf/theme.sh ] && source ~/.config/fzf/theme.sh

# -- Use fd instead of fzf --

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


source ~/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


# Replace ls with eza alias
alias ls='eza -a --color=always --group-directories-first --icons' # preferred listing alias
alias la='eza -al --color=always --group-directories-first --icons' # all files and dirs alias
alias ll='eza -l --color=always --group-directories-first --icons'  # long format alias
alias lt='eza -aT  --color=always --group-directories-first --icons'  # tree listing
alias l.="eza -a | grep -e '^\.'"

alias cd="z"
alias cat="bat"

# Yazi
function y() { 
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" 
    cwd yazi "$@" --cwd-file="$tmp" 
    IFS= read -r -d '' cwd < "$tmp" 
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" 
    rm -f -- "$tmp" 
} 

# SSH Port Forwarding Functions


# fip (Forward IP):
# - Usage: fip server 3000 8080
# - Creates SSH tunnels from your localhost to remote server
# - Flags explained:
#   - -f: Fork to background (daemon mode)
#   - -N: No remote command execution (just tunnel)
#   - -L: Local port forwarding syntax: local_port:remote_host:remote_port

fip() {
  [[ $# -lt 2 ]] && echo "Usage: fip <host> <port1> [port2] ..." && return 1
  local host="$1"
  shift
  for port in "$@"; do
    ssh -f -N -L "$port:localhost:$port" "$host" && echo "Forwarding localhost:$port -> $host:$port"
  done
}

# dip (Disconnect IP):
# - Usage: dip 3000 8080
# - **Kills SSH processes matching the port pattern
# - Gracefully handles "no such forwarding" case

dip() {
  [[ $# -eq 0 ]] && echo "Usage: dip <port1> [port2] ..." && return 1
  for port in "$@"; do
    pkill -f "ssh.*-L $port:localhost:$port" && echo "Stopped forwarding port $port" || echo "No forwarding on port $port"
  done
}

# lip (List IP):
# - Shows all active SSH forwards with process info
# - Example output: 12345 ssh -f -N -L 3000:localhost:3000 server

lip() {
  pgrep -af "ssh.*-L [0-9]+:localhost:[0-9]+" || echo "No active forwards"
}

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Load keychain-managed SSH keys
eval $(keychain --quiet --eval ~/.ssh/key)

# Zoxide (better cd)
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

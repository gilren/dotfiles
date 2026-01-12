# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.volta/bin:$BUN_INSTALL/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export VISUAL=nvim
export EDITOR=nvim 

plugins=(git zsh-autosuggestions web-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# history setup 
HISTFILE=$HOME/.zhistory 
SAVEHIST=1000 
HISTSIZE=999 
setopt share_history 
setopt hist_expire_dups_first 
setopt hist_ignore_dups 
setopt hist_verify 

# Useful aliases 
# Replace ls with eza alias
alias ls='eza -a --color=always --group-directories-first --icons' # preferred listing alias
alias la='eza -al --color=always --group-directories-first --icons' # all files and dirs alias
alias ll='eza -l --color=always --group-directories-first --icons'  # long format alias
alias lt='eza -aT --color=always --group-directories-first --icons'  # tree listing
alias l.="eza -a | grep -e '^\.'"

# # ---- Zoxide (better cd) ---- 
eval "$(zoxide init zsh)" alias cd="z"

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward 

# Common use
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

function y() { 
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" 
    cwd yazi "$@" --cwd-file="$tmp" 
    IFS= read -r -d '' cwd < "$tmp" 
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" 
    rm -f -- "$tmp" 
} 

# # bun completions 
[ -s "/home/renaud/.bun/_bun" ] && source "/home/renaud/.bun/_bun" 
# # bun 
export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH" 

eval $(keychain ~/.ssh/github 2>/dev/null)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias wt="curl -s wttr.in/Liege | head -n 17"

eval "$(starship init zsh)" 

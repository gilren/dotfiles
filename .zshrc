export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
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

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward 

eval "$(fzf --zsh)"

# Replace ls with eza alias
alias ls='eza -a --color=always --group-directories-first --icons' # preferred listing alias
alias la='eza -al --color=always --group-directories-first --icons' # all files and dirs alias
alias ll='eza -l --color=always --group-directories-first --icons'  # long format alias
alias lt='eza -aT --color=always --group-directories-first --icons'  # tree listing
alias l.="eza -a | grep -e '^\.'"

function y() { 
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" 
    cwd yazi "$@" --cwd-file="$tmp" 
    IFS= read -r -d '' cwd < "$tmp" 
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" 
    rm -f -- "$tmp" 
} 

# bun 
[ -s "/home/renaud/.bun/_bun" ] && source "/home/renaud/.bun/_bun" 

export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH" 

# github
eval $(keychain ~/.ssh/github 2>/dev/null)

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)" 



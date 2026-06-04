# grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# safer defaults
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Replace ls with eza alias
alias l="eza -al --color=always --group-directories-first --icons"  # all files and dirs alias
alias ls="eza -a --color=always --group-directories-first --icons"   # preferred listing alias
alias ll="eza -l --color=always --group-directories-first --icons"   # long format alias
alias lt="eza -aT  --color=always --group-directories-first --icons" # tree listing
alias l.="eza -a | grep -e '^\.'"

alias cd="z"
alias cat="bat"

alias cp='nocorrect cp'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'
alias su='nocorrect su'


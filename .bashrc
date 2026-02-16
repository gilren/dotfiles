[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.config/fzf/theme.sh ] && source ~/.config/fzf/theme.sh

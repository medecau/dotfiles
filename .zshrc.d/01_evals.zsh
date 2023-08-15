[ -f ~/.hidden.zsh ] && source ~/.hidden.zsh

eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

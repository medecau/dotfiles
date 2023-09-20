autoload -Uz compinit
compinit

eval "$(_LLM_COMPLETE=zsh_source llm)"

eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.hidden.zsh ] && source ~/.hidden.zsh

eval "$(starship init zsh)"

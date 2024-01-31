autoload -Uz compinit
compinit

# llm cli tool auto completion
eval "$(_LLM_COMPLETE=zsh_source llm)"

eval "$(invoke --print-completion-script=zsh)"

eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.hidden.zsh ] && source ~/.hidden.zsh

eval "$(starship init zsh)"

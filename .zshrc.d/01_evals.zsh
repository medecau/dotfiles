autoload -Uz compinit
compinit

# llm cli tool auto completion
eval "$(_LLM_COMPLETE=zsh_source llm)"

eval "$(invoke --print-completion-script=zsh)"

eval "$(direnv hook zsh)"

eval "$(fzf --zsh)"

# 1password
[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh

eval "$(starship init zsh)"

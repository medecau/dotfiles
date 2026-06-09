# search history with up/down arrow keys
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

setopt extendedhistory
setopt inc_append_history_time
setopt sharehistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_GLOB

setopt AUTO_PUSHD        # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

fpath+=~/.zfunc
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi
autoload -Uz colors && colors

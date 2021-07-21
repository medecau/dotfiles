# locale
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# opt out of tracking
export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1        # Homebrew
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # .NET CLI
export GATSBY_TELEMETRY_DISABLED=1    # Gatsby
export STNOUPGRADE=1                  # Syncthing
export SAM_CLI_TELEMETRY=0            # AWS Serverless Application Model
export AZURE_CORE_COLLECT_TELEMETRY=0 # Azure CLI

# history
export HISTSIZE=1000000
export SAVEHIST=1000000

# paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
eval "$(brew shellenv)" # homebrew

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# user
export PATH="$HOME/bin:$PATH"

# GO
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export GOPATH="$HOME/code/gopath"

export PATH=$PATH:/Library/TeX/texbin

# remove duplicates from PATH
if [ -n "$PATH" ]; then
  old_PATH=$PATH:
  PATH=
  while [ -n "$old_PATH" ]; do
    x=${old_PATH%%:*} # the first remaining entry
    case $PATH: in
    *:"$x":*) ;;        # already there
    *) PATH=$PATH:$x ;; # not there yet
    esac
    old_PATH=${old_PATH#*:}
  done
  PATH=${PATH#:}
  unset old_PATH x
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=6

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# hooks
eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# global

alias -g L=" | less"
alias -g G=" | grep"
alias -g F=" | fzf"

# basic

alias cdb="cd $OLDPWD"
alias ls="ls -Gh"                  # with colors and human file sizes when necessary
alias la="ls -a"                   # list with hidden files
alias ll="la -l"                   # list with more info - Long
alias lh="ls -d .*"                # only the hidden files
alias mkdir="mkdir -pv"            # create directory and any missing parent directories
alias pbclear="pbcopy < /dev/null" # clear pasteboard

alias g="git" # git alias should go in ~/.gitconfig
alias t="tmux"

alias dk="docker"
alias inv="invoke --config=.tasks" # invoke for user tasks

# vscode
alias code="/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code"
alias codeconfig="$EDITOR $HOME/Library/Application Support/Code - Insiders/User/"

# sublime apps
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias smerge="/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge"

# lua game engines
alias love="/Applications/love.app/Contents/MacOS/love"
alias lovr="/Applications/lovr.app/Contents/MacOS/lovr"

# SSH
alias s="autossh -M 0"
alias sa="ssh-add"
alias scp="scp -C" # scp with compression

# Python virtualenv
alias ve="virtualenv"
alias vei="ve .venv"                  # init
alias vea="source .venv/bin/activate" # activate
alias ved="deactivate"                # deactivate

# C lang
alias cc="cc -Wall -Werror" # all warnings + warnings are errors
alias cf="clang-format -i"  # format in-place

# ZSH utilities
alias zshconfig="$EDITOR ~/.zshrc"   # edit config file
alias ohmyzsh="$EDITOR ~/.oh-my-zsh" # edit config dir
alias reload="source ~/.zshrc"       # reload config

# dotfiles
alias dotfiles="git --git-dir='$HOME/.dotfiles.git' --work-tree=$HOME"
alias dfs="dotfiles"

# hooks
eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(pyenv init -)"

# enter tmux
if [ -z "$TMUX" ]; then
  tmux attach || tmux new
fi

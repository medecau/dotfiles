# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="witchhazelhypercolor"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=6

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

source $ZSH/oh-my-zsh.sh

# User configuration

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

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# globals
alias -g H=" | head"
alias -g T=" | tail"
alias -g E=" | sed"
alias -g S=" | sort"
alias -g U=" | uniq"
alias -g G=" | grep -i"
alias -g L=" | less"
alias -g X=" | xargs"

# fancy globals
alias -g C=" | pbcopy"
alias -g F=" | fzf --multi"
alias -g XI=" | xargs -I _"
alias -g NE=" 2 > /dev/null"
alias -g and=" && "
alias -g or=" || "

# basic

alias ls="ls -GFhrt"       # with colors and symbols, human file sizes, and reverse sorted by time
alias la="ls -a"           # list with hidden files
alias ll="la -l"           # list with more info - Long
alias lh="ls -d .*"        # only the hidden files
alias mkdir="mkdir -pv"    # create directory and any missing parent directories
alias git="git --no-pager" # git alias should go in ~/.gitconfig

alias cdb="cd $OLDPWD"
function cdf() {
  target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
  [ "$target" != "" ] && cd "$target" || echo 'No Finder window found' >&2
}
function copyfile() {
  cat $@ | pbcopy
}
alias ff="find . -type f -iname"
alias pbclear="pbcopy < /dev/null" # clear pasteboard
alias mancat="man -P cat"          # use cat as the pager
alias mc=mancat
alias www='python -m http.server'
alias treedirs='tree -d'
alias treedu='tree -d --du -h'

# ripgrep with Witch Hazel colors
alias rg='rg --colors=match:style:nobold --colors=match:fg:218 --colors=line:style:nobold --colors=line:fg:121 --colors=path:fg:183'

# fetch env var value from remote host
function rvar() {
  ssh $1 "printenv $2"
}

function calc() {
  python -c "print($@)"
}

# container stuff
alias dk="docker"
alias dc="docker compose"
alias mk="minikube"
alias kc="kubectl"

# tailscale
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias ts="tailscale"

# vscode
alias code="/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code"
function rcode() {
  code --remote ssh-remote+$1 $2
}
alias codeconfig="$EDITOR ~/Library/Application Support/Code - Insiders/User/"

# sublime apps
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias smerge="/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge"

# lua game engines
alias love="/Applications/love.app/Contents/MacOS/love"
alias lovr="/Applications/lovr.app/Contents/MacOS/lovr"

# SSH
alias autossh=autossh -o "ServerAliveInterval 2" -o "ServerAliveCountMax 2"
alias s="autossh -M 0"
alias sa="ssh-add"
alias scp="scp -C" # scp with compression

# age
alias ageencme="age --encrypt -R ~/.ssh/id_ed25519.pub"
alias agedecme="age --decrypt -i ~/.ssh/id_ed25519"

# PyEnv
alias pyenv-versions-unref="pyenv versions G -v '^*' E -E 's/^ +//'"
alias pyenv-install='pyenv install $(pyenv install -l F) && pyenv rehash'
alias pyenv-uninstall='pyenv uninstall $(pyenv-versions-unref F) && pyenv rehash'
alias pyenv-rm-config-files='find .pyenv/shims -name \"*-config\" -delete'

# Python virtualenv
alias ve="virtualenv"
alias vei="ve .venv"                  # init
alias vea="source .venv/bin/activate" # activate
alias ved="deactivate"                # deactivate
alias veia="vei && vea"

# C lang
alias cc="cc -Wall -Werror" # all warnings + warnings are errors
alias cf="clang-format -i"  # format in-place

# invoke and fabfile
alias inv='invoke --search-root=$HOME' # invoke for user tasks
eval "$(invoke --print-completion-script=zsh)"
eval "$(fab --print-completion-script=zsh)"

# ZSH utilities
alias zshconfig="$EDITOR ~/.zshrc"   # edit config file
alias ohmyzsh="$EDITOR ~/.oh-my-zsh" # edit config dir
alias reload="source ~/.zshrc"       # reload config
alias gitconfig="$EDITOR ~/.gitconfig"

# maintenance
alias brewup="brew update && brew upgrade"
alias macosup="softwareupdate -ia"
alias upall="macosup && brewup"

# dotfiles
alias dotfiles="git --no-pager --git-dir ~/.dotfiles.git --work-tree ~"
alias dfs="dotfiles"
function dfstoggle() {
  if [ -d ~/.dotfiles.git ]; then
    mv ~/.dotfiles.git ~/.git
  elif [ -d ~/.git ]; then
    mv ~/.git ~/.dotfiles.git
  fi
}

#  different file to avoid tainting home/work configs
[ -f ~/.hidden.zsh ] && source ~/.hidden.zsh

# hooks
eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# enter tmux
if [ -z "$TMUX" ]; then
  tmux attach || tmux new
fi

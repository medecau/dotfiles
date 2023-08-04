# locale
export LANG=en_US.UTF-8
unset LC_ALL

# opt out of tracking
export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1        # Homebrew
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # .NET CLI
export GATSBY_TELEMETRY_DISABLED=1    # Gatsby
export STNOUPGRADE=1                  # Syncthing
export SAM_CLI_TELEMETRY=0            # AWS Serverless Application Model
export AZURE_CORE_COLLECT_TELEMETRY=0 # Azure CLI
export MEILI_NO_ANALYTICS=1           # MeiliSearch
export MEILI_NO_SENTRY=1
# semgrep metrics are disabled in alias

# history
# do not put these inside "if" blocks
export HISTSIZE=1000000
export SAVEHIST=1000000

export PROMPT_ROWS=3

export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH

eval "$(brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="$PATH:$(brew --prefix go)/libexec/bin"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

hash -r

# We run these on the base shell to avoid the overhead when creating new panels in tmux
if [ -z "$TMUX" ]; then # global environment
  brew bundle install --no-upgrade --quiet

  export HOMEBREW_PREFIX_BZIP2="$(brew --prefix bzip2)"
  export HOMEBREW_PREFIX_OPENSSL="$(brew --prefix openssl)"
  export HOMEBREW_PREFIX_READLINE="$(brew --prefix readline)"
  export HOMEBREW_PREFIX_SQLITE3="$(brew --prefix sqlite3)"
  export HOMEBREW_PREFIX_XZ="$(brew --prefix xz)"
  export HOMEBREW_PREFIX_ZLIB="$(brew --prefix zlib)"

  export PYENV_PREFIX="$(pyenv prefix)"

  export CFLAGS="-I$HOMEBREW_PREFIX_BZIP2/include \
    -I$HOMEBREW_PREFIX_OPENSSL/include \
    -I$HOMEBREW_PREFIX_READLINE/include \
    -I$HOMEBREW_PREFIX_SQLITE3/include \
    -I$HOMEBREW_PREFIX_XZ/include\
    -I$HOMEBREW_PREFIX_ZLIB/include\
    -I$PYENV_PREFIX/include"
  export CPPFLAGS="$CFLAGS"

  export LDFLAGS="-L$HOMEBREW_PREFIX_BZIP2/lib\
    -L$HOMEBREW_PREFIX_OPENSSL/lib\
    -L$HOMEBREW_PREFIX_READLINE/lib\
    -L$HOMEBREW_PREFIX_SQLITE3/lib\
    -L$HOMEBREW_PREFIX_XZ/lib\
    -L$HOMEBREW_PREFIX_ZLIB/lib\
    -L$PYENV_PREFIX/lib"

  export OPENBLAS="$(brew --prefix openblas)"
  export LLVM_CONFIG="$(brew --prefix llvm)/bin/llvm-config"
  export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
  export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl --wait'
fi

# remove duplicates
typeset -U PATH

# Defining aliases

echo 'Defining command aliases'
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# globals
alias -g H=' | head'
alias -g T=' | tail'
alias -g E=' | sed'
alias -g S=' | sort'
alias -g U=' | uniq'
alias -g G=' | grep -i'
alias -g L=' | less'
alias -g X=' | xargs'
alias -g CL=' | wc -l'

# fancy globals
alias -g C=' | pbcopy'
alias -g F=' | fzf --multi'
alias -g XI=' | xargs -I _'
alias -g NE=' 2>/dev/null'
alias -g SE=' 2>&1'
alias -g and=' && '
alias -g or=' || '

# basic
alias help='man -P cat'

alias ls='ls -GFh'  # with colors and symbols, human file sizes, and reverse sorted by time
alias la='ls -a'    # list with hidden files
alias ll='la -l'    # list with more info - Long
alias lh='ls -d .*' # only the hidden files

# Makefile
alias clean='make clean'
alias test='make test'
alias dry='make -n'
alias targets="grep '^[^#[:space:]\.].*:' Makefile"

alias mkdir='mkdir -pv' # create directory and any missing parent directories

alias cdb='cd -' # go back to previous directory
function cdf() {
  target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
  [ "$target" != "" ] && cd "$target" || echo 'No Finder window found' >&2
}
function copyfile() {
  cat $@ | pbcopy
}
alias ff='find . -type f -iname'
alias pbclear='pbcopy < /dev/null' # clear pasteboard
alias www='python -m http.server'
alias treedirs='tree -d'
alias treedu='tree -d --du -h'

function take() {
  mkdir -pv $1
  cd $1
}

# ripgrep with Witch Hazel colors
alias rg='rg --colors=match:style:nobold --colors=match:fg:218 --colors=line:style:nobold --colors=line:fg:121 --colors=path:fg:183'

alias check='ls ~/.checklists/ F XI bat ~/.checklists/_'

# fetch env var value from remote host
function rvar() {
  ssh $1 "printenv $2"
}

function calc() {
  python -c "print($@)"
}

# wget
function tget() {
  wget --quiet --output-document - $1 | strip-tags -m
}

# yt-dlp
alias vget='yt-dlp'
alias aget='vget --extract-audio --audio-format mp3 --audio-quality 4'
# audio quality – Insert a value between 0 (best) and 10 (worst)

# move the file to the Castro iCloud folder
function sideload() {
  mv $1 ~/Library/Mobile\ Documents/iCloud-co-supertop-castro/Documents/Sideloads/
  echo "Sideloaded $1 to Castro - it should be available in the app soon."
}

# ansible stuff
alias ap='ansible-playbook'
alias ai='ansible-inventory'

alias tf='terraform'

# container stuff
alias dk='docker'
alias dc='docker compose'
alias ds='docker stack'
alias mk='minikube'
alias kc='kubectl'

# tailscale
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias ts='tailscale'

# lua game engines
alias love="/Applications/love.app/Contents/MacOS/love"
alias lovr="/Applications/lovr.app/Contents/MacOS/lovr"

# SSH
alias autossh=autossh -o 'ServerAliveInterval 2' -o 'ServerAliveCountMax 2'
alias s='autossh -M 0'
alias scp='scp -C' # scp with compression

# PyEnv
# list installed but unused pyenv versions
alias pyenv-versions-unref="pyenv versions G -v '^*' G -v 'system' E -E 's/^ +//'"
# install version after picking one then rehash pyenv
alias pyenv-install='pyenv install $(pyenv install -l F) && pyenv rehash'
# uninstall a version by picking from unused versions
alias pyenv-uninstall='pyenv uninstall $(pyenv-versions-unref F) && pyenv rehash'
alias pyenv-uninstall-unused='pyenv-versions-unref | xargs -I _ pyenv uninstall -f _'
# clean up config files from pyenv shims
alias pyenv-rm-config-files='find ~/.pyenv/shims -name "*-config" -delete'

# Python virtualenv
alias ve='virtualenv'
alias vei='ve .venv'                                       # init
alias vea='source .venv/bin/activate'                      # activate
alias ved='deactivate'                                     # deactivate
alias veia='vei && vea && \
pip install -U pip isort black &&\
touch main.py utils.py notes.md'
alias verm='ved; rm -rf .venv'                             # remove
alias vera='verm; veia'                                    # recreate

function playground() {
  local cmd=$1
  shift

  if [[ $cmd == 'help' ]]; then
    echo 'subcommands:'
    echo 'init:\tcreate and enter an ephemeral playground'
    echo 'enter:\tenter the ephemeral playground'
    echo 'exit:\texit the ephemeral playground'
    echo 'over:\texit and dissolve the ephemeral playground'
    echo 'real:\tmake the ephemeral playground permanent'

  elif [[ $cmd == 'init' ]]; then
    echo 'Scaffolding a new ephemeral playgrond.'
    export PLAYGROUND="$(mktemp -d)"
    playground enter
    veia
    echo "enter 'pg over' to dissolve this playground"
    echo "enter 'pg materialize' to make this playground permanent"

  elif [[ $cmd == 'enter' ]]; then
    cd $PLAYGROUND
    export BEFORE_PLAYGROUND=$OLDPWD
    if [[ -d '.venv' ]]; then
      vea
    fi

  elif [[ $cmd == 'exit' ]]; then
    ved
    if [[ $OLDPWD == $BEFORE_PLAYGROUND ]]; then
      cd -
    else
      cd $BEFORE_PLAYGROUND
    fi
    unset BEFORE_PLAYGROUND

  elif [[ $cmd == 'over' ]]; then
    echo 'Dissolving the playground.'
    playground exit
    rm -rf $PLAYGROUND
    unset PLAYGROUND

  elif [[ $cmd == 'materialize' ]]; then
    local real_path=$1
    if [[ -e $real_path ]]; then
      echo "The path '$real_path' already exists, remove before materializing there."
    elif [[ -n $real_path ]]; then
      playground exit
      mv $PLAYGROUND $real_path
      cd $real_path
      vea
    else
      echo "Please provide a destination path"
    fi

  else
    echo "Unrecognised command: $cmd"
  fi
}
alias pg=playground

# semgrep
alias semgrep='semgrep --disable-version-check --metrics=off'
alias sg-python='semgrep --config="p/ci" --config="p/python"'
alias sg-security='semgrep --config="p/secrets" --config="p/command-injection" --config="p/supply-chain" --config="p/trailofbits" --config="p/github-actions"'

# C lang
alias cc='cc -Wall -Werror' # all warnings + warnings are errors
alias cf='clang-format -i'  # format in-place

# invoke and fabfile
alias inv='invoke --search-root=$HOME' # invoke for user tasks
[ -f ~/bin/invoke ] && eval "$(invoke --print-completion-script=zsh)"
[ -f ~/bin/fab ] && eval "$(fab --print-completion-script=zsh)"

# ZSH utilities
function timezsh() {
  for i in $(seq 1 10); do
    shell=${1-$SHELL}
    /usr/bin/time $shell -i -c exit
  done
}

alias reload='source ~/.zshrc' # reload config

# easily edit config files
alias zshconfig="$EDITOR ~/.zshrc && reload"
alias gitconfig="$EDITOR ~/.gitconfig"
alias sshconfig="$EDITOR ~/.ssh/config"
alias brewconfig="$EDITOR ~/Brewfile && brewup"

# maintenance
alias brewup='brew bundle --file=~/Brewfile --quiet && brew update && brew upgrade'
alias macosup='softwareupdate -ia --force && xcodebuild -runFirstLaunch'
alias upall='macosup && brewup'

function xfill() {
  echo "$2 => $1"
  # recurse into directories
  # skip files that are newer on the receiver
  # preserve modification times
  # connect over ssh
  # compress data a bit during transfer
  # entertain me
  rsync --recursive --update --times \
    --rsh=ssh \
    --compress --compress-level=2 \
    --progress --human-readable --stats \
    $1 $2
}

# synchronize two, possibly remote, directories
function syncdir() {
  echo "Synchronizing $2 with $1"
  # recurse into directories
  # skip files that are newer on the receiver
  # preserve modification times
  # exclude hidden files
  # connect over ssh
  # put all update files in place at the end
  # compress data during transfer at maximum level
  # entertain me
  rsync --recursive --update --times \
    --exclude '.*' \
    --rsh=ssh --delay-updates \
    --compress --compress-level=9 \
    --progress --human-readable --stats \
    $1 $2
}

function syncdir2() {
  if [ $(basename $1) != $(basename $2) ]; then
    echo 'basename for both paths must match'
    false
  else
    echo "Two way sync between $1 and $2"
    syncdir $1 $(dirname $2)/
    syncdir $2 $(dirname $1)/
  fi
}

# dotfiles
alias dotfiles='git --no-pager --git-dir ~/.dotfiles.git --work-tree ~'
alias dfs='dotfiles'
function dfstoggle() {
  if [ -d ~/.dotfiles.git ]; then
    mv ~/.dotfiles.git ~/.git
  elif [ -d ~/.git ]; then
    mv ~/.git ~/.dotfiles.git
  fi
}
# fin defining aliases

echo 'Sourcing the hidden file'
#  different file to avoid tainting home/work configs
[ -f ~/.hidden.zsh ] && source ~/.hidden.zsh

echo 'Attaching hooks'
eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function preexec() {
  export VISIBLE_ROWS=$(($LINES - $PROMPT_ROWS * 2))
}

function chpwd() {
  echo "$fg[magenta]- $OLDPWD"
  echo "$fg[cyan]+ $PWD"

  [ -d '.git' ] && echo "$fg[yellow].git"
  [ -f 'Makefile' ] && echo "$fg[yellow]Makefile"
  [ -f 'Dockerfile' ] && echo "$fg[yellow]Dockerfile"
  [ -f 'docker-compose.yml' ] && echo "$fg[yellow]docker-compose.yml"
  [ -d '.venv' ] && echo "$fg[yellow].venv"
  [ -f 'pyproject.toml' ] && echo "$fg[yellow]pyproject.toml"

  # list the 5 most recently modified files
  # add how long ago they were modified in human readable format
  ls -t | head -n 5 | while read file; do
    echo "$fg[white]$(date -r $file '+%Y-%m-%d %H:%M:%S') $fg[green]$file"
  done
}

# search history with up/down arrow keys
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

setopt extendedhistory
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

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

autoload -Uz compinit && compinit
autoload -Uz colors && colors

# Starship prompt
eval "$(starship init zsh)"

if [[ -z "$TMUX" && -z "$SSH_CONNECTION" ]]; then
  echo 'Starting tmux'
  tmux attach || tmux new-session
elif [ -n "$SSH_CONNECTION" ]; then
  echo "$fg[cyan]SSH sesssion"
  tmux ls &>/dev/null
  if [ $? -eq 0 ]; then
    echo "$fg[cyan]tmux session found"
    echo "$fg[yellow]tmux a"
  else
    echo "$fg[cyan]No tmux session found"
    echo "$fg[yellow]tmux new"
  fi
fi

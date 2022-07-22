# We run these on the base shell to avoid the overhead when creating new panels in tmux
if [ -z "$TMUX" ]; then # global environment
  echo 'Setting up global environment variables'

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
  export HISTSIZE=1000000
  export SAVEHIST=1000000

  export PROMPT_ROWS=3

  # Bootstrap homebrew
  if [ -f /usr/local/bin/brew ]; then
    echo 'Homebrew Intel path'
    local HOMEBREW_PATH=/usr/local/bin/brew
  else
    echo 'Homebrew M1 path'
    local HOMEBREW_PATH=/opt/homebrew/bin/brew
  fi

  if [[ ! -f $HOMEBREW_PATH ]]; then
    echo 'Homebrew is missing!'
    if read -q "REPLY?Do you want to install Homebrew?"; then
      xcode-select --install # command-line tools
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi # fin bootstrap homebrew

  # Setup homebrew
  if [ -f $HOMEBREW_PATH ]; then
    eval "$($HOMEBREW_PATH shellenv)"

    # Bootstrap homebrew packages
    echo 'Running brew bundle install'
    brew bundle install --no-upgrade
    # fin bootstrap homebrew packages

    echo 'Setting compiler flags'
    # Compiler flags
    # export ARCHFLAGS="-arch x86_64"

    export HOMEBREW_PREFIX_BZIP2="$(brew --prefix bzip2)"
    export HOMEBREW_PREFIX_OPENSSL="$(brew --prefix openssl)"
    export HOMEBREW_PREFIX_READLINE="$(brew --prefix readline)"
    export HOMEBREW_PREFIX_SQLITE3="$(brew --prefix sqlite3)"
    export HOMEBREW_PREFIX_XZ="$(brew --prefix xz)"
    export HOMEBREW_PREFIX_ZLIB="$(brew --prefix zlib)"

    export PYENV_PREFIX="$(pyenv prefix)"

    export OPENBLAS="$(brew --prefix openblas)"
    export CFLAGS="-I$HOMEBREW_PREFIX_BZIP2/include -I$HOMEBREW_PREFIX_OPENSSL/include -I$HOMEBREW_PREFIX_READLINE/include -I$HOMEBREW_PREFIX_SQLITE3/include -I$HOMEBREW_PREFIX_XZ/include -I$HOMEBREW_PREFIX_ZLIB/include -I$PYENV_PREFIX/include"
    export CPPFLAGS="$CFLAGS"
    export LDFLAGS="-L$HOMEBREW_PREFIX_BZIP2/lib -L$HOMEBREW_PREFIX_OPENSSL/lib -L$HOMEBREW_PREFIX_READLINE/lib -L$HOMEBREW_PREFIX_SQLITE3/lib -L$HOMEBREW_PREFIX_XZ/lib -L$HOMEBREW_PREFIX_ZLIB/lib -L$PYENV_PREFIX/lib"

    # echo $CFLAGS
    # echo $LDFLAGS
    # fin compiler flags

  else
    echo 'Homebrew is missing'

  fi # fin setup homebrew

  # Setup pyenv
  if [ -f "$(which pyenv)" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
  else
    echo 'Pyenv is missing'
  fi # fin setup pyenv

  # user
  export PATH="$HOME/bin:$PATH"

  # GO
  # export PATH="$PATH:/usr/local/opt/go/libexec/bin"
  # export GOPATH="$HOME/code/gopath"

  # export PATH="$PATH:/Library/TeX/texbin"
  # export MANPATH="/usr/local/man:$MANPATH"

  # Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl --wait'
  fi

  # remove duplicates
  typeset -U PATH
fi # fin global environment

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
alias -g NE=' 2 > /dev/null'
alias -g and=' && '
alias -g or=' || '

# basic
alias help='man -P cat'

alias ls='ls -GFh'      # with colors and symbols, human file sizes, and reverse sorted by time
alias la='ls -a'        # list with hidden files
alias ll='la -l'        # list with more info - Long
alias lh='ls -d .*'     # only the hidden files
alias mkdir='mkdir -pv' # create directory and any missing parent directories

alias cdb="cd $OLDPWD"
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

# yt-dlp
alias vget='yt-dlp'

# ansible stuff
alias ap="ansible-playbook"
alias ai="ansible-inventory"

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
alias autossh=autossh -o "ServerAliveInterval 2" -o "ServerAliveCountMax 2"
alias s='autossh -M 0'
alias scp='scp -C' # scp with compression

# PyEnv
# list installed but unused pyenv versions
alias pyenv-versions-unref="pyenv versions G -v '^*' E -E 's/^ +//'"
# install version after picking one then rehash pyenv
alias pyenv-install='pyenv install $(pyenv install -l F) && pyenv rehash'
# uninstall a version by picking from unused versions
alias pyenv-uninstall='pyenv uninstall $(pyenv-versions-unref F) && pyenv rehash'
# clean up config files from pyenv shims
alias pyenv-rm-config-files='find ~/.pyenv/shims -name "*-config" -delete'

# Python virtualenv
alias ve='virtualenv'
alias vei='ve .venv'                          # init
alias vea='source .venv/bin/activate'         # activate
alias ved='deactivate'                        # deactivate
alias veia='vei && vea && pip install -U pip' # init and activate
alias verm='ved; rm -rf .venv'                # remove
alias vera='verm; veia'                       # recreate

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
alias zshconfig="$EDITOR ~/.zshrc"   # edit config file
alias ohmyzsh="$EDITOR ~/.oh-my-zsh" # edit config dir
alias gitconfig="$EDITOR ~/.gitconfig"
alias reload='source ~/.zshrc' # reload config

# maintenance
alias brewup='brew update && brew upgrade'
alias macosup='softwareupdate -ia --force'
alias upall='macosup && brewup'

# synchronize two, possibly remote, directories
function syncd() {
  echo "Synchronizing $2 with $1"
  rsync --recursive --update --times \
    --rsh=ssh --delay-updates \
    --compress --compress-level=9 \
    --human-readable \
    $1 $2
}

function 2waysync() {
  echo "Two way sync between $1 and $2"
  syncd $1 $2
  syncd $2 $1
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
  echo "$fg[magenta]$OLDPWD"
  echo "$fg[cyan]$PWD"
  if [ -f .venv/bin/activate ]; then
    echo "$fg[yellow].venv: $(.venv/bin/python --version)"
    echo "$fg[cyan]Enter 'vea' to activate"

  fi
  if [ -f pyproject.toml ]; then
    echo "$fg[yellow]Project: $fg[white]$(poetry version)$fg[yellow] - $fg[white]$(poetry run python --version)"
    echo "$fg[cyan]Enter '$fg[white]poetry shell$fg[cyan]' to activate "
  fi
}
# Starship prompt
eval "$(starship init zsh)"

if [[ -z "$TMUX" && -z "$SSH_CONNECTION" ]]; then
  echo 'Starting tmux'
  tmux attach || tmux new-session
elif [ -n "$SSH_CONNECTION" ]; then
  echo "$fg[cyan]SSH sesssion"
  tmux ls &>/dev/null
  if [ $? -eq 0 ]; then
    echo "$fg[yellow]tmux a"
  else
    echo "$fg[yellow]tmux new"
  fi

fi

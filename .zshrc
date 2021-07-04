# locale
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# history
export HISTSIZE=1000000
export SAVEHIST=1000000


# paths

export PYENV_ROOT="$HOME/.pyenv"

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PATH="$HOME/bin:$PATH"


# GO
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export GOPATH="$HOME/code/gopath"

export EDITOR="subl"


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=6

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git brew )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#


alias ls="ls -Gh"
alias la="ls -a"
alias ll="la -l"
alias mkdir="mkdir -pv"

# sublime apps
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias smerge="/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge"

# lua game engines
alias love="/Applications/love.app/Contents/MacOS/love"
alias lovr="/Applications/lovr.app/Contents/MacOS/lovr"

# short names
alias t="tmux"
alias g="git"


# ssh
alias s="autossh -M 0"
alias sa="ssh-add"
alias scp="scp -C"

# python virtualenv
alias ve="virtualenv"
alias vei="ve ve"  # init
alias vea="source ve/bin/activate"  # activate
alias ved="deactivate"  # deactivate

# C compiler
alias cc="cc -Wall -Werror" # all warnings + warnings are errors
alias cf="clang-format -i" # format in-place

# zsh utils
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias reload="source ~/.zshrc"

alias saymyname="say \"you are $(whoami)\""


# hooks
eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(pyenv init -)"


if [[ -z "$TMUX" ]]
then
    tmux attach || tmux new
fi
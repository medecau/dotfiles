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
alias -g XI=' | xargs -I _'
alias -g NE=' 2>/dev/null'
alias -g SE=' 2>&1'
alias -g and=' && '
alias -g or=' || '

# function aliases
alias cdf=change-to-finder-directory
alias catcopy=copy-file-contents
alias take=mkdir_and_cd

# invoke
alias inv='invoke --config=.tasks.yaml'

# basic
alias help='man -P cat'

alias ls='ls -GFh' # with colors and symbols, human file sizes, and reverse sorted by time
alias la='ls -A1'  # list with hidden files
alias ll='ls -Al'  # list with more info - Long

# Makefile
alias run='make run'
alias clean='make clean'
alias test='make test'
alias dry='make -n'
alias targets="grep '^[^#[:space:]\.].*:' Makefile"

alias rm='rm -I'        # confirm before deleting
alias mkdir='mkdir -pv' # create directory and any missing parent directories
alias tac='tail -r'

alias ff='find . -type f -iname'
alias pbclear='pbcopy < /dev/null' # clear pasteboard
alias www='python -m http.server'
alias treedirs='tree -d'
alias treedu='tree -d --du -h'

alias taketmp='cd $(mktemp -d)'

# ripgrep with Witch Hazel colors
alias rg='rg \
    --no-ignore-vcs \
    --colors=match:fg:218 \
    --colors=line:fg:121 \
    --colors=path:fg:183'

alias myip='hget https://icanhazip.com'
alias myipv4='hget https://ipv4.icanhazip.com'
alias myipv6='hget https://ipv6.icanhazip.com'

alias hget='wget --quiet --output-document=-'
alias tget='fetch-html-page-and-strip-tags'

# yt-dlp
alias vget='yt-dlp'
alias aget='vget --extract-audio --audio-format mp3 --audio-quality 4'
# audio quality – Insert a value between 0 (best) and 10 (worst)

# ansible stuff
alias ap='ansible-playbook'
alias ai='ansible-inventory'

alias tf='terraform'

# container stuff
alias dk='docker'
#check if 'docker-compose' exists as a command, if not, use 'docker compose'
if command -v docker-compose &>/dev/null; then
    alias dc='docker-compose'
else
    alias dc='docker compose'
fi
alias ds='docker stack'
alias mk='minikube'
alias kc='kubectl'

# tailscale
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
alias vei='ve .venv'                  # init
alias vea='source .venv/bin/activate' # activate
alias ved='deactivate'                # deactivate
alias veia='vei && vea && \
pip install -U pip isort black &&\
touch main.py utils.py notes.md'
alias verm='ved; rm -rf .venv' # remove
alias vera='verm; veia'        # recreate


# semgrep
alias semgrep='semgrep --disable-version-check --metrics=off'
alias sg-python='semgrep --config="p/ci" --config="p/python"'
alias sg-security='semgrep --config="p/secrets" --config="p/command-injection" --config="p/supply-chain" --config="p/trailofbits" --config="p/github-actions" --config="p/security-audit"'

# anthropic claude
alias claude='claude --allowedTools="Bash(ls:*),Bash(rg:*),Bash(git status:*),Bash(git log:*)"'

# C lang
alias cc='cc -Wall -Werror' # all warnings + warnings are errors
alias cf='clang-format -i'  # format in-place

alias zshcheck='zsh -n'        # no execute
alias reload='source ~/.zshrc' # reload config

# easily edit config files
alias zshconfig="$EDITOR ~/.zshrc ~/.zshrc.d && zshcheck ~/.zshrc && reload"
alias gitconfig="$EDITOR ~/.config/git/"
alias sshconfig="$EDITOR ~/.ssh/config"
alias brewconfig="$EDITOR ~/Brewfile && brewup"

# maintenance
alias brewup='brew bundle --file=~/Brewfile --quiet && brew update && brew upgrade && brew cleanup'
alias macosup='softwareupdate -ia --force && xcodebuild -runFirstLaunch'
alias pipxup='pipx upgrade-all'
alias uvtoolup='uv tool upgrade --all'
alias upall='macosup && brewup && uvtoolup && pipxup'

# other
alias fix-ms-team='pkill -9 "Microsoft Teams" && sleep 5 && rm -Irf ~/Library/Application\ Support/Microsoft/Teams && open -n /Applications/Microsoft\ Teams.app'
alias fix-dns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# dotfiles
alias dotfiles='git --no-pager --git-dir ~/.git.dfs --work-tree ~'
alias dfs='dotfiles'

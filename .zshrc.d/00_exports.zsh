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
export OTEL_SDK_DISABLED=1            # opentelemetry - crewai
export SOURCEBOT_TELEMETRY_DISABLED=1              # SOURCEBOT
export NEXT_PUBLIC_SOURCEBOT_TELEMETRY_DISABLED=1
# semgrep metrics are disabled in alias

# history
# do not put these inside "if" blocks
export HISTSIZE=1000000
export SAVEHIST=1000000

export PROMPT_ROWS=3

export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH

# exports for homebrew
eval "$(brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# exports for pyenv
eval "$(pyenv init --path)"

export PYTHON_CONFIGURE_OPTS='--enable-shared'
export PYTHONDONTWRITEBYTECODE='tired'
export PYTHONSTARTUP="$HOME/.repl_startup.py"

export ICLOUD="$HOME/Library/Mobile Documents"
export CASTRO_SIDELOADS="$ICLOUD/iCloud~co~supertop~castro/Documents/Sideloads"

# We run these on the base shell to avoid the overhead when creating new panels in tmux
if [ -z "$TMUX" ]; then # global environment
    brew bundle install --no-upgrade --quiet

    export HOMEBREW_PREFIX_BZIP2="$(brew --prefix bzip2)"
    export HOMEBREW_PREFIX_OPENSSL="$(brew --prefix openssl)"
    export HOMEBREW_PREFIX_READLINE="$(brew --prefix readline)"
    export HOMEBREW_PREFIX_SQLITE3="$(brew --prefix sqlite3)"
    export HOMEBREW_PREFIX_XZ="$(brew --prefix xz)"
    export HOMEBREW_PREFIX_ZLIB="$(brew --prefix zlib)"
    export HOMEBREW_PREFIX_OPENBLAS="$(brew --prefix openblas)"

    export PYENV_PREFIX="$(pyenv prefix)"

    export CFLAGS="-I$HOMEBREW_PREFIX_BZIP2/include \
    -I$HOMEBREW_PREFIX_OPENSSL/include \
    -I$HOMEBREW_PREFIX_READLINE/include \
    -I$HOMEBREW_PREFIX_SQLITE3/include \
    -I$HOMEBREW_PREFIX_XZ/include\
    -I$HOMEBREW_PREFIX_ZLIB/include\
    -I$HOMEBREW_PREFIX_OPENBLAS/include\
    -I$PYENV_PREFIX/include"
    
    export CPPFLAGS="$CFLAGS"

    export LDFLAGS="-L$HOMEBREW_PREFIX_BZIP2/lib\
    -L$HOMEBREW_PREFIX_OPENSSL/lib\
    -L$HOMEBREW_PREFIX_READLINE/lib\
    -L$HOMEBREW_PREFIX_SQLITE3/lib\
    -L$HOMEBREW_PREFIX_XZ/lib\
    -L$HOMEBREW_PREFIX_ZLIB/lib\
    -L$HOMEBREW_PREFIX_OPENBLAS/lib\
    -L$PYENV_PREFIX/lib"

    export CC=/usr/bin/clang
    export CXX=/usr/bin/clang++

    export OPENBLAS="$(brew --prefix openblas)"
    export CFLAGS="-falign-functions=8 ${CFLAGS}" # OpenBLAS

    export LLVM_CONFIG="$(brew --prefix llvm)/bin/llvm-config"
    export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
    export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1

    export PATH="$PATH:$(brew --prefix go)/libexec/bin"
    export PATH="$PATH:$(brew --prefix rust)/bin"
    export PATH="$PATH:$HOME/.cargo/bin"
    export PATH="$PATH:$(brew --prefix ruby)/bin"

    export JAVA_HOME=$(/usr/libexec/java_home)
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' --wait"
fi

# remove duplicates
typeset -U PATH

hash -r

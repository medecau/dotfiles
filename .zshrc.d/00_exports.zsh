# locale
export LANG=en_US.UTF-8
unset LC_ALL

# opt out of tracking
export DO_NOT_TRACK=1
export DISABLE_TELEMETRY=YES
export HOMEBREW_NO_ANALYTICS=1        # Homebrew
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # .NET CLI
export GATSBY_TELEMETRY_DISABLED=1    # Gatsby
export STNOUPGRADE=1                  # Syncthing
export SAM_CLI_TELEMETRY=0            # AWS Serverless Application Model
export AZURE_CORE_COLLECT_TELEMETRY=0 # Azure CLI
export MEILI_NO_ANALYTICS=1           # MeiliSearch
export MEILI_NO_SENTRY=1
export OTEL_SDK_DISABLED=1            # opentelemetry - crewai
export SOURCEBOT_TELEMETRY_DISABLED=1 # SOURCEBOT
export NEXT_PUBLIC_SOURCEBOT_TELEMETRY_DISABLED=1
export GRADIO_ANALYTICS_ENABLED="False"
export AIDER_ANALYTICS_DISABLE=1
# semgrep metrics are disabled in alias

# history
export HISTSIZE=1000000
export SAVEHIST=1000000

export PROMPT_ROWS=3

# this essentially adds the brew command to the path
export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH

# and this bootstraps homebrew
eval "$(brew shellenv)"

# exports for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# exports for pyenv
eval "$(pyenv init --path)"

# python
export PYTHON_CONFIGURE_OPTS='--enable-shared'
export PYTHONDONTWRITEBYTECODE='tired'
export PYTHONSTARTUP="$HOME/.repl_startup.py"

# common paths
local HOMEBREW_PREFIX="$(brew --prefix)"

export LDFLAGS="-L $HOMEBREW_PREFIX/lib:$LDFLAGS"
export CFLAGS="-I $HOMEBREW_PREFIX/include:$CFLAGS"
export CPPFLAGS="-I $HOMEBREW_PREFIX/include:$CPPFLAGS"

export LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"

export OPENBLAS="$HOMEBREW_PREFIX/opt/openblas"

export LLVM_CONFIG="$(brew --prefix llvm)/bin/llvm-config"
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

export CFLAGS="-falign-functions=8 ${CFLAGS}" # OpenBLAS

export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' --wait"
fi

# local stuff usefull for self on mac
export ICLOUD="$HOME/Library/Mobile Documents"
export CASTRO_SIDELOADS="$ICLOUD/iCloud~co~supertop~castro/Documents/Sideloads"

# remove duplicates
# 'fix-path' is ~/bin/fix-path
export PATH=$(fix-path $PATH)
export LIBRARY_PATH=$(fix-path $LIBRARY_PATH)
export LD_LIBRARY_PATH=$(fix-path $LD_LIBRARY_PATH)

hash -r

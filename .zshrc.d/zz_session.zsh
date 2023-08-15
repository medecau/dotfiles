if [[ -z "$SSH_CONNECTION" ]]; then
    export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
else
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        echo "$fg[magenta]1password SSH agent is disabled."
        echo "$fg[yellow]You are on a SSH connection without a forwarded agent."
        echo "$fg[cyan]If you need to SSH out (ex: git) you need to add the keys manually.$reset_color"
    fi
fi

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

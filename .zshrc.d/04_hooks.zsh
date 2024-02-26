function preexec() {
    export VISIBLE_ROWS=$(($LINES - $PROMPT_ROWS * 2 + 1))
}

function chpwd() {
    # show the old and new directories
    echo "$fg[magenta]- $OLDPWD"
    echo "$fg[cyan]+ $PWD" .. "$reset_color"

    # display a report about the state of the directory
    if [ -d '.git' ]; then
        # reset colors and leave a blank line
        echo "$reset_color"

        # uncommitted changes
        git status --short

        # last commit
        echo "$fg[cyan]$(git log -1 --pretty=format:'%h %s')"
    fi

    # Makefile
    if [ -f 'Makefile' ]; then
        # reset colors and leave a blank line
        echo "$reset_color"

        targets
    fi

    # show the existence of common files
    [ -f 'Dockerfile' ] && echo "$fg[yellow]Dockerfile" .. "$reset_color"
    [ -f 'docker-compose.yml' ] && echo "$fg[yellow]docker-compose.yml" .. "$reset_color"
    [ -d '.venv' ] && echo "$fg[yellow].venv" .. "$reset_color"
    [ -f 'pyproject.toml' ] && echo "$fg[yellow]pyproject.toml" .. "$reset_color"

    # show the 5 most recently modified files
    if [ -n $(find . -maxdepth 1 -type f -print -quit 2>/dev/null) ]; then
        # reset colors and leave a blank line
        echo "$reset_color"

        ls -t | head -5
    fi
}

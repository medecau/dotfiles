function change-to-finder-directory() {
    target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    [ "$target" != "" ] && cd "$target" || echo 'No Finder window found' >&2
}

function copy-file-contents() {
    cat $@ | pbcopy
}

function mkdir_and_cd() {
    mkdir $1
    cd $1
}

function fetch-html-page-and-strip-tags() {
    wget --quiet --output-document - $1 | strip-tags -m
}

# move the file to the Castro iCloud folder
function sideload() {
    mv $1 ~/Library/Mobile\ Documents/iCloud-co-supertop-castro/Documents/Sideloads/
    echo "Sideloaded $1 to Castro - it should be available in the app soon."
}

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

function dfstoggle() {
    if [ -d ~/.dotfiles.git ]; then
        mv ~/.dotfiles.git ~/.git
    elif [ -d ~/.git ]; then
        mv ~/.git ~/.dotfiles.git
    fi
}

# good for testing shell startup time
function timezsh() {
    for i in $(seq 1 10); do
        shell=${1-$SHELL}
        /usr/bin/time $shell -i -c exit
    done
}

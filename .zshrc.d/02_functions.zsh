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
    wget --quiet --output-document - "$1" | strip-tags -m
}

function blog-to-podcast() {
    temp_dir=$(mktemp -d)
    cd $temp_dir

    fetch-html-page-and-strip-tags $1 >blob.txt
    title=$(echo $1 | sed -E 's/.*\/([^\/]+)\/?$/\1/')
    podcastfile=$title.m4a
    fullpath=$temp_dir/$podcastfile

    say --progress -f blob.txt -o audio.aiff

    ffmpeg -stats -i audio.aiff -acodec aac -b:a 128k $podcastfile

    cd -
    mv $fullpath .
    echo $fullpath
}

# move the file to the Castro iCloud folder
function sideload() {
    mv $1 $CASTRO_SIDELOADS
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


function dfstoggle() {
    if [ -d ~/.git.dfs ]; then
        mv ~/.git.dfs ~/.git
    elif [ -d ~/.git ]; then
        mv ~/.git ~/.git.dfs
    fi
}

# good for testing shell startup time
function timezsh() {
    for i in $(seq 1 10); do
        shell=${1-$SHELL}
        /usr/bin/time $shell -i -c exit
    done
}

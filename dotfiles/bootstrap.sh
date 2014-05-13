#!/usr/bin/env bash

filelist=`git ls-files`
blacklist='README.org bootstrap.sh'

function symlink() {
    for fname in  $filelist; do
        if [[ $blacklist =~ $fname ]]; then
            continue
        fi
        echo  $PWD/$fname " -> " "$HOME/.$fname"
        ln -s $PWD/$fname "$HOME/.$fname"
    done
}


if [ "$1" == "--force" -o "$1" == "-f" ]; then
    symlink
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        symlink
    fi
fi

unset symlink

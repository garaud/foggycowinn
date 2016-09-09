#!/usr/bin/env bash

filelist=`git ls-files`
blacklist='README.org bootstrap.sh codeschool.vim fasd_install.sh profiles.clj'

function symlink() {
    for fname in  $filelist; do
        if [[ $blacklist =~ $fname ]]; then
            continue
        fi
        echo  $PWD/$fname " -> " "$HOME/.$fname"
        ln -fs $PWD/$fname "$HOME/.$fname"
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

# Just for the Vim colorscheme codeschool.
if [[ ! -d ~/.vim/colors ]]; then
   mkdir -p ~/.vim/colors
fi
echo $PWD/codeschool.vim "-> ~/.vim/colors/"
ln -fs $PWD/codeschool.vim -t ~/.vim/colors/

# Lein profiles
if [ ! -d ~/.lein ]; then
    mkdir ~/.lein
fi
if [ ! -f ~/.lein/profiles.clj ]; then
    cp profiles.clj ~/.lein/profiles.clj
fi

# External deps.
if [ ! -d ~/.zprezto/ ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# Prompt
echo $PWD/prompt_foggy_setup "-> ~/.zprezto/modules/prompt/functions/"
ln -fs $PWD/prompt_foggy_setup -t $HOME/.zprezto/modules/prompt/functions/

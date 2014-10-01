# -*- mode: sh; -*-

_foggy_packages=${0:h}/packages

if [ ! -d ~/.external-foggy ]; then
    mkdir ~/.external-foggy
fi

cp ${0:h}/init.zsh ~/.external-foggy/

awk  -F' ' '{ system("git clone " $2 " ~/.external-foggy/" $1) }' $_foggy_packages

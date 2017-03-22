#!/bin/bash

# Simple download and install in '~/usr' the upstream version of fasd

PREFIX=$HOME/usr
URL="https://github.com/jocelynmallon/zshmarks"

pushd $HOME/.zprezto/modules
git clone $URL

#!/bin/bash

# need to install the 'fzf' package
# see https://github.com/junegunn/fzf

URL="https://github.com/urbainvaes/fzf-marks"

pushd $HOME/.zprezto/modules
git clone $URL

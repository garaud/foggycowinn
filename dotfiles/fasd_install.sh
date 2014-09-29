#!/bin/bash

# Simple download and install in '~/usr' the upstream version of fasd

PREFIX=$HOME/usr
URL_FASD="https://github.com/clvv/fasd"

pushd /tmp/
git clone $URL_FASD
pushd fasd
PREFIX=$PREFIX make install
popd
popd

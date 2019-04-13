#!/usr/bin/env bash

export TERM="xterm-256color"
EMACS_USER_DIR="~/.emacs.terminal.d"
DISPLAY=
emacs -q --eval "(progn (setq user-emacs-directory \"${EMACS_USER_DIR}\") (setq user-init-file \"${EMACS_USER_DIR}/init.el\"))" -l $EMACS_USER_DIR/init.el $*

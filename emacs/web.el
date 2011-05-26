;; -*- coding: utf-8 -*-
;; Emacs configuration file for Web
;; 2011
;; Author(s): Damien Garaud

;; Loading path.
(add-to-list 'load-path "~/applications/emacs/identica-mode/")

;; For IRC. Do 'M-x erc'.
(require 'erc)

;; Where save logs.
(setq erc-log-channels-directory "~/.erc/logs/")
;; Save when quit.
(setq erc-save-buffer-on-part t)

;; Identica
(require 'identica-mode)
;; (setq identica-username "Username")
;; (setq identica-password "Password")

;; Post from the minibuffer without having an identica buffer active.
(global-set-key "\C-cip" 'identica-update-status-interactive)

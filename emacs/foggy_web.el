;; -*- coding: utf-8 -*-
;; Emacs configuration file for Web
;; 2011-2014
;; Author(s): Damien Garaud

;; For IRC. Do 'M-x erc'.
(require 'erc)

;; Where save logs.
(setq erc-log-channels-directory "~/.erc/logs/")
;; Save when quit.
(setq erc-save-buffer-on-part t)


(setq foggy_dev-loaded t)
(provide 'foggy_web)

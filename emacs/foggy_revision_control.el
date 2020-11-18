;; -*- coding: utf-8 -*-
;; Emacs configuration file for Git and Mercurial.
;; 2011-2014
;; Author(s): Damien Garaud

;;;;;;;;;
;; GIT ;;
;;;;;;;;;

;; Magit.
;(require 'magit)
;(require 'transient)
;(require 'forge)

;(with-eval-after-load 'magit
;  (require 'forge))

(global-set-key "\C-cg" 'magit-status)

;; For Mercurial
(require 'ahg)

;;;;;;;;;;;;;;;
;; Mercurial ;;
;;;;;;;;;;;;;;;

;;(require 'monky)

;; By default monky spawns a seperate hg process for every command.
;; This will be slow if the repo contains lot of changes.
;; if `monky-process-type' is set to cmdserver then monky will spawn a single
;; cmdserver and communicate over pipe.
;; Available only on mercurial versions 1.9 or higher

;;(setq monky-process-type 'cmdserver)


(setq foggy_revision_control-loaded t)
(provide 'foggy_revision_control)

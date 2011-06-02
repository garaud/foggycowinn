;; -*- coding: utf-8 -*-
;; Emacs configuration file for key bindings.
;; 2011
;; Author(s): Damien Garaud

;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL BINDINGS ;;
;;;;;;;;;;;;;;;;;;;;;


(global-unset-key "\C-x\i")
(global-set-key "\C-x\i" 'indent-region)

(global-set-key "\C-x\>" 'comment-region)
(global-set-key "\C-x\<" "\C-u\M-x\comment-region")

(global-set-key [(meta g)] 'goto-line)

(global-set-key [(meta v)] 'fill-region)

;; Deletes a line.
(global-unset-key [(meta r)])
(global-set-key [(meta r)] "\C-a\C-@\C-e\C-f\C-w")

;; Copies a line.
(global-unset-key [(meta s)])
(global-set-key [(meta s)] "\C-a\C-@\C-e\C-f\M-w")

;; Duplication functions (defined below).
(global-set-key [?\C-x up]    'duplicate-line-backward)
(global-set-key [?\C-x down]  'duplicate-line-forward)
(global-set-key [?\C-x right] 'duplicate-region-forward)
(global-set-key [?\C-x left]  'duplicate-region-backward)

;; In order to ease switching between buffers, accepts C-x C-b in addition to
;; the regular C-x b.
(global-unset-key "\C-x\C-b")
(global-set-key "\C-x\C-b" 'switch-to-buffer)

;; In order to ease switching between windows, accepts C-x C-o in addition to
;; the regular C-x o.
(global-unset-key "\C-x\C-o")
(global-set-key "\C-x\C-o" "\C-x\o")

;; In order to ease application of macros, accepts C-x C-e in addition to the
;; regular C-x e.
(global-unset-key "\C-x\C-e")
(global-set-key "\C-x\C-e" 'kmacro-end-and-call-macro)

(global-set-key [(meta j)] 'hippie-expand)

;; Switches to american dictionary.
(global-set-key "\C-cla"   '(lambda () (interactive)
				(ispell-change-dictionary "american")
				(setq ispell-personal-dictionary "~/.ispell-priv-us")))
;; Switches to french dictionary.
(global-set-key "\C-clf"   '(lambda () (interactive)
				(ispell-change-dictionary "francais")
				(setq ispell-personal-dictionary "~/.ispell-priv-fr")))



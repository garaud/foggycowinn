;; -*- coding: utf-8 -*-
;; Emacs configuration file for key bindings.
;; 2011-2014
;; Author(s): Damien Garaud

;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL BINDINGS ;;
;;;;;;;;;;;;;;;;;;;;;

;; Kill current buffer without boring message.
(global-set-key (kbd "C-x k")
                '(lambda () (interactive)
                   (if server-buffer-clients
                       (server-done) (kill-this-buffer))))

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
(global-set-key "\C-clf" '(lambda () (interactive)
                            (ispell-change-dictionary "francais")
                            (setq ispell-personal-dictionary "~/.ispell-priv-fr")))

;; Set the mark-ring to Shift + left
(global-set-key (kbd "<S-left>") (kbd "C-u C-SPC"))

;; Open different symbols of the current buffer (function, class, etc.) with ido.
(global-set-key (kbd "M-i") 'ido-goto-symbol)

;; Search the current word in a TAGS file.
(global-set-key (kbd "C-c w") 'search-word-tags)

;;;;;;;;;;
;; ReST ;;
;;;;;;;;;;

;; Double ticks for monospaced text such as ``something``.
(global-unset-key "\C-xt")
(global-set-key "\C-xt" "````\C-b\C-b")
;; Math syntax in ReST such as :math:`[some equations]`.
(global-unset-key "\C-cm")
(global-set-key "\C-cm" ":math:``\C-b")

;; TODO: I would like allow this keybindings only if rst-mode is used.

;;;;;;;;;;;;;
;; Doxygen ;;
;;;;;;;;;;;;;

;; Insert LaTeX math environment in a Doxygen comment (is defined between
;; '\f$').
(global-set-key "\C-cde" "\\f$\\f$\C-b\C-b\C-b")

;; TODO: I would like allow this keybinding only if doxy-mode is used.

(setq foggy_keybindings-loaded t)
(provide 'foggy_keybindings)

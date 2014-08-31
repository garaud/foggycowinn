;; -*- coding: utf-8 -*-
;; Emacs configuration file for the Emacs look
;; 2011-2014
;; Author(s): Damien Garaud

;; Special emacs launching with X:
;;  - tangotango theme
;;  - scroll bar mode to nil
(if (display-graphic-p)
    (progn
      (load-theme 'tangotango t)
      ((scroll-bar-mode -1))))

(set-default-font "DejaVu Sans Mono-12")

;; Gets rid of the useless tool bar and menu bar.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; No advertisement when Emacs starts.
(setq inhibit-startup-message t)

;; No blinked cursor.
(blink-cursor-mode -1)

;; Show trailing white space.
(setq-default show-trailing-whitespace t)

;; Show empty lines.
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Show time.
(display-time)

;; To select a default font, and windows width and height.
(set-frame-width (selected-frame) 88)
(set-frame-height (selected-frame) 42)

;; 80th column is not be crossed.
(setq-default fill-column 80)

;; Sets default encoding to UTF-8.
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;; Do not run into Abbrev mode.
(setq-default abbrev-mode nil)
(setq save-abbrevs 'silently)

;; Shows the buffer name in window title bar.
(setq frame-title-format "emacs - %b")

;; Highlights as much as possible.
(setq font-lock-maximum-decoration t)
(setq transient-mark-mode t)
;; Highlight the current line.
(if (display-graphic-p)
    (progn
      ((global-hl-line-mode t)
       (set-face-background 'hl-line "#282828"))))
;; For light theme.
;;(set-face-background 'hl-line "#F0F8FF")
;; Shows the column number.
(setq column-number-mode t)
;; Shows the brackets correspondence.
(show-paren-mode 1)
;; Highlights according to the syntax.
(global-font-lock-mode 1)
;; Shows the complains!
(setq visible-bell t)

;; Use to highligt some keywords in these modes.
(setq code-tag-mode-list '(
                          python-mode
                          c++-mode
                          c-mode
                          cmake-mode
                          conf-mode
                          makefile-mode
                          lisp-mode
                          emacs-lisp-mode))

;; TODO: try to pass a 2nd arg as the regexp keywords.
(defun highlight-warning-keyword (mode)
    "Use font-lock-add-keywords to highlight with a 'warning' way
    some specific keywords based on a regexp and a specific mode"
    (font-lock-add-keywords
      mode
      '(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\)" 1 font-lock-warning-face prepend)))
    )

;; Highlight as 'warning' some keywords for a list of modes.
(map 'list (lambda (mode)
             (highlight-warning-keyword mode))
     code-tag-mode-list)

;; For a better naming of the buffers (that is, not filename.txt<2>!).
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; XXX Is there a better way?
;; Conf-mode for 'rc' files.
(add-to-list 'auto-mode-alist '("hgrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".hgrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("vimrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".vimrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".colorgccrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("colorgccrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("todorc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".todorc\\'" . conf-mode))

(setq foggy-look-loaded t)
(provide 'foggy_look)

;; -*- coding: utf-8 -*-
;; Emacs configuration file for the Emacs look
;; 2011-2014
;; Author(s): Damien Garaud

;; Special emacs launching with X:
;;  - tangotango theme
;;  - scroll bar mode to nil
(if (display-graphic-p)
    (progn
      (scroll-bar-mode -1)))

;; (set-frame-font "DejaVu Sans Mono-14")
(set-frame-font "Fira Code-13")
(load-theme 'tangotango t)
;; (load-theme 'leuven t)

;; Gets rid of the useless tool bar and menu bar.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; No advertisement when Emacs starts.
(setq inhibit-startup-message t
      initial-scratch-message nil)

;; No blinked cursor.
(blink-cursor-mode -1)

;; Show trailing white space.
(setq-default show-trailing-whitespace t)

;; Show empty lines.
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Show time.
(setq display-time-24hr-format t)
(display-time)

;; To select a default font, and windows width and height.
;; (set-frame-width (selected-frame) 88)
;; (set-frame-height (selected-frame) 42)

;; 85th column is not be crossed.
(setq-default fill-column 85)

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
      (global-hl-line-mode t)
      ;; (set-face-background 'hl-line "#F0F8FF") ;; light theme
      (set-face-background 'hl-line "#282828")
      ))
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

;; highlight the cursor when scrolling up/down
(beacon-mode 1)
(setq beacon-color "#729fcf")

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

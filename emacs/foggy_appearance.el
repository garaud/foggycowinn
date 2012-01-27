;; -*- coding: utf-8 -*-
;; Emacs configuration file for appearance
;; 2011
;; Author(s): Damien Garaud

;; Loading path.
;;(add-to-list 'load-path "~/applications/emacs/color-theme-tangotango/")
(setq tangotango-path (format "%s/%s" emacs-foggy-package-dir "color-theme-tangotango"))
(add-to-list 'load-path tangotango-path)

;;(set-default-font "9x15")
(set-default-font "8x13")
(set-default-font "Monospace-12")
;; If Emacs 23 is in use, enjoy a great font!
;; (setq running-emacs-23 (> emacs-major-version 22))
;; (if running-emacs-23
;;     (progn
;;       (set-default-font "Monospace-12") ) )

;; Gets rid of the useless tool bar and menu bar.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; No advertisement when Emacs starts.
(setq inhibit-startup-message t)

;; No blinked cursor.
(blink-cursor-mode nil)

;; Show trailing white space.
(setq-default show-trailing-whitespace t)

;; Show time.
(display-time)

;; To select a default font, and windows width and height.
(set-frame-width (selected-frame) 80)
(set-frame-height (selected-frame) 42)

;; Frame maximization.
(defun frame-fullscreen (frame)
  (set-frame-parameter frame 'fullscreen
                       (if (frame-parameter frame 'fullscreen)
                           frame 'fullboth)))
(defun frame-maximize-vertically (frame)
  (set-frame-parameter frame 'fullscreen
                       (if (frame-parameter frame 'fullscreen)
                           frame 'fullheight)))
(defun fullscreen ()
  (interactive)
  (frame-fullscreen nil))
(defun maximize-vertically ()
  (interactive)
  (frame-maximize-vertically nil))
;; Maximizes the window vertically at startup.
(add-hook 'window-setup-hook 'maximize-vertically)
;; Maximizes a new frame vertically at startup.
(add-hook 'after-make-frame-functions 'frame-maximize-vertically)

;; Enables the mouse wheel (for old versions of Emacs).
;; (mouse-wheel-mode)

;; Sets default encoding to UTF-8.
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
;; Except for the keyboard!
(set-keyboard-coding-system 'latin-1)

;; Do not run into Abbrev mode.
(setq-default abbrev-mode nil)
(setq save-abbrevs 'silently)

;; Shows the buffer name in window title bar.
(setq frame-title-format "%b - emacs")

;; Highlights as much as possible.
(setq font-lock-maximum-decoration t)
(setq transient-mark-mode t)
;; Highlight the current line.
(global-hl-line-mode t)
;; For dark theme.
(set-face-background 'hl-line "#282828")
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

;; 80th column is not be crossed.
(setq-default fill-column 80)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; For a better naming of the buffers (that is, not filename.txt<2>!).
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


;; Emacs Goodies
(require 'emacs-goodies-el)
(require 'color-theme)
;;(color-theme-dark-laptop)
;; (color-theme-gnome2)
(require 'color-theme-tangotango)
(color-theme-tangotango)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

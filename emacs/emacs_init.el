;; -*- coding: utf-8 -*-
;; Main Emacs configuration file.
;; 2011-2014
;; Author(s): Damien Garaud

;;;;;;;;;;;;;
;; GENERAL ;;
;;;;;;;;;;;;;

(require 'calendar)

;; Ediff configuration.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Saves the minibuffer history.
(setq savehist-additional-variables
      '(search ring regexp-search-ring kill-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)
;; Saves the locations in the files.
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; In order to get a proper shell mode.
(add-hook 'shell-mode-hook
          'ansi-color-for-comint-mode-on)

;; Changing the case in a whole region is too dangerous, and it therefore
;; disabled.
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;
;; USER INTERFACE ;;
;;;;;;;;;;;;;;;;;;;;

;; In order to completely delete the selected area hitting backspace (DEL).
(delete-selection-mode 1)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Enables C-next.
(put 'scroll-left 'disabled nil)

;; Makes killing/yanking interact with clipboard X11 selection
(setq x-select-enable-clipboard t)

;; Windmove to easily move among windows.
;; (require 'windmove)
;; (windmove-default-keybindings 'meta)

;; 'yes' & 'no' with one character 'y' & 'n'.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Do not ask when I open a symlink pointing to a version controlled file.
(setq vc-follow-symlinks nil)

;; Note: excellent pour passer d'un buffer a l'autre et pour ouvrir des
;; fichiers: Interactively do things.
(ido-mode t)
(setq
 ido-save-directory-list-file "~/.emacs.d/ido.last"
 ido-enable-flex-matching t
 ido-max-prospects 6
 ido-everywhere t)

;; Auto fill-adapt for text-mode.
(setq text-mode-hook 'turn-on-auto-fill)

;; Flyspell mode.
;; (add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))

;; Kill ring management.
;; (require 'browse-kill-ring)
;; (browse-kill-ring-default-keybindings)

;; The Lisp file from Astyle project http://astyle.sourceforge.net/scripts.html
;; with (setq c-default-style "bsd") sets a fine C++ coding convention for me
;; --- brackets, indentation and so on.
(setq astyle-hooks-file (expand-file-name "astyle-hooks.el" emacs-foggy-dir))
;; Do nothing if the file does not exist.
(if (file-exists-p astyle-hooks-file)
    (load astyle-hooks-file))

;; Load
(require 'foggy_functions)
(require 'foggy_look)
(require 'foggy_dev)
(require 'foggy_revision_control)
;;(require 'foggy_latex)
(require 'foggy_orgmode)
(require 'foggy_web)
(require 'foggy_music)
(require 'foggy_keybindings)
(require 'foggy_custom)

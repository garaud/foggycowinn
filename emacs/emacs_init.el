;; -*- coding: utf-8 -*-
;; Main Emacs configuration file.
;; 2011
;; Author(s): Damien Garaud

(add-to-list 'load-path "/home/boubou/applications/emacs/")

;;;;;;;;;;;;;
;; GENERAL ;;
;;;;;;;;;;;;;


;;(set-default-font "9x15")
(set-default-font "8x13")
;; If Emacs 23 is in use, enjoy a great font!
(setq running-emacs-23 (> emacs-major-version 22))
(if running-emacs-23
    (progn
      (set-default-font "Monospace-10") ) )

;; Gets rid of the useless tool bar and menu bar.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; No advertisement when Emacs starts.
(setq inhibit-startup-message t)

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

;; Turns off auto-fill which is inherited from text-mode.
(add-hook 'LaTeX-mode-hook 'turn-off-auto-fill)
;; Activates visual line mode.
(add-hook 'LaTeX-mode-hook (lambda () (visual-line-mode 1)))
;; *Note*: Dans les nouveaux documents LaTeX, ne plus couper les
;; lignes, ne plus faire de M-q non plus. Les lignes n'ont plus de
;; largeur maximale.

;; Shows the buffer name in window title bar.
(setq frame-title-format "%b - emacs")

;; Highlights as much as possible.
(setq font-lock-maximum-decoration t)
(setq transient-mark-mode t)
;; Highlight the current line.
(global-hl-line-mode t)
(set-face-background 'hl-line "#282828")
;; Shows the column number.
(setq column-number-mode t)
;; Shows the brackets correspondence.
(show-paren-mode 1)
;; Highlights according to the syntax.
(global-font-lock-mode 1)
;; Shows the complains!
(setq visible-bell t)

;; 78th column is not be crossed.
(setq-default fill-column 78)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; For a better naming of the buffers (that is, not filename.txt<2>!).
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

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

;; Enables C-next.
(put 'scroll-left 'disabled nil)

;; Windmove to easily move among windows.
(require 'windmove)
(windmove-default-keybindings 'super)


;; Note: excellent pour passer d'un buffer a l'autre et pour ouvrir des
;; fichiers: Interactively do things.
(ido-mode t)
(setq
 ido-save-directory-list-file "~/.emacs.d/ido.last"
 ido-enable-flex-matching t
 ido-max-prospects 6
 ido-everywhere t)

;; Remember.
;;(org-remember-insinuate)
(setq org-remember-templates
      '(("Agenda" ?a "* %?" "~/org/agenda.org" bottom)))
;;         ;; ("Note" ?n "%?" "~/org/note.org" bottom)
;;         ;; ("Répondre" ?r "* TODO Répondre à %a :répondre:\n  %?"
;;         ;;  "~/org/todo.org" bottom)
;;         ;; ("todo" ?t "* TODO %? %^g" "~/org/todo.org" bottom)))
;; Location of the agenda, for org-mode.
(setq org-agenda-files (quote ("~/org/agenda.org"
                               "~/org/todo/work.org"
                               "~/org/todo/home.org")))
;; Diary.
;;(setq org-agenda-include-diary t)
;; Highlight the current line in agenda views.
;;(add-hook 'org-agenda-mode-hook 'highlight-current-line-minor-mode)


;; Kill ring management.
;; (require 'browse-kill-ring)
;; (browse-kill-ring-default-keybindings)


;;;;;;;;;;;;;;;;;;;;;;
;; USEFUL FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;


;; Redefines zap-to-char, and therefore M-z: the argument of the function is
;; not killed anymore.
(defun zap-to-char (arg char)
  "Kill up to (but not including) ARG'th occurrence of CHAR.
Goes backward if ARG is negative; error if CHAR not found."
  (interactive "p\ncZap to char: ")
  (kill-region (point) (progn
                         (search-forward (char-to-string char) nil nil arg)
                         (goto-char (if (> arg 0) (1- (point)) (1+ (point))))
                         (point))))

(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
		     (line-beginning-position)
		     (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n))))

(defun duplicate-region-backward ()
  "If mark is active duplicates the region backward."
  (interactive "*")
  (if mark-active
      
      (let* (
	     (deactivate-mark nil)
	     (start (region-beginning))
	     (end (region-end))
	     (contents (buffer-substring
			start
			end)))
	(save-excursion
	  (goto-char start)
	  (insert contents))
	(goto-char end)
	(push-mark (+ end (- end start))))
    (error "Mark is not active. Region not duplicated."))
  )

(defun duplicate-line-forward ()
  "Duplicate the current line forward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
		     (line-beginning-position)
		     (line-end-position))))
      (end-of-line)
      (insert ?\n contents)))
  (next-line 1))

(defun duplicate-region-forward ()
  "If mark is active duplicates the region forward."
  (interactive "*")
  (if mark-active     
      (let* (
	     (deactivate-mark nil)
	     (start (region-beginning))
	     (end (region-end))
	     (contents (buffer-substring
			start
			end)))
	(save-excursion
	  (goto-char end)
	  (insert contents))
	(goto-char start)
	(push-mark end)
	(exchange-point-and-mark))
    (error "Mark is not active. Region not duplicated."))
  )
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


(defun fullpath-relative-to-current-file (file-relative-path)
  "Returns the full path of FILE-RELATIVE-PATH, relative to file location where this function is called.

Example: If the file that calls fullpath-relative-to-call-location is at:
/Users/xah/web/emacs/emacs_init.el then,
 (fullpath-relative-to-call-location \"xyz.el\")
returns
 /Users/xah/web/emacs/xyz.el

This function solves 2 problems.

 (1) if you have file A, that calls the “load” on a file at B, and
 B calls “load” on file C using a relative path, then Emacs will
 complain about unable to find C. Because, emacs does not switch
 current directory with “load”.

 (2) To know the current file's full path, emacs has 2 ways:
 load-file-name and buffer-file-name.  If the file is loaded by
 “load”, then load-file-name works but buffer-file-name doesn't.
 If the file is called by eval-buffer, then load-file-name is
 nil. You want to be able to get the full path regardless the
 file is run by “load” or interactively by “eval-buffer”."
  (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path)
)

;; Add the dir of this file to load path.
(add-to-list 'load-path (fullpath-relative-to-current-file ""))


;; Load
(load (fullpath-relative-to-current-file "emacs_keybindings.el"))
(load (fullpath-relative-to-current-file "emacs_dev.el"))
(load (fullpath-relative-to-current-file "emacs_git.el"))
(load (fullpath-relative-to-current-file "emacs_latex.el"))
(load (fullpath-relative-to-current-file "emacs_web.el"))

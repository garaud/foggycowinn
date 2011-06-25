;; -*- coding: utf-8 -*-
;; Main Emacs configuration file.
;; 2011
;; Author(s): Damien Garaud

(add-to-list 'load-path "~/applications/emacs/")

;;;;;;;;;;;;;
;; GENERAL ;;
;;;;;;;;;;;;;

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
(load (fullpath-relative-to-current-file "foggy_appearance.el"))
(load (fullpath-relative-to-current-file "foggy_dev.el"))
(load (fullpath-relative-to-current-file "foggy_git.el"))
(load (fullpath-relative-to-current-file "foggy_keybindings.el"))
(load (fullpath-relative-to-current-file "foggy_latex.el"))
(load (fullpath-relative-to-current-file "foggy_orgmode.el"))
(load (fullpath-relative-to-current-file "personal_data.el"))
(load (fullpath-relative-to-current-file "foggy_web.el"))

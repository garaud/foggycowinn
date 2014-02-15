;; -*- coding: utf-8 -*-
;; Main Emacs configuration file.
;; 2011-2014
;; Author(s): Damien Garaud

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

;; Makes killing/yanking interact with clipboard X11 selection
(setq x-select-enable-clipboard t)

;; Windmove to easily move among windows.
(require 'windmove)
(windmove-default-keybindings 'meta)

;; 'yes' & 'no' with one character 'y' & 'n'.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Note: excellent pour passer d'un buffer a l'autre et pour ouvrir des
;; fichiers: Interactively do things.
(ido-mode t)
(setq
 ido-save-directory-list-file "~/.emacs.d/ido.last"
 ido-enable-flex-matching t
 ido-max-prospects 6
 ido-everywhere t)

;; Auto fill-adapt for text-mode.
(setq major-mode 'text-mode)
(setq text-mode-hook 'turn-on-auto-fill)

;; Flyspell mode.
;; (add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))


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

;; From http://www.emacswiki.org/emacs/ImenuMode#toc11 and
;; https://raw.github.com/xaccrocheur/kituu/master/.emacs
(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (cond
   ((not symbol-list)
    (let ((ido-mode ido-mode)
          (ido-enable-flex-matching
           (if (boundp 'ido-enable-flex-matching)
               ido-enable-flex-matching t))
          name-and-pos symbol-names position)
      (unless ido-mode
        (ido-mode 1)
        (setq ido-enable-flex-matching t))
      (while (progn
               (imenu--cleanup)
               (setq imenu--index-alist nil)
               (ido-goto-symbol (imenu--make-index-alist))
               (setq selected-symbol
                     (ido-completing-read "Symbol? " symbol-names))
               (string= (car imenu--rescan-item) selected-symbol)))
      (unless (and (boundp 'mark-active) mark-active)
        (push-mark nil t nil))
      (setq position (cdr (assoc selected-symbol name-and-pos)))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position)))))
   ((listp symbol-list)
    (dolist (symbol symbol-list)
      (let (name position)
        (cond
         ((and (listp symbol) (imenu--subalist-p symbol))
          (ido-goto-symbol symbol))
         ((listp symbol)
          (setq name (car symbol))
          (setq position (cdr symbol)))
         ((stringp symbol)
          (setq name symbol)
          (setq position
                (get-text-property 1 'org-imenu-marker symbol))))
        (unless (or (null position) (null name)
                    (string= (car imenu--rescan-item) name))
          (add-to-list 'symbol-names name)
          (add-to-list 'name-and-pos (cons name position))))))))

;; From http://www.emacswiki.org/emacs/InteractivelyDoThings#toc12
(defun ido-find-file-in-tag-files ()
  "Find files from TAGS file."
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))

;; Load
(require 'foggy_appearance)
(require 'foggy_dev)
(require 'foggy_revision_control)
(require 'foggy_keybindings)
(require 'foggy_latex)
(require 'foggy_orgmode)
(require 'foggy_web)
(require 'foggy_music)

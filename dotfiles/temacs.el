;; -*- mode: emacs-lisp -*-
;; Author: Damien Garaud
;; For emacs in text mode with tiny configuration and some keybindings

;; In an executable file, just:
;;   #!/usr/bin/env bash
;;
;;   DISPLAY=
;;   emacs -q -l ~/.temacs $*


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Personal Emacs configuration file ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list
 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t)

(setq custom-file "~/.emacs.terminal.d/custom.el")
(load-file custom-file)

;; ;;;;;;;;;;;;;
;; ;; General ;;
;; ;;;;;;;;;;;;;

(setq-default abbrev-mode nil)

(setq inhibit-startup-message t)

;;(standard-display-european 1)
(set-input-mode nil nil 1)

;; (setq visible-bell t)
(menu-bar-mode -1)

(setq indent-tabs-mode nil) 
(setq column-number-mode t) 

(setq-default fill-column 78)

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

(show-paren-mode 1)

(global-unset-key "\C-x\i")
(global-set-key "\C-x\i" 'indent-region)

(global-set-key "\C-x\>" 'comment-region)
(global-set-key "\C-x\<" "\C-u\M-x\comment-region")

(global-unset-key "\C-x\g")
(global-set-key "\C-x\g" 'goto-line)

(put 'upcase-region 'disabled nil)
;; (put 'downcase-region 'disabled nil)

(global-unset-key (kbd "<delete>"))
(global-set-key (kbd "<delete>") "\C-d")

(global-set-key [(meta g)] 'goto-line)

(global-set-key [(meta v)] 'fill-region)

(global-unset-key [(meta k)])
(global-set-key [(meta k)] "\C-a\C-@\C-e\C-f\C-w")

(global-unset-key [(meta r)])
(global-set-key [(meta r)] "\C-a\C-@\C-e\C-f\C-w")

(global-unset-key [(meta s)])
(global-set-key [(meta s)] "\C-a\C-@\C-e\C-f\M-w")

(global-set-key [(meta :)]   'hippie-expand)
(global-set-key [(meta j)]   'hippie-expand)

(setq ispell-personal-dictionary "~/.ispell-priv-fr")
(global-set-key "\C-c\C-a"   '(lambda () (interactive)
				(ispell-change-dictionary "american")
				(setq ispell-personal-dictionary "~/.ispell-priv-us")))
(global-set-key "\C-c\C-f"   '(lambda () (interactive)
				(ispell-change-dictionary "francais")
				(setq ispell-personal-dictionary "~/.ispell-priv-fr")))
(global-set-key "\C-c\C-y"   'flyspell-mode)


;; ;;;;;;;;;
;; ;; C++ ;;
;; ;;;;;;;;;

(add-hook 'c++-mode-hook
	  (lambda()
	    (show-paren-mode 1)))

(add-hook 'c++-mode-hook
	  (lambda()
	    (local-set-key "\C-x\>" "\C-c\C-c")))
(add-hook 'c++-mode-hook
	  (lambda()
	    (local-set-key "\C-x\<" "\C-u\C-c\C-c")))


;; ;;;;;;;;;;;;
;; ;; Python ;;
;; ;;;;;;;;;;;;

;; (autoload 'python-mode "~/applications/emacs/python-mode" "Enter Python :-P mode." t)

(add-hook 'python-mode-hook 'turn-on-auto-fill)


;; ;;;;;;;;;;
;; ;; HTML ;;
;; ;;;;;;;;;;

(autoload 'sgml-mode "~/applications/emacs/psgml-1.2.5/psgml" "Enter SGML mode." t)
(setq sgml-indent-data t)


;; ;;;;;;;;;;;;;;;;;;;
;; ;; NEW FUNCTIONS ;;
;; ;;;;;;;;;;;;;;;;;;;

(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
       (line-beginning-position)
       (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n))))
;;  (previous-line 1))

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

(global-set-key [(control x) up]                      'duplicate-line-backward)
(global-set-key [(control x) down]                    'duplicate-line-forward)
(global-set-key [(control x) right]                   'duplicate-region-forward)
(global-set-key [(control x) left]                    'duplicate-region-backward)

(defun zap-to-char (arg char)
  "Kill up to (but not including) ARG'th occurrence of CHAR.
Goes backward if ARG is negative; error if CHAR not found."
  (interactive "p\ncZap to char: ")
  (kill-region (point) (progn
                         (search-forward (char-to-string char) nil nil arg)
                         (goto-char (if (> arg 0) (1- (point)) (1+ (point))))
                         (point))))


(require 'projectile)
;; (require 'virtualenvwrapper)

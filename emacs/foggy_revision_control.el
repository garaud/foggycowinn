;; -*- coding: utf-8 -*-
;; Emacs configuration file for Git and Mercurial.
;; 2011
;; Author(s): Damien Garaud

;;;;;;;;;
;; GIT ;;
;;;;;;;;;

;; Magit.
(require 'magit)
(global-set-key "\C-cg" 'magit-status)


;;;;;;;;;;;;;;;
;; Mercurial ;;
;;;;;;;;;;;;;;;

;;; This version has better chances to run on windows
(setq hg-grep-command "grep --color=always -nH -e ")
(setq hg-grep-tempfile (make-temp-file "grep"))

(defun hg-grep (s)
  (interactive "sSearch project for: ")

  (setq hgroot (car (split-string (shell-command-to-string "hg root") "\n")))
  ;; replace hgroot absolute path with relative path
  ;; this should reduce the line size in the grep buffer
  (setq hgroot (file-relative-name hgroot))
  (setq hgmanifest (split-string (shell-command-to-string "hg manifest")))
  
  (setq cmd (concat hg-grep-command "\"" s "\" `cat " hg-grep-tempfile "`"))
  (setq files "")

  (while (>= (length hgmanifest) 1)
    ;;(setq cmd (concat cmd " " hgroot "/" (car hgmanifest)))
    (setq files (concat files hgroot "/" (car hgmanifest) "\n"))
    (setq hgmanifest (cdr hgmanifest))
    )
  (write-region files nil hg-grep-tempfile)

  ;;(setq c md (concat cmd "| sed -e \"s%" hgroot "%HG%\""))
  (compilation-start cmd 'grep-mode)
)

(defun hg-grep-region (start end)
  (interactive "r")

  (hg-grep (buffer-substring start end))
)
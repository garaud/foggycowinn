;; -*- coding: utf-8 -*-
;; Emacs configuration file for Git and Mercurial.
;; 2011-2014
;; Author(s): Damien Garaud

;;;;;;;;;
;; GIT ;;
;;;;;;;;;

;; Magit.
(require 'magit)
(global-set-key "\C-cg" 'magit-status)

;; For Mercurial
(require 'ahg)

;;;;;;;;;;;;;;;
;; Mercurial ;;
;;;;;;;;;;;;;;;

;;(require 'monky)

;; By default monky spawns a seperate hg process for every command.
;; This will be slow if the repo contains lot of changes.
;; if `monky-process-type' is set to cmdserver then monky will spawn a single
;; cmdserver and communicate over pipe.
;; Available only on mercurial versions 1.9 or higher

;;(setq monky-process-type 'cmdserver)


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

(setq foggy_revision_control-loaded t)
(provide 'foggy_revision_control)

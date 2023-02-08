;; -*- coding: utf-8 -*-
;; Emacs configuration file for downloading & installing some packages.
;; 2014
;; Hugely inspired from https://github.com/kaushalmodi/.emacs.d/blob/master/setup-packages.el

;; Package management
;; Loading of packages at startup
;; XXX File tO remove ?

(defun prepend-path ( my-path )
  (setq load-path (cons (expand-file-name my-path) load-path)))

(defun append-path ( my-path )
  (setq load-path (append load-path (list (expand-file-name my-path)))))

(prepend-path emacs-foggy-dir)
;; (prepend-path (concat user-emacs-directory "/setup-files"))

;; create the elpa directory if it doesn't exist
(setq elpa-dir (concat emacs-foggy-dir "/elpa"))
(unless (file-exists-p elpa-dir)
  (make-directory elpa-dir))

;; add all subdirectories under elpa to the load-path
(let ((default-directory (concat emacs-foggy-dir "/elpa")))
  (normal-top-level-add-subdirs-to-load-path))

(require 'cl)
(require 'package)

(package-initialize) ;; Load emacs packages and activate them

;; Auto install the required packages
;; Source: https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el
;; Source: http://toumorokoshi.github.io/emacs-from-scratch-part-2-package-management.html
;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in foggy-packages-list
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p foggy-packages-list)
    (when (not (package-installed-p p))
      (package-install p))))


(provide 'setup-packages)

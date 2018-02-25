;; -*- coding: utf-8 -*-
;; Emacs configuration file for org-mode
;; 2011-2015
;; Author(s): Damien Garaud

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Location of the agenda, for org-mode.
;; (setq org-directory "~/org/todo")
;; (setq org-agenda-files (quote ("~/org/todo/work.org"
;;                                "~/org/todo/home.org")))
;; (setq org-capture-templates
;;       '(("t" "Todo" entry
;;          (file+headline "~/org/todo/tiny-tasks.org" "Tasks")
;;          "* TODO %?\n  %i\n  %a")
;;         ("j" "Journal Entry" plain
;;          (file+datetree "~/org/journal.org")
;;          "%U\n\n%?" :empty-lines-before 1)))

;; Diary.
(setq org-agenda-include-diary t)
;; Highlight the current line in agenda views.
;; (add-hook 'org-agenda-mode-hook 'highlight-current-line-minor-mode)

;; Display date when a task is done.
(setq org-log-done t)

;; Enable highlight code syntax in code block.
(setq org-src-fontify-natively t)

;; Use to highlight the code blocks for HTML exporting.
(require 'htmlize)

;; org-babel
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

;; Agenda.
(define-key global-map "\C-ca" 'org-agenda)
;; Remember.
(define-key global-map "\C-cc" 'org-capture)

(define-key global-map "\C-cL" 'org-store-link)

(setq foggy_orgmode-loaded t)
(provide 'foggy_orgmode)

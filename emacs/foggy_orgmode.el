;; -*- coding: utf-8 -*-
;; Emacs configuration file for org-mode
;; 2011
;; Author(s): Damien Garaud

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

;; Display date when a task is done.
(setq org-log-done t)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

;; Agenda.
(define-key global-map "\C-ca" 'org-agenda)
;; Remember.
(define-key global-map "\C-cr" 'org-remember)

(define-key global-map "\C-cL" 'org-store-link)

;; -*- coding: utf-8 -*-
;; Emacs configuration file for development
;; 2011
;; Author(s): Damien Garaud

;; Loading path.
(add-to-list 'load-path "~/applications/emacs/")
(add-to-list 'load-path "~/applications/emacs/zencoding/")


;;;;;;;;;;;;
;; PYTHON ;;
;;;;;;;;;;;;

;; Damien G.: some python has not been tested yet. That's why there are a few
;; commented lines.

(require 'python-mode)

;; Set Python mode for SConsctruct file
(add-to-list 'auto-mode-alist '("\\SConstruct*" . python-mode))

;; TODO: test and clean up all stuff about Python.

;;(require 'ipython)
;;(setq py-python-command-args '( "--colors" "Linux"))

;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")

;; (defadvice py-execute-buffer (around python-keep-focus activate)
;;   "Thie advice to make focus python source code after execute command `py-execute-buffer'."
;;   (let ((remember-window (selected-window))
;;         (remember-point (point)))
;;     ad-do-it
;;     (select-window remember-window)
;;     (goto-char remember-point)))

;; (defun rgr/python-execute()
;;   (interactive)
;;   (if mark-active
;;       (py-execute-string (buffer-substring-no-properties (region-beginning) (region-end)))
;;     (py-execute-buffer)))

;; (global-set-key (kbd "C-c C-e") 'rgr/python-execute)

;; (add-hook 'python-mode-hook
;;           '(lambda () (eldoc-mode 1)) t)

;; (provide 'python-programming)

;; (require 'anything-ipython)
;; (add-hook 'python-mode-hook #'(lambda ()
;;                                 (define-key py-mode-map (kbd "M-<RET>") 'anything-ipython-complete)))
;; (add-hook 'ipython-shell-hook #'(lambda ()
;;                                   (define-key py-mode-map (kbd "M-<RET>") 'anything-ipython-complete)))
;; ;;
;; ;; If you want to use anything-show-completion.el,(facultative)
;; ;; <http://www.emacswiki.org/cgi-bin/emacs/anything-show-completion.el>
;; ;; add these lines:
;; ;;
;; (when (require 'anything-show-completion nil t)
;;   (use-anything-show-completion 'anything-ipython-complete
;;                                 '(length initial-pattern)))


;;;;;;;;;;;
;; C/C++ ;;
;;;;;;;;;;;

;; I want to have a C++ mode even for *.h files.
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

;; The Lisp file from Astyle project http://astyle.sourceforge.net/scripts.html
;; with (setq c-default-style "bsd") sets a fine C++ coding convention for me
;; --- brackets, indentation and so on. Do nothing if the file does not exist.
(setq astyle-file (fullpath-relative-to-current-file "astyle-hooks.el"))
(if (file-exists-p astyle-file) (load astyle-file))


;; TODO Clean up all this stuff.

;; (defun my-c-mode-hook ()
;;   ;; style
;;   (setq c-basic-offset 4)
;;   (setq default-tab-width 4)
;; )
;; (add-hook 'c++-mode-hook 'my-c-mode-hook)

;;(setq default-tab-width 4)

;;(setq c-default-style "mine")

;; Special option for April.
;; (defun april-c++-mode ()
  ;;(interactive)
  ;;(add-hook 'before-save-hook 'delete-trailing-whitespace t t)
  ;; (setq c-basic-offset 4)
  ;; (setq c-offsets-alist
  ;;       '((statement-block-intro . +))
  ;;       '((substatement-open . 0))
  ;;       '((substatement-label . 0))
  ;;       '((label . 0))
  ;;       '((statement-cont . +))
  ;;       ;;'((innamespace . -))
  ;;       '((inline-open . 0))
  ;;       '((template-args-cont . +))
  ;;       )
  ;;(setq c-default-style "mine")
;; c-set-offset 'substatement-open 0)
  ;;(setq c-default-style "gnu"
  ;;(setq default-tab-width 4)
;;  )
;; (defun april-c++-mode-hook ()
;;   (if (string-match "april" buffer-file-name)
;;       (april-c++-mode)))
;;(add-hook 'c++-mode-hook 'april-c++-mode-hook)

;; (c-add-style
;;  "mine"
;;  (quote
;;   (
;;    (c-basic-offset . 4)
;;    (statement-block-intro . 0)
;;    (substatement-open . -)
;;    (substatement-label . 0)
;;    (label . 0)
;;    (statement-cont . +)
;;    (innamespace . -)
;;    (inline-open . 0)
;;    (template-args-cont . +)
;;  )))
;; (setq c-default-style "mine")
;;(setq c-default-style "stroustrup")


;;;;;;;;;;;;;;;
;; Zencoding ;;
;;;;;;;;;;;;;;;
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;;;;;;;;;;
;;  ECB  ;;
;;;;;;;;;;;
;;(require 'ecb)

;;;;;;;;;;;;;
;; DOXYGEN ;;
;;;;;;;;;;;;;

;; Par ailleurs, il y a aussi un mode mineur pour Doxygen: Ce mode sert à
;; insérer rapidement des commentaires Doxygen (C-c d C-h).
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
(if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
   (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(setq-default doxymacs-doxygen-style "Qt")


;;;;;;;;;
;; GDB ;;
;;;;;;;;;

;; Use the gdb debugging tool with 'M-x gdb'.

;; Open many windows when you launch 'gdb'.
(setq gdb-many-windows t)

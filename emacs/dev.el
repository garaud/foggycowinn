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


;;;;;;;;;;;;;;;
;; Zencoding ;;
;;;;;;;;;;;;;;;
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;;;;;;;;;;
;;  ECB  ;;
;;;;;;;;;;;
(require 'ecb)

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

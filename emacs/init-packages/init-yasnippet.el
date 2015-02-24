(yas-global-mode 1)

;; Disable yasnippet in Lisp and REPL Slime major modes.
(add-hook 'lisp-mode-hook
	  '(lambda () (yas-minor-mode 0)))
(add-hook 'slime-repl-mode-hook
	  '(lambda () (yas-minor-mode 0)))

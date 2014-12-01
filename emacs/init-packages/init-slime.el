(setq inferior-lisp-program "/usr/bin/sbcl")
(eval-after-load "slime"
  '(progn
     (define-key slime-parent-map (kbd "M-,") nil)
     (define-key slime-mode-map (kbd "M-n") nil)
     (define-key slime-mode-map (kbd "C-c d") 'slime-documentation)
     (define-key slime-mode-map (kbd "C-j") 'slime-eval-print-last-expression)))



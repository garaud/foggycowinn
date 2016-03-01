(add-to-list 'load-path "~/.emacs.d/el-get/slime")
(require 'slime-autoloads)
(add-to-list 'slime-contribs 'slime-fancy)

(setq slime-backend
      "~/.emacs.d/el-get/slime/swank-loader.lisp")

(setq inferior-lisp-program "/usr/bin/sbcl")
(eval-after-load "slime"
  '(progn
     (slime-setup '(slime-fancy slime-autodoc slime-indentation slime-banner))
     (setq slime-complete-symbol*-fancy t)
     (define-key slime-parent-map (kbd "M-,") nil)
     (define-key slime-mode-map (kbd "M-n") nil)
     (define-key slime-mode-map (kbd "C-c d") 'slime-documentation)
     (define-key slime-mode-map (kbd "C-j") 'slime-eval-print-last-expression)))

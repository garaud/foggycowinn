(require 'smartparens-config)
(smartparens-global-mode)

;; The '' pair will autopair UNLESS the point is right after a word,
;; in which case you want to insert a single apostrophe.
(sp-pair "'" nil :unless '(sp-point-after-word-p))

(defvar sp--bracket-modes '(js-mode
			    sh-mode)
  "list of modes which use bracket to define sexp")
(sp-with-modes sp--bracket-modes
  (sp-local-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair "[" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

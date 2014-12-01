(require 'smartparens-config)


(sp-with-modes '(python-mode rst-mode text-mode)
  ;; disable ', it's the quote character!
  (sp-local-pair "'" nil :actions nil))

(defvar sp--bracket-modes '(js-mode
			    sh-mode)
  "list of modes which use bracket to define sexp")
(sp-with-modes sp--bracket-modes
  (sp-local-pair "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
  (sp-local-pair "[" nil :post-handlers '((my-create-newline-and-enter-sexp "RET"))))
(smartparens-global-mode)

(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

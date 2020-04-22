(require 'string-inflection)

;; permet de passer (en cycle) à des noms de variables
;;   underscore -> UPCASE -> CamelCase ->
;; exemple:
;;  emacs_lisp => EMACS_LISP => EmacsLisp => emacs_lisp

;; default
(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)

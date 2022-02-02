(require 'lsp-metals)

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(setq lsp-metals-treeview-show-when-views-received t)

;; Metals claims to support range formatting by default but it supports range
;; formatting of multiline strings only. You might want to disable it so that emacs
;; can use indentation provided by scala-mode.
(setq lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
;; (add-hook 'scala-mode-hook #'lsp)

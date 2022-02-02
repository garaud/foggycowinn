(require 'scala-mode)

(add-to-list 'interpreter-mode-alist '("scala" . scala-mode))

(add-hook 'scala-mode-hook #'company-mode)

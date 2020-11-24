(require 'py-isort)

;; https://github.com/paetzke/py-isort.el
(add-hook 'before-save-hook 'py-isort-before-save)
(setq py-isort-options '("--line-width=120" "--length-sort"))

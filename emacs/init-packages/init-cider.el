(require 'cider)

(setq cider-overlays-use-font-lock t)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

;; use company-mode completion
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

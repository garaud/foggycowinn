(require 'cider)

(setq cider-overlays-use-font-lock t)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

(require 'cider)

(setq cider-auto-mode t)
(setq cider-overlays-use-font-lock t)

;; it's quite strange but cider-mode is not enable by default when I open an .clj file
(add-hook 'clojure-mode-hook #'cider-mode)

;; use company-mode completion
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
;; also use eldoc
(add-hook 'cider-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

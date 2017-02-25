(require 'smart-mode-line)

(setq sml/no-confirm-load-theme t)
(setq rm-blacklist (mapconcat 'identity (list "\\w-?" "\\ca")  "\\|"))
(setq sml/theme 'respectful)
(sml/setup)

(require 'flycheck)

(setq flycheck-textlint-config "~/.config/textlint/textlintrc.json")
(setq flycheck-markdown-markdownlint-cli-config "~/.config/markdownlint/markdownlint.json")

;; Tune the error list display
;; https://www.flycheck.org/en/latest/user/error-list.html#tune-error-list-display
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.30)))

(global-flycheck-mode)

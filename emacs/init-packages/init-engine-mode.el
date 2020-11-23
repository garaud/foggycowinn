(require 'engine-mode)
(engine-mode t)


(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")

(defengine github
  "https://github.com/search/?ref=simplesearch&q=%s"
  :keybinding "g")

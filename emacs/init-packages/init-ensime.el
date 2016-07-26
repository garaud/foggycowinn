(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-mode)
(setq exec-path (append exec-path (list (concat (getenv "HOME") "/usr/bin"))))

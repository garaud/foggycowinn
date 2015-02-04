(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
;; ignore special buffer (i.e. starting with *)
(setq uniquify-ignore-buffers-re "^\\*")


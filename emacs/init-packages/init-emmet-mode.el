(require 'emmet-mode)

(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(setq emmet-move-cursor-between-quotes t)
(setq emmet-indentation 2)

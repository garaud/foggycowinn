(require 'shell-pop)

(setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
(setq shell-pop-term-shell "/bin/zsh")
;; need to do this manually or not picked up by `shell-pop'
(shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type)

;; See also http://pragmaticemacs.com/emacs/pop-up-a-quick-shell-with-shell-pop/

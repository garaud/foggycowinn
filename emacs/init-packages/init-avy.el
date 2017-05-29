(require 'avy)

(setq avy-background t)
(setq avy-keys '(?f ?j ?d ?k ?s ?l ?q ?m))
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

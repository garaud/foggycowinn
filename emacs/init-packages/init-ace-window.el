(require 'ace-window)

;; (setq aw-keys '(?f ?j ?d ?k ?s ?l ?q ?m))
(setq aw-dispatch-always t)
(global-set-key (kbd "M-p") 'ace-window)
(global-set-key [remap other-window] 'ace-window)

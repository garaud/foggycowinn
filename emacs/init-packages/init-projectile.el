
(require 'projectile)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; indexing method. Projectile will use the VCS itself to obtain the list of files.
;; (setq projectile-indexing-method 'alien)
(setq projectile-indexing-method 'hybrid)

;; sort files by recently opened
(setq projectile-sort-order 'recentf)


(projectile-mode +1)

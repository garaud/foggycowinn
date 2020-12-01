(require 'dashboard)
(require 'dashboard-widgets)

(setq dashboard-items '((recents  . 8)
 			(projects . 8)
 			(agenda . 5)
  			(bookmarks . 5)
 			(registers . 5)))

(setq dashboard-week-agenda t)
(setq dashboard-startup-banner 'logo)
(setq dashboard-projects-backend 'projectile)
(setq dashboard-set-navigator t)
(setq dashboard-set-init-info t)
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(dashboard-setup-startup-hook)

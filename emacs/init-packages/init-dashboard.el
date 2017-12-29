(require 'dashboard)
(dashboard-setup-startup-hook)

(setq dashboard-items '((recents  . 5)
                        (projects . 5)
			(bookmarks . 5)
                        (agenda . 5)
			(registers . 5)))

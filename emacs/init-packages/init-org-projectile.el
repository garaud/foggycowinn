(require 'org-projectile)

(setq org-projectile-projects-file "/home/dag/doc/work/tasks/projects.org")
(push (org-projectile-project-todo-entry) org-capture-templates)
(setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
(global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read)

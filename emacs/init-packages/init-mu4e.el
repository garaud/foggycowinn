(require 'mu4e)

(setq mu4e-org-contacts-file  "~/doc/work/contacts.org")
;(add-to-list 'mu4e-headers-actions
;             '("org-contact-add" . mu4e-action-add-org-contact) t)
;(add-to-list 'mu4e-view-actions
;             '("org-contact-add" . mu4e-action-add-org-contact) t)
;; You have to install 'html2text' command
(setq mu4e-html2text-command "html2text -utf8 -width 72")

;; Multiple cursors
(require 'multiple-cursors)
;; On an active region with multiple lines add a cursor to each line:
;; NOTE: 'C-S-c' means 'C-MAJ-c'
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; Add multiple cursors based on a keyword in the buffer (first set-mark your
;; keyword, then 'C->').
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

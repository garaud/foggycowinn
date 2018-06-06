(require 'highlight-indentation)

(set-face-background 'highlight-indentation-face "#424848")
(set-face-background 'highlight-indentation-current-column-face "#424848")

;; source https://stackoverflow.com/questions/1587972/how-to-display-indentation-guides-in-emacs/4459159#4459159
(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key [(C tab)] 'aj-toggle-fold)

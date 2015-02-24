;; custom color for company popup
(require 'color)
(defun setup-company-color ()
  "customize company popup color (called by make-frame hook)"
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip
       ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg
       ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg
       ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection
       ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common
       ((t (:inherit font-lock-constant-face)))))))

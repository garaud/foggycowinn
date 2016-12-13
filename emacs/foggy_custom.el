;; -*- coding: utf-8 -*-
;; Emacs configuration file for custom variables
;; 2014
;; Author(s): Damien Garaud

(require 'color)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 ;; Avoid highlight by smartparens (aka sp)
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay nil)
 '(sp-highlight-wrap-tag-overlay nil))

;; Globally inherits from my theme for company colors.
;; Inspired from https://github.com/noprompt/matilde/blob/master/emacs.d/noprompt-theme.el
(defun set-company-faces ()
  (let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip
     ((t (:inherit default :background ,(color-lighten-name bg 5)))))
   `(company-scrollbar-bg
     ((t (:background ,(color-lighten-name bg 10)))))
   `(company-scrollbar-fg
     ((t (:background ,(color-lighten-name bg 2)))))
   `(company-tooltip-selection
     ((t :inherit font-lock-function-name-face)))
   `(company-tooltip-common
     ((t :inherit font-lock-constant-face)))
   )))

(set-company-faces)

(setq foggy-custom-loaded t)
(provide 'foggy_custom)

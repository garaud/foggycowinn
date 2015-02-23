;; -*- coding: utf-8 -*-
;; Emacs configuration file for custom variables
;; 2014
;; Author(s): Damien Garaud

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

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
(custom-theme-set-faces
 'tangotango
 ;; Keep the color but change the default size (was 1.5 and 1.2 resp.).
 `(org-level-1 ((t (:bold t :foreground "dodger blue" :height 1.0))))
 `(org-level-2 ((t (:bold t :foreground "#edd400" :height 1.0))))
 ;; For Company
 `(company-tooltip ((t :background "lightgray" :foreground "black")))
 `(company-tooltip-selection ((t :background "steelblue" :foreground "white")))
 `(company-tooltip-mouse ((t :background "blue" :foreground "white")))
 `(company-tooltip-common ((t :background "lightgray" :foreground "black")))
 `(company-tooltip-common-selection ((t t :background "lightgray" :foreground "black")))
 `(company-scrollbar-fg ((t :background "black")))
 `(company-scrollbar-bg ((t :background "gray")))
 `(company-preview ((t :background nil :foreround "darkgray")))
 `(company-preview-common ((t :background nil :foreround "darkgray"))))
)

(setq foggy-custom-loaded t)
(provide 'foggy_custom)

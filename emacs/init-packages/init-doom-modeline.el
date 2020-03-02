(require 'doom-modeline)

(setq doom-modeline-height 25)
(setq doom-modeline-bar-width 8)
(setq doom-modeline-window-width-limit 120)
;; (window-width)

;; Whether display the icon for `major-mode'. Respects `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)

;; Whether display the colorful icon for `major-mode'.
;; Respects `doom-modeline-major-mode-icon'.
(setq doom-modeline-major-mode-color-icon t)

;; Whether display the buffer encoding.
(setq doom-modeline-buffer-encoding nil)

;; Whether display the indentation information.
(setq doom-modeline-indent-info nil)

;; If non-nil, only display one number for checker information if applicable.
(setq doom-modeline-checker-simple-format nil)

(setq doom-modeline-vcs-max-length 20)

;; Whether display the perspective name. Non-nil to display in the mode-line.
(setq doom-modeline-persp-name t)

;; If non nil the default perspective name is displayed in the mode-line.
(setq doom-modeline-display-default-persp-name t)

;; Whether display the mu4e notifications. It requires `mu4e-alert' package.
(setq doom-modeline-mu4e t)

;; Whether display the modification icon for the buffer.
;; Respects `doom-modeline-icon' and `doom-modeline-buffer-state-icon'.
(setq doom-modeline-buffer-modification-icon t)

(doom-modeline-mode 1)

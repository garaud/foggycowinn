
(require 'swiper)
(require 'counsel)
;(require 'ivy-rich)
(ivy-mode 1)


(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; the default without counsel-M-x to "^"
(setq ivy-initial-inputs-alist
      '((org-refile . "^")
        (org-agenda-refile . "^")
        (org-capture-refile . "^")
        (counsel-describe-function . "^")
        (counsel-describe-variable . "^")
        (man . "^")
        (woman . "^")))
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

(global-set-key "\C-s" 'swiper-isearch)
(global-set-key "\C-x\b" 'ivy-switch-buffer)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c f") 'counsel-git) ;; find file in the git repo
(global-set-key (kbd "C-c k") 'counsel-ag)

;(ivy-rich-mode 1)

(require 'company)
;; remove ropemacs from company-backends list
(setq company-backends
      (cl-loop for i in company-backends
	       when (not (eq i 'company-ropemacs)) collect i))
(add-to-list 'company-backends 'company-anaconda)
(add-hook 'python-mode-hook 'company-mode)

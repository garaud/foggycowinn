(add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'eldoc-mode)

(global-unset-key [(meta r)])
(global-set-key [(meta r)] "\C-a\C-@\C-e\C-f\C-w")

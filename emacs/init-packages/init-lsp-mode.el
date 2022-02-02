(require 'lsp-mode)
(require 'lsp-modeline)

(setq lsp-enable-links nil)

 (setq lsp-completion-provider :capf)

;; https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.1
      company-minimum-prefix-length 3)

(with-eval-after-load 'lsp-mode
  (require 'lsp-pylsp)
  (require 'lsp-java)
  (add-to-list 'lsp-enabled-clients 'pylsp)
  (add-to-list 'lsp-enabled-clients 'metals)
  (add-to-list 'lsp-enabled-clients 'java)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'scala-mode-hook #'lsp)
  (add-hook 'java-mode-hook #'lsp)
  (add-hook 'lsp-mode-hook #'lsp-lens-mode))

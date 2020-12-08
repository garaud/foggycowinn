(require 'pyenv-mode)

(defvar customized-pyenv-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-p") 'pyenv-mode-set)
    (define-key map (kbd "C-c C-u") 'pyenv-mode-unset)
    map)
  "Keymap for pyenv-mode.")

(setcdr (assoc 'pyenv-mode minor-mode-map-alist) customized-pyenv-mode-map)

(add-hook 'python-mode-hook 'pyenv-mode)

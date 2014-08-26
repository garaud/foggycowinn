;; -*- coding: utf-8 -*-
;; Emacs configuration file for development
;; 2011-2014
;; Author(s): Damien Garaud

;; Company (auto completion).
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-anaconda) ;; Python completion

;; Yasnippet.
(yas-global-mode 1)

;; Multiple cursors
(require 'multiple-cursors)
;; On an active region with multiple lines add a cursor to each line:
;; NOTE: 'C-S-c' means 'C-MAJ-c'
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; Add multiple cursors based on a keyword in the buffer (first set-mark your
;; keyword, then 'C->').
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;;;;;;;;;;
;; YAML ;;
;;;;;;;;;;

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
;; Unlike python-mode, this mode follows the Emacs convention of not binding the
;; ENTER key to `newline-and-indent'.  To get this behavior, add the key
;; definition to `yaml-mode-hook':
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;;;;;;;;;;;
;; Jinja2 ;;
;;;;;;;;;;;;

(require 'jinja2-mode)
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))


;;;;;;;;;;;;
;; PYTHON ;;
;;;;;;;;;;;;

;; **NOTE**
;; Prefer python.el (instead of python-mode). python-mode manages docstring and
;; triple quotes very badly.

;; Linum mode with Python.
(add-hook 'python-mode-hook 'linum-mode)

;; Automatic indent after 'RET'
(add-hook 'python-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

;; Set Python mode for SConsctruct file
(add-to-list 'auto-mode-alist '("\\SConstruct" . python-mode))

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

;; Cython mode
;; (add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
;; (add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
;; (add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))


;;;;;;;;;;;
;; C/C++ ;;
;;;;;;;;;;;

;; I want to have a C++ mode even for *.h files.
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

;; Linum mode for C++
(add-hook 'c++-mode-hook 'linum-mode)

;; Semantic mode for C++.
(add-hook 'c++-mode-hook 'semantic-mode)

(if (file-exists-p astyle-hooks-file)
    (setq c-default-style "bsd"))

;; Write a cout-c++-like for a specific variable.
(defun cppout ()
  "Write a c++ output of the current word."
  (interactive)
  (setq cword (current-word))
  (setq content (format "cout << \"%s: \" << %s << endl;" cword cword))
  (end-of-line 1)
  (newline)
  (beginning-of-line 1)
  (insert content)
)


;;;;;;;;;;;;;
;;  CMake  ;;
;;;;;;;;;;;;;

;; CMake mode.
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))


;;;;;;;;;
;; Lua ;;
;;;;;;;;;

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))


;;;;;;;;;;;;;
;; DOXYGEN ;;
;;;;;;;;;;;;;

;; Par ailleurs, il y a aussi un mode mineur pour Doxygen: Ce mode sert à
;; insérer rapidement des commentaires Doxygen (C-c d C-h).
;; XXX Seems to be not maintained. See SO
;; http://stackoverflow.com/questions/11324752/emacs-c-c-doxygen-alternative-to-doxymacs-with-yasnippet
;; TODO Maybe can use yasnippet instead.
;; (require 'doxymacs)
;; (add-hook 'c-mode-common-hook 'doxymacs-mode)
;; (defun my-doxymacs-font-lock-hook ()
;; (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;    (doxymacs-font-lock)))
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
;; (setq-default doxymacs-doxygen-style "Qt")


;;;;;;;;;
;; GDB ;;
;;;;;;;;;

;; Use the gdb debugging tool with 'M-x gdb'.
;; Open many windows when you launch 'gdb'.
(setq gdb-many-windows t)


(setq foggy_dev-loaded t)
(provide 'foggy_dev)

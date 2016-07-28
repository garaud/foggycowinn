;; -*- coding: utf-8 -*-
;; Emacs configuration file for development
;; 2011-2014
;; Author(s): Damien Garaud


;; sh-mode for zsh extension.:
(add-to-list 'auto-mode-alist '("\\.zsh$" . sh-mode))

;;;;;;;;;;
;; Lisp ;;
;;;;;;;;;;

;; Emacs Lisp autocompletion with company
(add-hook 'emacs-lisp-mode-hook 'company-mode)

(add-hook 'lisp-mode-hook '(lambda ()
                             (slime-mode 1)
                             (slime-autodoc-mode 1)))

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


;;;;;;;;;;
;; Rust ;;
;;;;;;;;;;

(require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))

;;;;;;;;;;;
;;  SQL  ;;
;;;;;;;;;;;

(eval-after-load "sql"
  (load-library "sql-indent"))


;;;;;;;;;;;;;;;;
;; Javascript ;;
;;;;;;;;;;;;;;;;

(setq js-indent-level 2)

;;;;;;;;;;;;
;; PYTHON ;;
;;;;;;;;;;;;

;; **NOTE**
;; Prefer python.el (instead of python-mode). python-mode manages docstring and
;; triple quotes very badly.

;; Automatic indent after 'RET'
(add-hook 'python-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

;; Set Python mode for SConsctruct file
(add-to-list 'auto-mode-alist '("\\SConstruct" . python-mode))

;; Cython mode
;; (add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
;; (add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
;; (add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))


;;;;;;;;;;;
;; C/C++ ;;
;;;;;;;;;;;

;; I want to have a C++ mode even for *.h files.
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

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


;; add line number in specific mode
(cl-map 'list (lambda (mode-hook)
                (add-hook mode-hook 'linum-mode))
        '(js-mode-hook
          rust-mode-hook
          sh-mode-hook
          python-mode-hook
          lisp-mode-hook
          scala-mode-hook
          haskell-mode-hook
          c++-mode-hook
          clojure-mode-hook
          emacs-lisp-mode-hook))

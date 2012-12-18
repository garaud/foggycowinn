;; -*- coding: utf-8 -*-
;; Emacs configuration file for development
;; 2011
;; Author(s): Damien Garaud

;; Loading path.
(setq zencoding-path (format "%s/%s" emacs-foggy-package-dir "zencoding"))
(add-to-list 'load-path zencoding-path)

;; Loading for lua-mode.
(setq lua-mode-path (format "%s/%s" emacs-foggy-package-dir "lua-mode"))
(add-to-list 'load-path lua-mode-path)

;; Loading for yaml-mode.
(setq yaml-mode-path (format "%s/%s" emacs-foggy-package-dir "yaml-mode"))
(add-to-list 'load-path yaml-mode-path)

;; Loading for jinja2-mode.
(setq jinja-mode-path (format "%s/%s" emacs-foggy-package-dir "jinja2-mode"))
(add-to-list 'load-path jinja-mode-path)

;; Loading for Auto-complete.
(setq auto-complete-path (format "%s/%s" emacs-foggy-package-dir "auto-complete"))
(add-to-list 'load-path auto-complete-path)
(require 'auto-complete-config)
(setq ac-dict-path (format "%s/%s" emacs-foggy-package-dir "auto-complete/ac-dict"))
(add-to-list 'ac-dictionary-directories ac-dict-path)
(ac-config-default)


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

;; Damien G.: some python has not been tested yet. That's why there are a few
;; commented lines.

;; **NOTE**
;; Prefer python.el (instead of python-mode). python-mode manages docstring and
;; triple quotes very badly.

;; Set Python mode for SConsctruct file
(add-to-list 'auto-mode-alist '("\\SConstruct" . python-mode))

;; Cython mode
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))


(defun cython-compile ()
  "Compile the file via Cython."
  (interactive)
  (let ((cy-buffer (current-buffer)))
    (with-current-buffer
        (compile compile-command)
      (set (make-local-variable 'cython-buffer) cy-buffer)
      (add-to-list (make-local-variable 'compilation-finish-functions)
                   'cython-compilation-finish)))
  )

(defun cython-compilation-finish (buffer how)
  "Called when Cython compilation finishes."
  ;; XXX could annotate source here
  )

(defvar cython-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Will inherit from `python-mode-map' thanks to define-derived-mode.
    (define-key map "\C-c\C-c" 'cython-compile)
    map)
  "Keymap used in `cython-mode'.")

(defvar cython-font-lock-keywords
  `(;; new keywords in Cython language
    (,(regexp-opt '("by" "cdef" "cimport" "cpdef" "ctypedef" "enum" "except?"
                    "extern" "gil" "include" "nogil" "property" "public"
                    "readonly" "struct" "union" "DEF" "IF" "ELIF" "ELSE") 'words)
     1 font-lock-keyword-face)
    ;; C and Python types (highlight as builtins)
    (,(regexp-opt '("NULL" "bint" "char" "dict" "double" "float" "int" "list"
                    "long" "object" "Py_ssize_t" "short" "size_t" "void") 'words)
     1 font-lock-builtin-face)
    ;; cdef is used for more than functions, so simply highlighting the next
    ;; word is problematic. struct, enum and property work though.
    ("\\<\\(?:struct\\|enum\\)[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"
     1 py-class-name-face)
    ("\\<property[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"
     1 font-lock-function-name-face))
  "Additional font lock keywords for Cython mode.")

(define-derived-mode cython-mode python-mode "Cython"
  "Major mode for Cython development, derived from Python mode.

\\{cython-mode-map}"
  (setcar font-lock-defaults
          (append python-font-lock-keywords cython-font-lock-keywords))
  (set (make-local-variable 'compile-command)
       (concat "cython -a " buffer-file-name))
  (add-to-list (make-local-variable 'compilation-finish-functions)
               'cython-compilation-finish)
)


;; TODO: test and clean up all stuff about Python.

;;(require 'ipython)
;;(setq py-python-command-args '( "--colors" "Linux"))

;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")

;; (defadvice py-execute-buffer (around python-keep-focus activate)
;;   "Thie advice to make focus python source code after execute command `py-execute-buffer'."
;;   (let ((remember-window (selected-window))
;;         (remember-point (point)))
;;     ad-do-it
;;     (select-window remember-window)
;;     (goto-char remember-point)))

;; (defun rgr/python-execute()
;;   (interactive)
;;   (if mark-active
;;       (py-execute-string (buffer-substring-no-properties (region-beginning) (region-end)))
;;     (py-execute-buffer)))

;; (global-set-key (kbd "C-c C-e") 'rgr/python-execute)

;; (add-hook 'python-mode-hook
;;           '(lambda () (eldoc-mode 1)) t)

;; (provide 'python-programming)

;; (require 'anything-ipython)
;; (add-hook 'python-mode-hook #'(lambda ()
;;                                 (define-key py-mode-map (kbd "M-<RET>") 'anything-ipython-complete)))
;; (add-hook 'ipython-shell-hook #'(lambda ()
;;                                   (define-key py-mode-map (kbd "M-<RET>") 'anything-ipython-complete)))
;; ;;
;; ;; If you want to use anything-show-completion.el,(facultative)
;; ;; <http://www.emacswiki.org/cgi-bin/emacs/anything-show-completion.el>
;; ;; add these lines:
;; ;;
;; (when (require 'anything-show-completion nil t)
;;   (use-anything-show-completion 'anything-ipython-complete
;;                                 '(length initial-pattern)))


;;;;;;;;;;;
;; C/C++ ;;
;;;;;;;;;;;

;; I want to have a C++ mode even for *.h files.
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

;; The Lisp file from Astyle project http://astyle.sourceforge.net/scripts.html
;; with (setq c-default-style "bsd") sets a fine C++ coding convention for me
;; --- brackets, indentation and so on. Do nothing if the file does not exist.
(setq astyle-file (fullpath-relative-to-current-file "astyle-hooks.el"))
(if (file-exists-p astyle-file) (load astyle-file))

;; Write a cout-c++-like for a specific variable.
(defun cppout (name)
  "Write a c++ output with 'name'."
  (interactive "s")
  (setq content (format "cout << \"%s: \" << %s << endl;" name name))
  (end-of-line 1)
  (newline)
  (beginning-of-line 1)
  (insert content)
)

;; TODO Clean up all this stuff.

;; (defun my-c-mode-hook ()
;;   ;; style
;;   (setq c-basic-offset 4)
;;   (setq default-tab-width 4)
;; )
;; (add-hook 'c++-mode-hook 'my-c-mode-hook)

;;(setq default-tab-width 4)

;;(setq c-default-style "mine")

;; Special option for April.
;; (defun april-c++-mode ()
  ;;(interactive)
  ;;(add-hook 'before-save-hook 'delete-trailing-whitespace t t)
  ;; (setq c-basic-offset 4)
  ;; (setq c-offsets-alist
  ;;       '((statement-block-intro . +))
  ;;       '((substatement-open . 0))
  ;;       '((substatement-label . 0))
  ;;       '((label . 0))
  ;;       '((statement-cont . +))
  ;;       ;;'((innamespace . -))
  ;;       '((inline-open . 0))
  ;;       '((template-args-cont . +))
  ;;       )
  ;;(setq c-default-style "mine")
;; c-set-offset 'substatement-open 0)
  ;;(setq c-default-style "gnu"
  ;;(setq default-tab-width 4)
;;  )
;; (defun april-c++-mode-hook ()
;;   (if (string-match "april" buffer-file-name)
;;       (april-c++-mode)))
;;(add-hook 'c++-mode-hook 'april-c++-mode-hook)

;; (c-add-style
;;  "mine"
;;  (quote
;;   (
;;    (c-basic-offset . 4)
;;    (statement-block-intro . 0)
;;    (substatement-open . -)
;;    (substatement-label . 0)
;;    (label . 0)
;;    (statement-cont . +)
;;    (innamespace . -)
;;    (inline-open . 0)
;;    (template-args-cont . +)
;;  )))
;; (setq c-default-style "mine")
;;(setq c-default-style "stroustrup")

;;;;;;;;;;;;;
;;  CMake  ;;
;;;;;;;;;;;;;

;; CMake mode.
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))


;;;;;;;;;;;;;;;
;; Zencoding ;;
;;;;;;;;;;;;;;;
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;;;;;;;;;;
;;  ECB  ;;
;;;;;;;;;;;
;;(require 'ecb)

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
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
(if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
   (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(setq-default doxymacs-doxygen-style "Qt")


;;;;;;;;;
;; GDB ;;
;;;;;;;;;

;; Use the gdb debugging tool with 'M-x gdb'.

;; Open many windows when you launch 'gdb'.
(setq gdb-many-windows t)

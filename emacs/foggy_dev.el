;; -*- coding: utf-8 -*-
;; Emacs configuration file for development
;; 2011-2014
;; Author(s): Damien Garaud

;; Auto Complete
(require 'auto-complete-config)
(ac-config-default)

;; Yasnippet.
(yas-global-mode 1)

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

;; Linum mode with Python.
(add-hook 'python-mode-hook 'linum-mode)

;; Rope (via ropemacs) & pymacs.
;;(require 'pymacs)
;; (pymacs-load "ropemacs")
;;(pymacs-load "ropemacs" "rope-")

;; Jedi setup.
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys t)
;; (setq jedi:complete-on-dot t)

;; Automatic indent after 'RET'
(add-hook 'python-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

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

;; Linum mode for C++
(add-hook 'c++-mode-hook 'linum-mode)

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

(defun search-word-tags ()
  "Search the current word in tags via 'tags-apropos'."
  (interactive)
  ;; Try to be clever than that.
  ;;   - case sensitive REGEXP
  (setq case-fold-search nil) ;; or 't' does not seem work to put the word in apropos REGEXP case sensitive.
  ;; Match with 'class|def word(' for instance (case insensitive for now).
  ;; Take a look at a TAGS file.
  (tags-apropos (concat "[^_]\\<" (current-word) "\\>\("))
)

;;;;;;;;;;;;;
;;  CMake  ;;
;;;;;;;;;;;;;

;; CMake mode.
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))


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
;; XXX Seems to be not maintained. See SO
;; http://stackoverflow.com/questions/11324752/emacs-c-c-doxygen-alternative-to-doxymacs-with-yasnippet
;; TODO Maybe can use yasnippet instead.
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


(setq foggy_dev-loaded t)
(provide 'foggy_dev)

;; add el-get to load-path
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(defun prepend-path ( my-path )
  (setq load-path (cons (expand-file-name my-path) load-path)))

(defun append-path ( my-path )
  (setq load-path (append load-path (list (expand-file-name my-path)))))

;; Foggydir in load path.
(prepend-path emacs-foggy-dir)

;; download el-get if necessary
(unless (require 'el-get nil t)
  (with-current-buffer
     (url-retrieve-synchronously
      "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
   (goto-char (point-max))
   (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; directory of code to init el-get packages
(setq el-get-user-package-directory (concat emacs-foggy-dir "/init-packages"))

(require 'package)
;; Add melpa package source when using package list
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(require 'el-get-elpa)
;; Build the El-Get copy of the package.el packages if we have not
;; built it before.  Will have to look into updating later ...
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

;; init package management with elpa (i.e. call init-package.el)
(el-get 'sync 'package)

(setq el-get-sources
      '((:name org-projectile
	       :type github
	       :depends (projectile)
               :website "https://github.com/IvanMalison/org-projectile"
               :description " Manage org-mode TODOs for your projectile projects"
	       :pkgname "IvanMalison/org-projectile")
	(:name ibuffer :type builtin)
	(:name tangotango
	       :type github
               :website "https://github.com/juba/color-theme-tangotango"
               :description "Tango theme for emacs"
               :prepare (add-to-list 'custom-theme-load-path default-directory)
	       :pkgname "juba/color-theme-tangotango")
	(:name ubiquify :type builtin)
	(:name libmpdel
	       :type github
	       :website "https://github.com/mpdel/libmpdel"
	       :pkgname "mpdel/libmpdel")
	(:name mpdel
	       :type github
	       :webiste "https://github.com/mpdel/mpdel"
	       :pkgname "mpdel/mpdel")
	(:name python-pytest
	       :type github
               :website "https://github.com/wbolster/emacs-python-pytest"
               :description "Run pytest inside Emacs"
	       :depends (projectile dash magit-popup)
	       :pkgname "wbolster/emacs-python-pytest")
        (:name blacken
               :type github
               :website "https://github.com/proofit404/blacken"
               :description "Python Black for Emacs"
               :pkgname "proofit404/blacken")
	))

(el-get 'sync '(org-mode))
(el-get 'sync
	(append (cl-mapcar #'(lambda (recipe) (cl-getf recipe :name))
			   el-get-sources)
		foggy-packages-list))

(provide 'setup-el-get)

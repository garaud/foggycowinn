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

;; init package management with elpa (i.e. call init-package.el)
(el-get 'sync 'package)

(require 'el-get-elpa)
;; Build the El-Get copy of the package.el packages if we have not
;; built it before.  Will have to look into updating later ...
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

(setq el-get-sources
      '((:name ibuffer :type builtin)
	(:name tangotango
	       :type github
               :website "https://github.com/juba/color-theme-tangotango"
               :description "Tango theme for emacs"
               :prepare (add-to-list 'custom-theme-load-path default-directory)
	       :pkgname "juba/color-theme-tangotango")
	(:name ubiquify :type builtin)
	))

(el-get 'sync
	(append (cl-mapcar #'(lambda (recipe) (cl-getf recipe :name))
			   el-get-sources)
		foggy-packages-list))

(provide 'setup-el-get)

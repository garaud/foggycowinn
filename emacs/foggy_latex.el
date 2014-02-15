;; -*- coding: utf-8 -*-
;; Emacs configuration file for LaTeX
;; 2011-2014
;; Author(s): Damien Garaud

;;;;;;;;;;;
;; LATEX ;;
;;;;;;;;;;;

;; AUCTeX.
(require 'tex-site)
(load "preview-latex")

;; Reference mode.
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; Turns off auto-fill which is inherited from text-mode.
(add-hook 'LaTeX-mode-hook 'turn-off-auto-fill)
;; Activates visual line mode.
(add-hook 'LaTeX-mode-hook (lambda () (visual-line-mode 1)))
;; *Note*: Dans les nouveaux documents LaTeX, ne plus couper les
;; lignes, ne plus faire de M-q non plus. Les lignes n'ont plus de
;; largeur maximale.

;; Use PDFLaTeX.
(setq TeX-PDF-mode 1)

;; C-o inserts "{}".
(add-hook 'LaTeX-mode-hook
	  '(lambda()
	     (local-set-key "\C-o" 'TeX-insert-braces)))

;; C-q inserts a macro.
(add-hook 'LaTeX-mode-hook
	  '(lambda()
	     (local-set-key "\C-q" 'TeX-insert-macro)))

;; French "guillemets": \og{}\fg{}.
(global-unset-key "\C-x\g")
(global-set-key "\C-x\g" "\\og{}\\fg{}\C-b\C-b\C-b\C-b\C-b")

;; Adds a compilation option that includes "--shell-escape".
(eval-after-load "tex" 
  '(add-to-list 'TeX-command-list 
		'("Escape" "pdflatex --shell-escape -interaction=nonstopmode %t"
		  TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))


;; Sets evince as the default viewer for DVI and PDF, and Konqueror for HTML.
(defcustom TeX-output-view-style
  `(("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$")
     "%(o?)dvips -t landscape %d -o && gv %f")
    ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f")
    ("^dvi$" (,(concat
		"^" (regexp-opt '("a4paper" "a4dutch" "a4wide" "sem-a4")) "$")
	      "^landscape$")
     "%(o?)kdvi %dS -paper a4r -s 0 %d")
    ("^dvi$" ,(concat
	       "^" (regexp-opt '("a4paper" "a4dutch" "a4wide" "sem-a4")) "$")
     "%(o?)kdvi %dS -paper a4 %d")
    ("^dvi$" (,(concat "^" (regexp-opt '("a5paper" "a5comb")) "$")
	      "^landscape$")
     "%(o?)kdvi %dS -paper a5r -s 0 %d")
    ("^dvi$" ,(concat "^" (regexp-opt '("a5paper" "a5comb")) "$")
     "%(o?)kdvi %dS -paper a5 %d")
    ("^dvi$" "^b5paper$" "%(o?)kdvi %dS -paper b5 %d")
    ("^dvi$" "^letterpaper$" "%(o?)kdvi %dS -paper us %d")
    ("^dvi$" "^legalpaper$" "%(o?)kdvi %dS -paper legal %d")
    ("^dvi$" "^executivepaper$" "%(o?)kdvi %dS -paper 7.25x10.5in %d")
    ("^dvi$" "." "%(o?)kdvi %dS %d")
    ("^pdf$" "." "evince %o %(outpage)")
    ("^html?$" "." "konqueror %o"))
  "List of output file extensions and view options.

If the first element (a regular expresion) matches the output
file extension, and the second element (a regular expression)
matches the name of one of the style options, any occurrence of
the string `%V' in a command in `TeX-command-list' will be
replaced with the third element.  The first match is used; if no
match is found the `%V' is replaced with `%v'.  The outcome of `%v'
is determined by the settings in `TeX-view-style' which therefore
serves as a fallback for `TeX-output-view-style'.  The second
element may also be a list of regular expressions, in which case
all the regular expressions must match for the element to apply."
  :group 'TeX-command
  :type '(repeat (group
		  (regexp :tag "Extension")
		  (choice regexp (repeat :tag "List" regexp))
		  (string :tag "Command"))))

(setq foggy_latex-loaded t)
(provide 'foggy_latex)

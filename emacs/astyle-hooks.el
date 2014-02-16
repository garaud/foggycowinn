;; Set Formatting Style  ##################################
;; set these options for testing
;; Emacs defaults for c-default-style is (java-mode, "java") (awk-mode, "awk") (other, "gnu")

;; set style for testing
;; use  "bsd"  "java"  "k&r"  "stroustrup"  "whitesmith"  "banner"  "gnu"  "linux"   "horstmann"
(setq c-default-style "horstmann")

;; set these options to "yes" or "no"
(setq indent-namespaces "no")
(setq indent-classes "no")

;; Define Additional Styles #########################################

;; add banner style - copy whitesmith style
;; the switch brace must be attached or the case statement will have an extra indent
(c-add-style "banner" 
	'("whitesmith" 
		(c-offsets-alist
			(case-label . +)))
	)  ;; end c-add-style

;; add horstmann style - copy bsd style
(c-add-style "horstmann" 
	'("bsd" 
		(c-offsets-alist
			(case-label . +)))
	)  ;; end c-add-style

;; Emacs options for ALL styles and languages #######################
; set Emacs variables to Artistic Style default styles

(defun set-common-options ()
	"options for ALL styles and languages"

	;; don't mix tab and space indents
	(setq indent-tabs-mode nil)

	;; don't change alignment of C type comments (fixes problem in JEdit)
	(c-set-offset 'c 'c-lineup-dont-change)

	;; align a continued string under the one it continues
	(c-set-offset 'statement-cont 'c-lineup-string-cont)

	;; align or indent after an assignment operator 
	(c-set-offset 'statement-cont 'c-lineup-math)

	;; align closing brace/paren with opening brace/paren
	(c-set-offset 'arglist-close 'c-lineup-close-paren)
	(c-set-offset 'brace-list-close 'c-lineup-close-paren)

	;; align current argument line with opening argument line 
	(c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist)

	;; don't change indent of java 'throws' statement in method declaration
	;;     and other items after the function argument list
	(c-set-offset 'func-decl-cont 'c-lineup-dont-change)

	)  ;; end set-common-options

;; AStyle C++ Mode Hook #############################################
;; convert Emacs default styles to Artistic Style default styles

(defun astyle-c++-mode-hook ()
	(message "Using astyle-c++-mode-hook and %s style." c-default-style)
 
 	(set-common-options)
	
	;; set basic offset to AStyle default indent
	(setq c-basic-offset 4)
	(if (string-match c-default-style "stroustrup")
		(setq c-basic-offset 5))
	(if (string-match c-default-style "gnu")
		(setq c-basic-offset 2))
	(if (string-match c-default-style "linux")
		(setq c-basic-offset 8))
	(if (string-match c-default-style "horstmann")
		(setq c-basic-offset 3))
		
	;; always unindent C++ class access labels for java style
	(if (string-match c-default-style "java")
		(c-set-offset  'access-label -4))

	;; set to NOT Indent Namespaces
	(if (string-match indent-namespaces "no")
		(progn
			(c-set-offset  'namespace-open 0)
			(c-set-offset  'namespace-close 0)
			(c-set-offset  'innamespace 0)))

	;; set to Indent Classes for bsd, java, k&r, and stroustrup
	(if (string-match indent-classes "yes")
		(progn
			(c-set-offset  'class-open 0)
			(c-set-offset  'class-close 0)
			(c-set-offset  'inclass 8)))
			
	;; set to Indent Classes for gnu
	(if (and (string-match indent-classes "yes")
			(string-match c-default-style "gnu"))
		(progn
			(c-set-offset  'class-open 0)
			(c-set-offset  'class-close 0)
			(c-set-offset  'inclass 4)))
			
	;; set to Indent Classes for linux
	(if (and (string-match indent-classes "yes")
			(string-match c-default-style "linux"))
		(progn
			(c-set-offset  'class-open 0)
			(c-set-offset  'class-close 0)
			(c-set-offset  'inclass 16)))

	;; set to Indent Classes for whitesmith
	;; always set regardless of "indent-classes" option
	(if (string-match c-default-style "whitesmith")
		(progn
			(c-set-offset  'class-open 4)
			(c-set-offset  'class-close 4)
			(c-set-offset  'inclass 4)))

	;; set to Indent Classes for banner
	;; always set regardless of "indent-classes" option
	(if (string-match c-default-style "banner")
		(progn
			(c-set-offset  'class-open 4)
			(c-set-offset  'class-close 4)
			(c-set-offset  'inclass 8)))

	)  ;; end astyle-c-mode-hook
(add-hook 'c-mode-hook 'astyle-c++-mode-hook)
(add-hook 'c++-mode-hook 'astyle-c++-mode-hook)


;; AStyle Java Mode Hook ############################################
;; convert Emacs default styles to Artistic Style default styles

;; indent-namespaces and indent-classes have no effect in java
(defun astyle-java-mode-hook ()
	(message "Using astyle-java-mode-hook and %s style." c-default-style)

	(set-common-options)
	
	;; set basic offset to AStyle default indent
	(setq c-basic-offset 4)
	(if (string-match c-default-style "stroustrup")
		(setq c-basic-offset 5))
	(if (string-match c-default-style "gnu")
		(setq c-basic-offset 2))
	(if (string-match c-default-style "linux")
		(setq c-basic-offset 8))
	(if (string-match c-default-style "horstmann")
		(setq c-basic-offset 3))
		
		;; no extra indent on these inline brackets
	(if (or (string-match c-default-style "k&r")
			(string-match c-default-style "stroustrup")
			(string-match c-default-style "linux"))
		(c-set-offset 'inline-open  0))

	)  ;; end astyle-java-mode-hook
(add-hook 'java-mode-hook 'astyle-java-mode-hook)


;; AStyle C# Mode Hook ##############################################
;; convert Emacs default styles to Artistic Style default styles
;; C# requires the csharp-mode.el file from Moonfire Games 
;; ( http://mfgames.com/linux/csharp-mode )

(defun astyle-csharp-mode-hook ()
	(message "Using astyle-csharp-mode-hook and %s style." c-default-style)

	;; set options here in case csharp-mode.el is autoloaded
	(set-common-options)

	;; set basic offset to AStyle default indent
	(setq c-basic-offset 4)
	(if (string-match c-default-style "stroustrup")
		(setq c-basic-offset 5))
	(if (string-match c-default-style "gnu")
		(setq c-basic-offset 2))
	(if (string-match c-default-style "linux")
		(setq c-basic-offset 8))
	(if (string-match c-default-style "horstmann")
		(setq c-basic-offset 3))
		
	;; set to NOT Indent Namespaces
	(if (string-match indent-namespaces "no")
		(progn
			(c-set-offset  'namespace-open 0)
			(c-set-offset  'namespace-close 0)
			(c-set-offset  'innamespace 0)))

	)  ;; end astyle-csharp-mode-hook
(add-hook 'csharp-mode-hook 'astyle-csharp-mode-hook)

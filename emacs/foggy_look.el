;; -*- coding: utf-8 -*-
;; Emacs configuration file for the Emacs look
;; 2011-2014
;; Author(s): Damien Garaud

;; Special emacs launching with X:
;;  - tangotango theme
;;  - scroll bar mode to nil
(if (display-graphic-p)
    (progn
      (scroll-bar-mode -1)))

;;(set-frame-font "DejaVu Sans Mono-14")
(set-frame-font "Fira Code-14")
(load-theme 'tangotango t)
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))

;; tips for FiraCode ligature
;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
            `(,(car regex-char-pair)
              (0 (prog1 ()
                   (compose-region (match-beginning 1)
                                   (match-end 1)
                                   ;; The first argument to concat is a string containing a literal tab
                                   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
          '(("\\(www\\)"                   #Xe100)
            ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
            ("\\(\\*\\*\\*\\)"             #Xe102)
            ("\\(\\*\\*/\\)"               #Xe103)
            ("\\(\\*>\\)"                  #Xe104)
            ("[^*]\\(\\*/\\)"              #Xe105)
            ("\\(\\\\\\\\\\)"              #Xe106)
            ("\\(\\\\\\\\\\\\\\)"          #Xe107)
            ("\\({-\\)"                    #Xe108)
            ("\\(\\[\\]\\)"                #Xe109)
            ("\\(::\\)"                    #Xe10a)
            ("\\(:::\\)"                   #Xe10b)
            ("[^=]\\(:=\\)"                #Xe10c)
            ("\\(!!\\)"                    #Xe10d)
            ("\\(!=\\)"                    #Xe10e)
            ("\\(!==\\)"                   #Xe10f)
            ("\\(-}\\)"                    #Xe110)
            ("\\(--\\)"                    #Xe111)
            ("\\(---\\)"                   #Xe112)
            ("\\(-->\\)"                   #Xe113)
            ("[^-]\\(->\\)"                #Xe114)
            ("\\(->>\\)"                   #Xe115)
            ("\\(-<\\)"                    #Xe116)
            ("\\(-<<\\)"                   #Xe117)
            ("\\(-~\\)"                    #Xe118)
            ("\\(#{\\)"                    #Xe119)
            ("\\(#\\[\\)"                  #Xe11a)
            ("\\(##\\)"                    #Xe11b)
            ("\\(###\\)"                   #Xe11c)
            ("\\(####\\)"                  #Xe11d)
            ("\\(#(\\)"                    #Xe11e)
            ("\\(#\\?\\)"                  #Xe11f)
            ("\\(#_\\)"                    #Xe120)
            ("\\(#_(\\)"                   #Xe121)
            ("\\(\\.-\\)"                  #Xe122)
            ("\\(\\.=\\)"                  #Xe123)
            ("\\(\\.\\.\\)"                #Xe124)
            ("\\(\\.\\.<\\)"               #Xe125)
            ("\\(\\.\\.\\.\\)"             #Xe126)
            ("\\(\\?=\\)"                  #Xe127)
            ("\\(\\?\\?\\)"                #Xe128)
            ("\\(;;\\)"                    #Xe129)
            ("\\(/\\*\\)"                  #Xe12a)
            ("\\(/\\*\\*\\)"               #Xe12b)
            ("\\(/=\\)"                    #Xe12c)
            ("\\(/==\\)"                   #Xe12d)
            ("\\(/>\\)"                    #Xe12e)
            ("\\(//\\)"                    #Xe12f)
            ("\\(///\\)"                   #Xe130)
            ("\\(&&\\)"                    #Xe131)
            ("\\(||\\)"                    #Xe132)
            ("\\(||=\\)"                   #Xe133)
            ("[^|]\\(|=\\)"                #Xe134)
            ("\\(|>\\)"                    #Xe135)
            ("\\(\\^=\\)"                  #Xe136)
            ("\\(\\$>\\)"                  #Xe137)
            ("\\(\\+\\+\\)"                #Xe138)
            ("\\(\\+\\+\\+\\)"             #Xe139)
            ("\\(\\+>\\)"                  #Xe13a)
            ("\\(=:=\\)"                   #Xe13b)
            ("[^!/]\\(==\\)[^>]"           #Xe13c)
            ("\\(===\\)"                   #Xe13d)
            ("\\(==>\\)"                   #Xe13e)
            ("[^=]\\(=>\\)"                #Xe13f)
            ("\\(=>>\\)"                   #Xe140)
            ("\\(<=\\)"                    #Xe141)
            ("\\(=<<\\)"                   #Xe142)
            ("\\(=/=\\)"                   #Xe143)
            ("\\(>-\\)"                    #Xe144)
            ("\\(>=\\)"                    #Xe145)
            ("\\(>=>\\)"                   #Xe146)
            ("[^-=]\\(>>\\)"               #Xe147)
            ("\\(>>-\\)"                   #Xe148)
            ("\\(>>=\\)"                   #Xe149)
            ("\\(>>>\\)"                   #Xe14a)
            ("\\(<\\*\\)"                  #Xe14b)
            ("\\(<\\*>\\)"                 #Xe14c)
            ("\\(<|\\)"                    #Xe14d)
            ("\\(<|>\\)"                   #Xe14e)
            ("\\(<\\$\\)"                  #Xe14f)
            ("\\(<\\$>\\)"                 #Xe150)
            ("\\(<!--\\)"                  #Xe151)
            ("\\(<-\\)"                    #Xe152)
            ("\\(<--\\)"                   #Xe153)
            ("\\(<->\\)"                   #Xe154)
            ("\\(<\\+\\)"                  #Xe155)
            ("\\(<\\+>\\)"                 #Xe156)
            ("\\(<=\\)"                    #Xe157)
            ("\\(<==\\)"                   #Xe158)
            ("\\(<=>\\)"                   #Xe159)
            ("\\(<=<\\)"                   #Xe15a)
            ("\\(<>\\)"                    #Xe15b)
            ("[^-=]\\(<<\\)"               #Xe15c)
            ("\\(<<-\\)"                   #Xe15d)
            ("\\(<<=\\)"                   #Xe15e)
            ("\\(<<<\\)"                   #Xe15f)
            ("\\(<~\\)"                    #Xe160)
            ("\\(<~~\\)"                   #Xe161)
            ("\\(</\\)"                    #Xe162)
            ("\\(</>\\)"                   #Xe163)
            ("\\(~@\\)"                    #Xe164)
            ("\\(~-\\)"                    #Xe165)
            ("\\(~=\\)"                    #Xe166)
            ("\\(~>\\)"                    #Xe167)
            ("[^<]\\(~~\\)"                #Xe168)
            ("\\(~~>\\)"                   #Xe169)
            ("\\(%%\\)"                    #Xe16a)
            ;; ("\\(x\\)"                   #Xe16b) This ended up being hard to do properly so i'm leaving it out.
            ("[^:=]\\(:\\)[^:=]"           #Xe16c)
            ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
            ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
          #'add-fira-code-symbol-keywords)

;; Gets rid of the useless tool bar and menu bar.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; No advertisement when Emacs starts.
(setq inhibit-startup-message t
      initial-scratch-message nil)

;; No blinked cursor.
(blink-cursor-mode -1)

;; Show trailing white space.
(setq-default show-trailing-whitespace t)

;; Show empty lines.
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Show time.
(setq display-time-24hr-format t)
(display-time)

;; To select a default font, and windows width and height.
;; (set-frame-width (selected-frame) 88)
;; (set-frame-height (selected-frame) 42)

;; 85th column is not be crossed.
(setq-default fill-column 85)

;; Sets default encoding to UTF-8.
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;; Do not run into Abbrev mode.
(setq-default abbrev-mode nil)
(setq save-abbrevs 'silently)

;; Shows the buffer name in window title bar.
(setq frame-title-format "emacs - %b")

;; Highlights as much as possible.
(setq font-lock-maximum-decoration t)
(setq transient-mark-mode t)
;; Highlight the current line.
(if (display-graphic-p)
    (progn
      (global-hl-line-mode t)
      (set-face-background 'hl-line "#282828")))
;; For light theme.
;;(set-face-background 'hl-line "#F0F8FF")
;; Shows the column number.
(setq column-number-mode t)
;; Shows the brackets correspondence.
(show-paren-mode 1)
;; Highlights according to the syntax.
(global-font-lock-mode 1)
;; Shows the complains!
(setq visible-bell t)

;; highlight the cursor when scrolling up/down
(beacon-mode 1)
(setq beacon-color "#729fcf")

;; Use to highligt some keywords in these modes.
(setq code-tag-mode-list '(
                          python-mode
                          c++-mode
                          c-mode
                          cmake-mode
                          conf-mode
                          makefile-mode
                          lisp-mode
                          emacs-lisp-mode))

;; TODO: try to pass a 2nd arg as the regexp keywords.
(defun highlight-warning-keyword (mode)
    "Use font-lock-add-keywords to highlight with a 'warning' way
    some specific keywords based on a regexp and a specific mode"
    (font-lock-add-keywords
      mode
      '(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\)" 1 font-lock-warning-face prepend)))
    )

;; Highlight as 'warning' some keywords for a list of modes.
(cl-map 'list (lambda (mode) (highlight-warning-keyword mode))
        code-tag-mode-list)

;; XXX Is there a better way?
;; Conf-mode for 'rc' files.
(add-to-list 'auto-mode-alist '("hgrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".hgrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("vimrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".vimrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".colorgccrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("colorgccrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("todorc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".todorc\\'" . conf-mode))

(setq foggy-look-loaded t)
(provide 'foggy_look)

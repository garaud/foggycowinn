;; -*- coding: utf-8 -*-
;; Emacs functions used in my Emacs configuration.
;; 2014
;; Author(s): Damien Garaud

(require 'calendar)
(require 'cal-iso)


;; Redefines zap-to-char, and therefore M-z: the argument of the function is
;; not killed anymore.
(defun zap-to-char (arg char)
  "Kill up to (but not including) ARG'th occurrence of CHAR.
Goes backward if ARG is negative; error if CHAR not found."
  (interactive "p\ncZap to char: ")
  (kill-region (point) (progn
                         (search-forward (char-to-string char) nil nil arg)
                         (goto-char (if (> arg 0) (1- (point)) (1+ (point))))
                         (point))))

(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
		     (line-beginning-position)
		     (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n))))

(defun duplicate-region-backward ()
  "If mark is active duplicates the region backward."
  (interactive "*")
  (if mark-active

      (let* (
	     (deactivate-mark nil)
	     (start (region-beginning))
	     (end (region-end))
	     (contents (buffer-substring
			start
			end)))
	(save-excursion
	  (goto-char start)
	  (insert contents))
	(goto-char end)
	(push-mark (+ end (- end start))))
    (error "Mark is not active. Region not duplicated."))
  )

(defun duplicate-line-forward ()
  "Duplicate the current line forward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
		     (line-beginning-position)
		     (line-end-position))))
      (end-of-line)
      (insert ?\n contents)))
  (next-line 1))

(defun duplicate-region-forward ()
  "If mark is active duplicates the region forward."
  (interactive "*")
  (if mark-active
      (let* (
	     (deactivate-mark nil)
	     (start (region-beginning))
	     (end (region-end))
	     (contents (buffer-substring
			start
			end)))
	(save-excursion
	  (goto-char end)
	  (insert contents))
	(goto-char start)
	(push-mark end)
	(exchange-point-and-mark))
    (error "Mark is not active. Region not duplicated."))
  )

;; From http://www.emacswiki.org/emacs/ImenuMode#toc11 and
;; https://raw.github.com/xaccrocheur/kituu/master/.emacs
(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (cond
   ((not symbol-list)
    (let ((ido-mode ido-mode)
          (ido-enable-flex-matching
           (if (boundp 'ido-enable-flex-matching)
               ido-enable-flex-matching t))
          name-and-pos symbol-names position)
      (unless ido-mode
        (ido-mode 1)
        (setq ido-enable-flex-matching t))
      (while (progn
               (imenu--cleanup)
               (setq imenu--index-alist nil)
               (ido-goto-symbol (imenu--make-index-alist))
               (setq selected-symbol
                     (ido-completing-read "Symbol? " symbol-names))
               (string= (car imenu--rescan-item) selected-symbol)))
      (unless (and (boundp 'mark-active) mark-active)
        (push-mark nil t nil))
      (setq position (cdr (assoc selected-symbol name-and-pos)))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position)))))
   ((listp symbol-list)
    (dolist (symbol symbol-list)
      (let (name position)
        (cond
         ((and (listp symbol) (imenu--subalist-p symbol))
          (ido-goto-symbol symbol))
         ((listp symbol)
          (setq name (car symbol))
          (setq position (cdr symbol)))
         ((stringp symbol)
          (setq name symbol)
          (setq position
                (get-text-property 1 'org-imenu-marker symbol))))
        (unless (or (null position) (null name)
                    (string= (car imenu--rescan-item) name))
          (add-to-list 'symbol-names name)
          (add-to-list 'name-and-pos (cons name position))))))))

;; From http://www.emacswiki.org/emacs/InteractivelyDoThings#toc12
(defun ido-find-file-in-tag-files ()
  "Find files from TAGS file."
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))

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

;; Thanks to hesste from Github
(defun toggle-show-trailing-whitespace ()
  "Display or not the trailing whitespace"
  (interactive)
  (setq show-trailing-whitespace
        (not show-trailing-whitespace)))

(defun comment-or-uncomment-current-line ()
  "Comment or uncomment the current line where the cursor is."
  (interactive)
  (let ((beg (line-beginning-position))
        (end (line-end-position)))
    (comment-or-uncomment-region beg end)))


(defun foggy:weekno (word)
  "extract the week number from a word such as S42"
  (if (eq 0 (string-match "\\bS\[0-9\]\\{2\\}\\b" word))
      (string-to-int (substring word 1))))

(defun foggy:current-year ()
  "return the current year"
  ;; (string-to-int (format-time-string "%Y")))
  (caddr (calendar-current-date)))


(defun foggy:date-from-weekno (weekno)
  "Get the date from a weekno. Return (month day year)."
  (let ((year (foggy:current-year)))
    (calendar-gregorian-from-absolute
     (calendar-iso-to-absolute (list weekno 1 year)))))

(defun foggy:swap-date (month day year)
  ""
  (list day month year))

(defun foggy:str-date (date)
  "string date format from a date (month day year)"
  (format-time-string "%a %m %Y" (apply #'encode-time
                                        (append '(0 0 0) (apply #'foggy:swap-date date)))))


(defun foggy:insert-week-date ()
  "Write a c++ output of the current word."
  (interactive)
  (setq cword (current-word))
  (if (foggy:weekno cword)
      (progn
        (end-of-line 1)
        (newline)
        (beginning-of-line 1)
        (insert (foggy:str-date (foggy:date-from-weekno (foggy:weekno cword)))))))


;; Can hide `mode-line`
;; from https://emacs-doctor.com/emacs-hide-mode-line.html
(defvar-local hidden-mode-line-mode nil)

(define-minor-mode hidden-mode-line-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global t
  :variable hidden-mode-line-mode
  :group 'editing-basics
  (if hidden-mode-line-mode
      (setq hide-mode-line mode-line-format
	    mode-line-format nil)
    (setq mode-line-format hide-mode-line
	  hide-mode-line nil))
  (force-mode-line-update)
  ;; Apparently force-mode-line-update is not always enough to
  ;; redisplay the mode-line
  (redraw-display)
  (when (and (called-interactively-p 'interactive)
	     hidden-mode-line-mode)
    (run-with-idle-timer
     0 nil 'message
     (concat "Hidden Mode Line Mode enabled.  "
	     "Use M-x hidden-mode-line-mode to make the mode-line appear."))))
;; If you want to hide the mode-line in every buffer by default
;; (add-hook 'after-change-major-mode-hook 'hidden-mode-line-mode)



(setq foggy_functions-loaded t)
(provide 'foggy_functions)

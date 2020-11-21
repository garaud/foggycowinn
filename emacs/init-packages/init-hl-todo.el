(require 'hl-todo)

;; highlight TODO/FIXME,etc. words

(global-hl-todo-mode)


(setq hl-todo-keyword-faces
      '(("HOLD" . "#d0bf8f")
        ("TODO" . "firebrick")
        ("NEXT" . "#dca3a3")
        ("THEM" . "#dc8cc3")
        ("PROG" . "#7cb8bb")
        ("OKAY" . "#7cb8bb")
        ("DONT" . "#5f7f5f")
        ("FAIL" . "#8c5353")
        ("DONE" . "#8cfa8c")
        ("NOTE" . "#d0bf8f")
        ("KLUDGE" . "#d0bf8f")
        ("HACK" . "#d0bf8f")
        ("TEMP" . "#d0bf8f")
        ("FIXME" . "#cc9393")
        ("QUESTION" . "#7cb8bb")
        ("XXX" . "red")
        ("XXXX" . "#cc9393")
        ("???" . "#cc9393")))

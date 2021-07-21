(use-package meow
  :init
  (meow-global-mode)
  :config
  (meow-setup-line-number)
  (setq meow-expand-hint-remove-delay 2.0)
  
  ;; fallback commands:
  ;; the cdr's are called when there's no available selection
  (setq meow-selection-command-fallback
	'((meow-replace . meow-replace-char)
	  (meow-change . meow-change-char)
	  (meow-save . meow-save-char)
	  (meow-kill . meow-C-k)
	  (meow-delete . meow-C-d)
	  (meow-cancel-selection . meow-keyboard-quit)
	  (meow-pop . meow-pop-grab)))

  ;; list of default states
  (setq meow-mode-state-list '((cider-browse-spec-view-mode . motion)
			       (beancount-mode . normal)
			       (fundamental-mode . normal)
			       (occur-edit-mode . normal)
			       (text-mode . normal)
			       (prog-mode . normal)
			       (conf-mode . normal)
			       (cider-repl-mode . normal)
			       (eshell-mode . normal)
			       (shell-mode . normal)
			       (eshell-mode . normal)
			       (vterm-mode . normal)
			       (json-mode . normal)
			       (deft-mode . normal)
			       (pass-view-mode . normal)
			       (telega-chat-mode . normal)
			       (restclient-mode . normal)
			       (help-mode . normal)
			       (deadgrep-edit-mode . normal)
			       (mix-mode . normal)
			       (py-shell-mode . normal)
			       (term-mode . normal)
			       (Custom-mode . normal)
			       (jupyter-repl-mode . normal)))
  (setq meow-replace-state-name-list
	(list (cons 'normal "(=ↀωↀ=)")
	      (cons 'motion "<M>")
	      (cons 'keypad "<K>")
	      (cons 'insert "(^･ｪ･^)")))
  (face-attribute 'mode-line :background)
  (set-face-attribute 'meow-normal-indicator nil
		      :foreground (face-attribute 'mode-line :background)
		      :background (face-attribute 'default :foreground))

  (setq meow-expand-hint-remove-delay 2.0)
  
  ;; fallback commands:
  ;; the cdr's are called when there's no available selection
  (setq meow-selection-command-fallback
	'((meow-replace . meow-replace-char)
	  (meow-change . meow-change-char)
	  (meow-save . meow-save-char)
	  (meow-kill . meow-C-k)
	  (meow-delete . meow-C-d)
	  (meow-cancel-selection . meow-keyboard-quit)
	  (meow-pop . meow-pop-grab)))

  (setq meow-replace-state-name-list
	(list (cons 'normal "(=ↀωↀ=)")
	      (cons 'motion "<M>")
	      (cons 'keypad "<K>")
	      (cons 'insert "(^･ｪ･^)")))
  
  (set-face-attribute 'meow-normal-indicator nil
		      :foreground (face-attribute 'mode-line :background)
		      :background (face-attribute 'default :foreground))

  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)

  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))

  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("a" . execute-extended-command)
   '("c" . meow-keypad-start)
   '("C" . find-file-in-emacs-config)
   '("d" . hl-todo/body)
   '("f" . org-roam-find-file)
   '("g" . meow-keypad-start)
   '("j" . meow-motion-origin-command)
   '("k" . meow-motion-origin-command)
   '("l" . recenter-top-bottom)
   '("j" . ivy-magit-todos)
   '("o" . consult-buffer)
   '("p" . project-find-file)
   '("P" . projectile-find-other-file)
   '("s" . consult-ripgrep)
   '("S" . (lambda () (interactive) (consult-ripgrep t)))
   '("t" . org-agenda-list)
   '("u" . tab-bar-switch-to-recent-tab)
   '("v" . vterm-toggle)
   '("x" . meow-keypad-start)
   '("zt" . arche/toggle-TeX-im)
   '("zb" . ibuffer)
   '("zc" . calendar)
   '("zn" . battery)
   '("zo" . olivetti-mode)
   '("zp" . proced)
   '("zr" . rename-buffer)
   '("zs" . arche/sel-color-scheme)
   '("<return>" . arche/recompile-dwim)
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("<tab>" . arche/exwm-recent-workspace)
   '(":" . eval-expression)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))

  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '(";" . comment-line)
   ;; left hand
   '("q" . meow-quit)
   '("w" . other-window)
   '("W" . delete-other-windows)
   '("e" . meow-append)
   '("r" . meow-reverse)
   '("R" . meow-replace)
   '("t" . meow-till)
   '("T" . meow-till-expand)
   '("a" . meow-insert)
   '("s" . meow-find)
   '("d" . meow-kill)
   '("f" . meow-visit)
   '("g" . meow-cancel)
   '("z" . meow-pop-selection)
   '("Z" . meow-pop-all-selection)
   '("x" . meow-C-d)
   '("c" . meow-change)
   '("C" . meow-change-save)
   '("v" . meow-save)
   ;; TODO: b
   '("b" . meow-back-word)

   ;; right hand
   '("y" . meow-yank)
   '("Y" . meow-yank-pop)
   '("u" . meow-mark-symbol)
   '("i" . meow-inner-of-thing)
   '("I" . meow-bounds-of-thing)
   '("o" . meow-open-below)
   '("O" . meow-open-above)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("'" . point-to-register)
   '("n" . meow-next-word)
   '("N" . meow-next-symbol)
   '("m" . point-to-register)
   '("," . meow-line-expand)
   '("." . repeat)
   '("/" . meow-search)
   ;; TODO: o
   '("G" . meow-grab)
   '("&" . meow-query-replace)
   '("%" . meow-query-replace-regexp)
   '("'" . jump-to-register)
   '("\\" . quoted-insert)))

(provide 'arche-meow)

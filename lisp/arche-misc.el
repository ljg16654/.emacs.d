(require 'arche-helm)

;; By default, emacs disables some commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; The inverse of M-q
;; From https://www.emacswiki.org/emacs/UnfillParagraph
;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

(global-set-key (kbd "M-Q") #'unfill-paragraph)

;; Font-lock by depth
(use-package prism)

;;* By default, visiting destination of symlink under version control asks for confirm 
(setq vc-follow-symlinks nil)

(defun my-copy-full-name ()
  "get full name of file and save to kill-ring"
  (interactive)
  (kill-new (file-truename (buffer-file-name))))

(defun my-alter-current-line ()
  (interactive)
  "yy p and prompt for replace. Useful for writing lines that
differ only by a few numbers."
  (progn
    (execute-kbd-macro
     (read-kbd-macro "C-e RET C-p C-a C-SPC C-e M-w C-n C-y TAB"))
    (execute-kbd-macro
     (read-kbd-macro "C-a C-SPC C-e"))
    (call-interactively #'query-replace-regexp)))

(global-set-key (kbd "C-M-y") #'my-alter-current-line)

(use-package expand-region)
(global-set-key (kbd "M-'") #'er/expand-region)

(use-package helpful
  :config
  (progn
    (global-set-key (kbd "C-h f") #'helpful-callable)
    (global-set-key (kbd "C-h v") #'helpful-variable)
    (global-set-key (kbd "C-h k") #'helpful-key)))

(use-package crux
  :config
  (progn
    (global-set-key (kbd "C-x 4 t") #'crux-transpose-windows)
    (global-set-key (kbd "C-x J") #'join-line)
    ;; rather than  going directory to line-beginning,
    ;; move back to indentation of beginning of line instead.
    (global-set-key (kbd "C-a") #'crux-move-beginning-of-line)
    (global-set-key (kbd "C-c R") #'crux-rename-file-and-buffer)))

;; highlight specified keyword
(use-package hl-todo)

(use-package ace-jump-mode)

(use-package lorem-ipsum)

(use-package ace-link
  :config
  (ace-link-setup-default))

(straight-use-package
 '(disk-usage :type git
	      :host github
	      :repo "emacs-straight/disk-usage"))

(straight-use-package
 '(gimp-mode :type git
	     :host github
	     :repo "https://github.com/pft/gimpmode"))

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "s-/") #'query-replace-regexp)

(global-set-key (kbd "μ") #'bookmark-jump)

(global-set-key (kbd "C-x v") #'view-mode)

(defun arche/recenter-center ()
  (execute-kbd-macro (read-kbd-macro "C-u C-l")))

(define-key view-mode-map (kbd "j")
  #'(lambda () (interactive) (progn (next-line)
			       (arche/recenter-center))))

(define-key view-mode-map (kbd "k")
  #'(lambda () (interactive) (progn (previous-line)
			       (arche/recenter-center))))

(use-package olivetti
  :config
  (setq-default olivetti-body-width 0.7)
  :bind (("C-c f e" . olivetti-mode)))

(defun arche/focus-writing ()
  (interactive)
  (progn
    (olivetti-mode 1)
    (auto-fill-mode -1)
    (variable-pitch-mode 1)
    (toggle-truncate-lines t)
    (hide-mode-line-mode 1)))

(setq bookmark-file (file-truename "~/.emacs.bmk"))

(general-define-key
 :prefix "C-c f"
 "p" #'(lambda () (interactive) (find-file (concat user-emacs-directory "init.el")))
 "P" #'(lambda () (interactive) (find-file (file-truename "~/Pictures/")))
 "d" #'(lambda () (interactive) (find-file (file-truename "~/Downloads")))
 "c" #'(lambda () (interactive) (find-file (file-truename "~/Documents")))
 "l" #'(lambda () (interactive) (find-file (file-truename "~/org/reading-list.org"))))

(use-package emojify)

(setq prettify-symbols-alist
      (list (cons "lambda" "λ")))

(global-prettify-symbols-mode)

(use-package emacspeak)

(provide 'arche-misc)

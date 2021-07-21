(require 'arche-package)
;; By default, emacs disables some commands

(setq-default display-line-numbers-width )

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;; king ring volume
(setq kill-ring-max 200)

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
(use-package prism :disabled)

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
(use-package hl-todo
  :config
  (defhydra hl-todo
    nil
    ("j" #'hl-todo-next)
    ("k" #'hl-todo-previous)
    ("l" #'hl-todo-occur)))

(use-package ace-jump-mode)

(use-package lorem-ipsum)

(use-package ace-link
  :config
  (ace-link-setup-default))

(use-package disk-usage
  :straight (disk-usage :type git
			:host github
			:repo "emacs-straight/disk-usage")
  :config
  (define-key dired-mode-map (kbd "H-s") #'disk-usage))

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "s-/") #'query-replace-regexp)

(global-set-key (kbd "μ") #'bookmark-jump)

(global-set-key (kbd "C-x v") #'view-mode)

(defun arche/recenter-center ()
  "Recenter to the center, avoid cycling due to continuous
calls."
  (execute-kbd-macro (read-kbd-macro "C-u C-l")))

(defun arche/move-paragraph-natural-recenter (direction)
  "Move forward/backward paragraph and then recenter to a position
natural for reading."
  (cond
   ((eq direction 'forward) (forward-paragraph))
   (t (backward-paragraph)))
  (recenter-top-bottom 8))

(require 'view)
(define-key view-mode-map (kbd "j")
  #'(lambda () (interactive) (progn (next-line)
			       (recenter-top-bottom 8))))

(define-key view-mode-map (kbd "k")
  #'(lambda () (interactive) (progn (previous-line)
			       (recenter-top-bottom 8))))

(define-key view-mode-map (kbd "{")
  #'(lambda () (interactive) (arche/move-paragraph-natural-recenter 'backward)))

(define-key view-mode-map (kbd "}")
  #'(lambda () (interactive) (arche/move-paragraph-natural-recenter 'forward)))

(define-key Info-mode-map (kbd "{")
  #'(lambda () (interactive) (arche/move-paragraph-natural-recenter 'backward)))

(define-key Info-mode-map (kbd "}")
  #'(lambda () (interactive) (arche/move-paragraph-natural-recenter 'forward)))

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
(add-hook 'kill-emacs-hook #'bookmark-save)

(general-define-key
 :prefix "C-c f"
 "p" #'(lambda () (interactive) (find-file (concat user-emacs-directory "init.el")))
 "P" #'(lambda () (interactive) (find-file (file-truename "~/Pictures/")))
 "d" #'(lambda () (interactive) (find-file (file-truename "~/Downloads")))
 "c" #'(lambda () (interactive) (find-file (file-truename "~/Documents")))
 "l" #'(lambda () (interactive) (find-file (file-truename "~/org/reading-list.org"))))

(use-package emojify)

;; TODO https://github.com/Ilazki/prettify-utils.el/blob/master/prettify-utils.el

(defvar arche/prettify-utils-loaded nil)

(defun prettify-set ()
  (unless arche/prettify-utils-loaded
    (progn
      (load "prettify-utils.el")
      (setq arche/prettify-utils-loaded t)
      (setq prettify-symbols-alist
	    (prettify-utils-generate
	     ("lambda"	"λ")
	     ("|>"	"▷")
	     ("<|"	"◁")
	     ("->>"	"↠")
	     ("->"	"→")
	     ("|->"	"↦")
	     ("<-"	"←")
	     ("\\int"     "∫")
	     ("\\mapsto"  "↦")
	     ("\\forall"  "∀")
	     ("\\in"      "∊")
	     ("\\exists"  "∃")
	     ("\\land"    "∧")
	     ("\\lor"     "∨")))
      (prettify-symbols-mode))))

(add-hook 'prog-mode-hook 'prettify-set)
(add-hook 'org-mode-hook 'prettify-set)

(global-set-key (kbd "C-x 8 d") "⇓")
(global-set-key (kbd "C-x 8 u") "⇑")

;; (use-package emacspeak)

(use-package keyfreq
  ;; installed on <2021-06-11 Fri>
  :init
  (keyfreq-mode)
  (keyfreq-autosave-mode)
  :config
  (setq keyfreq-excluded-commands '()))

(defun dos2unix (buffer)
  "Automate M-% C-q C-m RET C-q C-j RET"
  (interactive "*b")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m) nil t)
      (replace-match (string ?\C-j) nil t))))

(global-set-key (kbd "s-y") #'consult-register)

(use-package password-store)

(use-package pass)

(use-package point-history
  :straight (point-history
	     :type git
	     :host github
	     :repo "blue0513/point-history"))

(setq point-history-show-buffer-height 20
      point-history-max-item-num 100
      point-history-should-preview t)
(point-history-mode t)
(global-set-key (kbd "C-s-h") #'point-history-show)

(use-package super-save
  :custom
  (super-save-exclude (list "\\.pdf$"
			    "\\.epub$"))
  :config
  (super-save-mode +1))

(use-package docker)

(provide 'arche-misc)

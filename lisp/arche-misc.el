(require 'arche-helm)

(defun transparency (value)
  "sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "ntransparency value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(setq vc-follow-symlinks nil)

(put 'narrow-to-region 'disabled nil)

(defun my-copy-full-name ()
  (interactive)
  (kill-new (file-truename (buffer-file-name))))

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
    (global-set-key (kbd "s-k") #'crux-kill-whole-lines)
    (global-set-key (kbd "C-x J") #'join-line)
    ;; rather than  going directory to line-beginning,
    ;; move back to indentation of beginning of line instead.
    (global-set-key (kbd "C-a") #'crux-move-beginning-of-line)
    (global-set-key (kbd "C-c R") #'crux-rename-file-and-buffer)
    ))

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

(global-set-key (kbd "M-i") #'imenu)

(global-set-key (kbd "μ") #'bookmark-jump)

(global-set-key (kbd "C-x v") #'view-mode)

(use-package olivetti
  :config
  (progn
    ;; occupies 7/10 of the window width  
    (setq-default olivetti-body-width 0.7)
    )
  :bind (("C-c f e" . olivetti-mode)))

(setq bookmark-file (file-truename "~/.emacs.bmk"))

(general-define-key
 :prefix "C-c f"
 "p" #'(lambda () (interactive) (find-file (concat user-emacs-directory "init.el")))
 "P" #'(lambda () (interactive) (find-file (file-truename "~/Pictures/")))
 "d" #'(lambda () (interactive) (find-file (file-truename "~/Downloads")))
 "c" #'(lambda () (interactive) (find-file (file-truename "~/Documents")))
 "l" #'(lambda () (interactive) (find-file (file-truename "~/org/reading-list.org"))))

(use-package emojify)

(provide 'arche-misc)

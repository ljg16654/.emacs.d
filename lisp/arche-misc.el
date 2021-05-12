(require 'arche-helm)
(setq vc-follow-symlinks nil)
(put 'narrow-to-region 'disabled nil)
(defun my-copy-full-name ()
  (interactive)
  (kill-new (file-truename (buffer-file-name))))
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
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "M-i") #'helm-imenu)
(global-set-key (kbd "μ") #'bookmark-jump)
(global-set-key (kbd "C-x v") #'view-mode)
(define-key view-mode-map (kbd "l") #'org-open-at-point)

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

(provide 'arche-misc)

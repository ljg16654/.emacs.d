(require 'arche-package)
(use-package dired-narrow)
(use-package dired-subtree)
(use-package dired-k
  :config
  (add-hook 'dired-initial-position-hook 'dired-k))

(use-package dired
  :straight nil
  :ensure nil
  :custom
  (dired-maybe-use-globstar t)
  (delete-by-moving-to-trash t)
  :config
  (setq dired-guess-shell-alist-user '(("\\.mkv\\'" "vlc")
				       ("\\.webm\\'" "vlc")))
  (defun arche/dired-load-hook ()
    (dired-omit-mode t)
    (dired-hide-details-mode t))
  (add-hook 'dired-load-hook #'arche/dired-load-hook)
  :bind
  ("C-x j" . #'dired-jump-other-window))

(use-package all-the-icons-dired
  :after (all-the-icons)
  :config
  (add-hook 'dired-mode-hook #'all-the-icons-dired-mode))

(provide 'arche-dired)

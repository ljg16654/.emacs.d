(require 'arche-package)
(require 'arche-misc)
(use-package dired-narrow)
(use-package dired-subtree)
(setq dired-maybe-use-globstar t)
(setq delete-by-moving-to-trash t)
(global-set-key (kbd "C-x j") #'dired-jump-other-window)
(add-hook 'dired-mode-hook
	  #'(lambda () (progn
		    (dired-omit-mode t)
		    (olivetti-mode t)
		    (dired-hide-details-mode t))))
(provide 'arche-dired)

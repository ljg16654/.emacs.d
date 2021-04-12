(require 'arche-package)
(use-package dired-narrow)
(setq dired-maybe-use-globstar t)
(setq delete-by-moving-to-trash t)
(add-hook 'dired-mode-hook
	  #'(lambda () (dired-omit-mode t)))
(provide 'arche-dired)

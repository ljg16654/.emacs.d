(setq dired-maybe-use-globstar t)
(add-hook 'dired-mode-hook
	  #'(lambda () (dired-omit-mode t)))
(provide 'arche-dired)

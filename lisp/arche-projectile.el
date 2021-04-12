(require 'arche-package)
(use-package projectile
  :config
  (setq projectile-globally-ignored-files
	(list "*.el~"
	      ".DS_Store"
	      "TAGS"
	      ".o"
	      ".so"
	      ".pyc"))
  (global-set-key (kbd "s-u") #'projectile-switch-project)
  (global-set-key (kbd "s-SPC") #'projectile-find-file))

(use-package ibuffer-projectile
  :after projectile
  :config
  (progn
    (add-hook 'ibuffer-hook
	      (lambda ()
		(ibuffer-projectile-set-filter-groups)
		(unless (eq ibuffer-sorting-mode 'alphabetic)
		  (ibuffer-do-sort-by-alphabetic))))))

(provide 'arche-projectile)

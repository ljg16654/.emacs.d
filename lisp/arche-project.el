(require 'arche-package)
(require 'arche-org)

(use-package find-file-in-project :disabled)

(use-package projectile
  :config
  (setq projectile-globally-ignored-files
	(list "*.el~"
	      ".DS_Store"
	      "TAGS"
	      ".o"
	      ".so"
	      ".pyc")))

(global-set-key (kbd "s-SPC") #'project-find-file)
(global-set-key (kbd "s-u") #'project-switch-to-buffer)
(global-set-key (kbd "σ") #'project-compile)

(provide 'arche-project)

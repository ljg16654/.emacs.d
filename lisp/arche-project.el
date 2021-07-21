(require 'arche-package)

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

(use-package project
  :config
  (global-set-key (kbd "s-SPC") #'project-find-file)
  (global-set-key (kbd "s-u") #'project-switch-to-buffer)
  (global-set-key (kbd "σ") #'compile))

(defun find-file-in-emacs-config ()
  (interactive)
  (project-find-file-in "" (list "~/.emacs.d/") (cons 'vc "~/.emacs.d/")))

(provide 'arche-project)


(require 'arche-package)
(require 'arche-org)

(use-package find-file-in-project)
(global-set-key (kbd "s-SPC") #'find-file-in-project)

(use-package projectile
  :config
  (setq projectile-globally-ignored-files
	(list "*.el~"
	      ".DS_Store"
	      "TAGS"
	      ".o"
	      ".so"
	      ".pyc"))
  (global-set-key (kbd "s-u") #'projectile-switch-project))

(use-package ibuffer-projectile
  :disabled
  :after projectile
  :config
  (progn
    (remove-hook 'ibuffer-hook
		 (lambda ()
		   (ibuffer-projectile-set-filter-groups)
		   (unless (eq ibuffer-sorting-mode 'alphabetic)
		     (ibuffer-do-sort-by-alphabetic))))))

(use-package org-projectile
  :after (org projectile)
  :config
  (progn
    (setq org-projectile-projects-file
          (concat org-directory "/project.org"))
    (global-set-key (kbd "C-c n p")
                    #'org-projectile-project-todo-completing-read)
    (push (org-projectile-project-todo-entry) org-capture-templates)))

(provide 'arche-project)

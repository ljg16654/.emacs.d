(require 'arche-package)
(use-package magit)
(global-set-key (kbd "C-c g") #'magit)
(use-package git-gutter)
(use-package magit-todos
  :config
  (magit-todos-mode)
  (global-set-key (kbd "C-x l") #'ivy-magit-todos))

(provide 'arche-git)

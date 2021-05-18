(require 'arche-package)
(use-package flycheck)
(global-set-key (kbd "σ") #'compile)
(setq linum-format " %d  ")
(add-hook 'prog-mode-hook #'electric-pair-mode)
(use-package yaml-mode)

;; for Gazebo and ROS
(add-to-list 'auto-mode-alist '("\\.world\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))
(provide 'arche-prog)

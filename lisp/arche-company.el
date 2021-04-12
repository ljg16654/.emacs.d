(require 'arche-package)
(use-package company
  :config
  (setq company-idle-delay 0.2)
  (setq tab-always-indent 'complete)
  (add-hook 'after-init-hook 'global-company-mode))
(provide 'arche-company)


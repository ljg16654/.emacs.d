(require 'arche-package)
(require 'arche-minibuffer-completion)
(use-package helm
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (helm-mode t))
(provide 'arche-helm)

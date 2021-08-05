(require 'arche-package)
(use-package debbugs)
(use-package hyperbole
  :after (debbugs ace-window)
  :config
  (setq hsys-org-enable-smart-keys t)
  (hkey-ace-window-setup (kbd "M-o"))
  (global-set-key (kbd "s-m") #'hkey-either)
  (global-set-key (kbd "C-h h") #'hyperbole))
  
(provide 'arche-hyperbole)

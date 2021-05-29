(require 'arche-package)
(use-package debbugs)
(use-package hyperbole
  :after (debbugs ace-window)
  :config
  (progn
    (hkey-ace-window-setup (kbd "M-o"))
    (global-set-key (kbd "s-m") #'hkey-either)))
(provide 'arche-hyperbole)

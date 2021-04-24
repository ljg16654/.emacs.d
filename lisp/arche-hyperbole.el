(require 'arche-package)
(use-package debbugs)
(use-package hyperbole
  :after (debbugs)
  :config
  (progn
    (global-set-key (kbd "s-m") #'hkey-either)))
(provide 'arche-hyperbole)

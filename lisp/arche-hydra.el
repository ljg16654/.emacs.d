(require 'arche-package)
(require 'arche-elisp)

(use-package hydra)
(global-set-key (kbd "C-c h") #'hydra-pause-resume)

(provide 'arche-hydra)

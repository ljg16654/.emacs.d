(require 'arche-package)
(use-package lsp-mode)
(use-package lsp-ui
  :config
  (progn
    (setq lsp-ui-sideline-show-diagnostics nil)
    ))
(provide 'arche-lsp)

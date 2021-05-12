(require 'arche-package)

(setq lsp-keymap-prefix "ν")
(use-package lsp-mode)

(use-package lsp-ui
  :config
  (progn
    (setq lsp-ui-sideline-show-diagnostics nil)))

(provide 'arche-lsp)


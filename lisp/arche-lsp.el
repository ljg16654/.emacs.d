(require 'arche-package)

(use-package lsp-mode)

(use-package lsp-ui
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (define-key python-mode-map (kbd "H-b") #'lsp-ui-doc-focus-frame)
  (setq lsp-ui-sideline-show-diagnostics nil))

(use-package lsp-pyright)

(use-package ccls :disabled)

(provide 'arche-lsp)


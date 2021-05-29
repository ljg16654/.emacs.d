(require 'arche-package)

(use-package lsp-mode)

(use-package lsp-ui
  :config
  (progn
    ;; remove the sometimes annoying bullshit at EOL
    (setq lsp-ui-sideline-show-diagnostics nil)))

(add-hook 'lsp-mode-hook #'lsp-headerline-breadcrumb-mode)

(use-package lsp-pyright)

(provide 'arche-lsp)


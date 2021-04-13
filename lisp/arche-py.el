(require 'arche-package)
(require 'arche-prog)
(require 'arche-sibling)
(add-hook 'python-mode-hook #'linum-mode)
(use-package python-pytest)
(define-key python-mode-map (kbd "H-t") #'python-pytest-dispatch)
(define-key python-mode-map (kbd "H-s") #'arche-sibling-jump)
(define-key python-mode-map (kbd "H-z") #'python-shell-switch-to-shell)
;; for font-lock and filling paragraphs inside docstring region:
(use-package python-docstring)

;; pyright
(use-package lsp-pyright)
(defun my-enable-pyright ()
  "enable pyright"
  (interactive)
  (progn
    (require 'lsp-pyright)
    (lsp)))

;; for generating docstring of a defun whenever needed
(use-package sphinx-doc)
(add-hook 'python-mode-hook #'(lambda ()
				(sphinx-doc-mode t)
				(electric-pair-mode t)
				))

(provide 'arche-py)

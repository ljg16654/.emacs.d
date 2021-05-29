(require 'arche-package)
(require 'arche-prog)
(require 'arche-sibling)

;;* line number
(add-hook 'python-mode-hook #'linum-mode)

;;* pytest
(use-package python-pytest)

;;* live-py
(use-package live-py-mode)

;;* keybinding
(define-key python-mode-map (kbd "H-t") #'python-pytest-dispatch)
(define-key python-mode-map (kbd "H-f") #'python-pytest-function)
(define-key python-mode-map (kbd "H-r") #'python-pytest-last-failed)
(define-key python-mode-map (kbd "H-b") #'lsp-ui-doc-focus-frame)
(define-key python-mode-map (kbd "H-s") #'arche-sibling-jump)
(define-key python-mode-map (kbd "H-z") #'python-shell-switch-to-shell)
;; for font-lock and filling paragraphs inside docstring region:
(use-package python-docstring)

;;* LSP
(use-package lsp-pyright)
(defun my-enable-pyright ()
  "enable pyright"
  (interactive)
  (progn
    (require 'lsp-pyright)
    (lsp)))

;;* docstring generation
(use-package sphinx-doc)
(add-hook 'python-mode-hook #'(lambda ()
				(sphinx-doc-mode t)
				(electric-pair-mode t)))

;;* prettify symbols
(setq python-prettify-symbols-alist
      (list
       '("lambda"  . ?λ)
       '("**2" . ?²)
       '("sigma" . ?σ)
       '("rho" . ?ρ)
       '("mu" . ?μ)
       '("theta" . ?θ)
       '("_0" . ?₀)
       '("_1" . ?₁)
       '("_2" . ?₂)
       '("epsilon" . ?ε)
       ))

(provide 'arche-py)

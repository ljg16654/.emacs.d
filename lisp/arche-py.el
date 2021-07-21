(require 'arche-package)

;;* line number
(defun arche/python-mode-hook ()
  (electric-pair-mode t))

(add-hook 'python-mode-hook #'arche/python-mode-hook)

;;* pytest
(use-package python-pytest
  :config
  (define-key python-mode-map (kbd "H-t") #'python-pytest-dispatch)
  (define-key python-mode-map (kbd "H-f") #'python-pytest-function)
  (define-key python-mode-map (kbd "H-r") #'python-pytest-last-failed)
  (define-key python-mode-map (kbd "H-z") #'python-shell-switch-to-shell))

;;* live-py
(use-package live-py-mode)

;; for font-lock and filling paragraphs inside docstring region:
(use-package python-docstring)

;;* LSP
(use-package lsp-pyright
  :config
  (defun my-enable-pyright ()
  "enable pyright"
  (interactive)
  (progn
    (require 'lsp-pyright)
    (lsp))))

;;* docstring generation
(use-package sphinx-doc
  :config
  (add-hook 'python-mode-hook #'sphinx-doc-mode))

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
       '("epsilon" . ?ε)))

(provide 'arche-py)

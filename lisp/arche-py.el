(require 'arche-package)
(require 'arche-prog)
(add-hook 'python-mode-hook #'linum-mode)
(use-package python-pytest)
(define-key python-mode-map (kbd "H-t") #'python-pytest)

;; for font-lock and filling paragraphs inside docstring region:
(use-package python-docstring)

;; for generating docstring of a defun whenever needed
(use-package sphinx-doc)
(add-hook 'python-mode-hook #'(lambda ()
				(sphinx-doc-mode t)
				(electric-pair-mode t)
				))

(provide 'arche-py)

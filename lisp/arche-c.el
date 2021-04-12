(require 'arche-package)

(require 'cmake-mode)
(defun c-mode-my-basic-settings ()
  (progn
    (linum-mode t)
    (autopair-mode t)))

(add-hook 'c-mode-hook #'c-mode-my-basic-settings)
(add-hook 'c++-mode-hook #'c-mode-my-basic-settings)

(use-package clang-format)
(provide 'arche-c)

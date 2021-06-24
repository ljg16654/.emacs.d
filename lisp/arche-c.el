(require 'arche-package)

(require 'cmake-mode)
(defun c-mode-my-basic-settings ()
  (progn
    (linum-mode t)))

(add-hook 'c-mode-hook #'c-mode-my-basic-settings)
(add-hook 'c++-mode-hook #'c-mode-my-basic-settings)
(define-key c++-mode-map (kbd "C-k") #'crux-smart-kill-line)
(define-key c++-mode-map (kbd "C-k") #'crux-smart-kill-line)

(use-package clang-format)
(define-key c++-mode-map (kbd "H-f") #'clang-format)

(provide 'arche-c)

(require 'arche-package)

(require 'cmake-mode)
(defun c-mode-my-basic-settings ()
  (progn
    (linum-mode t)))

(add-hook 'c-mode-hook #'c-mode-my-basic-settings)
(add-hook 'c++-mode-hook #'c-mode-my-basic-settings)
(define-key c++-mode-map (kbd "C-k") #'crux-smart-kill-line)
(define-key c++-mode-map (kbd "C-k") #'crux-smart-kill-line)

(add-hook 'c++-mode-hook
	  (lambda () (add-hook 'after-save-hook #'clang-format-buffer)))

(use-package clang-format)
(provide 'arche-c)

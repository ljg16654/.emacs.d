(require 'arche-package)
(require 'cmake-mode)

(use-package clang-format
  :config
  (define-key c++-mode-map (kbd "H-f") #'clang-format-buffer)
  (defun clang-format-buffer-smart ()
    "Reformat buffer if .clang-format exists in the projectile root."
    (when (f-exists? (expand-file-name ".clang-format" (project-root (project-current))))
      (clang-format-buffer)))

  (defun clang-format-format-on-save ()
    (add-hook 'before-save-hook
	      #'clang-format-buffer-smart nil t)))

(defun c-mode-my-basic-settings ()
  (progn
    (c-set-style "awk")
    (clang-format-format-on-save)))

(add-hook 'c-mode-hook #'c-mode-my-basic-settings)
(add-hook 'c++-mode-hook #'c-mode-my-basic-settings)
(define-key c++-mode-map (kbd "C-k") #'crux-smart-kill-line)
(define-key c++-mode-map (kbd "C-k") #'crux-smart-kill-line)



(define-key c++-mode-map (kbd "H-SPC") #'projectile-find-other-file)

(provide 'arche-c)

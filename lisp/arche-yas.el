(require 'arche-package)
(use-package yasnippet
  :config
  (progn
    (setq yas-snippet-dirs
          (list (concat user-emacs-directory "snippet/")))
    (yas-global-mode)))
(provide 'arche-yas)

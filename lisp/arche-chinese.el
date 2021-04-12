(require 'arche-package)
(use-package pyim
  :ensure nil
  :config
  (use-package pyim-basedict
    :ensure nil
    :config (pyim-basedict-enable))
  ;; quanpin
  (setq pyim-default-scheme 'quanpin)
  (pyim-isearch-mode 1)
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-length 5)
  (add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart-1 t)))
  )
(provide 'arche-chinese)

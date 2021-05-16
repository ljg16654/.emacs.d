(require 'arche-package)

;;* vterm
(use-package vterm
  :config (setq vterm-max-scrollback 10000))
(general-define-key
 :keymaps 'vterm-copy-mode-map
 "q" #'vterm-copy-mode)
(define-key vterm-mode-map (kbd "H-f")
  #'vterm-copy-mode)
(use-package vterm-toggle
  :bind
  ("s-v" . vterm-toggle)
  ("s-V" . vterm-toggle-cd))
(provide 'arche-term)

;;* eshell
(use-package eshell-git-prompt
  :config
  (progn
    (eshell-git-prompt-use-theme 'robbyrussell)))

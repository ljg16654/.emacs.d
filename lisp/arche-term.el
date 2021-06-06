(require 'arche-package)

;;* vterm
(use-package vterm
  :config (setq vterm-max-scrollback 10000))

(general-define-key
 :keymaps 'vterm-copy-mode-map
 "q" #'vterm-copy-mode)

(define-key vterm-mode-map (kbd "H-f") #'vterm-copy-mode)

(use-package vterm-toggle
  :bind
  ("s-v" . vterm-toggle)
  ("s-V" . vterm-toggle-cd))

;;* eshell
;;** fish-like autosuggestion
(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

(use-package eshell-git-prompt)

(use-package esh-help
  :config
  (setup-esh-help-eldoc))

(use-package eshell-prompt-extras)

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

(provide 'arche-term)


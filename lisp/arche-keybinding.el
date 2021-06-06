(require 'arche-package)

(use-package general)

(use-package which-key
  :init
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  (which-key-mode))

(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.05)
  (setq key-chord-one-key-delay 0.2)
  :config
  (key-chord-mode t)
  (key-chord-define-global ",." "<>\C-b")
  (key-chord-define-global "jk" "[]\C-b")
  (key-chord-define-global "JK" "{}\C-b"))

(provide 'arche-keybinding)

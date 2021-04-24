(require 'arche-package)
(use-package general)
(use-package which-key)
(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.05)
  (setq key-chord-one-key-delay 0.2)
  :config
  (key-chord-mode t)
  (key-chord-define-global ",." "<>\C-b")
  (key-chord-define-global "jk" "[]\C-b")
  (key-chord-define-global "JK" "{}\C-b")
  )

(provide 'arche-keybinding)

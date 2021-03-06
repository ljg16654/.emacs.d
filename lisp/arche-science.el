(require 'arche-package)

(use-package wolfram-mode
  :disabled
  :config
  (setq org-babel-mathematica-command "/usr/local/bin/mathematica")
  (add-to-list 'org-src-lang-modes '("mathematica" . wolfram)))

(provide 'arche-science)

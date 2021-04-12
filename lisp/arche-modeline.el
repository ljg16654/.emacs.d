(require 'arche-package)
(use-package diminish)
(diminish 'ivy-mode)
(diminish 'auto-revert-mode)
(diminish 'yas-minor-mode)
(diminish 'which-key-mode "which?")
(diminish 'org-indent-mode)
(diminish 'org-roam-mode)
(diminish 'org-cdlatex-mode "cd")
(diminish 'company-mode)
(diminish 'projectile-mode)
(diminish 'helm-mode)
(diminish 'auto-fill-function "AuF")
(diminish 'evil-snipe-mode)
(diminish 'evil-escape-mode)
(provide 'arche-modeline)
(use-package doom-modeline
  ;; :init (doom-modeline-mode 1)
  :config
  (progn
    (setq doom-modeline-height 15)))
(use-package nyan-mode
  ;; :config
  ;; (nyan-mode)
  ;; (nyan-start-animation)
  )
(provide 'arche-modeline)

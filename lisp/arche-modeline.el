(require 'arche-package)
(require 'arche-misc)
(require 'arche-buffer-management)

(use-package diminish)

(use-package minions
  :after (ace-window helpful)
  :init (minions-mode)
  :config
  (defun arche/reset-mode-line ()
    (interactive)
    (progn
      (setq-default mode-line-format
		    (helpful--original-value 'mode-line-format))
      (minions-mode t)
      (ace-window-display-mode t))))

(use-package hide-mode-line)

(use-package nyan-mode
  ;; :config
  ;; (nyan-mode)
  ;; (nyan-start-animation)
  )

(provide 'arche-modeline)

(require 'arche-package)
(use-package posframe)

(use-package winner-mode
  ;; EXWM closing floating window causes winner-mode to crash
  :disabled
  :init
  (winner-mode t)
  :config
  (global-set-key (kbd "s--") #'winner-undo)
  (global-set-key (kbd "s-=") #'winner-redo))

(winner-mode -1)

(global-set-key (kbd "C-c s") #'window-toggle-side-windows)
(setq display-buffer-alist
      '(
        ("\\*Messages.*"
         (display-buffer-in-side-window)
         (window-height . 0.16)
         (side . top)
         (slot . 1)
         (window-parameters . ((no-other-window . t))))
        ("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\)\\*"
         (display-buffer-in-side-window)
         (window-height . 0.16)
         (side . top)
         (slot . 2)
         (window-parameters . ((no-other-window . t))))
	;; bottom side window
        ("\\*Python\\*"
         (display-buffer-reuse-mode-window display-buffer-at-bottom)
         (window-height . 0.4)
         (side . bottom)
         (slot . 1)
	 (window-parameters ((mode-line-format . none))
			    ))
        ("\\*ielm\\*"
         (display-buffer-reuse-mode-window display-buffer-at-bottom)
         (window-height . 0.4)
         (side . bottom)
         (slot . 2))
	("\\*Async Shell Command\\*"
	 (display-buffer-no-window))
        ;; left side window
        ("\\*Help.*"
         (display-buffer-reuse-mode-window display-buffer-at-bottom)
         (window-height . 0.35)		; See the :hook
         (side . left)
         (slot . 0))
	("\\*pytest.*"
	 (display-buffer-in-side-window)
	 (window-width . 0.5)		; See the :hook
	 (side . left)
	 (slot . 0)
         )))
(add-hook 'help-mode-hook #'visual-line-mode)
(add-hook 'custom-mode-hook #'visual-line-mode)
(setq Man-notify-method 'pushy)

(provide 'arche-window-buffer-rule)

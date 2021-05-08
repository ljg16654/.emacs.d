(require 'arche-package)
(use-package posframe)
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
         (window-parameters . ((no-other-window . t))))
        ("\\*.*\\([^E]eshell\\|shell\\|v?term\\).*"
         (display-buffer-reuse-mode-window display-buffer-at-bottom)
         (window-height . 0.4)
         ;; (mode . '(eshell-mode shell-mode))
         )))
(global-set-key (kbd "C-c 2") #'window-toggle-side-windows)
(add-hook 'help-mode-hook #'visual-line-mode)
(add-hook 'custom-mode-hook #'visual-line-mode)
(setq Man-notify-method 'pushy)

(provide 'arche-window-buffer-rule)

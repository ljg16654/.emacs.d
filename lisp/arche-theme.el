(require 'arche-package)
;; (load-theme 'modus-operandi t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq tab-bar-new-button nil)
(setq tab-bar-close-button nil)
;;* some random themes I favor
(use-package tron-legacy-theme)
(use-package plan9-theme)
;;* autothemer
(use-package autothemer)
(defun my-load-tron-legacy ()
  (interactive)
  (progn (setq pdf-view-midnight-colors
	       '("#B0CCDC" ;; bg
		 .
		 "#000000" ;; fg
		 ))
	 (load-theme 'tron-legacy t)))
(defun my-load-plan9 ()
  (interactive)
  (progn (setq pdf-view-midnight-colors
	       '("#424242"
		 .
		 "#FFFFE8"))
	 (load-theme 'plan9 t)))
;; (load-theme 'random t)
(setq pdf-view-midnight-colors
      '(
	"#191970" ;; background
	.
	"#f0ffdd" ;; foreground
	))
(provide 'arche-theme)

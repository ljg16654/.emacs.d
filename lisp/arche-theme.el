(require 'arche-package)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq tab-bar-new-button nil)
(setq tab-bar-close-button nil)

(use-package modus-themes
  :config
  (setq modus-themes-org-blocks 'gray-background)
  (setq modus-themes-mode-line '3d))

;;* some random themes I favor
(use-package tron-legacy-theme)
(use-package doom-themes)
(use-package plan9-theme)
(use-package greymatters-theme)
;;* autothemer
(use-package autothemer)

(defun my-load-tron-legacy ()
  (interactive)
  (progn (setq pdf-view-midnight-colors
	       '("#B0CCDC" ;; bg
		 .
		 "#000000" ;; fg
		 ))
	 ;; tab-bar
	 (set-face-attribute 'tab-bar-tab nil :family "Iosevka Fixed" :height 150 :box nil :background "black" :foreground "SlateGrey" :underline t)
	 (set-face-attribute 'tab-bar-tab-inactive nil :inherit nil :family "Iosevka Fixed" :height 150 :box nil :background "black" :foreground "SlateGrey")
	 (set-face-attribute 'tab-bar nil :background "black")
	 (load-theme 'tron-legacy t)))

(defun my-load-plan9 ()
  (interactive)
  (progn (setq pdf-view-midnight-colors
	       '("#424242"
		 .
		 "#FFFFE8"))
	 (load-theme 'plan9 t)))

(load-theme 'doom-nova t t)

(provide 'arche-theme)

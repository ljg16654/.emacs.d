(require 'arche-package)
(require 'arche-elisp)

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
(use-package leuven-theme)
(use-package spacemacs-theme :straight nil)
(use-package color-theme-modern)
;;* autothemer
(use-package autothemer)

(defun my-dark-tab-bar ()
  (interactive)
  (set-face-attribute 'tab-bar-tab nil :family "Iosevka Fixed" :height 150 :box nil :background "black" :foreground "SlateGrey" :underline t)
  (set-face-attribute 'tab-bar-tab-inactive nil :inherit nil :family "Iosevka Fixed" :height 150 :box nil :background "black" :foreground "SlateGrey")
  (set-face-attribute 'tab-bar nil :background "black")
  (set-face-attribute 'tab-bar nil :background "black" :foreground "SlateGrey")) ;

(use-package org-beautify-theme
  :disabled
  :config
  (load-theme 'org-beautify nil nil))

;; for org babel tangling
(defvar arche/color-sheme 'light)

(setq arche/color-scheme-list
      '(dark light))

(defun config-file (color-scheme fn)
  (if (equal color-scheme arche/color-scheme)
      fn
    "no"))

(defun arche/reload-color-scheme ()
  (interactive)
  (progn
    (org-babel-tangle-file "~/system/dotfiles.org"))) 

(defun arche/sel-color-scheme ()
  (interactive)
  (progn
    (setq arche/color-scheme
	  (read (completing-read "Sel color scheme: "
				 arche/color-scheme-list)))
    (arche/reload-color-scheme)))

(provide 'arche-theme)

(require 'arche-package)
(require 'arche-misc)
(use-package flycheck)
(global-set-key (kbd "σ") #'compile)
(setq linum-format " %d  ")
(add-hook 'prog-mode-hook #'arche/prog-mode-hook)

(defun arche/prog-mode-hook ()
  (electric-pair-mode t)
  (olivetti-mode t))

(use-package yaml-mode)

;; for Gazebo and ROS
(add-to-list 'auto-mode-alist '("\\.world\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

;; devdocs.io
;; https://github.com/blahgeek/emacs-devdocs-browser
(straight-use-package
 '(devdocs-browser :type git
		   :host github
		   :repo "blahgeek/emacs-devdocs-browser"))

(provide 'arche-prog)

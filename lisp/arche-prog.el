(require 'arche-package)
(use-package flycheck)
(setq linum-format " %d  ")

(defun arche/prog-mode-hook ()
  (electric-pair-mode t))

(add-hook 'prog-mode-hook #'arche/prog-mode-hook)

(use-package yaml-mode)

;; for Gazebo and ROS
(add-to-list 'auto-mode-alist '("\\.world\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

;; devdocs.io
;; https://github.com/blahgeek/emacs-devdocs-browser
(use-package devdocs-browser
  :straight (devdocs-browser :type git
			     :host github
			     :repo "blahgeek/emacs-devdocs-browser"))

(use-package origami
  :after (evil)
  :config
  ;; TODO read https://github.com/gregsexton/origami.el/wiki/Origami---Evil-Operator-Example
  (setq origami-show-fold-header t))

(use-package treemacs
  :config
  (use-package treemacs-evil))

(defun arche/recompile-dwim ()
  (interactive)
  (let
      ((cur (selected-window))
       (w (get-buffer-window "*compilation*" t)))
    (if (derived-mode-p 'prog-mode) (save-buffer))
    (select-window w)
    (recompile)
    (select-window cur)))

(provide 'arche-prog)

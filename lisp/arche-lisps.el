(require 'arche-package)

(use-package paren-face)
(use-package highlight-parentheses)

(use-package lispy
  :config
  (define-key lispy-mode-map (kbd "M-o") #'ace-window)
  (define-key lispy-mode-map (kbd "M-i") #'consult-imenu)
  (define-key lispy-mode-map (kbd "M-u") #'lispy-iedit))

(defun arche-lisps-hook ()
  (lispy-mode t)
  (paren-face-mode t)
  (highlight-parentheses-mode t))

;; apply hook to lisp major modes
(add-hook 'emacs-lisp-mode-hook #'arche-lisps-hook)
(add-hook 'lisp-mode-hook #'arche-lisps-hook)
(add-hook 'clojure-mode-hook #'arche-lisps-hook)
(add-hook 'cider-repl-mode-hook #'arche-lisps-hook)
(add-hook 'scheme-mode-hook #'arche-lisps-hook)

(add-hook 'inferior-emacs-lisp-mode #'(lambda () (autopair-mode t)))
(define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-buffer)

;;* common lisp
(use-package slime
  :hook
  (slime-repl-mode-hook . arche-lisps-hook)
  :config
  (setq inferior-lisp-program (executable-find "sbcl"))
  (setq slime-lisp-implementations
	`((sbcl ,(list (executable-find "sbcl")) :coding-system utf-8-unix)
	  (clisp ,(list (executable-find "clisp")) :coding-system utf-8-unix))))

;;* clojure
(use-package cider
  :hook
  (clojure-mode-hook . cider-mode))

;;* schemes
(use-package geiser-guile)

(use-package racket-mode
  :config
  (add-hook 'racket-mode-hook #'arche-lisps-hook)
  (define-key racket-mode-map (kbd "M-e") #'racket-xp-mode))

(provide 'arche-lisps)

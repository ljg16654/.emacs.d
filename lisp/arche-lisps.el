(require 'arche-package)
(require 'arche-misc)

;;* editing
(use-package lispy)
(use-package paren-face)
(use-package highlight-parentheses)
(defun arche-lisps-hook ()
  (lispy-mode t)
  (paren-face-mode t)
  (highlight-parentheses-mode t)
  (hl-todo-mode t))

;; use my usual binding of imenu
(define-key lispy-mode-map (kbd "M-i") #'imenu)
(define-key lispy-mode-map (kbd "M-u") #'lispy-iedit)

;; apply hook to lisp major modes
(add-hook 'emacs-lisp-mode-hook #'arche-lisps-hook)
(add-hook 'lisp-mode-hook #'arche-lisps-hook)
(add-hook 'slime-repl-map-mode-hook #'arche-lisps-hook)
(add-hook 'clojure-mode-hook #'arche-lisps-hook)
(add-hook 'cider-repl-mode-hook #'arche-lisps-hook)

(add-hook 'inferior-emacs-lisp-mode #'(lambda () (autopair-mode t)))
(define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-buffer)

;;* common lisp
(use-package slime
  :config
  (let
      ((my-lisp-prog (file-truename "~/.local/bin/sbcl")))
    (setq inferior-lisp-program my-lisp-prog)
    (setq slime-lisp-implementations
	  `((sbcl ,(list my-lisp-prog) :coding-system utf-8-unix)))))

;;* clojure
(use-package cider)
(add-hook 'clojure-mode-hook #'cider-mode)

;;* schemes
(use-package geiser-guile)

(provide 'arche-lisps)

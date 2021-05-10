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
(add-hook 'lisp-mode-hook #'arche-lisps-hook)
(add-hook 'emacs-lisp-mode-hook #'arche-lisps-hook)
(add-hook 'inferior-emacs-lisp-mode #'(lambda () (autopair-mode t)))
(add-hook 'slime-repl-map-mode-hook #'(lambda () (lispy-mode t)))
(define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-buffer)

;;* common lisp
(use-package slime
  :config
  (let
      ((my-lisp-prog (file-truename "~/.local/bin/sbcl")))
      (setq inferior-lisp-program my-lisp-prog)
    (setq slime-lisp-implementations
	  `((sbcl ,(list my-lisp-prog) :coding-system utf-8-unix)))))
(provide 'arche-lisps)

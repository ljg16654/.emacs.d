(require 'arche-package)
(use-package s)
(use-package dash)
(use-package f)
(use-package transient)

;; library for graph
(add-to-list 'load-path (concat
			 user-emacs-directory "site-lisp/graph.el"))
(load-library "graph.el")
(provide 'arche-elisp)

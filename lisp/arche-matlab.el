(require 'arche-package)
(add-to-list 'load-path (concat
			 user-emacs-directory "site-lisp/matlab-emacs-src"))
(load-library "matlab-load")
(matlab-cedet-setup)
(provide 'arche-matlab)

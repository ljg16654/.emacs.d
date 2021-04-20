(require 'arche-package)
(require 'arche-org)
(use-package w3m)
(setq browse-url-generic-program "qutebrowser")
(setq browse-url-browser-function #'eww-browse-url)
(defun my-sel-url-browser-function ()
  "Prompt for selection of the 'browse-url-browser-function'"
  (interactive)
  (progn
    (setq browse-url-browser-function
	  (cl-case (completing-read "Select the browser: "
				    (list 'eww
					  'qutebrowser
					  'firefox))
	    ('eww #'eww-browse-url)
	    ('qutebrowser "qutebrowser")
	    ('firefox 'browse-url-firefox)
	    ))
    (message "%s" browse-url-browser-function)
    ))

(use-package org-web-tools)
(use-package engine-mode)
(provide 'arche-web)

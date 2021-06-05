(require 'arche-package)
(require 'arche-org)

(use-package eww
  :after ace-link
  :config
  (progn (define-key eww-mode-map (kbd "f") #'ace-link)))

(setq browse-url-generic-program "qutebrowser")
;; (setq browse-url-browser-function #'eaf-open-browser)
(setq browse-url-browser-function #'browse-url-browser-function)
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
(use-package mentor)
(provide 'arche-web)

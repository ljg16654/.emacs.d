(require 'arche-package)
(require 'arche-org)

(use-package eww
  :after ace-link
  :config
  (progn (define-key eww-mode-map (kbd "f") #'ace-link)))

;; Try this link with hyperbole!
;; http://ergoemacs.org/emacs/emacs_set_default_browser.html

;; qutebrowser
(setq browse-url-generic-program "qutebrowser")
(setq browse-url-browser-function #'browse-url-generic)

;; TODO in qutebrowser frame, prompt for selection between {eww,
;; firefox, vivaldi} to open current url

;; eaf
;; (setq browse-url-browser-function #'eaf-open-browser)

(use-package org-web-tools)
(use-package engine-mode)
(use-package mentor)
(provide 'arche-web)

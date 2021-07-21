(require 'arche-package)

(use-package eww
  :after ace-link
  :config
  (progn (define-key eww-mode-map (kbd "f") #'ace-link)))

;; Try this link with hyperbole!
;; http://ergoemacs.org/emacs/emacs_set_default_browser.html

;; qutebrowser
(setq browse-url-generic-program "qutebrowser")
(setq browse-url-browser-function #'browse-url-generic)

(use-package org-web-tools)

(use-package youtube-dl
  :custom
  (youtube-dl-directory "~/Videos"))

(provide 'arche-web)

(require 'arche-package)
(require 'arche-org)
(require 'arche-elisp)

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

;; web search
;;;###autoload
(defun arche/duckduckgo-search ()
  (interactive)
  "If input starts with space, go to the link after the
space. Otherwise, search for the input."
  (let
      ((what (read-string "Search for: ")))
    (cond ((s-prefix-p " " what) (browse-url (s-trim what)))
	  ((s-prefix-p ",g " what) (browse-url (concat "https://github.com/search?q=" (s-chop-prefix ",g " what))))
	  (t (browse-url (concat "www.duckduckgo.com/?q=" what))))))

;;;###autoload
(defun arche/browse-qutebrowser-hist ()
  (interactive)
  (let*
      ((hist (shell-command-to-string "~/scripts/qutebrowser-get-hist.sh"))
       (hist-list (-filter
		   (lambda (str) (not (s-blank? str)))
		   (s-split "\n" hist)))
       (url-with-description (completing-read "Choose from Qutebrowser history: " hist-list))
       (url (-last-item (s-split " " url-with-description))))
    (browse-url url)))

(use-package org-web-tools)
(use-package engine-mode)
(use-package mentor)

;; met error
;; (void-variable hierarchy--make)
;; (use-package md4rd)

(provide 'arche-web)

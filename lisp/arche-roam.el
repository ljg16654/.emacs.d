(require 'arche-package)
(require 'arche-ecm)

(executable-find "sqlite3")

(use-package org-roam
  :commands org-roam-mode
  :init (add-hook 'after-init-hook 'org-roam-mode)
  :config
  ;; make sure org-ref has been loaded
  (require 'arche-org-ref)
  (require 'org-ref)
  (progn
    ;; all subdirectories of org-roam-directory are considered part of
    ;; org-roam regardless of level of nesting.
    (setq org-roam-buffer "*org-roam-backlinks*")
    (setq org-roam-buffer-window-parameters
	  '((mode-line-format . nil)))
    (setq org-roam-directory (file-truename "~/org-roam"))
    (setq org-roam-tag-sources
	  (list
	   'prop
	   'last-directory)))

  (defun arche/rg-org-roam ()
    (interactive)
    (consult-ripgrep "~/org-roam" ""))

  (general-define-key
   :prefix "C-c r"
   "r" #'helm-bibtex
   "d" #'(lambda () (interactive)
	   (dired org-roam-directory))
   "s" #'(lambda () (interactive)
	   (progn
	     (org-roam-backlinks-mode t)
	     (org-roam-buffer-toggle-display)))
   "c" #'org-roam-db-build-cache
   "f" #'org-roam-find-file
   "y" #'org-roam-dailies-find-yesterday
   "x" #'org-roam-dailies-find-today
   "j" #'org-roam-dailies-capture-today
   "i" #'org-roam-insert
   "/" #'arche/rg-org-roam)
  
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
	'(("d" "default" entry
           #'org-roam-capture--get-point
           "* %?"
           :file-name "daily/%<%Y-%m-%d>"
           :head "#+title: %<%Y-%m-%d>\n\n")))
  (use-package org-roam-bibtex
    :after org-roam
    :hook (org-roam-mode . org-roam-bibtex-mode))
  (use-package org-roam-server
    :ensure t
    :config
    (setq org-roam-server-host "127.0.0.1"
          org-roam-server-port 8080
          org-roam-server-authenticate nil
          org-roam-server-export-inline-images t
          org-roam-server-serve-files nil
          org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
          org-roam-server-network-poll t
          org-roam-server-network-arrows nil
          org-roam-server-network-label-truncate t
          org-roam-server-network-label-truncate-length 60
          org-roam-server-network-label-wrap-length 20))
  (require 'org-roam-protocol)
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}\n#+ROAM_KEY: ${ref}"
           :unnarrowed t))))

(straight-use-package
 '(org-transclusion
   :type git
   :host github
   :repo "nobiot/org-transclusion"))

(provide 'arche-roam)

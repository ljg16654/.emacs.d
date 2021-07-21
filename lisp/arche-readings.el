(require 'arche-package)

(use-package nov
  :config
  ;; tip: never use toc (t), use imenu instead!
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :hook
  (nov-mode . variable-pitch-mode))

(use-package ereader
  :straight (ereader 
	     :type git
	     :host github
	     :repo "bddean/emacs-ereader")
  :config
  (require 'ereader)
  (require 'org-ebook))

(use-package adoc-mode)

(provide 'arche-readings)

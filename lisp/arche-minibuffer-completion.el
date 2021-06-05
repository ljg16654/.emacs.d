(require 'arche-package)

;;* Compeltion Style
(use-package orderless)
(setq completion-styles '(orderless partial-completion))
;; for file name completion, ignore case
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;;* My favored incrementally narrowing tool in minibuffer
(use-package vertico)
(vertico-mode t)

(use-package icomplete-vertical
  :ensure t
  :demand t
  :config
  :bind (:map icomplete-minibuffer-map
              ("<down>" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("<up>" . icomplete-backward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-toggle)))

(icomplete-mode -1)
(icomplete-vertical-mode -1)

(use-package ivy
  :config
  (setq ivy-height 5)
  (setq ivy-re-builders-alist
	(list )))

(ivy-mode -1)
(provide 'arche-minibuffer-completion)

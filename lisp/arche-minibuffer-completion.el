(require 'arche-package)

;;* Compeltion Style
(use-package orderless)
(setq completion-styles '(orderless partial-completion))
;; for file name completion, ignore case
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;;* My favored incrementally narrowing tool in minibuffer

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

(icomplete-mode t)
(icomplete-vertical-mode t)

(provide 'arche-minibuffer-completion)

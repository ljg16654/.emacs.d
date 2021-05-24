(require 'arche-package)

;;* Compeltion Style
(use-package orderless)
(setq completion-styles '(orderless))
;; for file name completion, ignore case
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;;* My favored incrementally narrowing tool in minibuffer
(use-package vertico)
(vertico-mode t)

(provide 'arche-minibuffer-completion)

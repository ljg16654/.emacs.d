(require 'arche-package)

;;* Compeltion Style
(use-package orderless)
(setq completion-styles
      '(partial-completion
	flex
	initials
	substring
	orderless))
;; for file name completion, ignore case
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;;* My favored incrementally narrowing tool in minibuffer

;; For some reason selectrum doesn't work properly with wordnut-search
(use-package selectrum)
(selectrum-mode 0)

(use-package icomplete-vertical
  :bind (:map icomplete-minibuffer-map
              ("<down>" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("<up>" . icomplete-backward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-toggle)))
(icomplete-mode)
(icomplete-vertical-mode)

(provide 'arche-minibuffer-completion)

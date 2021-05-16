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

(use-package icomplete-vertical)
(icomplete-mode)
(icomplete-vertical-mode)

(provide 'arche-minibuffer-completion)

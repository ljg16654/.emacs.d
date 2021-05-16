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
;; (icomplete-mode nil)
(use-package selectrum)
(selectrum-mode +1)

(provide 'arche-minibuffer-completion)

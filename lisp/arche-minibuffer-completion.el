(require 'arche-package)

(icomplete-mode t)

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
(provide 'arche-minibuffer-completion)

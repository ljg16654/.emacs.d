(require 'arche-package)

;;* savehist
(use-package savehist
    :config
    (setq history-length 25)
    (savehist-mode 1))

;;* Compeltion Style
(use-package orderless)
(setq completion-styles '(orderless partial-completion))
;; for file name completion, ignore case
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;;* My favored incrementally narrowing tool in minibuffer
(use-package vertico)
(vertico-mode t)

(use-package marginalia
  :after vertico
  :straight t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

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

(provide 'arche-minibuffer-completion)

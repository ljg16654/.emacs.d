(require 'arche-package)

(use-package evil
  :after (general crux)
  :init
  (setq evil-buffer-regexps
	(list (cons (rx "*info*") 'emacs)
	      (cons (rx "*helpful") 'emacs)
	      (cons (rx "*lispy-message*") 'emacs)))
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-C-w-delete t)
  (setq evil-want-C-w-in-emacs-state nil)
  (setq evil-disable-insert-state-bindings t)
  :config
  (evil-set-initial-state 'emacs-lisp-mode 'emacs)
  (evil-set-initial-state 'lisp-mode 'emacs)
  (evil-set-initial-state 'clojure-mode 'emacs)
  (evil-set-initial-state 'scheme-mode 'emacs)
  (evil-set-initial-state 'info-mode 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'vterm-mode 'emacs)
  (evil-set-initial-state 'wordnut-mode 'emacs)
  ;; reclaim C-e C-a C-n C-p
  (general-define-key
   :states '(normal insert)
   "C-e" 'move-end-of-line
   "C-a" 'crux-move-beginning-of-line
   "C-n" 'next-line
   "C-p" 'previous-line)

  (define-key evil-normal-state-map (kbd "gr")
    #'(lambda () (interactive)
	(if lsp-mode
	    (lsp-find-references)
	  (xref-find-references))))
  (evil-mode t))

(use-package evil-escape
  :config
  (setq-default evil-escape-key-sequence "qk")
  (setq-default evil-escape-delay 0.2)
  (evil-escape-mode))

(use-package lispyville
  :config
  (add-hook 'lispy-mode-hook #'lispyville-mode))

(provide 'arche-evil)


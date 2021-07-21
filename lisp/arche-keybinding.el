(require 'arche-package)


(use-package general)

(use-package which-key
  :init
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 2)
  (setq which-key-idle-secondary-delay 0.05)
  (which-key-mode))

(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.1)
  (setq key-chord-one-key-delay 0.2)
  :config
  (key-chord-mode t)
  (key-chord-define-global "JK" "{}\C-b"))

(use-package hydra)

(use-package hercules)

(use-package boon
  :disabled
  :config
  ;; respect vanilla keybinding in selected modes
  (setq boon-special-mode-list '(Buffer-menu-mode cfw:calendar-mode debugger-mode ediff-mode ediff-meta-mode finder-mode git-rebase-mode mu4e-headers-mode mu4e-view-mode notmuch-hello-mode notmuch-search-mode notmuch-show-mode notmuch-tree-mode org-agenda-mode pass-mode view-mode dired-mode emacs-lisp-mode lisp-mode scheme-mode))
  (general-define-key
   :keymaps 'boon-command-map
   "i" #'boon-set-insert-like-state
   "o" #'boon-open-next-line-and-insert
   "O" #'boon-open-line-and-insert
   "f" #'boon-smarter-forward
   "v" #'boon-smarter-backward
   "a" #'boon-beginning-of-line
   "e" #'boon-end-of-line
   "h" #'backward-char
   "l" #'forward-char
   "j" #'next-line
   "k" #'previous-line
   "d" #'boon-take-region
   "J" #'scroll-down-line
   "K" #'scroll-up-line
   "x" #'boon-x-map
   "{" #'backward-paragraph
   "}" #'forward-paragraph
   ;; boon-quote-character
   "c" #'boon-c-god
   "." #'boon-repeat-command
   ))

(require 'arche-meow)

(when arche/go-evil
  (require 'arche-evil))

(provide 'arche-keybinding)

(require 'arche-package)

;;* vterm
(use-package vterm
  :after (hide-mode-line)
  :straight nil
  :config
  (setq vterm-max-scrollback 10000)
  (add-hook 'vterm-mode-hook #'(lambda () (interactive)
				 (hide-mode-line-mode t)))
  (define-key vterm-copy-mode-map (kbd "q") #'vterm-copy-mode)
  (define-key vterm-mode-map (kbd "H-f") #'vterm-copy-mode))

(use-package vterm-toggle
  :bind
  ("s-v" . vterm-toggle)
  ("s-V" . vterm-toggle-cd))

(use-package fish-completion)

;;* eshell
;;** fish-like autosuggestion
(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

(use-package eshell-git-prompt)

(use-package esh-help
  :config
  (setup-esh-help-eldoc))

(use-package eshell-prompt-extras)

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

(if (executable-find "fish")
    (progn
      (use-package fish-mode)
      (use-package fish-completion
	:config
	(global-fish-completion-mode))))

(defun arche/assure-battery ()
  "Assure there's more than 5% battery."
  (when (executable-find "acpi")
    (let
	((percentage
	  (string-to-number (s-trim (shell-command-to-string "acpi -b | awk -F'[,:%]' '{print $3}'")))))
      (> percentage 5))))

;; Interacting with tmux from inside Emacs
;; tips:
;; https://github.com/emacsorphanage/emamux
;; {M-x emamux:send-command RET}
;; probably change target with C-u
(use-package emamux)

;; Manage external services from inside Emacs
;; https://github.com/rejeep/prodigy.el
(use-package prodigy)

;; workflow for managing multiple eshell/shell buffers
;; s-s / s-e to open side window for placing shell/eshell
;; C-u s-s / C-u s-e to create new shell/eshell buffer and SPC z r to give a mnemonic name to it.
;; C-o to switch to other shells
(defun arche/switch-to-buffer-same-major-mode ()
  "Using completing-read, switch to other buffers with the same major-mode"
  (interactive)
  (let ((buffers
	 (-filter
	  (lambda (buf)
	    (equal (with-current-buffer buf major-mode) major-mode))
	  (buffer-list))))
    (unless (< (length buffers) 2)
      (switch-to-buffer (completing-read
			 "Select buffer: "
			 (cl-remove (buffer-name) (mapcar #'buffer-name buffers)))))))

(general-define-key
 :keymaps '(eshell-mode-map shell-mode-map)
 "C-o" #'arche/switch-to-buffer-same-major-mode
 "C-<return>" #'delete-window)

(provide 'arche-term)


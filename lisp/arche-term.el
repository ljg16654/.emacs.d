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

;; Emulation of 'scratchpad' in i3
;; s-s / s-e to toggle or create side window for placing shell/eshell
;; C-u s-s / C-u s-e to create new shell/eshell buffer and SPC z r to give a mnemonic name to it.
;; In a shell, C-o to switch to other shells
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


(defun arche/toggle-window-with-major-mode (&optional major-mode-to-toggle raise-win-fn)
  "Toggle windows with specific major-mode in current frame. This
function is mainly written for major-modes of inferior
intepreters or shells.

If the argument `major-mode-to-toggle' is not given, choose the
major-mode associated with current buffer.

If no live windows with specified major-mode exist in current
frame, call `raise-win-fn' to open one. Otherwise, close all
lives windows that match specified major-mode.
"
  (interactive)
  (let* ((wl (window-list))
	 (mm (if major-mode-to-toggle major-mode-to-toggle major-mode))
	 (wl-filtered (-filter
		       #'(lambda (win)
			   (equal mm (with-current-buffer (window-buffer win) major-mode)))
		       wl)))
    (pcase (length wl-filtered)
      (0 (and raise-win-fn (funcall raise-win-fn)))
      (_ (mapcar #'delete-window wl-filtered)))))

(defun arche/toggle-eshell (&optional arg)
  "Toggle or create eshell buffer.

Without prefix arg, toggle eshell. Otherwise the behavior is the same as `eshell'."
  (interactive)
  (if arg
      (eshell arg)
    (arche/toggle-window-with-major-mode 'eshell-mode #'eshell)))

(global-set-key (kbd "s-e") #'arche/toggle-eshell)

(defun arche/toggle-shell ()
  (interactive)
  (arche/toggle-window-with-major-mode 'shell-mode #'shell))

(global-set-key (kbd "s-s") #'arche/toggle-shell)

(defun arche/switch-to-first-by-major-mode (mm)
  (switch-to-buffer-other-window (-first #'(lambda (buf)
					     (with-current-buffer buf (derived-mode-p mm)))
					 (buffer-list))))

(defun arche/raise-vterm ()
  (interactive)
  (arche/switch-to-first-by-major-mode 'vterm-mode))

(defun arche/toggle-vterm ()
  (interactive)
  (arche/toggle-window-with-major-mode 'vterm-mode #'arche/raise-vterm))

(global-set-key (kbd "s-v") #'arche/toggle-vterm)

(defun arche/raise-inferior-python ()
  (interactive)
  (arche/switch-to-first-by-major-mode 'inferior-python-mode))

(defun arche/toggle-python ()
  (interactive)
  (arche/toggle-window-with-major-mode 'inferior-python-mode #'arche/raise-inferior-python))

(global-set-key (kbd "C-c p") #'arche/toggle-python)

(general-define-key
 :keymaps '(eshell-mode-map shell-mode-map vterm-mode-map)
 "C-o" #'arche/switch-to-buffer-same-major-mode)

(provide 'arche-term)


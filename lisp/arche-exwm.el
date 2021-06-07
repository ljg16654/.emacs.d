(require 'arche-package)
(require 'arche-web)

(use-package exwm
  :init
  (winner-mode -1)
  (setq mouse-autoselect-window nil
        focus-follows-mouse t
        exwm-workspace-warp-cursor t
        exwm-workspace-number 5)
  :config
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-class-name)))
  
  (require 'arche-desktop)
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (pcase exwm-class-name
                ("qutebrowser" (exwm-workspace-rename-buffer (format "Qutebrowser: %s" exwm-title)))
		("Alacritty" (exwm-workspace-rename-buffer (format "Alacritty: %s" exwm-title))))))
  
  (add-hook 'exwm-init-hook #'(lambda () (setq arche/exwm-enabled t)))
  (define-key exwm-mode-map (kbd "C-q") #'exwm-input-send-next-key)
  (define-key exwm-mode-map (kbd "s-u") #'universal-argument)
  (define-key exwm-mode-map (kbd "C-u") #'(lambda () (interactive)
					    (execute-kbd-macro (read-kbd-macro "C-q C-u"))))
  
  (setq exwm-input-global-keys
	;; global keys that take effect both in  emacs buffers and X windows
	(list
	 (cons (kbd "s-a") #'(lambda () (interactive) (arche/raise-or-run "alacritty" "Alacritty: ")))
	 (cons (kbd "s-C") #'(lambda () (interactive)
			       (kill-buffer (current-buffer))
			       (unless (one-window-p) (delete-window))))
	 (cons (kbd "s-e") #'eshell)
	 (cons (kbd "s-f") #'arche/duckduckgo-search)
	 (cons (kbd "s-g") #'exwm-workspace-switch)
	 (cons (kbd "s-h") #'arche/browse-qutebrowser-hist)
	 (cons (kbd "s-k") #'(lambda () (interactive)
			       (kill-buffer (current-buffer))))
	 (cons (kbd "s-n") #'next-buffer)
	 (cons (kbd "s-o") #'switch-to-buffer)
	 (cons (kbd "s-C-o") #'counsel-wmctrl)
	 (cons (kbd "s-p") #'previous-buffer)
	 (cons (kbd "s-q") #'(lambda () (interactive) (arche/raise-or-run "qutebrowser" "Qutebrowser: ")))
	 (cons (kbd "s-r") #'exwm-reset)
	 (cons (kbd "s-t") #'arche/toggle-touchpad)
	 (cons (kbd "s-w") #'wordnut-search-and-capture)
	 (cons (kbd "s-#") #'desktop-environment-screenshot)
	 (cons (kbd "s-$") #'desktop-environment-screenshot-part)
	 (cons (kbd "χ") #'other-window)
	 (cons (kbd "ρ") #'(lambda () (interactive)
			     (other-window -1)))
	 (cons (kbd "θ") #'ace-window)))
  
  ;; toggle touchpad
;;;###autoload
  (defun arche/toggle-touchpad ()
    (interactive)
    "Toggle the dumb touchpad."
    (start-process-shell-command "sh" nil " sh ~/scripts/toggleTouchpad.sh"))

  ;; init tmux sessions
  (efs/run-in-background "sh ~/scripts/tmux_initialize_sessions.sh")
  
  ;; remap before sending to the X window
  (setq exwm-input-simulation-keys
	;; Use (read-key) to get cdr of the cons list
	(list
	 ;; M-w |-> C-c
	 (cons (kbd "M-w") [3])
	 ;; C-y |-> C-v
	 (cons (kbd "C-y") [22])
	 (cons (kbd "M-b") [C-left])
	 (cons (kbd "M-f") [C-right])
	 (cons (kbd "M-DEL") [C-backspace])))
  
  (exwm-enable)
  (require 'exwm-randr)
  (setq exwm-randr-workspace-monitor-plist '(0 "eDP-1-1" 1 "DP-1-2"))
  (exwm-randr-enable))


(provide 'arche-exwm)

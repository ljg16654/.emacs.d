(require 'arche-package)

(defvar arche/exwm-enabled nil)

(use-package exwm
  :init
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
  (define-key exwm-mode-map (kbd "χ") #'other-window)
  (define-key exwm-mode-map (kbd "ρ") #'(lambda () (interactive)
					  (other-window -1)))
  (global-set-key (kbd "θ") #'ace-window)
  (define-key exwm-mode-map (kbd "s-o") #'switch-to-buffer)
  
  (define-key exwm-mode-map (kbd "s-p") #'previous-buffer)
  (define-key exwm-mode-map (kbd "s-n") #'next-buffer)
  (define-key exwm-mode-map (kbd "s-k") #'(lambda () (interactive)
					    (kill-buffer (current-buffer))))

  (setq exwm-input-global-keys
	;; only for exwm-related commands
	(list
	 (cons (kbd "s-r") #'exwm-reset)
	 (cons (kbd "s-g") #'exwm-workspace-switch)
	 (cons (kbd "s-t") #'arche/toggle-touchpad)
	 (cons (kbd "s-q") #'(lambda () (interactive) (arche/raise-or-run "qutebrowser" "Qutebrowser: ")))
	 (cons (kbd "s-a") #'(lambda () (interactive) (arche/raise-or-run "alacritty" "Alacritty: ")))))
  
  ;; toggle touchpad
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
	 (cons (kbd "C-y") [22])))
  
  (exwm-enable)
  (require 'exwm-randr)
  (setq exwm-randr-workspace-output-plist '(0 "eDP-1-1"))
  (exwm-randr-enable))

(provide 'arche-exwm)

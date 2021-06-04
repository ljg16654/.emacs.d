(require 'arche-package)
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
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (pcase exwm-class-name
                ("qutebrowser" (exwm-workspace-rename-buffer (format "Qutebrowser: %s" exwm-title))))))
  
  (setq exwm-input-global-keys
	;; only for exwm-related commands
	(list
	 (cons (kbd "s-r") #'exwm-reset)
	 (cons (kbd "s-g") #'exwm-workspace-switch)))

  ;; toggle touchpad
  (defun arche/toggle-touchpad ()
    (interactive)
    "Toggle the dumb touchpad."
    (start-process-shell-command "sh" nil " sh ~/scripts/toggleTouchpad.sh"))
  
  ;; TODO write macro to do it together with global-set-key
  (define-key exwm-mode-map (kbd "C-q") #'exwm-input-send-next-key)
  (define-key exwm-mode-map (kbd "s-o") #'consult-buffer)
  (define-key exwm-mode-map (kbd "χ") #'other-window)
  (define-key exwm-mode-map (kbd "s-t") #'arche/toggle-touchpad)
  (global-set-key (kbd "s-t") #'arche/toggle-touchpad)

  ;; TODO implement run-or-raise in stumpwm

  ;; TODO find a decent launcher

  ;; TODO bufler setup

  ;; remap before sending to the X window 
  (setq exwm-input-simulation-keys
	(list
	 (cons (kbd "M-w") (kbd "C-c"))))
  
  (exwm-enable)
  (require 'exwm-randr)
  (setq exwm-randr-workspace-output-plist '(0 "eDP-1-1"))
  (exwm-randr-enable))

(provide 'arche-exwm)

(require 'arche-package)
(require 'arche-web)
(require 'arche-dictionaries)

(use-package exwm
  :init
  (winner-mode -1)
  (setq mouse-autoselect-window nil
        focus-follows-mouse t
        exwm-workspace-warp-cursor t
        exwm-workspace-number 2)
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
		("Alacritty" (exwm-workspace-rename-buffer (format "Alacritty: %s" exwm-title)))
		("Zathura" (exwm-workspace-rename-buffer (format "Zathura: %s" exwm-title)))
		("Firefox" (exwm-workspace-rename-buffer (format "Firefox: %s" exwm-title))))))

  (defun arche/setup-window-by-class ()
    (interactive)
    (pcase exwm-class-name
      ("qutebrowser" (exwm-workspace-move-window 1))))

  (add-hook 'exwm-manage-finish-hook
            (lambda ()
              ;; Send the window where it belongs
              (arche/setup-window-by-class)))

  (add-hook 'exwm-init-hook #'(lambda () (setq arche/exwm-enabled t)))
  (define-key exwm-mode-map (kbd "C-q") #'exwm-input-send-next-key)
  (define-key exwm-mode-map (kbd "s-u") #'universal-argument)
  (define-key exwm-mode-map (kbd "C-u") #'(lambda () (interactive)
					    (execute-kbd-macro (read-kbd-macro "C-q C-u"))))

  (defun arche/tmp-global-key (kbd func)
    (progn
      (define-key exwm-mode-map kbd func)
      (global-set-key kbd func)))

  ;; IMPORTANT: C-c C-k (exwm-input-release-keyboard) to open char-mode
  ;; Useful for virtual machines.

  (setq exwm-input-global-keys
	;; global keys that take effect both in  emacs buffers and X windows
	(list
	 (cons (kbd "s-a")	#'(lambda () (interactive) (arche/raise-or-run "alacritty" "Alacritty: ")))
	 (cons (kbd "s-b")	#'ibuffer)
	 (cons (kbd "s-c")	#'calendar)
	 (cons (kbd "s-C")	#'arche/kill-window-and-buffer-if-not-single)
	 (cons (kbd "s-e")	#'eshell)
	 (cons (kbd "s-f")	#'arche/duckduckgo-search)
	 (cons (kbd "s-g")	#'exwm-workspace-switch)
	 (cons (kbd "s-h")	#'arche/browse-qutebrowser-hist)
	 (cons (kbd "s-i")	#'arche/exwm-recent-workspace)
	 (cons (kbd "s-k")	#'arche/kill-current-buffer)
	 (cons (kbd "s-n")	#'next-buffer)
	 (cons (kbd "s-o")	#'switch-to-buffer)
	 (cons (kbd "s-C-o")	#'counsel-wmctrl)
	 (cons (kbd "s-p")	#'previous-buffer)
	 (cons (kbd "s-C-p")	#'proced)
	 (cons (kbd "s-q")	#'(lambda () (interactive)
				    (arche/raise-or-run "qutebrowser" "Qutebrowser: ")))
	 (cons (kbd "s-r")	#'exwm-reset)
	 (cons (kbd "s-t")	#'arche/toggle-touchpad)
	 (cons (kbd "s-v")	#'vterm-toggle)
	 (cons (kbd "s-w")	#'wordnut-search-and-capture)
	 (cons (kbd "s-C-SPC")	#'counsel-linux-app)
	 (cons (kbd "s-0")	#'(lambda () (interactive)
				    (exwm-workspace-switch-create 0)))
	 (cons (kbd "s-.")	#'tab-bar-switch-to-next-tab)
	 (cons (kbd "s-,")	#'tab-bar-switch-to-prev-tab)
	 (cons (kbd "s-[")	#'arche/exwm-previous-workspace)
	 (cons (kbd "s-]")	#'arche/exwm-next-workspace)
	 (cons (kbd "s-#")	#'desktop-environment-screenshot)
	 (cons (kbd "s-$")	#'desktop-environment-screenshot-part)
	 (cons (kbd "χ")	#'other-window)
	 (cons (kbd "ψ")	#'tab-bar-switch-to-recent-tab)
	 (cons (kbd "ρ")	#'(lambda () (interactive)
				    (other-window -1)))
	 (cons (kbd "θ")	#'ace-window)))

  ;; toggle touchpad
;;;###autoload
  (defun arche/toggle-touchpad ()
    (interactive)
    "Toggle the dumb touchpad."
    (start-process-shell-command "sh" nil " sh ~/scripts/toggleTouchpad.sh"))

  ;; remap before sending to the X window
  (setq exwm-input-simulation-keys
	;; Use (read-key) to get cdr of the cons list
	(list
	 ;; M-w |-> C-c
	 (cons (kbd "M-w") [3])
	 ;; C-y |-> C-v
	 (cons (kbd "C-y") [22])
	 (cons (kbd "C-a") [home])
	 (cons (kbd "C-e") [end])
	 (cons (kbd "C-p") [up])
	 (cons (kbd "C-n") [down])
	 (cons (kbd "C-f") [right])
	 (cons (kbd "C-b") [left])
	 (cons (kbd "M-b") [C-left])
	 (cons (kbd "M-f") [C-right])
	 (cons (kbd "M-DEL") [C-backspace])))

  (exwm-enable)
  (exwm-workspace-switch-create 1)
  (require 'exwm-randr)
  (setq exwm-randr-workspace-monitor-plist '(0 "eDP-1" 1 "DP-2" 2 "DP-2"))
  (add-hook 'exwm-randr-screen-change-hook
            (lambda ()
              (start-process-shell-command
               "autorandr" nil "autorandr --change")))
  (exwm-randr-enable))

(provide 'arche-exwm)

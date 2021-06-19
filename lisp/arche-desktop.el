;; see arche-web.el for more configuration related to the browser   
(require 'arche-package)
(require 'arche-elisp)
(defvar arche/transparency 85)

(defun arche/exwm-next-workspace ()
  (interactive)
  (let*
      ((current-idx (exwm-workspace--position exwm-workspace--current))
       (workspace-num (exwm-workspace--count))
       (next-idx (mod (+ 1 current-idx) workspace-num)))
    (exwm-workspace-switch next-idx)))

(defun arche/exwm-previous-workspace ()
  (interactive)
  (let*
      ((current-idx (exwm-workspace--position exwm-workspace--current))
       (workspace-num (exwm-workspace--count))
       (next-idx (mod (+ (- 1) current-idx) workspace-num)))
    (exwm-workspace-switch next-idx)))

(defvar arche/last-exwm-workspace-indice '(0 0)
  "(current, previous)")

(defun arche/exwm-switch-workspace-hook ()
  (unless
      (eq (exwm-workspace--position exwm-workspace--current)
	  (car arche/last-exwm-workspace-indice))
      (progn
	(setf (cdr arche/last-exwm-workspace-indice)
	      (car arche/last-exwm-workspace-indice))
	(setf (car arche/last-exwm-workspace-indice)
	      (exwm-workspace--position exwm-workspace--current)))))

(defun arche/exwm-recent-workspace ()
  (interactive)
  (let*
      ((current-idx (exwm-workspace--position exwm-workspace--current))
       (previous-idx (cdr arche/last-exwm-workspace-indice)))
    (if (not (eq current-idx previous-idx))
	(exwm-workspace-switch previous-idx))))

(add-hook 'exwm-workspace-switch-hook #'arche/exwm-switch-workspace-hook)

(arche/tmp-global-key (kbd "s-[") #'arche/exwm-previous-workspace)
(arche/tmp-global-key (kbd "s-]") #'arche/exwm-next-workspace)
(arche/tmp-global-key (kbd "H-SPC") #'arche/exwm-recent-workspace)

(use-package desktop-environment
  :after exwm
  :config
  (desktop-environment-mode)
  ;; TODO find latest screenshot
  )

(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

;; stumpwm simulation
;;;###autoload
(defun arche-desktop/filter-buffer-by-prefix (prefix)
  (-filter
   (lambda (buf)
     (s-prefix-p prefix (buffer-name buf)))
   (buffer-list)))

;;;###autoload
(defun arche/raise-or-run (cmd prefix)
  (let
      ((buf (car (arche-desktop/filter-buffer-by-prefix prefix))))
    (if buf
	(if (get-buffer-window buf)
	    (select-window (get-buffer-window buf))
	  (switch-to-buffer buf))
      (efs/run-in-background cmd))))

(defun arche/open-tmux-session-in-alacritty-completing-read ()
  "Prompt for selection of tmux session or open the only one."
  (interactive)
  (let*
      ((sessions (shell-command-to-string "tmux ls"))
       (session-list (--> (s-split "\n" sessions)
		       (-map (lambda (str) (car (s-split ":" str))) it)
		       (-filter (lambda (str) (not (s-blank? str))) it))))
    (cond
     ((> (seq-length session-list) 1)
      (efs/run-in-background
       (concat "alacritty -e tmux attach -t "
	       (completing-read "Select tmux session: "
				session-list))))
     ((eq (seq-length session-list 1))
      (efs/run-in-background
       (concat "alacritty -e tmux attach -t "
	       (car session-list))))
     (t (message "No active tmux session found.")))))

(defun arche/open-tmux-session-in-alacritty (session-name)
  (efs/run-in-background (concat "alacritty -e tmux attach -t" session-name)))

(global-set-key (kbd "C-x N")
		#'(lambda () (interactive (arche/open-tmux-session-in-alacritty "net-bt"))))
(global-set-key (kbd "C-x M")
		#'(lambda () (interactive (arche/open-tmux-session-in-alacritty "music"))))
(global-set-key (kbd "C-x D")
		#'(lambda () (interactive (arche/open-tmux-session-in-alacritty "default"))))
(global-set-key (kbd "C-x T")
		#'arche/open-tmux-session-in-alacritty-completing-read)

(defun arche/select-wallpaper ()
  "Use sxiv to select wallpaper. Then Use feh to set it."
  (interactive)
  (efs/run-in-background "~/scripts/select-wallpaper.sh"))

(defun transparency (value)
  "Set transparency value."
  (interactive "ntransparency value 0 - 100 opaque:")
  (setq arche/transparency value))

(defun arche/toggle-transparency ()
  "Toggle transparency of selected frame."
  (interactive)
  (let ((current-transparency (cdr (assoc 'alpha (frame-parameters (selected-frame))))))
    (cond ((eq current-transparency 100)
	   (set-frame-parameter (selected-frame) 'alpha arche/transparency))
	  (t
	   (set-frame-parameter (selected-frame) 'alpha 100)))))

(defun arche/open-pdf-in-zathura ()
  (interactive)
  (if (executable-find "zathura")
      (if (eq major-mode 'pdf-view-mode)
       (efs/run-in-background (concat "zathura "
				      (file-truename (buffer-file-name)))))
      (message "Cannot find zathura...")))

(define-key pdf-view-mode-map (kbd "z") #'arche/open-pdf-in-zathura)

(global-set-key (kbd "C-c t") #'arche/toggle-transparency)
(global-set-key (kbd "C-c W") #'arche/select-wallpaper)

(provide 'arche-desktop)

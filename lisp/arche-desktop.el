;; see arche-web.el for more configuration related to the browser   
(require 'arche-package)
(defvar arche/transparency 85)

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

(global-set-key (kbd "C-c t") #'arche/toggle-transparency)

(provide 'arche-desktop)

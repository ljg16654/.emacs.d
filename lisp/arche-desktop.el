;; see arche-web.el for more configuration related to the browser   
(require 'arche-package)
(require 'arche-elisp)

;;;###autoload
(defun arche-websearch ()
  (interactive)
  "If input starts with space, go to the link after the
space. Otherwise, search for the input."
  (let
      ((what (read-string "Search for: ")))
    (cond ((s-prefix-p " " what) (browse-url (s-trim what)))
	  ((s-prefix-p ",g " what) (browse-url (concat "https://github.com/search?q=" (s-chop-prefix ",g " what))))
	  ((s-prefix-p ",a " what)
	   (browse-url (concat "https://wiki.archlinux.org/index.php?search="
			       (string-replace " " "+"
					       (s-chop-prefix ",a " what)))))
	  ((s-prefix-p ",l " what)
	   (browse-url (concat "http://libgen.rs/search.php?req=" 
			       (string-replace " " "+"
					       (s-chop-prefix ",l " what)))))
	  (t (browse-url what)))))


;;;###autoload
(defun arche/browse-qutebrowser-hist ()
  (interactive)
  (let*
      ((hist (shell-command-to-string "~/scripts/qutebrowser-get-hist.sh"))
       (hist-list (-filter
		   (lambda (str) (not (s-blank? str)))
		   (s-split "\n" hist)))
       (url-with-description (completing-read "Choose from Qutebrowser history: " hist-list))
       (url (-last-item (s-split " " url-with-description))))
    (efs/run-in-background (concat
			    "qutebrowser "
			    url))))

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

(use-package desktop-environment
  :after (exwm telega)
  :config
  (setq desktop-environment-screenshot-directory "~/Pictures/screenshots")
  (desktop-environment-mode)
  (require 's)
  (defun latest-screenshot ()
    (concat desktop-environment-screenshot-directory "/"
	    (s-trim (shell-command-to-string (concat "ls "
						     desktop-environment-screenshot-directory
						     " | grep '.png$'  | sort | tail -n 1")))))
  (defun telega-send-latest-screenshot ()
    (interactive)
    (telega-buffer-file-send (latest-screenshot)
			     (telega-completing-read-chat "Send to chat: ") t)))

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

(defvar arche/wallpaper-dir "~/Pictures/Wallpapers/")

(defun arche/select-wallpaper ()
  "Use sxiv to select wallpaper. Then Use feh to set it."
  (interactive)
  (efs/run-in-background "~/scripts/select-wallpaper.fish"))

(defun transparency (value)
  "Set transparency value."
  (interactive "ntransparency value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(global-set-key (kbd "C-c t") #'arche/toggle-transparency)
(global-set-key (kbd "C-c W") #'arche/select-wallpaper)

(use-package app-launcher
  :straight '(app-launcher :host github :repo "SebastienWae/app-launcher"))

(use-package wttrin
  :config
  (setq wttrin-default-cities
	(list "Shanghai")))

(provide 'arche-desktop)

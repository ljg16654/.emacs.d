;; see arche-web.el for more configuration related to the browser   
(require 'arche-package)

(use-package desktop-environment
  :after exwm
  :config (desktop-environment-mode))

(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

;; stumpwm simulation
(defun arche-desktop/filter-buffer-by-prefix (prefix)
  (-filter
   (lambda (buf)
     (s-prefix-p prefix (buffer-name buf)))
   (buffer-list)))

(defun arche/raise-or-run (cmd prefix)
  (let
      ((buf (car (arche-desktop/filter-buffer-by-prefix prefix))))
    (if buf
	(if (get-buffer-window buf)
	    (select-window (get-buffer-window buf))
	  (switch-to-buffer buf))
      (efs/run-in-background cmd))))

(provide 'arche-desktop)

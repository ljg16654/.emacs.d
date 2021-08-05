(require 'arche-package)

(use-package telega
  :straight nil
  :config
  (setq telega-proxies
	'((:server "127.0.0.1"
		   :port 7890
		   :enable t
		   :type (:@type "proxyTypeHttp")
		   )))
  (add-hook 'telega-chat-mode-hook #'timeclock-query-out)
  (add-hook 'timeclock-in-hook #'(lambda () (telega-kill t)))
  (define-key dired-mode-map (kbd "H-s") #'telega-buffer-file-send)
  (add-hook 'telega-chat-mode-hook
	    #'(lambda () (setq line-spacing 0))))

(setq work-states
      '(work
	moyu
	entertain))

(defvar arche/state)

(defun select-work-state ()
  (interactive)
  (setq arche/state
	(completing-read "select state: "
			 work-states nil t)))

(add-hook 'org-clock-in-hook (lambda () (setq arche/state "work")))
(global-set-key (kbd "s-S") #'select-work-state)

(defun moyu-detection ()
  (when (boundp 'arche/state)
   (labels ((quit-telegram () (telega-kill t)))
     (if (equal arche/state "work")
	 (progn (quit-telegram)
		(message "¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿"))))))

(add-hook 'telega-root-mode-hook #'moyu-detection)
(add-hook 'telega-chat-mode-hook #'moyu-detection)

(provide 'arche-telegram)

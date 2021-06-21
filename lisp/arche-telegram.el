(require 'arche-package)
(use-package telega
  :config
  (setq telega-proxies
	'((:server "127.0.0.1"
		   :port 7890
		   :enable t
		   :type (:@type "proxyTypeHttp")
		   ))))

(define-key dired-mode-map (kbd "H-s") #'telega-buffer-file-send)

(add-hook 'telega-chat-mode-hook
	  #'(lambda () (setq line-spacing 0)))

(provide 'arche-telegram)

(require 'arche-package)
(use-package telega
  :config
  (setq telega-proxies
	'((:server "127.0.0.1"
		   :port 7890
		   :enable t
		   :type (:@type "proxyTypeHttp")
		   ))))
(provide 'arche-telegram)

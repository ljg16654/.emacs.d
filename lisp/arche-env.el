(setenv "PATH"
	(concat
	 ;; manually added
	 ;; sbcl
	 "/home/jigang/.local/lib/sbcl/" ";"
	 (getenv "PATH")))
(setenv "http_proxy" "http://127.0.0.1:7890")
(setenv "https_proxy" "http://127.0.0.1:7890")
(provide 'arche-env)

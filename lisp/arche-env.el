(setenv "PATH"
	(concat
	 ;; manually added
	 ;; sbcln
	 "/home/jigang/.local/lib/sbcl/" ";"
	 "/home/jigang/src/td/tdlib" ";"
	 "~/.local/bin" ";"
	 (getenv "PATH")))
(setenv "http_proxy" "http://127.0.0.1:7890")
(setenv "https_proxy" "http://127.0.0.1:7890")
(provide 'arche-env)

(require 'arche-package)
(setenv "PATH"
	(concat
	 ;; manually added
	 ;; sbcln
	 "/home/jigang/scripts/" ";"
	 ;; "/home/jigang/.local/lib/sbcl/" ";"
	 ;; "/usr/local/MATLAB/R2020a/bin/" ";"
	 ;; "/home/jigang/src/td/tdlib" ";"
	 "~/.local/bin" ";"
	 (getenv "PATH")))
(setenv "http_proxy" "http://127.0.0.1:7890")
(setenv "https_proxy" "http://127.0.0.1:7890")
(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))
(provide 'arche-env)

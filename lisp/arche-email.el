;; (setq gnus-select-method '(nnimap "imap.sjtu.edu.cn"))
(setq gnus-select-method '(nnnil nil))
(setq gnus-secondary-select-methods
      '(
	(nnimap "SJTU"
		(nnimap-address "imap.sjtu.edu.cn"))
	;; (nnimap "imap.sjtu.edu.cn")
	(nnimap "umich.edu"
		(nnimap-address "imap.gmail.com")
		(nnimap-server-port 993)
		(nnimap-inbox "INBOX")
		(nnimap-stream ssl))))
(provide 'arche-email)

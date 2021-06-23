(require 'arche-org)
;; (setq gnus-select-method '(nnimap "imap.sjtu.edu.cn"))
;;* gnus
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

;;* notmuch
(require 'notmuch)

(use-package mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :init
  (require 'org-mu4e)
  (require 'mu4e)
  :config
  (setq mail-user-agent 'mu4e-user-agent)
  (setq mu4e-maildir "/home/jigang/Maildir")
  (setq mu4e-get-mail-command "offlineimap")
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq mu4e-contexts
	`( ,(make-mu4e-context
	     :name "UMich"
	     :match-func (lambda (msg) (when msg
				    (string-prefix-p "/UMich" (mu4e-message-field msg :maildir))))
	     :vars '(
		     (mu4e-trash-folder . "/UMich/[Gmail].Trash")
		     (mu4e-refile-folder . "/UMich/[Gmail].Archive")
		     (smtpmail-smtp-server . "smtp.sjtu.edu.cn")
		     ))
	   ,(make-mu4e-context
	     :name "SJTU"
	     :match-func (lambda (msg) (when msg
				    (string-prefix-p "/SJTU" (mu4e-message-field msg :maildir))))
	     :vars '( 		   
		     (mu4e-trash-folder . "/SJTU/Trash")
		     (smtpmail-smtp-server . "smtp.gmail.com"))))))


(provide 'arche-email)

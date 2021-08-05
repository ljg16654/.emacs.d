(require 'arche-package)

(use-package mu4e
  :straight nil
  :init
  (require 'org-mu4e)
  (require 'mu4e)
  :config
  (add-hook 'mu4e-view-mode-hook #'olivetti-mode)
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
		     (smtpmail-smtp-server . "smtp.gmail.com")))
	   )))

(use-package mu4e-alert
  :config
  (defun my-mu4e-alert-mode-line-formatter (mail-count)
    (format "[unread: %d]" mail-count))
  (setq mu4e-alert-modeline-formatter #'my-mu4e-alert-mode-line-formatter)
  (mu4e-alert-enable-mode-line-display))


(provide 'arche-email)

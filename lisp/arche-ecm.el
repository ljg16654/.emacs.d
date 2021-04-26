;;*  Embark, Consult and Marginalia
(require 'arche-package)
(require 'arche-keybinding)
(use-package embark
  :after which-key
  :config
  (progn
    (global-set-key (kbd "H-e") #'embark-act)
    ;; quit minibuffer after performing the action when called from the minibuffer
    ;; the behavior can be reversed by calling 'embard-act' with 'C-u'
    (setq embark-quit-after-action t)
    (defun embark-act-noquit ()
      "Run action but don't quit the minibuffer afterwards."
      (interactive)
      (let ((embark-quit-after-action nil))
        (embark-act)))
    (global-set-key (kbd "H-M-e") #'embark-act-noquit)
    ;; integration with which-key
    (setq embark-action-indicator
          (lambda (map _target)
            (which-key--show-keymap "Embark" map nil nil 'no-paging)
            #'which-key--hide-popup-ignore-command)
          embark-become-indicator embark-action-indicator)
    ))

(use-package consult
  :config
  (progn
    ;; 'f SPC' for recentf
    (recentf-mode t)
    ))
(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))
(use-package marginalia)

;;* add action to exsiting category
(define-key embark-general-map (kbd "W") #'wordnut-search)
;;* new categories for embark
(add-to-list 'marginalia-prompt-categories
	     '("tab by name" . tab))
(provide 'arche-ecm)
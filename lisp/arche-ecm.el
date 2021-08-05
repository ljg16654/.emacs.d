;;*  Embark, Consult and Marginalia
(require 'arche-package)

(use-package embark
  :after which-key
  :config
  (define-key global-map (kbd "C-,") #'embark-act)
  (let ((map vertico-map))
    (define-key map (kbd "C-,") #'embark-act)
    (define-key map (kbd "M-q") #'embark-collect-toggle-view))
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
  (recentf-mode t)
  (global-set-key (kbd "M-i") #'consult-imenu)
  (global-set-key (kbd "ν") #'consult-mark))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

(use-package marginalia
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil)))

;;* add action to exsiting category
(define-key embark-general-map (kbd "W") #'wordnut-search)

(provide 'arche-ecm)

(global-set-key (kbd "H-l") #'embark-collect-completions)

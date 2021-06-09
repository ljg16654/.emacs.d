(require 'arche-package)

(if (not arche/enable-exwm)
    (progn
      (global-set-key (kbd "s-o") #'switch-to-buffer)
      (global-set-key (kbd "s-p") #'previous-buffer)
      (global-set-key (kbd "s-n") #'next-buffer)
      (global-set-key (kbd "s-k") #'(lambda () (interactive)
				      (kill-buffer (current-buffer))))
      (global-set-key (kbd "s-b") #'ibuffer)
      (global-set-key (kbd "s-.") #'tab-bar-switch-to-next-tab)
      (global-set-key (kbd "s-,") #'tab-bar-switch-to-prev-tab)
      (global-set-key (kbd "ψ") #'tab-bar-switch-to-recent-tab)))

(general-define-key
 :prefix "C-c f"
 "p" #'(lambda () (interactive) (find-file (concat user-emacs-directory "init.el")))
 "d" #'(lambda () (interactive) (find-file (file-truename "~/Downloads")))
 "c" #'(lambda () (interactive) (find-file (file-truename "~/Documents")))
 "l" #'(lambda () (interactive) (find-file (file-truename "~/org/reading-list.org"))))

(defun my-tab-tab-bar-toggle ()
  "Toggle `tab-bar' presentation."
  (interactive)
  (if (bound-and-true-p tab-bar-mode)
      (progn
        (setq tab-bar-show nil)
        (tab-bar-mode -1))
    (setq tab-bar-show t)
    (tab-bar-mode 1)))

(general-define-key
 :prefix "C-x t"
 "n" #'tab-bar-new-tab
 "k" #'tab-bar-close-tab
 "u" #'tab-bar-undo-close-tab
 "o" #'tab-bar-close-other-tabs
 "f" #'tab-bar-switch-to-next-tab
 "b" #'tab-bar-switch-to-prev-tab
 "r" #'tab-bar-rename-tab
 "c" #'tab-bar-select-tab
 "s" #'my-tab-tab-bar-toggle
 "t" #'tab-bar-select-tab-by-name)

(setq tab-bar-new-tab-choice "*scratch*")

(defun my-select-tab ()
  (interactive)
  (let ((tabs (mapcar (lambda (tab)
			(alist-get 'name tab))
		      (tab-bar--tabs-recent))))
    (cond
     ((eq tabs nil) (tab-new))
     ((eq (length tabs) 1) (tab-next))
     (t
      (tab-bar-switch-to-tab
       (completing-read "Select tab: " tabs nil t))))))

(use-package avy)
(global-set-key (kbd "s-'") #'avy-goto-word-1)

(use-package ace-window
  :config
  (setq aw-keys
	(list ?a ?s ?d ?f ?j ?k ?l ?q ?w ?e ?r ?x ?c ?v)))
(global-set-key (kbd "θ") #'ace-window)
(global-set-key (kbd "χ") #'other-window)
(global-set-key (kbd "ρ") #'(lambda () (interactive)
			      (other-window -1)))

(use-package bufler
  :disabled
  :straight t
  :bind (("C-M-j" . bufler-switch-buffer)
         ("C-M-k" . bufler-workspace-frame-set))
  :config
  (setf bufler-groups
        (bufler-defgroups
          ;; Subgroup collecting all named workspaces.
          (group (auto-workspace))
          ;; Subgroup collecting buffers in a projectile project.
          (group (auto-projectile))
          ;; Grouping browser windows
          (group
           (group-or "Browsers"
                     (name-match "Chromium" (rx bos "Chromium"))))
          (group
           (group-or "Chat"
                     (mode-match "Telega" (rx bos "telega-"))))
          (group
           ;; Subgroup collecting all `help-mode' and `info-mode' buffers.
           (group-or "Help/Info"
                     (mode-match "*Help*" (rx bos (or "help-" "helpful-")))
                     ;; (mode-match "*Helpful*" (rx bos "helpful-"))
                     (mode-match "*Info*" (rx bos "info-"))))
          (group
           ;; Subgroup collecting all special buffers (i.e. ones that are not
           ;; file-backed), except `magit-status-mode' buffers (which are allowed to fall
           ;; through to other groups, so they end up grouped with their project buffers).
           (group-and "*Special*"
                      (name-match "**Special**"
                                  (rx bos "*" (or "Messages" "Warnings" "scratch" "Backtrace" "Pinentry") "*"))
                      (lambda (buffer)
                        (unless (or (funcall (mode-match "Magit" (rx bos "magit-status"))
                                             buffer)
                                    (funcall (mode-match "Dired" (rx bos "dired"))
                                             buffer)
                                    (funcall (auto-file) buffer))
                          "*Special*"))))
          ;; Group remaining buffers by major mode.
          (auto-mode))))

(provide 'arche-buffer-management)

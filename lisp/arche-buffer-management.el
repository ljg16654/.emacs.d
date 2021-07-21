(require 'arche-package)

(defun arche/kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun arche/kill-window-and-buffer-if-not-single ()
  (interactive)
  (progn
    (kill-buffer (current-buffer))
    (unless (one-window-p) (delete-window))))

(use-package all-the-icons-ibuffer
  :init (all-the-icons-ibuffer-mode 1))

(if (not arche/enable-exwm)
    (progn
      (global-set-key (kbd "s-o") #'switch-to-buffer)
      (global-set-key (kbd "s-p") #'previous-buffer)
      (global-set-key (kbd "s-n") #'next-buffer)
      (global-set-key (kbd "s-k") #'arche/kill-current-buffer)
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

(defun polybar-disp-tabs ()
  "For displaying tabs in polybar.
In polybar config, add module of type `type = custom/script' and
specify exec = emacsclient -e '(polybar-disp-tabs)'"
  (let*
      ((tab-get-name (lambda (tab) (substring-no-properties (alist-get 'name tab))))
       (current-tab-name (funcall tab-get-name (tab-bar--current-tab)))
       (tab-names (mapcar (lambda (tab) (funcall tab-get-name tab)) (funcall tab-bar-tabs-function))))
    (string-join (mapcar
		  (lambda (name) (if (string-equal name current-tab-name) (concat ">>" name "<<")
			      name)) tab-names)
		 " ")))

(defun my-select-tab ()
  (interactive)
  (let ((tabs (mapcar (lambda (tab)
			(alist-get 'name tab))
		      (tab-bar--tabs-recent))))
    (cond
     ((eq tabs nil) (tab-new))
     ((eq (length tabs) 1) (tab-next))
     (t
      (tab-bar-switch-to-tabn
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

(defun arche/ace-focus-window (key-string)
  (execute-kbd-macro (read-kbd-macro
		      (concat "θ" key-string))))

(defmacro aw-bind-to-hyper (key-string)
  `(global-set-key (kbd (concat "H-" ,key-string))
		      #'(lambda () (interactive)
			  (arche/ace-focus-window ,key-string))))
(aw-bind-to-hyper "a")
(aw-bind-to-hyper "s")
(aw-bind-to-hyper "d")
(aw-bind-to-hyper "f")

(provide 'arche-buffer-management)

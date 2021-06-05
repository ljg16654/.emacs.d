(require 'arche-package)
(use-package eaf
  :disabled
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  :init
  (use-package epc :defer t :ensure t)
  (use-package ctable :defer t :ensure t)
  (use-package deferred :defer t :ensure t)
  (use-package s :defer t :ensure t)
  :custom
  (eaf-browser-continue-where-left-off t)
  :config
  ;; For keybindings to work in StumpWM, see
  ;; https://github.com/manateelazycat/emacs-application-framework/issues/657
  (add-to-list 'eaf-wm-focus-fix-wms "stumpwm")
  
  ;; ---------interleave is rubbish-----------
  ;;* Interleave
  ;; First enable the mode by default
  
  (add-hook 'eaf-mode-hook 'eaf-interleave-app-mode)
  ;; https://github.com/manateelazycat/emacs-application-framework/pull/267
  ;; keymap in the org file
  
  (general-define-key
   :keymaps 'eaf-interleave-mode-map
   "M-." #'eaf-interleave-sync-current-note
   "M-p" #'eaf-interleave-sync-previous-note
   "M-n" #'eaf-interleave-sync-next-note)

  ;;* Browser
  (global-set-key (kbd "s-h") #'eaf-search-it)
  (global-set-key (kbd "s-H") #'eaf-open-browser-with-history)
  (setq eaf-browser-default-search-engine "duckduckgo")

  (setq eaf-interleave-org-notes-dir-list
	(list
	 ;; "./" is automatically replaced by dir//pdf/file
	 "./"
	 "./notes"
	 "~/org-roam"
	 "~/org/interleave_notes")))

(provide 'arche-eaf)

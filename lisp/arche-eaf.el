(require 'arche-package)
(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  :init
  (use-package epc :defer t :ensure t)
  (use-package ctable :defer t :ensure t)
  (use-package deferred :defer t :ensure t)
  (use-package s :defer t :ensure t)
  :custom
  (eaf-browser-continue-where-left-off t)
  :config
  (setq eaf-org-override-pdf-links-open nil)
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (eaf-bind-key nil "M-q" eaf-browser-keybinding))

;; For keybindings to work in StumpWM, see
;; https://github.com/manateelazycat/emacs-application-framework/issues/657
(add-to-list 'eaf-wm-focus-fix-wms "stumpwm")
(eaf-setq eaf-browser-default-zoom "2.25")
(defun eaf-open-demo-clone ()
  "Open my clone of EAF demo screen to verify that EAF is working properly."
  (interactive)
  (eaf-open "eaf-demo_clone" "demo-clone"))


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

;; keymap in the eaf application
(general-define-key
 :keymaps 'eaf-interleave-app-mode-map
 "C-c M-i" #'eaf-interleave-add-note
 "C-c M-o" #'eaf-interleave-open-notes-file
 "C-c M-q" #'eaf-interleave-quit)

(setq eaf-interleave-org-notes-dir-list
      (list
       ;; "./" is automatically replaced by dir//pdf/file
       "./"
       "./notes"
       "~/org-roam"
       "~/org/interleave_notes"))

;;* Browser
(global-set-key (kbd "s-h") #'eaf-search-it)
(global-set-key (kbd "s-H") #'eaf-open-browser-with-history)
(setq eaf-browser-default-search-engine "duckduckgo")

(provide 'arche-eaf)

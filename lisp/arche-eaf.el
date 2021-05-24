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

(global-set-key (kbd "s-h") #'eaf-open-browser-with-history)
(setq eaf-browser-default-search-engine "duckduckgo")

(provide 'arche-eaf)

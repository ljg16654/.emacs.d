(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d gcs"
                     (format "%.2f seconds" (float-time (time-subtract
                                                         after-init-time
                                                         before-init-time)))
                     gcs-done)))

(setq gc-cons-threshold 128000000)
(add-hook 'after-init-hook (lambda ()
                             ;; restore after startup
                             (setq gc-cons-threshold (default-value 'gc-cons-threshold))))

(setq inhibit-startup-message t)
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

(defconst my-emacs-d (file-name-as-directory user-emacs-directory)
  "Directory of emacs.d")

(defconst my-site-lisp-dir (concat my-emacs-d "site-lisp")
  "Directory of site-lisp")

(defconst my-lisp-dir (concat my-emacs-d "lisp")
  "Directory of lisp.")

(add-to-list 'load-path my-lisp-dir)

;; each use-package form also invoke straight.el to install the package
(require 'arche-package)
(require 'arche-keybinding)
(require 'arche-dired)
(require 'arche-pdf)
(require 'arche-elisp)
(require 'arche-org)
(require 'arche-hydra)
(require 'arche-yas)
(require 'arche-minibuffer-completion)
(require 'arche-ecm)
(require 'arche-helm)
(require 'arche-company)
(require 'arche-rg)
(require 'arche-popup)
(require 'arche-window-buffer-rule)
(require 'arche-buffer-management)
(require 'arche-isearch)
(require 'arche-git)
(require 'arche-projectile)
(require 'arche-epub)
(require 'arche-rss)
(require 'arche-font)
(require 'arche-theme)
(require 'arche-prog)
(require 'arche-lisps)
(require 'arche-py)
(require 'arche-c)
(require 'arche-matlab)
(require 'arche-rust)
(require 'arche-lsp)
(require 'arche-misc)
(require 'arche-dictionaries)
(require 'arche-term)
(require 'arche-modeline)
(require 'arche-env)
(require 'arche-web)
(require 'arche-email)
(require 'arche-telegram)
(require 'arche-log)
(require 'arche-chinese)
(require 'arche-sibling)
(server-start)
 
(put 'narrow-to-region 'disabled nil)

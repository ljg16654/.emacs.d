(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d gcs"
                     (format "%.2f seconds" (float-time (time-subtract
                                                         after-init-time
                                                         before-init-time)))
                     gcs-done)))

(defvar arche/file-name-handler-alist file-name-handler-alist)

(setq gc-cons-threshold 128000000
      gc-cons-percentage 0.6)

(setq inhibit-startup-message nil)
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)
(setq warning-minimum-log-level :error)

(defconst my-emacs-d (file-name-as-directory user-emacs-directory)
  "Directory of emacs.d")

(defconst my-site-lisp-dir (concat my-emacs-d "site-lisp")
  "Directory of site-lisp")

(defconst my-lisp-dir (concat my-emacs-d "lisp")
  "Directory of lisp.")

(add-to-list 'load-path my-lisp-dir)

;; each use-package form also invoke straight.el to install the package
(setq debug-on-error t)

(defvar arche/enable-exwm t)
(defvar arche/exwm-enabled nil)
(defvar arche/go-evil nil)

(require 'arche-package)
(require 'arche-keybinding)
(require 'arche-hyperbole)
(require 'arche-dired)
(require 'arche-pdf)
(require 'arche-elisp)
(require 'arche-org)
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
(require 'arche-project)
(require 'arche-readings)
(require 'arche-rss)
(require 'arche-font)
(require 'arche-theme)
(require 'arche-prog)
(require 'arche-lisps)
(require 'arche-py)
(require 'arche-c)
;; (require 'arche-matlab)
;; (require 'arche-science)
(require 'arche-rust)
(require 'arche-haskell)
(require 'arche-lsp)
(require 'arche-modeline)
(require 'arche-misc)
(require 'arche-dictionaries)
(require 'arche-term)
(require 'arche-env)
(require 'arche-web)
(require 'arche-email)
(require 'arche-telegram)
(require 'arche-log)
(require 'arche-im)
(require 'arche-sibling)
(require 'arche-music)
(require 'arche-ledger)
;; (require 'arche-eaf)
(if arche/enable-exwm (require 'arche-exwm))

(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1
      file-name-handler-alist arche/file-name-handler-alist)

(server-start)

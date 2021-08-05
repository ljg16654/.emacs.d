(require 'arche-package)
(require 'arche-keybinding)

(use-package org
  :after (general)
  :custom
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers nil)
  (org-image-actual-width nil)
  (org-export-with-toc nil)
  (org-imenu-depth 7)
  (org-capture-bookmark nil "otherwise all captures will have wired bookmark faces...  ")
  (system-time-locale "C")
  (org-agenda-files (list "~/org/todo.org"))
  :config
  (general-define-key
   :keymaps 'org-mode-map
   "M-h" #'org-metaleft
   "M-H" #'mark-paragraph
   "M-l" #'org-metaright
   "C-c e" #'org-mark-element)
  ;; window behavior when following org-mode-link
  (setq org-link-frame-setup
	'((vm . vm-visit-folder-other-frame)
	  (vm-imap . vm-visit-imap-folder-other-frame)
	  (gnus . org-gnus-no-new-news)
	  (file . find-file)
	  (wl . wl-other-frame)))
  (setq org-link-elisp-skip-confirm-regexp (rx (or "man" "wordnut-search")))
  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("^ *\\([-]\\) "
  ;;                            (0 (prog1 ()
  ;; 				  (compose-region (match-beginning 1) (match-end 1) "•"))))))
  
  (defun update-org-latex-fragments ()
    (if (equal major-mode 'org-mode)
	(org-latex-preview '(64))
      (plist-put org-format-latex-options :scale (* 3 text-scale-mode-amount))
      (org-latex-preview '(16))))
  (use-package org-bullets)
  (defun arche-org-mode-hook ()
    (progn
      (auto-fill-mode t)
      (org-bullets-mode t)
      (org-indent-mode t)
      (if (one-window-p) (olivetti-mode t))))

  (add-hook 'org-mode-hook #'arche-org-mode-hook)
  ;; TODO have a look at https://github.com/progfolio/doct
  (setq org-capture-templates
	'(("t" "Personal todo" entry
           (file+headline "todo.org" "Inbox")
           "* TODO %?\n%i" :prepend t)
          ("r" "read later" checkitem
           (file+headline "read-later.org" "Inbox")
           "[ ] %? ")
	  ;; TODO capture template for wordnut-buffer
          ("w" "word" plain
	   (file+headline "words.org" "Inbox")
	   "[[elisp:(wordnut-search \"%(org-capture-wordnut-capture)\")][%(org-capture-wordnut-capture)]]")))
  ;;* agenda
  (setq org-todo-keywords
	'((sequence "TODO(t)" "STUCK(z@/@)" "|" "DONE(d@)" "CANCELLED(c@)")))

  
  (setq org-agenda-restore-windows-after-quit t
	;; wiredly, the window abides by display-buffer-alist when 'only-window is set
	org-agenda-window-setup 'only-window)
  ;;* babel
  ;;** basic setup
  (setq-default org-hide-block-startup t)
  (setq org-edit-src-content-indentation 0)
  (setq org-src-tab-src-acts-natively t)
  ;; leading whitespace not preserved on export
  (setq org-src-preserve-indentation nil)
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-window-setup 'current-window)
  ;; display/update images in the buffer after I evaluate
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
  ;; citations
  (require 'arche-oc)
  
  :bind
  (("H-c" . org-capture)))

(use-package org-timeline
  :config
  (add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append))
;;* journal
;; https://stackoverflow.com/questions/28913294/emacs-org-mode-language-of-time-stamps
;; make sure the weekdays in the time stamps of Org mode files appear in English

;; org journal also provides integration with Emacs Calendar, see ./arche-log.el
;; try "j r", "j d" "j n" over dates in calendar-mode!
(use-package org-journal
  :custom
  ;; Otherwise separate headings with time as titles are created for each new entry
  (org-journal-time-prefix nil)
  (org-journal-file-type 'monthly))

;;** writing LaTeX
;; (require 'arche-org-latex-inline-math)

(use-package org-download
  :config
  (setq org-download-screenshot-method "scrot -s %s"))

(use-package org-noter
  :config
  (progn
    (setq org-noter-always-create-frame t)
    (setq org-noter-notes-search-path
	  '("~/Documents/"
	    "~/org-roam/"))))

(use-package org-pdftools
  :after (pdf-tools)
  :hook (org-mode . org-pdftools-setup-link))

(global-set-key (kbd "C-c n l") #'org-store-link)
(setq org-file-apps '((auto-mode . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . default)))

;; (use-package ob-ipython)

(use-package plantuml-mode
  :config
  (progn
    (setq org-plantuml-jar-path (expand-file-name "~/tools/plantuml.1.2021.6.jar"))
    (add-to-list
     'org-src-lang-modes '("plantuml" . plantuml))))

(setq org-babel-python-command "python3")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (lisp . t)
   (scheme . t)
   (gnuplot . t)
   (shell . t)
   (java . t)
   (C . t)
   (clojure . t)
   (js . t)
   (ditaa . t)
   (plantuml . t)
   (dot . t)
   (org . t)
   (latex . t)
   (haskell . t)
   (ditaa . t)
   (maxima . t)
   (ledger . t)
   ;; (ipython . t)
   ;; provided by package ob-ipython
   ;; (matlab . t)
   ))

(use-package cdlatex
  :hook (org-mode-hook . #'org-cdlatex-mode))

(use-package org-fragtog
  :config
  (add-hook 'org-mode-hook #'org-fragtog-mode))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 4))

;;;###autoloadovement between blocks
(defun arche-cc-preserve-current-window ()
  "Issue org-ctrl-c-ctrl-c and force stay in current window."
  (interactive)
  (let
      ((tmp-window (get-buffer-window)))
    (progn
      (org-ctrl-c-ctrl-c)
      (select-window tmp-window))))

(defhydra 'org-blocks
  (org-mode-map "H-b")
  ("j" #'(lambda () (interactive)
	   (progn
	     (call-interactively 'org-next-block)
	     (reposition-window))))
  ("k" #'(lambda () (interactive)
	   (progn
	     (call-interactively 'org-previous-block)
	     (reposition-window))))
  ("c" #'arche-cc-preserve-current-window))

(use-package magic-latex-buffer)

;;* org-ref
(require 'arche-org-ref)
(require 'arche-roam)
(provide 'arche-org)

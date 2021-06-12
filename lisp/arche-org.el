;; -*- Lexical-binding: t; -*-
(require 'arche-package)
(require 'arche-pdf)
(require 'cl-lib)
(require 'arche-company)
(require 'arche-hydra)
(require 'arche-misc)
;; (use-package org
;;   :straight org-plus-contrib)
(use-package org)

;;* appearance stuff 
(setq org-ellipsis " ▾"
      org-hide-emphasis-markers nil
      org-imenu-depth 7
      org-export-with-toc nil
      org-image-actual-width nil)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Rescale latex-preview, adopted from
;; https://emacs.stackexchange.com/questions/3387/how-to-enlarge-latex-fragments-in-org-mode-at-the-same-time-as-the-buffer-text
;; text-scale-mode is automatically turned on after text-scale-adjust
;;;###autoload
(defun update-org-latex-fragments ()
  (if (eq major-mode 'org-mode)
   (org-latex-preview '(64))
   (plist-put org-format-latex-options :scale (* 1.6 text-scale-mode-amount))
   (org-latex-preview '(16))))

;; (remove-hook 'text-scale-mode-hook 'update-org-latex-fragments)

(use-package org-bullets)

;;* ed
;;;###autoloaditing experience
(defun arche-org-mode-hook ()
  (progn
    (auto-fill-mode t)
    (org-bullets-mode t)
    (org-indent-mode t)
    (flyspell-mode t)
    (olivetti-mode t)))

(add-hook 'org-mode-hook #'arche-org-mode-hook)

;;* capture
;; If set to t, all captures will have wired bookmark faces...  
(setq org-capture-bookmark nil)
(setq org-link-elisp-skip-confirm-regexp
      (rx (or "man" "wordnut-search")))

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

(global-set-key (kbd "H-c") #'org-capture)

;;* journal
;; https://stackoverflow.com/questions/28913294/emacs-org-mode-language-of-time-stamps
;; make sure the weekdays in the time stamps of Org mode files appear in English
(setq system-time-locale "C")
;; org journal also provides integration with Emacs Calendar, see ./arche-log.el
;; try "j r", "j d" "j n" over dates in calendar-mode!
(use-package org-journal
  :config
  (progn
    ;; Otherwise separate headings with time as titles are created for each new entry
    (setq org-journal-time-prefix nil)
    (setq org-journal-file-type 'monthly)))

;;** writing LaTeX
(require 'arche-org-latex-inline-math)

;;* search and query
(use-package helm-org-rifle)

;;* links
;; enables org-mode style fontification and activation of
;; bracket links in modes other than org-mode.
;; (use-package org-link-minor-mode)

;; window behavior when following org-mode-link
(setq org-link-frame-setup
      '((vm . vm-visit-folder-other-frame)
	(vm-imap . vm-visit-imap-folder-other-frame)
	(gnus . org-gnus-no-new-news)
	(file . find-file)
	(wl . wl-other-frame)))

(defun arche/follow-org-mode-link-other-window ()
  (let ((org-link-frame-setup
	 '((vm . vm-visit-folder-other-frame)
	  (vm-imap . vm-visit-imap-folder-other-frame)
	  (gnus . org-gnus-no-new-news)
	  (file . find-file-other-window)
	  (wl . wl-other-frame)))))
  (org-open-at-point))

(use-package org-download
  :config
  (progn (setq org-download-screenshot-method "gnome-screenshot -a -f %s")))

(use-package org-noter
  :config
  (progn
    (setq org-noter-always-create-frame t)
    (setq org-noter-notes-search-path
	  '("~/Documents/"
	    "~/org-roam/"))))

(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(global-set-key (kbd "C-c n l") #'org-store-link)
(setq org-file-apps '((auto-mode . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . default)
                      ;; ("\\.pdf\\'" . "zathura %s")
))

;;* keybindings 
(general-define-key
 :keymaps 'org-mode-map
 "M-h" #'org-metaleft
 "M-H" #'mark-paragraph
 "M-l" #'org-metaright
 "C-c e" #'org-mark-element)

;;* agenda
(setq org-todo-keywords
      '((sequence "MAYBE(m@)" "TODO(t)" "IN-PROGRESS(i@)" "STUCK(z@/@)" "|" "DONE(d@)" "CANCELLED(c@)")
        (sequence "BUG(b/@)" "KNOWNCAUSE(k@)" "|" "FIXED(f)")
        (sequence "STUDY(s)" "|" "STUDIED(S@)" "ARCHIVED(a@)")
        ))
(setq org-stuck-projects
      ;; identify a project with TODO keywords/tags
      ;; identify non-stuck state with TODO keywords
      ;; identify non-stuck state with tags
      ;; regexp match non-stuck projects
      '("-moyu&-MAYBE" ("TODO" "IN-PROGRESS" "BUG" "KNOWNCAUSE") nil ""))

;;* babel
;;** basic setup
(setq org-edit-src-content-indentation 0)
(setq org-src-tab-src-acts-natively t)
;; leading whitespace not preserved on export
(setq org-src-preserve-indentation nil)
(setq org-confirm-babel-evaluate nil)
(setq org-src-window-setup 'current-window)
;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;;** load languages
(require 'arche-matlab)

(require 'arche-mma)

(use-package ob-ipython)

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
   (ipython . t) ;; provided by package ob-ipython
   (matlab . t)
   ))

;;** m
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

;;* org-ref
(require 'arche-org-ref)
(require 'arche-roam)
(provide 'arche-org)

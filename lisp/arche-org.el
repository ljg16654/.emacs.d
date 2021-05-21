(require 'arche-package)
(require 'arche-pdf)
(require 'cl-lib)
(require 'arche-company)
(require 'arche-dictionaries)
(use-package org
  :straight org-plus-contrib)

;;* appearance stuff 
(setq org-ellipsis " ▾"
      org-hide-emphasis-markers t
      org-imenu-depth 7
      org-export-with-toc nil
      )
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(use-package org-bullets)

;;* editing experience
(defun arche-org-mode-hook ()
  (progn
    (auto-fill-mode)
    (org-bullets-mode)
    (org-indent-mode)
    (flyspell-mode)
    ))
(add-hook 'org-mode-hook #'arche-org-mode-hook)

;;* capture
(setq org-link-elisp-skip-confirm-regexp
      (rx "wordnut-search"))

(defun org-capture-wordnut-capture ()
  "Get the word being displayed in *Wordnut* buffer if it exists."
  (with-current-buffer "*WordNut*"
    (wordnut--lexi-word)))

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

(defun arche-wordnut-search (word)
  "Prompt for a word to search for, then do the lookup."
  (interactive (list (wordnut--completing (if (eq major-mode 'pdf-view-mode) "" (current-word t t)))))
  (ignore-errors
    (wordnut--history-update-cur wordnut-hs))
  (wordnut--lookup word))

(defun wordnut-search-and-capture ()
  "Perform wordnut-search and then capture."
  (interactive)
  (progn
    ;; (call-interactively #'wordnut-search)
    (call-interactively #'arche-wordnut-search)
    (org-capture nil "w")
    (org-capture-finalize)))

(global-set-key (kbd "s-w") #'wordnut-search-and-capture)

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

;;* refile
(use-package helm-org-rifle)

;;* links
;; enables org-mode style fontification and activation of
;; bracket links in modes other than org-mode.
;; (use-package org-link-minor-mode)

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

(use-package org-noter-pdftools
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freestyle-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

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

;;* org-ref
(require 'arche-org-ref)
(require 'arche-roam)
(provide 'arche-org)

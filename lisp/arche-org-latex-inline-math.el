(require 'arche-package)
(require 'arche-company)
(require 'cl-lib)
(require 'company)

(setq org-format-latex-options
      '(:foreground default
		    :background default
		    :scale 4.2
		    :html-foreground "Black" :html-background "Transparent" :html-scale 1.0
		    :matchers
		    ("begin" "$1" "$" "$$" "\\(" "\\[")))

(use-package auctex :defer t)
(use-package cdlatex)
(add-hook 'org-mode-hook #'(lambda ()
			     (org-cdlatex-mode t)))

(use-package org-fragtog
  :after org)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(defvar inline-math-candidates '()
  "A list of strings. Stored for completion of inline math LaTeX
  fragments.")

(defun my-org-get-inline-math () 
  "Get inline math around cursor"
       (interactive)
       (let* ((context (org-element-context))
	      (type (org-element-type context)))
	 (when (memq type '(latex-environment latex-fragment))
	   (my-remove-inline-matrix-delimiter (org-element-property :value context))
	   )))

(defun my-org-get-inline-math-prefix ()
  "Prefix definition for company backend. Returns nil if the
cursor is no inside a latex fragment. Otherwise, the substring
between left delimiter and the current cursor is returned."
  ;; the prefix must be immediately before the pointer
  ;; first confirm the point is inside a latex-fragment
  ;; then search-forward for '\\(' and obtain the prefix
  (interactive
   let* ((context (org-element-context))
	 (type (org-element-type context)))
   (when (eq type 'latex-fragment)
     (let* ((inline-math (org-element-property :value context))
	    (inline-math-prefix-point-min (+ (save-excursion (re-search-backward (rx "\\("))) 2)))
       (buffer-substring-no-properties inline-math-prefix-point-min (point))))))

(defun my-org-get-all-inline-math ()
  "Store all inline math LaTeX fragments in the `inline-math-candidates'"
  (interactive)
  (progn
    (save-excursion (progn (setq inline-math-candidates nil)
			   (goto-char (point-min))
			   (while (re-search-forward
				   (rx (not "=") "\\(")
				   (point-max) t)
			     (add-to-list 'inline-math-candidates (my-org-get-inline-math))
			     )))))

(defun my-remove-inline-matrix-delimiter (str)
  "Given the value of a LaTeX fragment org element, remove its
delimiters to make it an appropriate candidate for completion."
  (string-remove-prefix "\\("
			(string-remove-suffix "\\)"
					      str)))

(defun company-inline-math-backend (command &optional arg &rest ignored)
  "The company backend for completing inline math LaTeX
fragments.  The candidates are obtained by trasversing all LaTeX
fragments in the org buffer"
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-inline-math-backend))
    (prefix (and (eq major-mode 'org-mode)
		 (my-org-get-inline-math-prefix)))
    (candidates
	     (cl-remove-if-not
	      (lambda (str) (string-prefix-p arg str))
	      (progn (my-org-get-all-inline-math)
		    inline-math-candidates)))))

(add-to-list 'company-backends #'company-inline-math-backend)

(defun my-select-inline-math ()
  "Complete inline math and insert."
  (interactive)
    (insert (try-completion "Select inline math: "
		 (progn (my-org-get-all-inline-math)
			inline-math-candidates)
		 nil t)))


(defun my-tcolorbox-get-env-labels ()
  "In current org-mode buffer, get the labels of blocks with envrionment defined within \newtcb*."
  (interactive)
  (let* ((label-prefix
	  ;; The prefix is the name of LaTeX environment defined with
	  ;; \newtcb* (see tcolorbox manual p355 'library theorems')
	  ;; they've been configured to be identical with name of corresponding
	  ;; org blocks.
	  (completing-read
	   "tcolorbox environment name: "
	   (list "theorem"
		 "lemma"
		 "corollary"
		 "proposition"
		 "remark"
		 "definition")))
	 (src-block-regexp
	  (concat (rx "#+" (or "begin" "BEGIN") "_") label-prefix)))
    (progn
      (setq my-tcolorbox-env-label-candidates nil)
      (save-excursion
	(progn
	  (message "%s" (concat "searching for block regexp: "
				src-block-regexp))
	  (sleep-for 0.5)
	  (goto-char (point-min))
	  ;; recursively search for org block that match #+begin_'label-prefix'
	  (while (re-search-forward src-block-regexp (point-max) t)
	    (progn
	      (previous-line)
	      ;; is the optional label given? 
	      (if (string-match
		   "#\\+[aA][tT][tT][rR]_[lL][aA][tT][eE][xX]: *:options *{[a-zA-Z_\\- ]+} *{[a-zA-Z_ ]+}"
		   (thing-at-point 'line 'no-properties))
		  (progn
		    (search-forward "{" (line-end-position) t)
		    (search-forward "{" (line-end-position) t)
		    (message "%s" (concat "got label:" (thing-at-point 'word 'no-properties)))
		    ;; DEBUG 
		    (sleep-for 1)
		    (add-to-list 'my-tcolorbox-env-label-candidates
				 (thing-at-point 'word 'no-properties))))
	      ;; until the line below #+begin_...  
	      (next-line)
	      (next-line)))
	  )))
    (if my-tcolorbox-env-label-candidates
	(insert (completing-read "choose" (mapcar
					   #'(lambda (str) (concat label-prefix ":" str))
					   my-tcolorbox-env-label-candidates)))
      (message "No such env in current buffer!"))))


(provide 'arche-org-latex-inline-math)
(string-match (rx "#+" (or "begin" "BEGIN") "_") "#+BEGIN_src sjf")
(rx (zero-or-more " "))

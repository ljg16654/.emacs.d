(require 'arche-package)
(use-package org-ref
  :custom
  ;; cache position
  (orhc-bibtex-cache-file "~/.cache/emacs/orhc-bibtex-cache")
  :config
  (progn
    ;; The name of the BibTeX field in which the path to PDF files is stored
    ;; and bibtex-completion will look up PDF in the directories
    ;; specifies by 'bibtex-completion-library-path
    (setq bibtex-completion-pdf-field "file")
    (let* ((my-ref-bibtex
	    (mapcar #'file-truename
		    (list
		     "~/library/hcimu.bib")))
	   (my-pdf-parent-dirs
	    (mapcar #'file-truename (list
				     "~/library/pdf/"
				     "~/library/epub/"
				     "~/library/djvu/"))))
      (setq reftex-default-bibliography my-ref-bibtex
	    org-ref-default-bibliography my-ref-bibtex
	    org-ref-bibtex-files my-ref-bibtex
	    bibtex-completion-bibliography my-ref-bibtex
	    bibtex-completion-pdf-extension (list ".pdf"
						  ".djvu"
						  ".epub")
	    org-ref-pdf-directory my-pdf-parent-dirs
	    bibtex-completion-library-path my-pdf-parent-dirs))
    (setq org-ref-get-pdf-filename-function #'org-ref-get-pdf-filename-helm-bibtex
	  org-ref-open-pdf-function #'org-ref-open-pdf-at-point))) 
(define-key org-mode-map (kbd "H-p") #'org-ref-open-pdf-at-point)

(defun harvard-cite (key page)
  "From https://emacs.stackexchange.com/questions/52479/how-do-you-create-an-org-ref-harvard-style-in-text-citation-with-a-page-number"
  (interactive (list (completing-read "Cite: " (orhc-bibtex-candidates))
		     (read-string "Page: ")))
  (insert
   (org-make-link-string (format "cite:%s"
				 (cdr (assoc
				       "=key="
				       (cdr (assoc key (orhc-bibtex-candidates))))))
			 page)))

(define-key org-mode-map (kbd "H-h") #'harvard-cite)

(require 'arche-org-export)
(provide 'arche-org-ref)

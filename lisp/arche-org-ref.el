(require 'arche-package)
(use-package org-ref
  :config
  (progn
    ;; The name of the BibTeX field in which the path to PDF files is stored
    ;; and bibtex-completion will look up PDF in the directories
    ;; specifies by 'bibtex-completion-library-path
    (setq bibtex-completion-pdf-field "file")
    (let* ((my-ref-bibtex
	    (mapcar #'file-truename
		    (list
		     "~/library/hcimu.bib"
		     )))
	   (my-pdf-parent-dirs
	    (mapcar #'file-truename (list
				     "~/Zot/mylib/"
				     "~/Zot/math/"
				     "~/library/"
				     "~/library/pdf/"
				     ))))
      (setq reftex-default-bibliography my-ref-bibtex
	    org-ref-default-bibliography my-ref-bibtex
	    bibtex-completion-bibliography my-ref-bibtex
	    org-ref-pdf-directory my-pdf-parent-dirs
	    bibtex-completion-library-path my-pdf-parent-dirs))
    (setq org-ref-get-pdf-filename-function #'org-ref-get-pdf-filename-helm-bibtex
	  org-ref-open-pdf-function #'org-ref-open-pdf-at-point)))
(define-key org-mode-map (kbd "H-p") #'org-ref-open-pdf-at-point)
(require 'arche-org-export)
(provide 'arche-org-ref)

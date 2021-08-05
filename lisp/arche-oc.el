(setq my-global-bibtex-file (file-truename "~/library/hcimu.bib"))

;; for oc.el
(setq org-cite-global-bibliography (list my-global-bibtex-file))
;; for bibtex.el
(setq bibtex-files (list my-global-bibtex-file))

(provide 'arche-oc)

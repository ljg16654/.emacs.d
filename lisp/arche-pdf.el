(require 'arche-package)

(use-package pdf-tools :straight nil
  :config
  (pdf-tools-install)

  (general-define-key
   :keymaps 'pdf-view-mode-map
   ;; tips:
   ;; W to fit width
   ;; H to fit height
   "o" #'pdf-outline
   "/" #'pdf-occur
   "j" #'pdf-view-next-line-or-next-page
   "k" #'pdf-view-previous-line-or-previous-page
   "z" #'pdf-annot-add-highlight-markup-annotation
   "_" #'pdf-annot-add-underline-markup-annotation
   "v" #'image-mode-copy-file-name-as-kill
   "w" #'other-window
   "L" #'org-store-link
   "M" #'pdf-view-themed-minor-mode)
  
  (general-define-key
   :keymaps 'pdf-outline-buffer-mode
   "m" #'pdf-outline-follow-link)
  
  (defun arche/pdf-hook ()
    (blink-cursor-mode -1))

  (add-hook 'pdf-tools-enabled-hook #'arche/pdf-hook))

  ;; TODO: finish it
)

(provide 'arche-pdf)

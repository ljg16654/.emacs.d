(require 'arche-package)

(use-package pdf-tools :straight nil)

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
 "v" #'image-mode-copy-file-name-as-kill
 "w" #'other-window
 "M" #'pdf-view-midnight-minor-mode)

(general-define-key
 :keymaps 'pdf-outline-buffer-mode
 "m" #'pdf-outline-follow-link)

(provide 'arche-pdf)

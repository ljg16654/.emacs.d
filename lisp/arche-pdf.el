(require 'arche-package)

(straight-use-package
 '(pdf-tools :type git :host github :repo "politza/pdf-tools"
	     :fork (:host github :repo "vedang/pdf-tools")))

(pdf-tools-install)

(general-define-key
 :keymaps 'pdf-view-mode-map
 "o" #'pdf-outline
 "/" #'pdf-occur
 "j" #'pdf-view-next-line-or-next-page
 "k" #'pdf-view-previous-line-or-previous-page)

(provide 'arche-pdf)

(require 'arche-package)
(straight-use-package
 '(pdf-tools :type git :host github :repo "politza/pdf-tools"
	     :fork (:host github :repo "vedang/pdf-tools"))
 )

(pdf-tools-install)
(general-define-key
 :keymaps 'pdf-view-mode-map
 "o" #'pdf-outline
 "/" #'pdf-occur)
(provide 'arche-pdf)

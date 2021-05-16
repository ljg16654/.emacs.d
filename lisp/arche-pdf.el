(require 'arche-package)

(use-package hide-mode-line)

(straight-use-package
 '(pdf-tools :type git :host github :repo "politza/pdf-tools"
	     :fork (:host github :repo "vedang/pdf-tools")))

(pdf-tools-install)

(general-define-key
 :keymaps 'pdf-view-mode-map
 "o" #'pdf-outline
 "/" #'pdf-occur)

(add-hook 'pdf-view-mode-hook #'hide-mode-line-mode)

(provide 'arche-pdf)

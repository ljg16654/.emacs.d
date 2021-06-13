(require 'arche-package)

(use-package nov
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))))

(use-package adoc-mode)

(provide 'arche-readings)





(require 'arche-package)
(require 'arche-keybinding)
(use-package popper
  :init
  (setq popper-display-control nil)
  (setq popper-reference-buffers
	(list "\\*Python\\*"
	      "\\*eshell\\*"
              "\\*ielm\\*"))
  :config
  (defhydra 'popper-stuff
    (global-map "C-c t")
    ("t" #'popper-toggle-latest)
    ("o" #'popper-cycle)
    ("p" #'popper-toggle-type))
  (key-chord-define-global "dk" #'popper-toggle-latest)
  (popper-mode +1))

(defun clear-popper-popup-alive ()
  "Clear popup buffers that are currently maintained by
	      popper.el. Useful when related rules are changed."
  (interactive)
  (progn
    (setq popper-open-popup-alist nil)
    (setq popper-buried-popup-alist nil)
    (message "Popper active alist cleared."))
  )

(provide 'arche-popup)

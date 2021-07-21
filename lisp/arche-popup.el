(require 'arche-package)

(use-package popper
  :after key-chord
  :init
  (setq popper-display-control nil)
  (setq popper-reference-buffers
	(list "\\*Python\\*"
              "\\*ielm\\*"
	      "eshell"
	      "vterm"))
  :config
  (key-chord-define-global "dk" #'popper-toggle-latest)
  (popper-mode +1))

(defun clear-popper-popup-alive ()
  "Clear popup buffers that are currently maintained by
	      popper.el. Useful when related rules are changed."
  (interactive)
  (progn
    (setq popper-open-popup-alist nil)
    (setq popper-buried-popup-alist nil)
    (message "Popper active alist cleared.")))

(provide 'arche-popup)

(require 'arche-package)
(use-package s)
(use-package dash)
(use-package f)
(use-package transient)
(use-package ov)

(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(provide 'arche-elisp)

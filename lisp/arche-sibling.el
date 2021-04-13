(defun arche-sibling-jump ()
  "Jump to the file's sibling"
  (interactive)
  (cl-case major-mode
    ('python-mode
     (let ((fn (file-relative-name (buffer-file-name (current-buffer)))))
       (if (string-prefix-p "test_" fn)
	   (switch-to-buffer (s-chop-prefix "test_" fn))
	 (switch-to-buffer (s-prepend "test_" fn))))
     (t (message "Not in a python buffer!"))
     )))
(define-key python-mode-map (kbd "H-s") #'arche-sibling-jump)

(provide 'arche-sibling)

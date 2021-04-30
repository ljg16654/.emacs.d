;; minor mode for maintenance of closely related files 
;; c* file and header
;; python file and pytest file, relevant doc/book
;; ...

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

(defun arche-sibling-declare-tie ()
  "Tie current buffer to another buffer by completion.")
(defun arche-sibling-declare-untie ()
  "Untie current buffer from another buffer by completion.")
(defun arche-sibling-quit ()
  "Kill all bunds with other siblings.")
(defun arche-sibling-list-siblings ()
  "List siblings of current buffer.")
(defun arche-sibling-whoami ()
  "Give the attribute of current buffer in its siblings.")
;; (defhydra
(provide 'arche-sibling)

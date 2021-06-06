;; minor mode for maintenance of closely related files 
;; c* file and header
;; python file and pytest file, relevant doc/book
;; ...

;;;###autoload
(defun arche-sibling-jump ()
  "Jump to the file's sibling"
  (interactive)
  (cond 
   ((eq major-mode 'python-mode)
    (let ((fn (file-relative-name (buffer-file-name (current-buffer)))))
      (if (string-prefix-p "test_" fn)
	  (switch-to-buffer (s-chop-prefix "test_" fn))
	(switch-to-buffer (s-prepend "test_" fn)))))
   (t (message "Not in a python buffer!"))))

;;;###autoload
(defun arche-sibling-declare-tie ()
  "Tie
;;;###autoload current buffer to another buffer by completion.")
(defun arche-sibling-declare-untie ()
  "Unt
;;;###autoloadie current buffer from another buffer by completion.")
(defun arche-sibling-quit ()
  "Kil
;;;###autoloadl all bunds with other siblings.")
(defun arche-sibling-list-siblings ()
  "List siblings of current buffer.")
(defun arche-sibling-whoami ()
  "Give the attribute of current buffer in its siblings.")

(provide 'arche-sibling)

(require 'arche-misc)

(define-minor-mode arche/count-word-mode
  "Minor mode for displaying word count."
  :global nil
  (if arche/count-word-mode
      (progn (setq
	      mode-line-format
	      `((arche/count-word-mode
		 (:eval (number-to-string (count-words (point-min)
						       (point-max)))))
		,@(default-value 'mode-line-format)))
	     (force-mode-line-update t))
    (progn
      (setq
       mode-line-format
       (assq-delete-all
	'arche/count-word-mode
	(default-value 'mode-line-format))))))

(provide 'arche-writing)

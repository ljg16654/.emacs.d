(require 'arche-package)

(use-package diminish)
(use-package minions
  :after (ace-window helpful)
  :init (minions-mode)
  :config
  (defun arche/reset-mode-line ()
    (interactive)
    (progn
      (setq-default mode-line-format
		    (helpful--original-value 'mode-line-format))
      (minions-mode t)
      (ace-window-display-mode t))))

(use-package hide-mode-line)

(use-package nyan-mode
  :disabled
  :config
  (nyan-mode)
  (nyan-start-animation))

(use-package doom-modeline
  :custom
  (doom-modeline-height 18))

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

(defun arche/buffer-name ()
  "Truncate the buffer name if its too long"
  (let* ((bn (buffer-name))
	 (l (length bn))
	 (lmax 21)
	 (lside (floor (/ (- lmax 3) 2))))
    (if (> l lmax)
	(concat
	 (s-left lside bn)
	 "..."
	 (s-right lside bn))
      bn)))

(defun +format-mode-line ()
  (let* ((lhs '((:eval (meow-indicator))
		(:eval (rime-lighter))
		" Row %l "
		(:eval (when (bound-and-true-p flycheck-mode) flycheck-mode-line))
		(:eval (when (bound-and-true-p flymake-mode)
			 flymake-mode-line-format))
		"  "
		(:eval (arche/buffer-name))))
	 (rhs '((:eval (+smart-file-name-cached))
		" "
		(:eval mode-name)
		(vc-mode vc-mode)))
	 (ww (window-width))
	 (lhs-str (format-mode-line lhs))
	 (rhs-str (format-mode-line rhs))
	 (rhs-w (string-width rhs-str)))
    (format "%s%s%s"
	    lhs-str
	    (propertize " " 'display `((space :align-to (- (+ right right-fringe right-margin) (+ 1 ,rhs-w)))))
	    rhs-str)))

(setq-default mode-line-format '((:eval (+format-mode-line))))

(provide 'arche-modeline)

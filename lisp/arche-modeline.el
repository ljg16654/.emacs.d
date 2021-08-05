(require 'arche-package)
(require 'arche-oc)
 
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

(defun arche/bib-pdf-get-title ()
    (let
	((key (file-name-base))
	 (bibtex-file-live-p (get-buffer (file-name-nondirectory my-global-bibtex-file))))
      (with-current-buffer (find-file-noselect my-global-bibtex-file)
	(goto-char (bibtex-find-entry key t))
	(let ((title (bibtex-autokey-get-field "title")))
		 (unless bibtex-file-live-p (kill-buffer (current-buffer)))
		 title))))

(defun arche/buffer-name ()
  "Buffer name displayed in mode-line."
  (let* ((bn (buffer-name))
	 (fn (buffer-file-name))
	 (l (length bn))
	 (lmax 21)
	 (lside (floor (/ (- lmax 3) 2))))
    (cond
     ((org-roam-node-at-point)
      (concat " " (org-roam-node-title (org-roam-node-at-point))))
     ((and (s-prefix? (file-truename "~/library/pdf/") (buffer-file-name))
	   (equal major-mode 'pdf-view-mode))
      (concat " " (arche/bib-pdf-get-title)))
     ((s-prefix? "Qutebrowser: " bn) (concat " [] "
					     (s-chop-suffix " - qutebrowser"
							    (s-chop-prefix "Qutebrowser: " bn))))
     ((> l lmax) (concat
		  (s-left lside bn)
		  "..."
		  (s-right lside bn)))
     (t bn))))

(defun +format-mode-line ()
  (let* ((lhs '((:eval (unless (equal major-mode 'exwm-mode) (meow-indicator)))
		" "
		(:eval (window-parameter (selected-window) 'ace-window-path))
		(:eval (unless (member major-mode '(exwm-mode
						    pdf-view-mode))
			 " Row %l "))
		(:eval (if (equal major-mode 'pdf-view-mode) (format " Page %d/%d "
								     (pdf-view-current-page)
								     (pdf-cache-number-of-pages))))
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

(use-package mini-modeline
  :config
  (setq mini-modeline-l-format mode-line-format))

;; tab-bar as global modeline
(custom-set-variables '(tab-bar-format
			'(tab-bar-format-history
                          tab-bar-format-tabs
                          tab-bar-separator
                          tab-bar-format-add-tab
			  tab-bar-format-align-right
			  tab-bar-format-global)))

(display-time-mode)
(display-battery-mode)

(provide 'arche-modeline)

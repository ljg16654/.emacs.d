(require 'arche-package)

(use-package wordnut
  :config 
;;;###autoload
  (defun org-capture-wordnut-capture ()
    "Get the word being displayed in *Wordnut* buffer if it exists."
    (with-current-buffer "*WordNut*"
      (wordnut--lexi-word)))
  
;;;###autoload
  (defun arche/wordnut-search (word)
    "Prompt for a word to search for, then do the lookup."
    (interactive (list
		  (wordnut--completing
		   (if (eq major-mode 'pdf-view-mode) "" (current-word t t)))))
    (ignore-errors
      (wordnut--history-update-cur wordnut-hs))
    (wordnut--lookup word))

;;;###autoload
  (defun wordnut-search-and-capture ()
    "Perform wordnut-search and then capture."
    (interactive)
    (progn
      ;; (call-interactively #'wordnut-search)
      (call-interactively #'arche/wordnut-search)
      (org-capture nil "w")
      (org-capture-finalize)))

  (global-set-key (kbd "s-w") #'wordnut-search-and-capture)
  (define-key wordnut-mode-map (kbd "w") #'wordnut-search-and-capture)
  (define-key view-mode-map (kbd "w") #'wordnut-search-and-capture))

(define-minor-mode wordnut-review-word-mode
  "Toggle minor-mode for reviewing wordnut history"
  :lighter "[ReW]"
  :global nil
  :keymap
  '(("n" . wrw-next-word)
    ("p" . wrw-prev-word)
    ("d" . wrw-delete-word)
    ("m" . wrw-mark-word)))

;;;###autoload
(defun wrw-next-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j C-n C-c C-o")))

;;;###autoload
(defun wrw-prev-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j C-p C-c C-o")))

;;;###autoload
(defun wrw-delete-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j C-a C-k C-c C-o")))

;;;###autoload
(defun wrw-mark-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j M-s h . C-c C-o")))

(provide 'arche-dictionaries)

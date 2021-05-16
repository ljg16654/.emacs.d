(require 'arche-package)
(require 'arche-modeline)
(require 'arche-misc)
(use-package wordnut)

(define-minor-mode wordnut-review-word-mode
  "Toggle minor-mode for reviewing wordnut history"
  :lighter "[ReW]"
  :global nil
  :keymap
  '(("n" . wrw-next-word)
    ("p" . wrw-prev-word)
    ("d" . wrw-delete-word)
    ("m" . wrw-mark-word)))

(defun wrw-next-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j C-n C-c C-o")))

(defun wrw-prev-word ()
  (interactive)
  (execute-kbd-macro
		   (read-kbd-macro
		    "C-x 4 b words.org C-j C-p C-c C-o")))

(defun wrw-delete-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j C-a C-k C-c C-o")))

(defun wrw-mark-word ()
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "C-x 4 b words.org C-j M-s h . C-c C-o")))

(provide 'arche-dictionaries)

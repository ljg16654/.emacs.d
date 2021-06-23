(require 'arche-elisp)

(set-face-attribute 'default nil :family "FantasqueSansMono Nerd Font Mono" :weight 'normal :height 135)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
(setq-default line-spacing 0.1)

;; give more space because of latex-preview
(add-hook 'org-mode-hook #'(lambda ()
			     (setq line-spacing 0.3)))

(add-hook 'org-mode-hook #'variable-pitch-mode)

(defun arche/search-font ()
  (interactive)
  (insert (completing-read "Insert font: " (-uniq (font-family-list)))))

(provide 'arche-font)

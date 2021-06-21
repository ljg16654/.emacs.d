(require 'arche-elisp)

(set-face-attribute 'default nil :family "FantasqueSansMono Nerd Font Mono" :weight 'normal :height 135)
(set-face-attribute 'default nil :family "Iosevka" :weight 'normal :height 135)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Iosevka-fixed")
(setq-default line-spacing 0.1)

(defun arche/search-font ()
  (interactive)
  (insert (completing-read "Insert font: " (-uniq (font-family-list)))))

(provide 'arche-font)

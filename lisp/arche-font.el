(require 'arche-elisp)

(global-hl-line-mode)

;; victor mono with iosevka
(set-face-attribute 'default nil :family "Victor Mono" :weight 'normal :height 150)
(set-face-attribute 'Info-quoted nil :family "Iosevka" :weight 'semibold)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Iosevka Fixed")
(set-face-attribute 'org-block-begin-line nil :family "Iosevka" :weight 'semilight)
(set-face-attribute 'org-block-end-line nil :family "Iosevka" :weight 'semilight)
(set-face-attribute 'hl-line nil :box t)

;; recursive
;; (set-face-attribute 'default nil :family "RecMonoSemicasual" :weight 'norml :height 130)
;; (set-face-attribute 'Info-quoted nil :family "Recursive_VF" :weight 'semibold)
;; (set-face-attribute 'variable-pitch nil :family "Recursive_VF")

(setq-default line-spacing 0.1)

;; give more space because of latex-preview
(add-hook 'org-mode-hook #'(lambda ()
			     (setq line-spacing 0.15)))

(defun arche/search-font ()
  (interactive)
  (insert (completing-read "Insert font: " (-uniq (font-family-list)))))

(use-package all-the-icons)
(provide 'arche-font)

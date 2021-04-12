(require 'autothemer)
(autothemer-deftheme
 random "Random as its name."		;

 ;; Specify the color classes used by the theme
 ((((class color) (min-colors #xFFFFFF)))

  ;; Specify the color palette for each of the classes above.
  (random-light  "#EAEBE1")
  (random-dark   "#242E11")
  (random-red    "#781210")
  (random-green  "#50B89F")
  (random-blue   "#212288")
  (random-purple "#812FFF")
  (random-yellow "#EFFE00")
  (random-orange "#E06500")
  (random-cyan   "#22DDFF"))

 ;; specifications for Emacs faces.
 ((button (:underline t :weight 'bold :foreground random-dark))
  (cursor (:background "SeaGreen"))
  (font-lock-comment-face (:foreground "CadetBlue" :background "#e8ffdd" :slant 'italic))
  (font-lock-variable-name-face (:foreground "ForestGreen"))
  (font-lock-keyword-face (:foreground "DeepPink3"))
  (font-lock-string-face (:foreground "RoyalBlue" :background "#f0ffe5"))
  (font-lock-constant-face (:weight 'bold))
  (font-lock-type-face (:foreground "OrangeRed" :weight 'bold :slant 'italic))
  (default (:foreground "#050570" :background "#f0ffdd" :weight 'medium))
  ;; modeline
  (mode-line-inactive (:background "DarkSeaGreen"))
  (mode-line (:background "black" :foreground "DarkSeaGreen"))
  ;; edge of the frames
  (fringe (:background "#f0ffdd"))
  ;; org-mode stuff
  (org-block (:background "#e8ffdd" :weight 'light))
  ;; tab-bar
  (tab-bar (:family "Fira Code" :background "DarkSeaGreen" :foreground "MidnightBlue" :underline nil))
  (tab-line (:background "DarkSeaGreen"))
  (company-tooltip-selection (:background "LightGreen" :foreground "black"))
  (company-tooltip-common (:foreground "sienna"))
  (company-tooltip (:background "#e8ffdd" :foreground "DarkSeaGreen4"))
  (company-scrollbar-fg (:background "black"))
  (company-scrollbar-bg (:background "#d8ffdd"))
  ;; menubar: doesn't seem to work!
  (menubar (:background "DarkSeaGreen"))
  (error  (:foreground random-red)))

 )

(custom-set-faces
 '(tab-bar-tab-inactive ((t (:inherit tab-bar-tab :foreground "DarkGreen")))))

(setq pdf-view-midnight-colors
      '(
       "#191970" ;; background
       .
       "#f0ffdd" ;; foreground
       ))

(provide-theme 'random)
(global-set-key (kbd "M-o") #'describe-face)
(local-set-key (kbd "M-u") #'counsel-colors-emacs)

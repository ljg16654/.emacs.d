(require 'autothemer)
(autothemer-deftheme
 random "Random as its name."		;

 ;; Specify the color classes used by the theme
 ((((class color) (min-colors #xFFFFFF)))

  ;; Specify the color palette for each of the classes above.
  (random-brightest "#fafffa")
  (random-br "#f0fff0")
  (random-br1 "#ecffec")
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
  (font-lock-comment-face (:foreground "CadetBlue" :background random-br :slant 'italic))
  (font-lock-variable-name-face (:foreground "ForestGreen"))
  (font-lock-keyword-face (:foreground "gold4"))
  (font-lock-string-face (:foreground "RoyalBlue" :background "#f0ffe5"))
  (font-lock-constant-face (:weight 'bold :foreground "orange"))
  (font-lock-type-face (:foreground "OrangeRed" :weight 'bold :slant 'italic))
  (default (:foreground "#050570" :background random-brightest :weight 'medium))
  ;; modeline
  (mode-line-inactive
   (:background random-br1
		:background random-br
		:box (:line-width 2 :style 'released-button)))
  (mode-line
   (:background "orange"
		:foreground "#220022"
		:box (:line-width 4 :style 'released-button)))
  ;; edge of the frames
  (fringe (:background random-brightest))
  ;; org-mode stuff
  (org-block
   (:background random-br :weight 'light))
  (org-document-title
   (:height 300
	    :underline t))
  (org-level-1
   (:background "#d5ffc5"
		:foreground "black"
		:family "UnTaza"
		:overline t))
  (org-level-2
   (:background "#e5ffd5"
		:family "UnTaza"
		:overline t))
  ;; tab-bar
  (tab-bar-tab
   (:family "UnTaza"
	    :background random-brightest
	    :foreground "OrangeRed"
	    :height 150))
  (tab-bar-tab-inactive
   (:family "UnTaza"
	    :inherit 'tab-bar-tab
	    :background random-brightest
	    :foreground "black"
	    :height 150))
  ;; (tab-line :background random-brightest)
  (company-tooltip-selection (:background "LightGreen" :foreground "black"))
  (company-tooltip-common (:foreground "sienna"))
  (company-tooltip (:background random-br :foreground "DarkSeaGreen4"))
  (company-scrollbar-fg (:background "black"))
  (company-scrollbar-bg (:background "#d8ffdd"))
  ;; menubar: doesn't seem to work!
  (menubar (:background "DarkSeaGreen"))
  (error  (:foreground random-red)))
 )

(setq pdf-view-midnight-colors
      '(
       "#191970" ;; background
       .
       random-brightest ;; foreground
       ))

(provide-theme 'random)
(global-set-key (kbd "M-o") #'describe-face)
(local-set-key (kbd "M-u") #'counsel-colors-emacs)

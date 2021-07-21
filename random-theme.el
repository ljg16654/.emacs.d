(require 'autothemer)
(autothemer-deftheme
 random "Random as its name."		

 ;; Specify the color classes used by the theme
 ((((class color) (min-colors #xFFFFFF)))

  ;; Specify the color palette for each of the classes above.
  (random-bg-default "#eeeeee")
  (random-deeper-than-bg-1 "#e3e3e3")
  (random-deeper-than-bg-2 "#e1e1e1")
  (random-lighter-than-black-1 "#111111")
  (random-lighter-than-black-2 "#222222")
  (random-lighter-than-black-3 "#333333")
  (random-lighter-than-black-4 "#444444")
  (random-bluegreen "#33aabb")
  (random-slategrey "#2f4f4f")
  (random-purple "#9370db")
  (random-br "#f0fff0")
  (random-br1 "#ecffec")
  (random-mode-line "#aaaaaa")
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
  (font-lock-comment-face (:foreground random-lighter-than-black-4 :background random-deeper-than-bg-2 :slant 'italic))
  (font-lock-variable-name-face (:foreground "ForestGreen"))
  (font-lock-keyword-face (:foreground "brown"))
  (font-lock-string-face (:foreground "darkcyan"))
  (font-lock-constant-face (:weight 'normal :foreground random-bluegreen))
  (font-lock-type-face (:foreground random-purple :weight 'normal :slant 'italic))
  (default (:foreground "RoyalBlue" :background random-bg-default :weight 'medium))
  ;; modeline
  (mode-line-inactive
   (:background random-mode-line :overline t))
  (mode-line
   (:background random-mode-line :overline t))
  ;; edge of the frames
  (fringe (:background random-bg-default))
  ;; org-mode stuff
  (org-block
   (:background random-deeper-than-bg-1 :weight 'light))
  (org-document-title
   (:height 300
	    :underline t))
  (org-level-1
   (:background "#d5ffc5"
		:foreground "black"
		:family "Iosevka Fixed"
		:overline t))
  (org-level-2
   (:background "#e5ffd5"
		:family "Iosevka Fixed"
		:overline t))
  ;; tab-bar
  (tab-bar (:background random-bg-default))
  (tab-bar-tab
   (:family "Iosevka Fixed"
	    :height 120
	    :background random-bg-default
	    :foreground "black"
	    :underline t
	    ))
  (tab-bar-tab-inactive
   (:underline nil :family "Iosevka Fixed" :height 120 :background random-bg-default :foreground "black"))
  (company-tooltip-selection (:background "LightGreen" :foreground "black"))
  (company-tooltip-common (:foreground "sienna"))
  (company-tooltip (:background random-br :foreground "DarkSeaGreen4"))
  (company-scrollbar-fg (:background "black"))
  (company-scrollbar-bg (:background "#d8ffdd"))
  ;; menubar: doesn't seem to work!
  (menubar (:background "DarkSeaGreen"))
  (error  (:foreground random-red))))

(setq pdf-view-midnight-colors
      ;; fore, back
      '("DarkSlateBlue" . "#fafffa"))

(provide-theme 'random)
(global-set-key (kbd "M-o") #'describe-face)
(local-set-key (kbd "M-u") #'counsel-colors-emacs)

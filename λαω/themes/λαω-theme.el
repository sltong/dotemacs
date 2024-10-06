;;; λαω-theme.el --- Λαω theme -*- coding: utf-8; lexical-binding: t; -*-
(deftheme λαω
  "λαω theme."
  :background-mode 'dark
  :kind 'color-scheme)

(let ((class '((class color) (min-colors 88)))
      (bg "#100f14")
      (fg "#e6e4e8")

      (bg-theme "#3a3254")
      (fg-theme "#d8c8fd")

      (hl "#4f495d")
      (hl-3/4 "#353143")
      (hl-1/2 "#211e2a")
      (hl-1/4 "#18161e")

      (bg-inactive "#22202c")
      (fg-inactive "#7d7a82")

      ;; minimum allowable contrast (15 Lc) for backgrounds on top of
      ;; the main background
      (bg-min-red "#903232")
      (bg-min-yellow "#5f5231")
      (bg-min-orange "#794531")

      (black "#0c0b0e")
      (white "#e9e8ec")
      (red "#ee5263")
      (pink "#ffb9cc")
      (blue "#9fd2ff")
      (teal "#8adbd3")
      (yellow "#e6cb77")
      (yellow-bright "#f8f442")
      (green "#a2dc8c")
      (green-darker "#71a36f")
      (orange "#ffbf91")
      (magenta "#eabdf8")
      (violet "#cfc7ff")
      (light-grey "#9894a6")
      (grey "#817c91")

      (comment "#9692a4")
      (string "#e2cb8b")
      )

  (custom-theme-set-faces
   'λαω
   `(default ((,class (:background ,bg :foreground ,fg))))
   `(cursor  ((,class (:background ,yellow))))
   `(escape-glyph ((,class (:foreground ,fg-theme))))
   `(homoglyph ((,class (:foreground ,fg-theme))))
   `(minibuffer-prompt ((,class (:foreground ,fg-theme))))
   `(highlight ((,class (:background ,hl))))
   `(region ((,class (:background ,hl :foreground ,fg))))
   `(shadow ((,class (:foreground ,grey))))
   `(secondary-selection ((,class (:background ,hl
                                               :foreground ,green
                                               :weight bold))))

   ;; whitespace
   `(trailing-whitespace ((,class (:background ,bg-min-red)))) ; wtf?
   `(whitespace-trailing ((,class (:background ,bg-min-red)))) ; wtf?
   `(whitespace-empty ((,class (:background ,bg-min-yellow))))
   `(whitespace-tab ((,class (:background ,bg-min-orange))))
   `(whitespace-line ((,class (:background ,hl-1/2 :foreground ,yellow))))
   `(whitespace-missing-newline-at-eof ((,class (:background ,bg-min-yellow))))
   `(whitespace-space-before-tab ((,class (:background ,bg-min-yellow))))
   `(whitespace-space-after-tab ((,class (:background ,bg-min-yellow))))
   `(whitespace-indentation ((,class ((:background ,bg-min-yellow)))))

   ;; notices
   `(success ((,class (:foreground ,green))))
   `(error ((,class (:foreground ,red))))
   `(warning ((,class (:foreground ,orange))))

   ;; font lock
   `(font-lock-punctuation-face ((t nil)))
   `(font-lock-bracket-face ((t (:inherit (font-lock-punctuation-face)))))
   `(font-lock-builtin-face ((,class (:foreground ,pink))))
   `(font-lock-comment-face ((,class (:foreground ,comment))))
   `(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
   `(font-lock-constant-face ((,class (:foreground ,blue))))
   `(font-lock-delimiter-face ((t (:inherit (font-lock-punctuation-face)))))
   `(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
   `(font-lock-doc-markup-face ((t (:inherit (font-lock-constant-face)))))
   `(font-lock-escape-face ((t (:inherit (font-lock-regexp-grouping-backslash)))))
   `(font-lock-function-call-face ((t (:inherit (font-lock-function-name-face)))))
   `(font-lock-function-name-face ((,class (:foreground ,blue))))
   `(font-lock-keyword-face ((,class (:foreground ,violet))))
   `(font-lock-negation-char-face ((t nil)))
   `(font-lock-number-face ((t nil)))
   `(font-lock-misc-punctuation-face ((t (:inherit (font-lock-punctuation-face)))))
   `(font-lock-operator-face ((t nil)))
   `(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
   `(font-lock-property-name-face ((t (:inherit (font-lock-variable-name-face)))))
   `(font-lock-property-use-face ((t (:inherit (font-lock-property-name-face)))))
   `(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
   `(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
   `(font-lock-string-face ((,class (:foreground ,string))))
   `(font-lock-type-face ((,class (:foreground ,magenta))))
   `(font-lock-variable-name-face ((,class (:foreground ,teal))))
   `(font-lock-variable-use-face ((t (:inherit (font-lock-variable-name-face)))))
   `(font-lock-warning-face ((t (:inherit (error)))))

   `(link ((,class (:underline (:color foreground-color
                                       :style line
                                       :position nil)
                               :foreground ,green))))
   `(link-visited ((,class (:inherit (link) :foreground ,green-darker))))
   `(button ((t (:inherit (link)))))

   `(fringe ((t (:inherit (default)))))
   `(header-line ((default (:inherit (mode-line))) (((type tty)) (:underline (:color foreground-color :style line :position nil) :inverse-video nil)) (((class color grayscale) (background light)) (:box nil :foreground "grey20" :background "grey90")) (((class color grayscale) (background dark)) (:box nil :foreground "grey90" :background "grey20")) (((class mono) (background light)) (:underline (:color foreground-color :style line :position nil) :box nil :inverse-video nil :foreground "black" :background "white")) (((class mono) (background dark)) (:underline (:color foreground-color :style line :position nil) :box nil :inverse-video nil :foreground "white" :background "black"))))
   `(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))

   ;; mode line
   `(mode-line ((,class (:background ,bg-theme))))
   `(mode-line-buffer-id ((,class (:weight bold))))
   `(mode-line-emphasis ((,class (:weight bold))))
   `(mode-line-highlight ((((supports :box t) (class color grayscale) (min-colors 88)) (:box (:line-width (2 . 2) :color "grey40" :style released-button))) (t (:inherit (highlight)))))
   `(mode-line-inactive ((,class (:background ,bg-inactive :foreground ,fg-inactive))))

   ;; isearch
   `(isearch ((,class (:background ,green :foreground ,bg :weight bold))))
   `(isearch-fail ((,class (:background ,bg-min-red :foreground ,pink))))
   `(isearch-group-1 ((,class (:background ,hl :foreground ,teal))))
   `(isearch-group-2 ((,class (:background ,hl :foreground ,blue))))

   `(lazy-highlight ((,class (:background ,hl :foreground ,green :weight bold))))

   `(next-error ((t (:inherit (region)))))

   ;; completions
   `(completions-common-part ((,class (:foreground ,green :weight bold))))
   `(completions-annotations ((,class (:inherit font-lock-comment-face))))

   ;; matching
   `(match ((,class (:background ,hl :foreground ,green :weight bold))))
   `(reb-match-0 ((,class (:inherit (match) :foreground ,green))))
   `(reb-match-1 ((,class (:inherit (match) :foreground ,teal))))
   `(reb-match-2 ((,class (:inherit (match) :foreground ,blue))))
   `(reb-match-3 ((,class (:inherit (match) :foreground ,violet))))
   `(show-paren-match ((,class (:background ,hl
                                            :foreground ,yellow-bright
                                            :weight bold))))

   ;;; package faces

   ;; avy
   `(avy-goto-char-timer-face ((,class (:background ,hl))))
   `(avy-lead-face ((,class (:background ,hl-1/2 :foreground ,magenta :weight bold))))
   `(avy-lead-face-0 ((,class (:background ,hl-1/2 :foreground ,teal :weight bold))))
   `(avy-lead-face-1 ((,class (:background ,hl-1/2 :foreground ,yellow :weight bold))))
   `(avy-lead-face-2 ((,class (:background ,hl-1/2 :foreground ,blue :weight bold))))

   ;; dired
   `(dired-broken-symlink ((,class (:foreground ,red))))
   `(dired-marked ((,class (:inherit (warning) :weight bold))))

   ;; eglot
   `(eglot-inlay-hint-face ((,class (:inherit (font-lock-comment-face)
                                              :height 0.9))))

   ;; flymake
   `(flymake-warning ((,class (:underline
                               (:style wave :color ,orange)))))
   `(flymake-error ((,class (:underline
                             (:style wave :color ,red)))))
   `(flymake-error ((,class (:underline
                             (:style wave :color ,red)))))
   ;; TODO
   `(flymake-note-echo ((,class (:foreground ,violet))))

   ;; hl-line mode
   `(hl-line ((,class (:inherit (highlight) :background ,hl-1/2 :extend t))))

   ;; Info
   `(Info-quoted ((,class (:inherit (font-lock-constant-face)))))
   `(info-menu-star ((,class (:foreground ,yellow))))


   ;; help
   `(help-key-binding ((,class (:foreground ,magenta :weight bold))))

   ;; line number
   `(line-number ((,class (:inherit (font-lock-comment-face)))))
   `(line-number-current-line ((,class (:inherit (line-number)
                                                 :foreground ,light-grey))))

   ;; magit
   `(magit-section-heading ((,class (:foreground ,green
                                                 :extend t
                                                 :weight bold))))

   ;; marginalia
   `(marginalia-off ((,class (:inherit (shadow)))))
   `(marginalia-number ((,class (:inherit (font-lock-comment-face)))))
   `(marginalia-file-priv-dir ((,class (:foreground ,magenta))))
   `(marginalia-file-priv-read ((,class (:foreground ,green))))
   `(marginalia-file-priv-write ((,class (:inherit (warning)))))
   `(marginalia-file-priv-exec ((,class (:foreground ,pink))))


   ;; orderless
   `(orderless-match-face-0 ((,class (:foreground ,blue :weight bold))))
   `(orderless-match-face-1 ((,class (:foreground ,magenta :weight bold))))
   `(orderless-match-face-2 ((,class (:foreground ,teal :weight bold))))
   `(orderless-match-face-3 ((,class (:foreground ,violet :weight bold))))

   ;; org mode
   `(org-block-begin-line ((,class (:inherit (shadow)
                                             :background ,hl-1/4
                                             :extend t
                                             :slant italic))))
   `(org-block ((,class (:background ,hl-1/2))))
   `(org-block-end-line ((,class (:inherit (org-block-begin-line)))))

   `(org-code ((,class (:foreground ,teal))))
   `(org-footnote ((,class (:inherit (font-lock-comment-face)))))
   ;; `(org-footnote ((,class (:foreground ,yellow))))

   `(outline-1 ((,class (:foreground ,violet))))
   `(outline-2 ((,class (:foreground ,blue))))
   `(outline-3 ((,class (:foreground ,orange))))
   `(outline-4 ((,class (:foreground ,green))))
   `(outline-5 ((,class (:foreground ,yellow))))
   `(outline-6 ((,class (:foreground ,magenta))))
   ;; `(outline-7 ((,class (:foreground ,))))
   ;; `(outline-8 ((,class (:foreground ,))))

   ;; which-key
   `(which-key-key-face ((,class (:inherit (font-lock-keyword-face)
                                           :weight bold))))
   `(which-key-highlighted-command-face ((,class (:foreground ,teal))))
   `(which-key-command-description-face ((,class (:inherit (comment)))))
   `(which-key-group-description-face ((,class (:foreground ,pink))))
   `(which-key-local-map-description-face ((,class (:inherit (comment)))))

   ;; vterm
   `(vterm-color-default ((,class (:background ,bg :foreground ,fg))))
   `(vterm-color-black ((,class (:background ,black :foreground ,black))))
   `(vterm-color-red ((,class (:background ,pink :foreground ,pink))))
   `(vterm-color-green ((,class (:background ,green :foreground ,green))))
   `(vterm-color-yellow ((,class (:background ,yellow :foreground ,yellow))))
   `(vterm-color-blue ((,class (:background ,blue :foreground ,blue))))
   `(vterm-color-magenta ((,class (:background ,magenta :foreground ,magenta))))
   `(vterm-color-cyan ((,class (:background ,teal :foreground ,teal))))
   `(vterm-color-white ((,class (:background ,white :foreground ,white))))
   ))

(provide-theme 'λαω)
;;; λαω-theme.el ends here

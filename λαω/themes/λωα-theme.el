;;; λωα-theme.el --- λωα theme -*- coding: utf-8; lexical-binding: t; -*-
(deftheme λωα
  "λαω theme."
  :kind 'color-scheme)

(let* ((class '((class color) (min-colors 88)))

       (theme-50  "#f8f2ff")
       (theme-100 "#dcbffe")
       (theme-200 "#b599d6")
       (theme-300 "#9075af")
       (theme-400 "#6d5389")
       (theme-500 "#4c3167")
       (theme-600 "#472267")
       (theme-700 "#3f0764")
       (theme-800 "#310051")
       (theme-900 "#25003f")

       (theme-light-100 "#ebdaff")
       (theme-light-200 "#dec2ff")
       (theme-light-300 "#ccb0ed")
       (theme-light-400 "#ba9edb")
       (theme-light-500 "#a98cca")
       (theme-light-600 "#8f6bb7")
       (theme-light-700 "#6d3f98")
       (theme-light-800 "#4b0278")

       (bg theme-50)
       (fg "#453457")

       (bg-theme "#3a3254")
       (bg-theme-darker "#27223b")
       (fg-theme "#d3caf5")

       (bg-highlight theme-light-100)

       (hl "#403a4e")
       (hl-3/4 "#353143")
       (hl-1/2 "#211e2a")
       (hl-1/4 "#18161e")

       (bg-inactive "#e8dcf7")
       (fg-inactive "#8f8899")

       ;; minimum allowable contrast (15 Lc) for backgrounds on top of
       ;; the main background
       (bg-min-red "#903232")
       (bg-min-yellow "#635301")
       (bg-min-orange "#7b4321")
       (bg-min-green "#345c30")

       (black "#060509")
       (white "#eeedf5")
       (red "#662425")
       (pink "#63233a")
       (blue "#27396e")
       (teal "#277877")
       (yellow "#6b5b01")
       (yellow-bright "#f8f442")
       (green "#204811")
       (orange "#622b01")
       (magenta "#572855")
       (violet "#35356c")
       (light-grey "#9894a6")
       (grey "#817c91")

       (bg-mode-line theme-light-100)
       (fg-mode-line theme-500)
       (bg-hl-line "#eadbfa")

       (comment "#b7a2d1")
       (string yellow)
       (fg-link "#91ce79")
       (fg-link-visited "#6ea558")
       )

  (custom-theme-set-faces
   'λωα
   `(default ((,class (:background ,bg :foreground ,fg))))
   `(cursor  ((,class (:background "#b396ff"))))
   `(escape-glyph ((,class (:foreground ,fg-theme))))
   `(homoglyph ((,class (:foreground ,fg-theme))))
   `(minibuffer-prompt ((,class (:foreground ,fg-theme))))
   `(highlight ((,class (:background ,bg-highlight))))
   `(region ((,class (:background ,bg-highlight :foreground ,fg))))
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
   `(warning ((,class (:foreground ,yellow))))

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
   `(font-lock-warning-face ((t (:inherit (warning)))))

   `(link ((,class (:foreground ,fg-link
                                :underline (:color foreground-color
                                                   :style line
                                                   :position nil)))))
   `(link-visited ((,class (:inherit (link) :foreground ,fg-link-visited))))

   `(button ((t (:inherit (link)))))

   `(fringe ((t (:inherit (default)))))
   `(header-line ((default (:inherit (mode-line) :background ,bg-theme-darker))))
   `(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))

   `(vertical-border ((,class (:foreground ,hl-3/4))))

   ;; mode line
   `(mode-line ((,class (:background ,bg-mode-line :foreground ,fg-mode-line))))
   `(mode-line-active ((,class (:inherit (mode-line)))))
   `(mode-line-buffer-id ((,class (:weight bold))))
   `(mode-line-emphasis ((,class (:weight bold))))
   `(mode-line-highlight ((((supports :box t) (class color grayscale) (min-colors 88)) (:box (:line-width (2 . 2) :color "grey40" :style released-button))) (t (:inherit (highlight)))))
   `(mode-line-inactive ((,class (:inherit (mode-line) :background ,bg-inactive :foreground ,fg-inactive))))

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
   `(avy-goto-char-timer-face ((,class (:background ,hl))))
   `(avy-lead-face ((,class (:background ,hl-1/2 :foreground ,magenta :weight bold))))
   `(avy-lead-face-0 ((,class (:background ,hl-1/2 :foreground ,teal :weight bold))))
   `(avy-lead-face-1 ((,class (:background ,hl-1/2 :foreground ,yellow :weight bold))))
   `(avy-lead-face-2 ((,class (:background ,hl-1/2 :foreground ,blue :weight bold))))

   `(corfu-default ((,class (:background ,hl-1/2))))
   `(corfu-bar ((,class (:background ,violet))))
   `(corfu-border ((,class (:background ,hl-3/4))))
   `(corfu-current ((,class (:background ,hl :foreground ,green :weight bold))))

   `(custom-button ((,class (:background ,bg-theme :foreground ,fg :box (:line-width 2 :style flat-button)))))
   `(custom-button-mouse ((,class (:inherit (custom-button)))))
   `(custom-button-pressed ((,class (:inherit (custom-button) :background ,bg-theme-darker :foreground ,comment))))

   `(diff-hl-change ((,class (:background ,bg-min-yellow :foreground ,yellow))))
   `(diff-hl-delete ((,class (:background ,bg-min-red :foreground ,red))))
   `(diff-hl-insert ((,class (:background ,bg-min-green :foreground ,green))))

   `(dired-broken-symlink ((,class (:foreground ,red))))
   `(dired-marked ((,class (:inherit (warning) :weight bold))))

   `(fill-column-indicator ((,class (:foreground ,theme-light-100))))

   `(eglot-inlay-hint-face ((,class (:inherit (font-lock-comment-face)
                                              :height 0.9))))

   `(eshell-prompt ((,class (:foreground ,violet :weight bold))))

   `(flymake-warning ((,class (:underline
                               (:style wave :color ,orange)))))
   `(flymake-error ((,class (:underline
                             (:style wave :color ,red)))))
   `(flymake-error ((,class (:underline
                             (:style wave :color ,red)))))
   ;; TODO
   `(flymake-note-echo ((,class (:foreground ,violet))))

   `(gnus-group-mail-1         ((,class (:foreground ,violet ))))
   `(gnus-group-mail-1-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-mail-2         ((,class (:foreground ,pink ))))
   `(gnus-group-mail-2-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-mail-3         ((,class (:foreground ,blue ))))
   `(gnus-group-mail-3-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-mail-low       ((,class (:foreground ,yellow ))))
   `(gnus-group-mail-low-empty ((,class (:foreground ,grey :slant italic))))

   `(gnus-group-news-1         ((,class (:foreground ,green))))
   `(gnus-group-news-1-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-news-2         ((,class (:foreground ,blue))))
   `(gnus-group-news-2-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-news-3         ((,class (:foreground ,pink))))
   `(gnus-group-news-3-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-news-4         ((,class (:foreground ,teal))))
   `(gnus-group-news-4-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-news-5         ((,class (:foreground ,orange))))
   `(gnus-group-news-5-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-news-6         ((,class (:foreground ,violet))))
   `(gnus-group-news-6-empty   ((,class (:foreground ,grey :slant italic))))
   `(gnus-group-news-low       ((,class (:foreground ,yellow))))
   `(gnus-group-news-low-empty ((,class (:foreground ,grey :slant italic))))

   `(gnus-header            ((,class (:inherit (fixed-pitch)))))
   `(gnus-header-content    ((,class (:inherit (gnus-header) :foreground ,violet))))
   `(gnus-header-from       ((,class (:inherit (gnus-header) :foreground ,blue))))
   `(gnus-header-name       ((,class (:inherit (gnus-header) :foreground ,pink))))
   `(gnus-header-newsgroups ((,class (:inherit (gnus-header) :foreground ,green))))
   `(gnus-header-subject    ((,class (:inherit (gnus-header) :foreground ,green))))

   `(gnus-server-opened     ((,class (:foreground ,green :slant italic))))
   `(gnus-server-offline    ((,class (:foreground ,grey :slant italic))))

   `(hl-line ((,class (:background ,bg-hl-line))))
   `(hl-todo ((,class (:foreground ,yellow))))

   `(Info-quoted ((,class (:inherit (font-lock-constant-face)))))
   `(info-menu-star ((,class (:foreground ,yellow))))

   `(help-key-binding ((,class (:foreground ,magenta :weight bold))))

   `(line-number ((,class (:inherit (font-lock-comment-face)))))
   `(line-number-current-line ((,class (:inherit (line-number)
                                                 :foreground ,light-grey))))


   `(magit-section-heading ((,class (:foreground ,green
                                                 :extend t
                                                 :weight bold))))

   `(marginalia-off ((,class (:inherit (shadow)))))
   `(marginalia-number ((,class (:inherit (font-lock-comment-face)))))
   `(marginalia-file-priv-dir ((,class (:foreground ,magenta))))
   `(marginalia-file-priv-read ((,class (:foreground ,green))))
   `(marginalia-file-priv-write ((,class (:inherit (warning)))))
   `(marginalia-file-priv-exec ((,class (:foreground ,pink))))

   `(orderless-match-face-0 ((,class (:foreground ,blue :weight bold))))
   `(orderless-match-face-1 ((,class (:foreground ,magenta :weight bold))))
   `(orderless-match-face-2 ((,class (:foreground ,teal :weight bold))))
   `(orderless-match-face-3 ((,class (:foreground ,violet :weight bold))))

   `(org-block-begin-line ((,class (:inherit (shadow)
                                             :background ,hl-1/4
                                             :extend t
                                             :slant italic))))
   `(org-block ((,class (:background ,hl-1/2))))
   `(org-block-end-line ((,class (:inherit (org-block-begin-line)))))
   `(org-code ((,class (:foreground ,teal))))
   `(org-footnote ((,class (:inherit (font-lock-comment-face)))))
   `(org-todo ((,class (:foreground ,yellow :weight bold))))
   `(org-done ((,class (:foreground ,green :weight bold :slant italic))))

   `(outline-1 ((,class (:foreground ,violet))))
   `(outline-2 ((,class (:foreground ,blue))))
   `(outline-3 ((,class (:foreground ,orange))))
   `(outline-4 ((,class (:foreground ,green))))
   `(outline-5 ((,class (:foreground ,yellow))))
   `(outline-6 ((,class (:foreground ,magenta))))
   ;; `(outline-7 ((,class (:foreground ,))))
   ;; `(outline-8 ((,class (:foreground ,))))

   `(which-key-key-face ((,class (:inherit (font-lock-keyword-face)
                                           :weight bold))))
   `(which-key-highlighted-command-face ((,class (:foreground ,teal))))
   `(which-key-command-description-face ((,class (:inherit (comment)))))
   `(which-key-group-description-face ((,class (:foreground ,pink))))
   `(which-key-local-map-description-face ((,class (:inherit (comment)))))

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

(provide-theme 'λωα)
;;; λωα-theme.el ends here

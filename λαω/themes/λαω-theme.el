;;; λαω-theme.el --- λαω theme -*- coding: utf-8; lexical-binding: t; -*-

;; Local Variables:
;; eval: (colorful-mode t)
;; End:
(deftheme λαω
  "λαω theme."
  :background-mode 'dark
  :kind 'color-scheme)

(let* ((class '((class color) (min-colors 88)))
       (bg "#15141c")
       (fg "#cdcbcf")

       (theme-50  "#f5f3ff")
       (theme-100 "#cfc2fe")
       (theme-200 "#a79bd4")
       (theme-300 "#8275ac")
       (theme-400 "#5e5185")
       (theme-500 "#3d2f62")
       (theme-600 "#382265")
       (theme-700 "#310d64")
       (theme-800 "#280058")
       (theme-900 "#1f0046")

       (bg-theme "#3a3254")
       (bg-theme-darker "#27223b")
       (fg-theme "#d3caf5")

       (hl "#3a3653")
       (hl-3/4 "#312d48")
       (hl-1/2 "#242137")
       (hl-1/4 "#1d1b2d")

       (bg-inactive "#1d1d28")
       (fg-inactive "#7d7a82")

       ;; minimum allowable contrast (15 Lc) for backgrounds on top of
       ;; the main background
       (bg-min-red "#903232")
       (bg-min-yellow "#635301")
       (bg-min-orange "#7b4321")
       (bg-min-green "#345c30")

       (black "#060509")
       (white "#eeedf5")
       (red "#ee5263")
       (pink "#ffb9cc")
       (blue "#9fd2ff")
       (teal "#8adbd3")
       (yellow "#e6cb77")
       (yellow-bright "#f8f442")
       (green "#a2dc8c")
       (orange "#ffbf91")
       (magenta "#eabdf8")
       (violet "#cfc7ff")
       (light-grey "#9894a6")
       (grey "#817c91")

       (comment "#9692a4")
       (string "#e2cb8b")
       (fg-link "#91ce79")
       (fg-link-visited "#6ea558")

       (bg-diff-hl-change "#363418") (fg-diff-hl-change "#7b7744")
       (bg-diff-hl-insert "#263924") (fg-diff-hl-insert "#5c8059")
       (bg-diff-hl-delete "#472a26") (fg-diff-hl-delete "#9a655d")

       (bg-avy-lead-face "#363418"))

  (custom-theme-set-faces
   'λαω
   `(elisp-shorthand-font-lock-face ((,class (:foreground ,orange :weight bold))))

   `(λαω-mode-line-bell-warning ((,class (:background ,bg-min-yellow))))

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
   `(mode-line ((,class (:background ,bg-theme))))
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
   `(show-paren-mismatch ((,class (:background ,bg-min-red
                                   :foreground ,pink
                                   :weight bold))))

   ;; tabs
   `(tab-bar ((,class (:background ,hl-1/4))))
   `(tab-bar-tab ((,class (:background ,hl
                           :box (:line-width (1 . 1)
                                 :style flat-button
                                 :color ,hl)))))
   `(tab-bar-tab-inactive ((,class (:inherit (shadow) :slant italic))))

   ;;; package faces
   `(activities-tabs ((,class (:foreground ,green))))

   `(avy-goto-char-timer-face ((,class (:background ,bg-avy-lead-face
                                        :foreground ,fg
                                        :weight bold))))
   `(avy-lead-face ((,class (:inherit (avy-goto-char-timer-face) :foreground ,green :weight bold))))
   `(avy-lead-face-0 ((,class (:inherit (avy-goto-char-timer-face) :foreground ,magenta :weight bold))))
   `(avy-lead-face-1 ((,class (:inherit (avy-goto-char-timer-face) :foreground ,orange :weight bold))))
   `(avy-lead-face-2 ((,class (:inherit (avy-goto-char-timer-face) :foreground ,teal :weight bold))))

   `(bookmark-face ((,class (:foreground ,yellow))))

   `(corfu-default ((,class (:inherit (default) :background ,hl-1/2))))
   `(corfu-bar ((,class (:inherit (default) :background ,violet))))
   `(corfu-border ((,class (:inherit (default) :background ,hl-3/4))))
   `(corfu-current ((,class (:inherit (default)
                             :background ,hl
                             :foreground ,green
                             :weight bold))))

   `(custom-button ((,class (:background ,bg-theme :foreground ,fg :box (:line-width 2 :style flat-button)))))
   `(custom-button-mouse ((,class (:inherit (custom-button)))))
   `(custom-button-pressed ((,class (:inherit (custom-button) :background ,bg-theme-darker :foreground ,comment))))

   `(dired-flagged ((,class (:foreground ,red :weight bold))))
   `(dired-perm-write ((,class (:foreground ,orange))))
   `(dired-async-failures ((,class (:foreground ,red))))
   `(dired-async-message ((,class (:foreground ,violet))))
   `(dired-async-mode-message ((,class (:foreground ,violet))))

   `(diff-hl-change ((,class (:background ,bg-diff-hl-change :foreground ,fg-diff-hl-change))))
   `(diff-hl-delete ((,class (:background ,bg-diff-hl-delete :foreground ,fg-diff-hl-delete))))
   `(diff-hl-insert ((,class (:background ,bg-diff-hl-insert :foreground ,fg-diff-hl-insert))))

   `(dired-broken-symlink ((,class (:foreground ,red))))
   `(dired-marked ((,class (:inherit (warning) :weight bold))))

   `(fill-column-indicator ((,class (:foreground ,bg-inactive))))

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

   `(hl-line ((,class (:inherit (highlight) :background ,hl-1/2 :extend t))))
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

   `(org-date ((,class (:foreground ,magenta :slant italic))))
   `(org-block-begin-line ((,class (:inherit (shadow)
                                             :background ,hl-1/4
                                             :extend t
                                             :slant italic))))
   `(org-block ((,class (:background ,hl-1/2))))
   `(org-block-end-line ((,class (:inherit (org-block-begin-line)))))
   `(org-code ((,class (:foreground ,teal))))
   `(org-drawer ((,class (:inherit (shadow)))))
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

(provide-theme 'λαω)
;;; λαω-theme.el ends here

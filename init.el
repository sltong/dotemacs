;;; init.el --- Emacs user initialization file -*- coding: utf-8; lexical-binding: t; no-byte-compile: t; -*-

;; Copyright (C) 2024 λαω

;; Author: λαω <lambda.alpha.omega@proton.me>
;; Maintainer: λαω <lambda.alpha.omega@proton.me>
;; Keywords: local

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU Affero General Public License
;; as published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Affero General Public License for more details.

;; You should have received a copy of the GNU Affero General Public
;; License along with this program. If not, see
;; <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This is my init file. There are many like it, but this one is mine.

;; My init file is my best friend. It is my life. I must master it as
;; I must master my life.

;; Without me, my init file is useless. Without my init file, I am
;; useless. I must load my init file true. I must edit with Emacs
;; sharper than my enemy who is trying to outedit me. I must pwn him
;; before he pwns me. I will...

;; My init file and I know that what counts in editors is not the
;; start-up times, the backing by a tech corporation, nor the ricing
;; and anime catgirl theme backgrounds. We know that it is the edits
;; we make. We will edit...

;; My init file is human, even as I am human, because it is my
;; life. Thus, I will learn it as a brother. I will learn its
;; weaknesses, its strength, its parts, its dependencies, its bugs and
;; its syntax. I will keep my init file clean and ready, even as I am
;; clean and ready. We will become part of each other. We will...

;; Before God, I swear this creed. My init file and I are the
;; defenders of FOSS. We are the masters of our enemy. We are the
;; saviors of my life.

;; So be it, until victory is Richard Stallman's and there is no
;; enemy, but peace!

;;; Code:

(setq user-emacs-etc-directory (expand-file-name "etc/" user-emacs-directory))
(setq user-emacs-var-directory (expand-file-name "var/" user-emacs-directory))

;;; package configurations
(require 'package)
(require 'use-package)

(use-package package
  :ensure nil
  :defer nil
  :init
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  :bind ("C-h p" . describe-package))

(use-package use-package
  :ensure nil
  :defer nil
  :custom
  (use-package-always-defer t)
  (use-package-always-ensure t))

(use-package auto-compile
  :defer nil
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

;;; λαω
(defvar λαω-emacs-directory (expand-file-name "λαω/" user-emacs-directory)
  "Emacs λαω directory.")

(use-package λαω
  :defer nil
  :load-path λαω-emacs-directory)

;;; Emacs initialization and (built-in package) customizations
(use-package emacs
  :init
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (if (file-exists-p custom-file)
      (load custom-file)
    (message
     "`custom.el' does not exist. Creating it..."
     custom-file)
    (make-empty-file custom-file t))

  ;; default fonts
  (if (display-graphic-p)
      (progn
        (when (member "JetBrains Mono NL" (font-family-list))
          (add-to-list 'default-frame-alist
                       '(font . "JetBrains Mono NL"))
          (custom-set-faces
           '(fixed-pitch-serif ((t (:family "JetBrains Mono NL"))))))
        (when (member "IBM Plex Sans" (font-family-list))
          (custom-set-faces
           '(variable-pitch ((t (:family "IBM Plex Sans")))))))
    (message "Emacs is not running graphically. Skipping setting default font.")
    nil)

  ;; ensure `λαω-remove-kill-ring-text-properties' is the first
  ;; function in `kill-emacs-hook'
  (add-hook 'kill-emacs-hook 'λαω-remove-kill-ring-text-properties -100)

  :config
  (setopt custom-theme-directory (expand-file-name
                                  "themes" user-emacs-etc-directory))
  ;; aliases
  (defalias 'elisp-mode 'emacs-lisp-mode)
  ;; default modes
  (setq-default indent-tabs-mode nil)

  :hook
  (after-init . λαω-display-init-time-message)
  (org-mode . visual-line-mode)

  :bind (("C-x C-k" . kill-current-buffer)
         :map λαω-buffer-map
         ("s" . 'scratch-buffer))

  :custom
  (column-number-mode t)
  ;; (custom-enabled-themes '(modus-vivendi-tinted))
  (inhibit-default-init t "Don't load `default.el'.")
  (selection-coding-system 'utf-8)
  (auto-save-timeout 4)
  (auto-save-interval 65)
  (kill-ring-max 512)
  ;; undo
  (undo-limit (* 1000000) "Increase undo information to 1MB.")
  ;; last-ditch outer limit for single undo commands
  (undo-outer-limit (* 128000000)) ; 128MB
  (undo-strong-limit (* 8000000)) ; 8MB
  ;; (minibuffer) history
  (history-length 1024)
  (history-delete-duplicates t)
  (enable-recursive-minibuffers t)
  (truncate-lines t)
  ;; *scratch* buffer
  (initial-major-mode 'fundamental-mode
   "Set initial *scratch* buffer major mode to `fundamental-mode'.")
  (initial-scratch-message nil)
  (visible-bell t) ; replace audible bell with visual one
  (scroll-preserve-screen-position t)
  (message-log-max 10000
   "Increase maximum number of lines in the message log buffer.")
  (use-short-answers t "Make `yes-or-no-p' accept \"y\" or \"n\".")
  (yes-or-no-prompt "(y or n)")
  (default-input-method "greek")
  (sentence-end-double-space nil
   "Make Emacs recognize single spaces as sentence-ending.")
  (delete-by-moving-to-trash t
   "Don't delete files, but move them to OS-specific trash can.")
  ;; Emacs 30 and newer: disable Ispell completion function. As an
  ;; alternative, try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  ;; Enable indentation/completion using the TAB key.
  (tab-always-indent 'complete))

;; load immediately, as soon as possible
;; later packages still explicitly set their modes' respective
;; directories or file paths for redundancy.
(use-package no-littering
  :demand t
  :config
  ;; explicitly set "etc" and "var" directories for good measure
  (setq no-littering-etc-directory user-emacs-etc-directory)
  (setq no-littering-var-directory user-emacs-var-directory)
  (no-littering-theme-backups))

(use-package exec-path-from-shell
  :demand t
  :if (or (memq window-system '(mac ns x))
          (daemonp))
  :config
  (exec-path-from-shell-initialize))

;;; early packages
(use-package delight :defer 0.3)
(use-package diminish :defer 0.3)

;;; included packages
;; these packages should have :ensure explicitly set to nil in order
;; to prevent fetching them from repositories
(use-package autorevert
  :ensure nil
  :defer 1
  :config
  (global-auto-revert-mode)
  :diminish auto-revert-mode)

(use-package bookmark
  :ensure nil
  :defer 0.75
  :custom
  (bookmark-menu-confirm-deletion t)
  (bookmark-menu-length 80))

(use-package cc-mode
  :ensure nil
  :custom
  (c-basic-offset 4))

(use-package crm
  :ensure nil
  :commands (completing-read-multiple)
  :config
  (advice-add #'completing-read-multiple
              :filter-args #'λαω-crm-prompt-indicator))

(use-package delsel
  :ensure nil
  :defer 1
  :config
  (delete-selection-mode))

(use-package desktop
  :ensure nil
  :defer nil
  :config
  (desktop-save-mode)
  :custom
  (desktop-base-file-name ".desktop-session")
  (desktop-base-lock-name ".desktop-session.lock")
  (desktop-missing-file-warning t
   "Offer to recreate the buffers of deleted files.")
  (desktop-auto-save-timeout 1.5)
  (desktop-restore-eager 3)
  (desktop-lazy-idle-delay 0.5)
  (desktop-lazy-verbose nil)
  (desktop-globals-to-save '(desktop-missing-file-warning
                             file-name-history
                             kill-ring
                             kmacro-ring
                             regexp-search-ring
                             register-alist
                             search-ring
                             tags-file-name
                             tags-table-list))
  (desktop-clear-preserve-buffers
   '("\\*scratch\\*"
     "\\*Messages\\*"
     "\\*server\\*"
     "\\*tramp/.+\\*"
     "\\*Warnings\\*"
     "\\*Flymake log\\*")
   "‘desktop-clear’ should not delete these buffers.")
  (desktop-globals-to-clear '()
   "Don't clear any global variables with `desktop-clear'."))

(use-package dired
  :ensure nil
  :defer nil
  :bind (:map dired-mode-map
         ("b" . dired-up-directory)
         ("+" . dired-create-empty-file)
         ("M-+" . dired-create-directory))
  :custom
  (dired-listing-switches "-ahl")
  (dired-auto-revert-buffer t))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :custom
  (display-line-numbers-grow-only t)
  (display-line-numbers-width 3))

(use-package eldoc
  :ensure nil
  :defer 1.5
  :diminish)

(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-local-mode))

(use-package eshell
  :ensure nil
  :config
  (add-to-list 'eshell-modules-list 'eshell-tramp t)
  :bind (:map λαω-cli-map
         ("e" . eshell))
  :custom
  (eshell-buffer-maximum-lines 8192)
  ;; fix glitch where prompt gets partially hidden underneath modeline
  (eshell-scroll-to-bottom-on-input t)
  (eshell-scroll-to-bottom-on-output t)
  (eshell-scroll-show-maximum-output nil))

(use-package files
  :ensure nil
  :defer 1
  :custom
  (backup-by-copying t) ; don't break hard or symbolic links
  (version-control t) ; always use numerically versioned backups
  (delete-old-versions t)
  (kept-old-versions 0)
  (kept-new-versions 8)
  (confirm-kill-emacs 'y-or-n-p)
  (require-final-newline t))

(use-package finder
  :ensure nil
  :bind ("C-h P" . finder-by-keyword))

(use-package flymake
  :ensure nil
  :hook (prog-mode))

(use-package help-fns
  :ensure nil
  :bind (("C-h M" . describe-keymap)))

(use-package hideshow
  :ensure nil
  :hook (prog-mode . hs-minor-mode)
  :diminish (hs-minor-mode)
  :bind (("C-c C-<tab>" . hs-toggle-hiding)
         ("C-c <tab>" . hs-toggle-hiding))
  :custom
  (hs-isearch-open t "Open both code and comment blocks when doing `isearch'."))

(use-package hl-line
  :defer 1
  :init
  (defun λαω-disable-hl-line-mode-temporarily (func &rest args)
    "Temporarily disable `global-hl-line-mode' when calling FUNC.

Credit to Sacha Chua. See:
URL https://sachachua.com/dotemacs/index.html#highlight-line-mode"
    (if global-hl-line-mode
        (progn
          (global-hl-line-mode -1)
          (prog1 (apply func args)
            (global-hl-line-mode 1)))
      (apply func args)))
  (advice-add #'face-at-point :around #'λαω-disable-hl-line-mode-temporarily)
  :config
  (global-hl-line-mode))

(use-package ibuffer
  :ensure nil
  :bind (("C-x C-b" . ibuffer)
         :map λαω-buffer-map
         ("b" . ibuffer)))

(use-package mb-depth
  :ensure nil
  :defer 1.5
  :config
  (minibuffer-depth-indicate-mode))

(use-package minibuffer
  :ensure nil
  :commands minibuffer-mode
  :custom
  ;; tab cycle if there are only few candidates
  (completion-cycle-threshold 3))

(use-package paren
  :ensure nil
  :defer 1
  :config
  (show-paren-mode)
  :custom
  (show-paren-delay 0))

(use-package password-cache
  :ensure nil
  :defer 1
  :custom
  (password-cache-expiry (* 60 5))) ; 5 minutes

(use-package pixel-scroll
  :ensure nil
  :if (display-graphic-p)
  :defer 1
  :config
  (pixel-scroll-precision-mode))

(use-package re-builder
  :ensure nil
  :defer 1
  :custom
  (reb-re-syntax 'string)
  (reb-auto-match-limit 512))

(use-package recentf
  :ensure nil
  :defer 1
  :config
  (recentf-mode)
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name user-emacs-var-directory))
  :bind (("C-c f r" . recentf)
         :map λαω-files-map
         ("r" . recentf))
  :custom
  (recentf-max-saved-items 64))

(use-package repeat
  :ensure nil
  :defer 1
  :config
  (repeat-mode)
  :custom
  (repeat-exit-timeout 1))

(use-package replace
  :ensure nil
  :bind (("C-c r" . query-replace-regexp)
         :map λαω-map
         ("r" . query-replace-regexp)))

(use-package savehist
  :ensure nil
  :defer 0.01
  :config
  (savehist-mode)
  :custom
  (savehist-additional-variables '(kill-ring
                                   kmacro-ring
                                   regexp-search-ring
                                   search-ring
                                   Info-history)))

(use-package saveplace
  :ensure nil
  :defer 1.5
  :config
  (save-place-mode))

(use-package time
  :ensure nil
  :defer 0.03
  :config
  (display-time-mode)
  :custom
  (display-time-24hr-format t)
  (display-time-day-and-date t)
  (display-time-default-load-average
   nil
   "Don't show system load average (wtf?).")
  (display-time-format "%a %h %d %H:%M"))

(use-package tramp
  :ensure nil
  :defer 1
  :custom
  (tramp-default-method "ssh")
  (tramp-backup-directory-alist backup-directory-alist)
  ;; set default shell to bash
  (tramp-connection-properties '((nil "remote-shell" "/usr/bin/bash")))
  (tramp-encoding-shell "/usr/bin/bash"))

(use-package treesit
  :ensure nil
  :defer 2
  :config
  (setq treesit-language-grammars-directory
        (expand-file-name "treesit/language-grammars" user-emacs-var-directory))
  (setq treesit-extra-load-path (list treesit-language-grammars-directory)))

(use-package vc-hooks
  :ensure nil
  :defer 1
  :custom
  (vc-make-backup-files t))

(use-package window
  :ensure nil
  :defer nil
  :custom
  ;; See:
  ;; https://www.masteringemacs.org/article/demystifying-emacs-window-manager
  (switch-to-buffer-obey-display-actions t
   "treat manual buffer switching the same as programmatic switching"))

(use-package winner
  :ensure nil
  :defer 1.5
  :config
  (winner-mode)
  :bind (("C-c w C-/" . winner-undo)
         ("C-c w C-?" . winner-redo)))

(use-package which-key
  :ensure nil
  :defer 0.4
  :config
  (which-key-mode)
  :diminish
  :custom
  (which-key-idle-delay 0.25)
  (which-key-preserve-window-configuration t)
  (which-key-max-description-length nil)
  (which-key-dont-use-unicode nil)
  (which-key-prefix-prefix "*")
  (which-key-separator " → "))

(use-package whitespace
  :ensure nil
  :hook
  (prog-mode text-mode)
  :diminish
  :custom
  (whitespace-style '(face
                      trailing
                      tabs
                      missing-newline-at-eof
                      empty
                      indentation::space
                      space-after-tab
                      space-before-tab
                      tab-mark)))

(use-package window
  :ensure nil
  :bind (("C-c C-l" . recenter-top-bottom)
         ("C-c l" . recenter-top-bottom)
         :map λαω-map
         ("C-l" . recenter-top-bottom)
         :repeat-map λαω-recenter-window-repeat-map
         ("C-l" . recenter-top-bottom)
         ("l" . recenter-top-bottom)))

;;; third-party packages
(use-package doom-themes
  :defer 0.01
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-dracula t)
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :defer 0.01
  :config
  (doom-modeline-mode))

(use-package undo-fu-session
  :hook
  (text-mode prog-mode))

(use-package avy
  :bind (("M-j" . avy-goto-char-timer)))

(use-package expreg
  :config
  (defun λαω-expreg-expand-sentences ()
    "Expand sentences with `expreg'.

This function adds the `expreg--sentence' expansion function to
`expreg-functions'."
    (add-to-list 'expreg-functions 'expreg--sentence))

  :hook (text-mode . λαω-expreg-expand-sentences)
  :bind (("C->" . expreg-expand)
         ("C-<" . expreg-contract)))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package eat
  :hook
  (eshell-load . eat-eshell-visual-command-mode)
  :bind (:map λαω-cli-map
         ("t" . eat)))

(use-package vterm
  :config
  (keymap-unset vterm-mode-map "C-l" t)
  :bind (:map vterm-mode-map
         ("C-q" . vterm-send-next-key)
         :map λαω-cli-map
         ("v" . vterm)))

(use-package orderless
  :defer 1
  :init
  ;; efficient prefix filtering for inputs shorter than 4 characters
  (defun orderless-fast-dispatch (word index total)
    (and (= index 0) (= total 1) (length< word 4)
         (cons 'orderless-literal-prefix word)))
  :config
  (orderless-define-completion-style orderless-fast
    (orderless-style-dispatchers '(orderless-fast-dispatch))
    (orderless-matching-styles
     '(orderless-flex orderless-literal orderless-regexp)))
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; enable file wildcard support using partial completion
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :defer 1
  :config
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  (keymap-set consult-narrow-map
              (concat consult-narrow-key " ?") #'consult-narrow-help)

  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ; orig. project-switch-to-buffer
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ; orig. goto-line
         ("M-g o" . consult-outline)               ; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ; orig. next-matching-history-element
         ("M-r" . consult-history))                ; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :custom
  (consult-preview-key 'any))

(use-package consult-dir
  :after consult
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package vertico
  :defer 0.5
  :config
  (vertico-mode)
  :custom
  (vertico-cycle t) ; enable cycling for `vertico-next/previous'
  (vertico-count 7)
  (vertico-resize nil)) ; affix minibuffer window size

(use-package corfu
  :defer 1
  :config
  (global-corfu-mode)
  (keymap-unset corfu-map "<RET>")
  ;; corfu extensions
  (corfu-echo-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)
  :bind (:map corfu-map
         ;; configure SPC for separator insertion
         ("SPC" . corfu-insert-separator))
  :custom
  (corfu-cycle t) ; enable cycling for `corfu-next/previous'
  (corfu-separator ?\s) ; orderless field separator
  (corfu-scroll-margin 3)
  (corfu-popupinfo-delay '(0.5 . 0.25))
  (corfu-preview-current t))

(use-package corfu-terminal
  :after corfu
  :if (display-graphic-p)
  :defer 1.5
  :config
  (corfu-terminal-mode))

(use-package cape
  :defer 1
  :config
  ;; Add to the global default value of
  ;; `completion-at-point-functions' which is used by
  ;; `completion-at-point'. The order of the functions matters, the
  ;; first function returning a result wins. Note that the list of
  ;; buffer-local completion functions takes precedence over the
  ;; global list.
  ;;  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-elisp-symbol)
  ;; (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-history)
  ;; (add-hook 'completion-at-point-functions #'cape-emoji)

  (keymap-set λαω-text-completion-map "c" (cons "cape" cape-prefix-map)))

(use-package marginalia
  :defer 1.25
  :config
  (marginalia-mode)
  :bind (("M-A" . marginalia-cycle))
  :custom
  (marginalia-field-width 120))

(use-package embark
  :defer 1
  :config
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  :bind
  (("C-." . embark-act) ;; pick some comfortable binding
   ("C-;" . embark-dwim) ;; good alternative: M-.
   ("C-h B" . embark-bindings))) ;; alternative for `describe-bindings'

(use-package embark-consult
  ;; show consult previews as you move around an auto-updating embark
  ;; collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package magit
  :defer 1
  :commands (magit-auto-revert-mode magit-mode magit-wip-mode)
  :config
  (add-to-list 'magit-no-confirm 'safe-with-wip)
  (magit-wip-mode)
  :diminish magit-wip-mode
  :bind (:map λαω-git-map
         ("d" . magit-dispatch)
         ("f" . magit-file-dispatch)
         ("g" . magit-status)))

(use-package magit-todos
  :after magit
  :defer 1
  :config
  (magit-todos-mode))

(use-package git-timemachine
  :bind (:map λαω-git-map
         ("t" . git-timemachine)))

(use-package diff-hl
  :defer 1
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  :hook
  (magit-pre-refresh . diff-hl-magit-pre-refresh)
  (magit-post-refresh . diff-hl-magit-post-refresh)
  (dired-mode . diff-hl-dired-mode)
  :custom
  (diff-hl-update-async t)
  (diff-hl-draw-borders nil)
  (diff-hl-flydiff-delay 0.2))

(use-package yasnippet
  :disabled
  :defer 1
  :config
  (yas-reload-all)
  (yas-minor-mode)
  :bind (("C-c y e" . yas-expand)
         :map λαω-map
         ("y" . yas-insert-snippet)))

(use-package yasnippet-snippets
  :disabled
  :after yasnippet)

(use-package whitespace-cleanup-mode
  :defer 1
  :config
  (global-whitespace-cleanup-mode)
  :diminish)

(use-package ialign
  :bind (:map λαω-text-map
         ("a" . ialign)))

(use-package vundo
  :bind (("C-M-/" . vundo)))

(use-package goto-line-preview
  :bind ([remap goto-line] . goto-line-preview))

(use-package indent-bars
  :config
  (require 'indent-bars-ts)
  :hook (prog-mode)
  :custom
  (indent-bars-color '(highlight :face-bg t :blend 0.25))
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.2)
  (indent-bars-pad-frac 0.2)
  (indent-bars-display-on-blank-lines nil)
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  (indent-bars-treesit-scope '((function_definition
                                class_definition
                                for_statement
                                if_statement
                                with_statement
                                while_statement))))

(use-package colorful-mode
  :hook (prog-mode text-mode))

;;; init.el ends here

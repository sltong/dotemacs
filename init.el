;;; init.el --- Emacs user initialization file -*- coding: utf-8; lexical-binding: t; -*-

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

;;; package configurations
(require 'package)
(require 'use-package)

(use-package package
  :ensure nil
  :demand t
  :init
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  :bind ("C-h p" . describe-package)
  :custom
  (package-quickstart-file
   (expand-file-name "package-quickstart.el" user-emacs-var-directory))
  (package-quickstart t
   "Speed up start-up time by precomputing package activation actions."))

(use-package use-package
  :ensure nil
  :demand t
  :custom
  (use-package-always-ensure t))

;; system packages
(use-package system-packages)
(use-package use-package-ensure-system-package)

;; λαω
(setq emacs-λαω-directory (expand-file-name "λαω" user-emacs-directory))
(use-package λαω
  :load-path emacs-λαω-directory)

;;; Emacs initialization and customizations
(use-package emacs
  :init
  ;; customizations file
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (unless (file-exists-p custom-file)
    (message
     "Custom file %s does not exist. Creating..."
     custom-file)
    (make-empty-file custom-file t))
  (load custom-file)

  ;; themes directory
  (setq custom-themes-directory (expand-file-name
                                 "themes" user-emacs-etc-directory))
  (unless (file-directory-p custom-themes-directory)
    (message
     "Custom themes directory %s does not exist. Creating..."
     custom-themes-directory)
    (make-directory custom-themes-directory t))

  ;; hooks
  (add-hook 'after-init-hook 'λαω-display-init-time-message)
  ;; ensure `λαω-remove-kill-ring-text-properties' is the first
  ;; function in `kill-emacs-hook'
  (add-hook 'kill-emacs-hook 'λαω-remove-kill-ring-text-properties -100)
  (add-hook 'org-mode-hook 'visual-line-mode)
  :custom
  (custom-enabled-themes '(modus-vivendi-tinted))
  (load-prefer-newer t)
  (inhibit-default-init t)
  (selection-coding-system 'utf-8)
  (auto-save-timeout 5)
  (auto-save-interval 65)
  (kill-ring-max 512)
  ;; undo
  (undo-limit (* 1000 1000 1) "Increase undo information to 1MB.")
  ;; last-ditch outer limit for single undo commands
  (undo-outer-limit (* 1000 1000 100)) ; 50MB
  (undo-strong-limit (* 1000 1000 5)) ; 5MB
  ;; (minibuffer) history
  (history-length 1024)
  (history-delete-duplicates t)
  (enable-recursive-minibuffers t)
  (truncate-lines t)
  (column-number-mode t)
  (indent-tabs-mode nil)
  ;; *scratch* buffer
  (initial-major-mode 'fundamental-mode
   "Set initial *scratch* buffer major mode to `fundamental-mode'.")
  (initial-scratch-message nil)
  (visible-bell t) ; replace audible bell with visual one
  (scroll-conservatively 101)
  (scroll-preserve-screen-position t)
  (message-log-max 10000
   "Increase maximum number of lines in the message log buffer.")
  (use-short-answers t "Make `yes-or-no-p' accept \"y\" or \"n\".")
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

;;; early packages
;; load immediately, as soon as possible
;; later packages still explicitly set their modes' respective
;; directories or file paths for redundancy.
(use-package no-littering
  :demand t
  :config
  (no-littering-theme-backups))

(use-package exec-path-from-shell
  :demand t
  :if (or (memq window-system '(mac ns x))
          (daemonp))
  :config
  (exec-path-from-shell-initialize))

;; load early without :demand
(use-package delight)
(use-package diminish)

;;; built-in packages
;; these packages should have :ensure explicitly set to nil in order
;; to prevent fetching them from repositories
(use-package autorevert
  :ensure nil
  :config
  (global-auto-revert-mode)
  :diminish (auto-revert-mode))

(use-package cc-vars
  :ensure nil
  :custom
  (c-basic-offset 4))

(use-package crm
  :ensure nil
  :config
  (advice-add #'completing-read-multiple
              :filter-args #'λαω-crm-prompt-indicator))

(use-package delsel
  :ensure nil
  :init
  (delete-selection-mode)) ; replace active selection with typed text

(use-package desktop
  :ensure nil
  :init
  (desktop-save-mode)
  :custom
  (desktop-base-file-name ".desktop-session")
  (desktop-base-lock-name ".desktop-session.lock")
  (desktop-missing-file-warning t)
  (desktop-auto-save-timeout 4)
  (desktop-lazy-idle-delay 1)
  (desktop-lazy-verbose nil))

(use-package dired
  :ensure nil
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

(use-package frame
  :ensure nil
  :config
  (keymap-global-unset "C-z"))

(use-package help-fns
  :ensure nil
  :bind (("C-h M" . describe-keymap)))

(use-package hideshow
  :ensure nil
  :config
  (hs-minor-mode)
  :bind (("C-c C-<tab>" . hs-toggle-hiding)
         ("C-c <tab>" . hs-toggle-hiding)))

(use-package ibuffer
  :ensure nil
  :bind (("C-x C-b" . ibuffer)
         :map λαω-map
         ("b" . ibuffer)))

(use-package mb-depth
  :ensure nil
  :config
  (minibuffer-depth-indicate-mode))

(use-package minibuffer
  :ensure nil
  :custom
  ;; tab cycle if there are only few candidates
  (completion-cycle-threshold 3))

(use-package paren
  :ensure nil
  :config
  (show-paren-mode))

(use-package password-cache
  :ensure nil
  :custom
  (password-cache-expiry (* 60 5))) ; 5 minutes

(use-package pixel-scroll
  :ensure nil
  :if (display-graphic-p)
  :init
  (pixel-scroll-precision-mode))

(use-package re-builder
  :ensure nil
  :custom
  (reb-re-syntax 'string)
  (reb-auto-match-limit 512))

(use-package recentf
  :ensure nil
  :defer 1
  :config
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (recentf-mode)
  :bind (("C-c f r" . recentf)
         :map λαω-file-map
         ("f" . recentf))
  :custom
  (recentf-max-saved-items 64))

(use-package repeat
  :ensure nil
  :init
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
  :init
  (savehist-mode)
  :custom
  (savehist-additional-variables '(kill-ring
                                   kmacro-ring
                                   regexp-search-ring
                                   search-ring)))

(use-package saveplace
  :ensure nil
  :config
  (save-place-mode))

(use-package time
  :init
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
  :defer t
  :custom
  (tramp-default-method "ssh")
  (tramp-backup-directory-alist backup-directory-alist)
  ;; set default shell to bash
  (tramp-connection-properties '((nil "remote-shell" "/usr/bin/bash")))
  (tramp-encoding-shell "/usr/bin/bash"))

(use-package treesit
  :ensure nil
  :init
  (setq treesit-language-grammars-directory
        (expand-file-name "treesit/language-grammars" user-emacs-var-directory))
  (setq treesit-extra-load-path (list treesit-language-grammars-directory)))

(use-package vc-hooks
  :ensure nil
  :custom
  (vc-make-backup-files t))

(use-package winner
  :ensure nil
  :config
  (winner-mode))

(use-package which-key
  :ensure nil
  :init
  (which-key-mode)
  :diminish
  :custom
  (which-key-idle-delay 0.3)
  (which-key-preserve-window-configuration t)
  (which-key-max-description-length nil)
  (which-key-dont-use-unicode nil)
  (which-key-prefix-prefix "*")
  (which-key-separator " → "))

(use-package whitespace
  :ensure nil
  :diminish
  :hook
  (prog-mode text-mode)
  :custom
  (whitespace-style '(face
                      trailing
                      tabs
                      indentation::space
                      space-after-tab
                      space-before-tab
                      tab-mark)))

(use-package window
  :ensure nil
  :bind (("C-c l" . recenter-top-bottom)
         :repeat-map λαω-recenter-window-repeat-map
         ("l" . recenter-top-bottom)))

;;; third-party packages
(use-package undo-fu-session
  :hook
  (text-mode prog-mode))

(use-package avy
  :defer 1
  :bind (("M-j" . avy-goto-char-timer)))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package eat
  :config
  (eat-eshell-visual-command-mode)
  :bind (:map λαω-cli-map
         ("t" . eat)))

(use-package vterm
  ;; needed to compile libvterm
  :ensure-system-package (cmake libtool)
  :config
  (keymap-unset vterm-mode-map "C-l" t)
  :bind (:map λαω-cli-map
         ("v" . vterm)))

(use-package orderless
  :demand t
  :init
  ;; efficient prefix filtering for inputs shorter than 4 characters
  (defun orderless-fast-dispatch (word index total)
    (and (= index 0) (= total 1) (length< word 4)
         (cons 'orderless-literal-prefix word)))
  :config
  (orderless-define-completion-style orderless-fast
    (orderless-style-dispatchers '(orderless-fast-dispatch))
    (orderless-matching-styles '(orderless-literal orderless-regexp)))
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; enable file wildcard support using partial completion
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t) ; enable cycling for `vertico-next/previous'
  (vertico-count 7)
  (vertico-resize nil)) ; affix minibuffer window size

(use-package corfu
  :init
  (global-corfu-mode)
  (add-hook 'eshell-mode-hook
            (defun λαω-disable-corfu-auto-for-eshell ()
              (setq-local corfu-auto nil)
              (corfu-mode)))
  ;; corfu extensions
  (corfu-echo-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)
  ;; configure SPC for separator insertion
  :bind (:map corfu-map
         ("SPC" . corfu-insert-separator))
  :custom
  (corfu-cycle t)         ; enable cycling for `corfu-next/previous'
  (corfu-separator ?\s)   ; orderless field separator
  (corfu-scroll-margin 3)
  (corfu-popupinfo-delay '(1.25 . 0.9)))

(use-package corfu-terminal
  :requires corfu
  :if (display-graphic-p)
  :init
  (corfu-terminal-mode))

(use-package marginalia
  :config
  (marginalia-mode)
  :bind (("M-A" . marginalia-cycle))
  :custom
  (marginalia-field-width 120))


(use-package expreg
  :config
  (defun custom-expreg-expand-sentences ()
    (add-to-list 'expreg-functions 'expreg--sentence))
  :hook (text-mode . custom-expreg-expand-sentences)
  :bind (("C->" . expreg-expand)
         ("C-<" . expreg-contract)))

(use-package magit
  :ensure-system-package git
  :commands (magit-auto-revert-mode magit-mode magit-wip-mode)
  :config
  (add-to-list 'magit-no-confirm 'safe-with-wip)
  (magit-wip-mode)
  :diminish magit-wip-mode
  :bind (("C-c g s" . magit-status)
         ("C-c g g" . magit-dispatch)
         ("C-c g f" . magit-file-dispatch)
         :map λαω-git-map
         ("g" . magit-status)))

(use-package magit-todos
  :after magit
  :config
  (magit-todos-mode))

(use-package git-timemachine
  :ensure-system-package git
  :bind (("C-c g t" . git-timemachine)
         :map λαω-git-map
         ("t" . git-timemachine)))

(use-package diff-hl
  :init
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  :hook
  (dired-mode . diff-hl-dired-mode)
  :custom
  (diff-hl-update-async t)
  (diff-hl-draw-borders nil)
  (diff-hl-flydiff-delay 0.2))

(use-package yasnippet
  :config
  (keymap-unset yas-minor-mode-map "<tab>" t)
  (yas-minor-mode)
  :bind (("C-c y e" . yas-expand)
         :map λαω-map
         ("y" . yas-insert-snippet)))

(use-package yasnippet-snippets
  :requires yasnippet)

(use-package whitespace-cleanup-mode
  :defer 3
  :init
  (global-whitespace-cleanup-mode)
  :diminish)

(use-package ialign
  :bind (("C-c t i" . ialign)))

(use-package vundo
  :bind (("C-M-/" . vundo)))

(use-package goto-line-preview
  :bind ([remap goto-line] . goto-line-preview))

(use-package beacon
  :init
  (beacon-mode)
  :config
  (add-to-list 'beacon-dont-blink-major-modes
               'artist-mode
               'which-key-mode)
  :diminish
  :custom
  (beacon-blink-delay 0.25)
  (beacon-blink-duration 0.25)
  (beacon-color "#fcb948")
  (beacon-size 32))

(use-package indent-bars
  :config
  (require 'indent-bars-ts)
  :hook (prog-mode)
  :custom
  (indent-bars-color '(highlight :face-bg t :blend 0.2))
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.1)
  (indent-bars-pad-frac 0.1)
  (indent-bars-display-on-blank-lines nil)
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  (indent-bars-treesit-scope '((function_definition
                                class_definition
                                for_statement
                                if_statement
                                with_statement
                                while_statement))))

;;; init.el ends here

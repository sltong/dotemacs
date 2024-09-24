;;; init.el --- Emacs user initialization file -*- lexical-binding: t -*-

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
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'use-package)
(use-package use-package
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-verbose t))

;;; early packages
;; load immediately, as early as possible
(use-package no-littering
  :demand t)

(use-package exec-path-from-shell
  :demand t
  :if (or (memq window-system '(mac ns x))
          (daemonp))
  :config
  (exec-path-from-shell-initialize))

;;; local packages and directories
(add-to-list 'load-path
             (directory-file-name (expand-file-name "λαω" user-emacs-directory)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (message
   "Custom file %s does not exist. Creating..."
   custom-file)
  (make-empty-file custom-file t))
(load custom-file)

(setq user-emacs-etc-directory (expand-file-name "etc" user-emacs-directory))
(setq user-emacs-var-directory (expand-file-name "var" user-emacs-directory))

(setq custom-themes-directory (expand-file-name "themes" user-emacs-etc-directory))
(unless (file-directory-p custom-themes-directory)
  (message
   "Custom themes directory %s does not exist. Creating..."
   custom-themes-directory)
  (make-directory custom-themes-directory t))

;; (minibuffer) history
(setq history-length 1024)
(setq history-delete-duplicates t)

;; initial scratch buffer
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

(setq visible-bell t) ; replace audible bell with visual one
(setq column-number-mode t)

(setq scroll-conservatively 101)
(setq scroll-preserve-screen-position t)

(setq message-log-max 10000) ; max number of lines for message log buffer

(setq use-short-answers t) ; make "yes-or-no-p" accept "y" and "n"

(setq-default indent-tabs-mode nil)

;;; local packages
(require 'λαω-keys)
(require 'λαω-functions)

;;; built-in packages
;; these packages should have :ensure explicitly set to nil in order
;; to prevent fetching them from repositories
(use-package cc-vars
  :ensure nil
  :custom
  (c-basic-offset 4))

(use-package delsel
  :ensure nil
  :init
  (delete-selection-mode 1)) ; replace active selection with typed text

(use-package desktop
  :ensure nil
  :init
  (desktop-save-mode 1)
  :custom
  (desktop-save 'ask)
  (desktop-base-file-name ".desktop-session")
  (desktop-base-lock-name ".desktop-session.lock")
  (desktop-restore-eager 3)
  (desktop-lazy-idle-delay 1)
  (desktop-lazy-verbose nil))

(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
	 ("b" . dired-up-directory)))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :custom
  (display-line-numbers-grow-only t)
  (display-line-numbers-width 3))

(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package eshell
  :ensure nil
  :bind (:map λαω-shell-map
         ("e" . eshell))
  :custom
  (eshell-buffer-maximum-lines 8192))

(use-package files
  :ensure nil
  :custom
  (backup-directory-alist
        (list (cons "." (expand-file-name "backups" user-emacs-var-directory))))
  (backup-by-copying t) ; don't break hard or symbolic links
  (version-control t) ; always use numerically versioned backups
  (delete-old-versions t)
  (kept-old-versions 3)
  (kept-new-versions 5))

(use-package finder
  :ensure nil
  :bind ("C-h P" . finder-by-keyword))

(use-package help-fns
  :ensure nil
  :bind (("C-h M" . describe-keymap)))

(use-package ibuffer
  :ensure nil
  :bind (:map λαω-map
         ("b" . ibuffer)))

(use-package package
  :ensure nil
  :bind ("C-h p" . describe-package))

(use-package pixel-scroll
  :ensure nil
  :if (display-graphic-p)
  :init
  (pixel-scroll-precision-mode 1))

(use-package prog-mode
  :ensure nil
  :config
  (defun λαω-prog-mode-hook ()
    (setq-local truncate-lines t))
  (add-hook 'prog-mode-hook #'λαω-prog-mode-hook))

(use-package re-builder
  :ensure nil
  :custom
  (reb-re-syntax 'string))

(use-package recentf
  :ensure nil
  :defer 1
  :init
  (recentf-mode 1)
  :config
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  :bind (("C-c f r" . recentf)
         :map λαω-map
         ("f" . recentf))
  :custom
  (recentf-max-saved-items 64))

(use-package savehist
  :ensure nil
  :defer 1
  :init
  (savehist-mode 1)
  :custom
  (savehist-additional-variables '(kill-ring kmacro-ring regexp-search-ring search-ring)))

(use-package simple
  :ensure nil
  :custom
  (kill-ring-max 512))

(use-package treesit
  :ensure nil
  :init
  (setq treesit-language-grammars-directory
        (expand-file-name "treesit/language-grammars" user-emacs-var-directory))
  (setq treesit-extra-load-path (list treesit-language-grammars-directory)))

(use-package which-key
  :ensure nil
  :demand t
  :init
  (which-key-mode 1))

(use-package whitespace
  :ensure nil
  :hook
  (prog-mode . whitespace-mode)
  (text-mode . whitespace-mode)
  :custom
  (whitespace-style '(face trailing tabs)))

(use-package window
  :ensure nil
  :bind (("C-c l" . recenter-top-bottom)))

;;; third-party packages
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
  :defer 1
  :init
  (defun λαω-vertico-insert-unless-tramp ()
    "Insert current candidate in minibuffer, except for tramp."
    (interactive)
    (if (vertico--remote-p (vertico--candidate))
        (minibuffer-complete)
      (vertico-insert)))
  (vertico-mode 1)
  :bind (:map vertico-map
         ("TAB" . λαω-vertico-insert-unless-tramp))
  :custom
  (vertico-cycle t) ; enable cycling for `vertico-next/previous'
  (vertico-count 7)
  (vertico-resize nil)) ; affix minibuffer window size

(use-package corfu
  :defer 1
  :init
  (global-corfu-mode 1)
  (add-hook 'eshell-mode-hook
            (lambda ()
              (setq-local corfu-auto nil)
              (corfu-mode)))
  ;; corfu extensions
  (corfu-echo-mode 1)
  (corfu-history-mode 1)
  (corfu-popupinfo-mode 1)
  ;; configure SPC for separator insertion
  :bind (:map corfu-map
         ("SPC" . corfu-insert-separator))
  :custom
  (corfu-cycle t)         ; enable cycling for `corfu-next/previous'
  (corfu-separator ?\s)   ; orderless field separator
  (corfu-scroll-margin 3)
  (corfu-popupinfo-delay '(1.25 . 0.9)))

(use-package corfu-terminal
  :if (display-graphic-p)
  :init
  (corfu-terminal-mode 1))

(use-package marginalia
  :init
  (marginalia-mode 1)
  :custom
  (marginalia-field-width 120))

(use-package vundo
  :demand t
  :bind (("C-M-/" . vundo)))

(use-package magit
  :ensure-system-package git
  :bind (("C-c g s" . magit-status)
	 ("C-c g g" . magit-dispatch)
	 ("C-c g f" . magit-file-dispatch)
         :map λαω-git-map
         ("g" . magit-status)))

(use-package expreg
  :config
  (defun custom-expreg-expand-sentences ()
    (add-to-list 'expreg-functions 'expreg--sentence))
  :hook (text-mode . custom-expreg-expand-sentences)
  :bind (("C->" . expreg-expand)
         ("C-<" . expreg-contract)))

(use-package yasnippet
  :init
  (yas-global-mode 1)
  (keymap-unset yas-minor-mode-map "TAB" t)
  :bind (("C-c y e" . yas-expand)
         :map λαω-map
         ("y" . yas-insert-snippet)))

(use-package yasnippet-snippets
  :requires yasnippet)

(use-package colorful-mode
  :hook (prog-mode text-mode))

(use-package emacs
  ;; many of these configurations are suggested by vertico and corfu
  :init
  ;; add prompt indicator to `completing-read-multiple'
  ;; display [CRM<separator>], e.g., [CRM,] if the separator is a comma
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))

  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
  ;; show minibuffer recursion depth
  (minibuffer-depth-indicate-mode 1)

  :custom
  ;; undo
  (undo-limit (* 1000 1000 1)) ; 1MB
  ;; last-ditch outer limit for single undo commands
  (undo-outer-limit (* 1000 1000 100)) ; 50MB
  (undo-strong-limit (* 1000 1000 5)) ; 5MB

  ;; support opening new minibuffers from inside existing minibuffers
  (enable-recursive-minibuffers t)

  ;; TAB cycle if there are only few candidates
  (completion-cycle-threshold 3)

  ;; hide commands in M-x which do not work in the current mode. vertico
  ;; commands are hidden in normal buffers.
  (read-extended-command-predicate #'command-completion-default-include-p)

  ;; Emacs 30 and newer: disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (text-mode-ispell-word-completion nil)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete))

(setq package-quickstart t) ; improve start-up time

;;; init.el ends here

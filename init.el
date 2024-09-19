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

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'load-path
             (directory-file-name (expand-file-name "λαω" user-emacs-directory)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq user-emacs-etc-directory (expand-file-name "etc" user-emacs-directory))
(setq user-emacs-var-directory (expand-file-name "var" user-emacs-directory))

(setq custom-themes-directory (expand-file-name "themes" user-emacs-etc-directory))
(unless (file-directory-p custom-themes-directory)
  (message
   "Custom themes directory %s does not exist. Creating..."
   custom-themes-directory)
  (make-directory custom-themes-directory t))

;; file backups
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-var-directory))))
(setq version-control t) ; always use numerically versioned backups
(setq delete-old-versions t)
(setq kept-old-versions 3)
(setq kept-new-versions 5)

;; initial scratch buffer
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

(setq visible-bell t) ; replace audible bell with visual one

(setq column-number-mode t)

(setq message-log-max 10000) ; max number of lines for message log buffer

(setq use-short-answers t) ; make "yes-or-no-p" accept "y" and "n"

(setq frame-resize-pixelwise t)

(setq-default indent-tabs-mode nil)

;;; local packages
(require 'λαω-functions)

;; `use-package' configurations
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; load immediately, as early as possible
(use-package no-littering
  :demand t)

;;; built-in packages
;; Some built-in packages needs :ensure to be explicitly set to nil in
;; order to prevent fetching them from repositories.
(use-package completion-preview
  :init
  (global-completion-preview-mode 1))

(use-package delsel
  :init
  (delete-selection-mode 1)) ; replace active selection with typed text

(use-package desktop
  :custom
  (desktop-base-file-name ".desktop-session")
  (desktop-base-lock-name ".desktop-session.lock")
  :init
  (desktop-save-mode 1))

(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
	 ("b" . dired-up-directory)))

(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode))

(use-package elec-pair
  :init
  (electric-pair-mode 1))

(use-package eshell
  :ensure nil
  :init
  ;; this is needed to preemptively define `eshell-mode-map'
  (require 'esh-mode)
  :bind (:map eshell-mode-map
              ("C-d" . eshell-life-is-too-much))) ; emulate ^D EOF quitting

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package re-builder
  :custom
  (reb-re-syntax 'string))

(use-package recentf
  :init
  (recentf-mode 1)
  :config
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory))
  :custom
  (recentf-max-menu-items 13)
  (recentf-max-saved-items 23))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package simple
  ;; explicitly set to prevent `use-package' from fetching from
  ;; package repositories
  :ensure nil
  :custom
  (undo-limit (* 1000 1000 1)) ; 1MB
  ;; last-ditch outer limit for single undo commands
  (undo-outer-limit (* 1000 1000 100)) ; 50MB
  (undo-strong-limit (* 1000 1000 5)) ; 5MB
  (kill-ring-max 512))

(use-package treesit
  :ensure nil
  :config
  (setq treesit-language-grammars-directory
        (expand-file-name "treesit/language-grammars" user-emacs-var-directory))
  (setq treesit-extra-load-path (list treesit-language-grammars-directory)))

(use-package which-key
  :init
  (which-key-mode 1))

(use-package whitespace
  :custom
  (whitespace-style '(face trailing tabs))
  :hook
  (prog-mode . whitespace-mode)
  (text-mode . whitespace-mode))

;;; third-party packages
(use-package exec-path-from-shell
  :if (or (memq window-system '(mac ns x)) (daemonp))
  :init
  (exec-path-from-shell-initialize))

(use-package vundo
  :bind (("C-M-/" . vundo)))

(use-package expreg
  :bind (("C->" . expreg-expand)
         ("C-<" . expreg-contract))
  :config
  (defun custom-expreg-expand-sentences ()
    (add-to-list 'expreg-functions 'expreg--sentence))
  :hook (text-mode . custom-expreg-expand-sentences))

(use-package magit
  :ensure-system-package git
  :bind (("C-x g" . magit-status)
	 ("C-c g" . magit-dispatch)
	 ("C-c f" . magit-file-dispatch)))

(use-package orderless
  :init
  :config
  ;; efficient prefix filtering for inputs shorter than 4 characters
  (defun orderless-fast-dispatch (word index total)
    (and (= index 0) (= total 1) (length< word 4)
         (cons 'orderless-literal-prefix word)))
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
  (vertico-mode 1)
  :config
  ;; adjust number of candidates when resizing minibuffer
  (defun vertico-resize--minibuffer ()
    (add-hook 'window-size-change-functions
              (lambda (win)
                (let ((height (window-height win)))
                  (when (/= (1- height) vertico-count)
                    (setq-local vertico-count (1- height))
                    (vertico--exhibit))))
              t t))
  (advice-add #'vertico--setup :before #'vertico-resize--minibuffer)

  (defun law-vertico-insert-unless-tramp ()
    "Insert current candidate in minibuffer, except for tramp."
    (interactive)
    (if (vertico--remote-p (vertico--candidate))
        (minibuffer-complete)
      (vertico-insert)))

  :bind (:map vertico-map
         ("TAB" . law-vertico-insert-unless-tramp))
  :custom
  (vertico-cycle t) ; enable cycling for `vertico-next/previous'
  (vertico-count 7)
  (vertico-resize nil)) ; affix minibuffer window size

(use-package corfu
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

(use-package yasnippet
  :init
  (yas-global-mode 1)
  (keymap-unset yas-minor-mode-map "TAB" t)
  :bind (:map yas-minor-mode-map
              ("C-c y e" . yas-expand)))

(use-package yasnippet-snippets
  :requires yasnippet)

(use-package colorful-mode
  :hook (prog-mode text-mode))

(use-package emacs
  ;; many of these configurations are suggested by vertico and corfu
  :custom
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
  (tab-always-indent 'complete)

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
  (minibuffer-depth-indicate-mode 1))

(setq package-quickstart t) ; improve start-up time

;; keymaps
(defvar-keymap λαω-config-map
  :doc "Keymap for configurations.")

(defvar-keymap λαω-emacs-config-map
  :doc "Keymap for Emacs configurations.")

(defvar-keymap λαω-shell-config-map
  :doc "Keymap for shell configurations.")

(defvar-keymap λαω-shell-map
  :doc "Keymap for shells.")

;; key bindings
;; config key(map) bindings
(keymap-global-set "C-c C-c" λαω-config-map)
(keymap-global-set "C-c c" λαω-config-map)
(keymap-set λαω-config-map "e" λαω-emacs-config-map)
(keymap-set λαω-config-map "s" λαω-shell-config-map)

(keymap-set λαω-emacs-config-map "e"
            (cons "open-emacs-early-init-file"
                  '(lambda ()
                     (interactive)
                     (find-file early-init-file))))
(keymap-set λαω-emacs-config-map "i"
            (cons "open-emacs-init-file"
                  '(lambda ()
                     (interactive)
                     (find-file user-init-file))))
(keymap-set λαω-shell-config-map "b"
            (cons "open-bashrc"
                  '(lambda ()
                     (interactive)
                     (find-file "~/.bashrc"))))

;; shell key(map) bindings
(keymap-global-set "C-c C-s" λαω-shell-map)
(keymap-global-set "C-c s" λαω-shell-map)
(keymap-set λαω-shell-map "e" 'eshell)

;;; init.el ends here

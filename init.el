;;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

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

(setq visible-bell t) ; replace audible bell with visual one

;; prompts
(setq use-short-answers t) ; make "yes-or-no-p" accept "y" and "n"

;; file backups
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-var-directory))))
(setq version-control t) ; create multiple, numbered backups
(setq delete-old-versions t) ; automatically delete excess backup files
(setq kept-old-versions 3) ; keep oldest 3 files
(setq kept-new-versions 5) ; keep newest 5 files

(setq message-log-max 10000) ; max number of lines for message log buffer

(setq-default indent-tabs-mode nil) ; disable tabs for indentation

;; initial scratch buffer
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

(setq column-number-mode t)

;; `use-package'
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; needs to be loaded immediately as early as possible
(use-package no-littering
  :demand t)

;; built-in packages
(use-package delsel
  :init
  (delete-selection-mode)) ; replace active selection with typed text

(use-package desktop
  :custom
  (desktop-base-file-name ".desktop-session")
  (desktop-base-lock-name ".desktop-session.lock")
  :init
  (desktop-save-mode))

(use-package dired
  :ensure nil ; dired is built-in, so don't try installing from package archives
  :bind (:map dired-mode-map
	 ("b" . dired-up-directory)))

(use-package elec-pair
  :init
  (electric-pair-mode))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package re-builder
  :custom
  (reb-re-syntax 'string))

(use-package recentf
  :init
  (recentf-mode)
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
  (savehist-mode))

(use-package simple
  :ensure nil ; built-in
  :custom
  (undo-limit (* 1000 1000 1)) ; 1MB
  ;; last-ditch outer limit for one undo command
  (undo-outer-limit (* 1000 1000 100)) ; 50MB
  (undo-strong-limit (* 1000 1000 5))) ; 5MB

(use-package which-key
  :init
  (which-key-mode))

(use-package whitespace
  :custom
  (whitespace-style '(face trailing tabs))
  :hook
  (prog-mode . whitespace-mode)
  (text-mode . whitespace-mode))

;; external packages
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
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; enable file wildcard support with partial completion
  (completion-category-overrides '((file (styles partial-completion))))
  ;; unconditionally load `orderless'
  :init)

(use-package vertico
  :init
  (vertico-mode)
  :config
  ;; adjust the number of candidates when resizing minibuffer
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
  (vertico-count 12))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package emacs
  ;; many of these configurations come from vertico and corfu
  :custom
  ;; support opening new minibuffers from inside existing minibuffers
  (enable-recursive-minibuffers t)
  ;; hide commands in M-x which do not work in the current mode. vertico
  ;; commands are hidden in normal buffers.
  (read-extended-command-predicate #'command-completion-default-include-p)
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
  (minibuffer-depth-indicate-mode))

(setq package-quickstart t) ; improve start-up time

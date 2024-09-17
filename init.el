;;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(setq package-quickstart t) ;; improve start-up time

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq user-emacs-etc-directory (expand-file-name "etc" user-emacs-directory))
(setq user-emacs-var-directory (expand-file-name "var" user-emacs-directory))

(setq custom-theme-directory (expand-file-name "themes" user-emacs-etc-directory))

(setq visible-bell t) ;; replace audible bell with visual one

;; prompts
(setq yes-or-no-prompt "(y or n) ")
(setq use-short-answers t) ;; make "yes-or-no-p" accept "y" and "n"

;; file backups
(setq backup-directory-alist (list (cons "." (expand-file-name "backups" user-emacs-var-directory))))
(setq version-control t) ; create multiple, numbered backups
(setq delete-old-versions t) ; automatically delete excess backup files
(setq kept-old-versions 3) ; keep oldest 3 files
(setq kept-new-versions 5) ; keep newest 5 files

(setq-default indent-tabs-mode nil) ; disable tabs for indentation

;; initial scratch buffer
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

(setq column-number-mode t)

;; `use-package'
(use-package use-package
  :init
  (setq use-package-always-ensure t))


;; built-in packages
(use-package delsel
  :init
  (delete-selection-mode)) ;; replace active selection with typed text

(use-package desktop
  :custom
  (desktop-base-file-name ".desktop-session")
  (desktop-base-lock-name ".desktop-session.lock")
  (add-to-list 'desktop-path desktop-session-directory)
  :init
  (setq desktop-session-directory (expand-file-name "desktop/" user-emacs-var-directory))
  (unless (file-directory-p desktop-session-directory)
    (make-directory desktop-session-directory))
  (desktop-save-mode))

(use-package dired
  :ensure nil ;; dired is built-in, so don't try installing from package archives
  :bind (:map dired-mode-map
	 ("b" . dired-up-directory)))

(use-package elec-pair
  :init
  (electric-pair-mode))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package savehist
  :custom
  (savehist-file (expand-file-name "minibuffer-history.el" user-emacs-var-directory))
  :init
  (savehist-mode))

(use-package whitespace
  :custom
  (whitespace-style '(face trailing tabs))
  :init
  (global-whitespace-mode))

(use-package which-key
  :init
  (which-key-mode))

;; external packages
(use-package exec-path-from-shell
  :init
  (when (or (memq window-system '(mac ns x))
            (daemonp))
    (exec-path-from-shell-initialize)))

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
  :custom
  (vertico-cycle t) ;; enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

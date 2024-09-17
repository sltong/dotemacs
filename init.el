;;; -*- lexical-binding: t -*-

(setq package-quickstart t) ;; improve start-up time

(setq initial-frame-alist '((fullscreen . maximized)))

(setq user-emacs-var-directory (expand-file-name "var" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; prompts
(setq yes-or-no-prompt "(y or n) ")
(setq use-short-answers t) ;; make "yes-or-no-p" accept "y" and "n"

;; file backups
(setq backup-directory-alist (list (cons "." (expand-file-name "backups" user-emacs-var-directory))))
(setq version-control t) ; create multiple, numbered backups
(setq delete-old-versions t) ; automatically delete excess backup files
(setq kept-old-versions 3) ; keep oldest 3 files
(setq kept-new-versions 5) ; keep newest 5 files

;; `use-package'
(setq use-package-always-ensure t)

(use-package desktop
  :custom
  (desktop-dirname (expand-file-name "desktop" user-emacs-var-directory))
  :init
  (desktop-save-mode))

(use-package savehist
  :custom
  (savehist-file (expand-file-name "minibuffer-history.el" user-emacs-var-directory))
  :init
  (savehist-mode))

(use-package which-key
  :init
  (which-key-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; enable file wildcard support with partial completion
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package vertico
  :custom
  (vertico-cycle t) ;; enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

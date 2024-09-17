;;; -*- lexical-binding: t -*-

(setq package-quickstart t) ;; improve start-up time

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; prompts
(setq yes-or-no-prompt "(y or n) ")
(setq use-short-answers t) ;; make "yes-or-no-p" accept "y" and "n"

;; file backups
(setq backup-directory-alist (list (cons "." (expand-file-name "backups/" user-emacs-directory))))
(setq version-control t) ; create multiple, numbered backups
(setq delete-old-versions t) ; automatically delete excess backup files
(setq kept-old-versions 3) ; keep oldest 3 files
(setq kept-new-versions 5) ; keep newest 5 files

;; `which-key'
(which-key-mode)

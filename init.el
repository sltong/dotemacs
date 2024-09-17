;;; -*- lexical-binding: t -*-

(setq package-quickstart t) ;; improve start-up time

(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

;; file backups
(setq version-control t) ; create multiple, numbered backups
(setq delete-old-versions t) ; automatically delete excess backup files
(setq kept-old-versions 3) ; keep oldest 3 files
(setq kept-new-versions 5) ; keep newest 5 files


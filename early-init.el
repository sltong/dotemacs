;;; early-init.el --- Emacs user early initialization file -*- coding: utf-8; lexical-binding: t; no-byte-compile: t; -*-

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

;; Emacs user early initialization file.

;; `setq' is used instead of `customize-set-variable' and `setopt' for
;; performance.

;;; Code:

;; set these high enough as to effectively disable garbage collection
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.9)

(defvar file-name-handler-alist-pre-init file-name-handler-alist
  "Pre-`user-init-file' `file-name-handler-alist'.

This variable stores the original `file-name-handler-alist' so that it
can be set to nil during initialization to speed it up.")

(setq file-name-handler-alist nil)

;; set `native-comp-eln-load-path'
(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))

(setq package-user-dir (convert-standard-filename
                        (expand-file-name "var/elpa/" user-emacs-directory)))

;; load the newest version of a file irrespective of its extension
(setq load-prefer-newer t)

;; temporarily hide warnings
(setq warning-minimum-level :error)
;; suppress native compilation warnings
(setq native-comp-async-report-warnings-errors 'silent)

;; Don't try to preserve a frame's number of columns and don't round
;; frame sizes when resizing. These should optimize for the case when
;; the frame font size is different from the system's.
(setq frame-inhibit-implied-resize t)
(setq frame-resize-pixelwise t)

;; initial and default frames
(setq initial-frame-alist '((fullscreen             . maximized)
                            (horizontal-scroll-bars . nil)
                            (vertical-scroll-bars   . nil)
                            (menu-bar-lines         . 0)
                            (tool-bar-lines         . 0)))

(setq default-frame-alist '((fullscreen             . maximized)
                            (horizontal-scroll-bars . nil)
                            (vertical-scroll-bars   . nil)
                            (menu-bar-lines         . 0)
                            (tool-bar-lines         . 0)))

(tooltip-mode -1)

(setq inhibit-startup-screen t)

(defun λαω-emacs-startup-hook-function ()
  "`emacs-startup-hook' hook function.

This function is run after loading `user-init-file' and handling the
command line.

Restore the following:
- garbage collection
- displaying of warnings
- `file-name-handler-alist'"
  (setq gc-cons-threshold (* 1024 1024 16)) ; 16MiB
  (setq gc-cons-percentage 0.1)
  (setq warning-minimum-level :warning)
  (setq file-name-handler-alist file-name-handler-alist-pre-init)
  (load custom-file))

(add-hook 'emacs-startup-hook #'λαω-emacs-startup-hook-function)

(add-to-list 'load-path (expand-file-name "λαω/" user-emacs-directory))

(provide 'early-init)

;;; early-init.el ends here

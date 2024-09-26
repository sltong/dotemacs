;;; early-init.el --- Emacs user early initialization file -*- lexical-binding: t -*-

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

;;; Code:

;; set these high enough as to effectively disable garbage collection
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.9)
;; set "etc" and "var" Emacs user directories
(setq user-emacs-etc-directory (convert-standard-filename
                                (expand-file-name "etc/" user-emacs-directory)))
(setq user-emacs-var-directory (convert-standard-filename
                                (expand-file-name "var/" user-emacs-directory)))

;; store `eln-cache' in the "var" user-emacs-directory
(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (expand-file-name "eln-cache/" user-emacs-var-directory)))

;; don't try to preserve a frame's number of columns and don't round
;; frame sizes when resizing
;; these should optimize for the case when the frame font size is
;; different from the system's
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; initial and default frames
(setq initial-frame-alist '((fullscreen . maximized)
                            (horizontal-scroll-bars . nil)
                            (vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)))
(setq default-frame-alist '((fullscreen . maximized)
                            (horizontal-scroll-bars . nil)
                            (vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)))

(setq inhibit-startup-screen t)

;; theming
(setq custom-enabled-themes '(modus-vivendi-tinted))
(load-theme 'modus-vivendi-tinted)

;; add hook for turning garbage collection back on by resetting
;; `gc-cons-threshold' and `gc-cons-percentage' to normal values
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold (* 1000 1000 16) ; 16MB
          gc-cons-percentage 0.1)))

;;; early-init.el ends here

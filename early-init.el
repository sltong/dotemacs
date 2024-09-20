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

;; turn garbage collection back on by resetting `gc-cons-threshold'
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold (* 1000 1000 16) ; 16MB
          gc-cons-percentage 0.1)))

;; store `eln-cache' in the "var" user-emacs-directory
(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))

;; don't try to preserve a frame's number of columns and don't round
;; frame sizes when resizing
;; these should optimize for the case when the frame font size is
;; different from the system's
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; theming
(setq custom-enabled-themes '(modus-vivendi-tinted))
(load-theme 'modus-vivendi-tinted)

;; initial and default frames
(setq initial-frame-alist '((fullscreen . maximized)))
(setq default-frame-alist '((fullscreen . maximized)
                             (tool-bar-lines . 0)))

;;; early-init.el ends here

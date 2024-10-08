;;; λαω-themes.el --- λαω themes -*- coding: utf-8; lexical-binding: t; -*-

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

;; λαω themes.

;;; Code:

(require 'λαω)

;; fonts
(if (display-graphic-p)
    (progn
      (when (member "Iosevka Law" (font-family-list))
        (add-to-list 'default-frame-alist
                     '(font . "Iosevka Law-14"))
        (custom-set-faces
         '(fixed-pitch ((t (:family "Iosevka Law"))))))
      (when (member "IBM Plex Sans" (font-family-list))
        (custom-set-faces
         '(variable-pitch ((t (:family "IBM Plex Sans"))))
         '(variable-pitch-text ((t (:inherit (variable-pitch) :height 1.05)))))))
  (message "Emacs is not running graphically. Skipping setting default font.")
  nil)

(defcustom λαω-themes-directory (expand-file-name
                                 "themes/" λαω-emacs-directory)
  "λαω themes directory."
  :type 'directory
  :group 'λαω)

(setopt custom-theme-directory
        (expand-file-name "themes/" λαω-emacs-directory))

(add-to-list 'custom-theme-load-path λαω-themes-directory)

(load-theme 'λαω t)

(provide 'λαω-themes)
;;; λαω-themes.el ends here

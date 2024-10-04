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

(defcustom λαω-themes-directory (expand-file-name
                                 "themes/" λαω-emacs-directory)
  "λαω themes directory."
  :type 'directory
  :group 'λαω)

(add-to-list 'custom-theme-load-path λαω-themes-directory)

(load-theme 'λαω t)

(provide 'λαω-themes)
;;; λαω-themes.el ends here

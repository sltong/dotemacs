;;; λαω-functions.el --- λαω functions  -*- lexical-binding: t -*-

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

;; you should have received a copy of the gnu affero general public
;; license along with this program. if not, see
;; <https://www.gnu.org/licenses/>.

;;; Commentary:

;; λαω functions.

;;; Code:

(defun λαω-downcase-and-hyphenate-region (beginning end)
  "Downcase words and replaces spaces with a hyphen in the active
region. Consecutive spaces are replaced by a single hyphen."
  (interactive "r")
  (when (use-region-p)
    (downcase-region beginning end)
    (replace-regexp "\\([[:alnum:]]\\)[[:space:]]+\\([[:alnum:]]\\)" "\\1-\\2"
                    nil beginning end)))

(provide 'λαω-functions)

;;; λαω-functions.el ends here

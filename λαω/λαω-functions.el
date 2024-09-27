;;; λαω-functions.el --- λαω functions -*- coding: utf-8; lexical-binding: t; -*-

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

;; Functions.

;;; Code:

;;; utilities

(defun λαω-downcase-and-hyphenate-region (region-start region-end)
  "Downcase words in the region and concatenate them with hyphens.

Consecutive blank characters are replaced by a single hyphen.

Any non-blank, non-word characters (such as punctuation marks) will
break concatenation. For example, the function will transform \"Oh no!
Our word chain; it's broken.\", \"oh-no! our-word-chain; it's-broken.\"."
  (interactive "r")
  (when (use-region-p)
    (save-excursion
      (downcase-region region-start region-end)
      (goto-char region-start)
      (while (re-search-forward "\\b[[:blank:]]+\\b" region-end t)
        (replace-match "-" nil nil)))))

(defun λαω-scratch-other-window ()
  "Show or create the *scratch* buffer in the other window."
  (interactive)
  (switch-to-buffer-other-window (get-scratch-buffer-create)))

(provide 'λαω-functions)

;;; λαω-functions.el ends here

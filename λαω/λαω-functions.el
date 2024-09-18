;;; λαω-functions.el --- Functions  -*- lexical-binding: t -*-

;; Copyright (C) 2024 λαω

;; Author: λαω <lambda.alpha.omega@proton.me>
;; Keywords: local
;; Created: 2024
;; Version: 0.1
;; Requires: ((emacs "30.0"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package consists of functions intended for local use.

;;; Code:

(defun λαω-open-emacs-init-file ()
  "Open the user Emacs init file."
  (interactive)
  (find-file user-init-file))

(provide 'λαω-functions)

;; λαω-functions.el ends here

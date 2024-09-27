;;; λαω-custom.el --- λαω customization groups, variables, and faces -*- coding: utf-8; lexical-binding: t; -*-

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

;; Customization groups, variables, and faces.

;;; Code:

(defgroup λαω-use-package-defer-priority
  nil ; group members
  "`use-package' `:defer' priorities."
  :group 'use-package
  :prefix "λαω-use-package-defer-priority")

(defcustom λαω-use-package-defer-priority-highest 0.01
  "Highest priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(defcustom λαω-use-package-defer-priority-higher 0.2
  "Higher priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(defcustom λαω-use-package-defer-priority-high 0.5
  "High priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(defcustom λαω-use-package-defer-priority-medium 0.75
  "Medium priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(defcustom λαω-use-package-defer-priority-low 1
  "Low priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(defcustom λαω-use-package-defer-priority-lower 2
  "Lower priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(defcustom λαω-use-package-defer-priority-lowest 3
  "Lowest priority for `use-package' `:defer'."
  :type '(choice number (const nil))
  :require 'use-package
  :group 'λαω-use-package-defer-priority)

(provide 'λαω-custom)

;;; λαω-custom.el ends here

;;; λαω-org.el --- λαω Org Mode(-related) -*- coding: utf-8; lexical-binding: t; -*-

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

;; All things Org Mode.

;;; Code:

(use-package org
  :ensure nil
  :defer λαω-use-package-defer-priority-medium
  :diminish org-indent-mode
  :bind (:map λαω-org-map
         ("a" . org-agenda))
  :custom
  (org-startup-indented t)
  (org-special-ctrl-a/e t)
  (org-edit-src-content-indentation 0)
  (org-hide-leading-stars t)
  (org-src-tab-acts-natively t)
  (org-display-custom-times t)
  (org-timestamp-custom-formats
   '("<%Y-%m-%d (%a.)>" . "<%Y-%m-%d %H:%M:%S (%a.)>"))
  ;; agenda
  (org-agenda-files (expand-file-name "agendas.org" org-directory))
  ;; babel
  (org-confirm-babel-evaluate nil)
  ;; todo
  (org-todo-keywords '((sequence "TODO(t)" "DOING(d)" "POSTPONED(p)"
                                 "|" "DONE(f)" "CANCELLED(x)")))
  ;; exporting
  (org-html-doctype "html5")
  (org-html-head-include-default-style nil))

(provide 'λαω-org)

;;; λαω-org.el ends here

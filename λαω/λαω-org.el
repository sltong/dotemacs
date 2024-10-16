;;; λαω-org.el --- λαω Org(-related) -*- coding: utf-8; lexical-binding: t; -*-

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
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; Affero General Public License for more details.

;; You should have received a copy of the GNU Affero General Public
;; License along with this program. If not, see
;; <https://www.gnu.org/licenses/>.

;;; Commentary:

;; All things Org.

;;; Code:

(require 'λαω-functions)
(require 'λαω-keys)

(use-package org
  :ensure nil
  :config
  (λαω-make-visit-file-function 'org-directory)
  :bind (:map λαω-org-map
         ("a" . org-agenda)
         ("M-p" . org-metaup)
         ("M-n" . org-metadown))
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
  (org-todo-keywords '((sequence "TODO(t)" "MAYBE(m)" "DOING(d)" "POSTPONED(p)"
                                 "|" "DONE(f)" "CANCELLED(x)")))
  ;; exporting
  (org-html-doctype "html5")
  (org-html-head-include-default-style nil))

(use-package org-noter
  :defer t)

;; `org-noter' modules
(use-package org-noter-pdf
  :ensure nil
  :after org-noter
  :defer t)

(use-package org-noter-nov
  :ensure nil
  :after nov
  :defer t)

(use-package org-pdftools
  :hook (org-mode-hook . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :defer t
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package org-roam
  :defer t)

(use-package org-ql
  :defer t)

(use-package org-download
  :defer t)

(provide 'λαω-org)

;;; λαω-org.el ends here

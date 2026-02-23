;;; λαω-org.el --- λαω Org(-related) -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright (C) 2024 λαω

;; Author: Lao Tong <lao.s.t@pm.me>
;; Maintainer: Lao Tong <lao.s.t@pm.me>
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
  (org-special-ctrl-a/e t)
  (org-edit-src-content-indentation 2)
  (org-hide-leading-stars t)
  (org-src-tab-acts-natively t)
  (org-display-custom-times t)
  (org-timestamp-custom-formats
   '("<%Y-%m-%d (%a.)>" . "<%a. %Y-%m-%d %H:%M:%S>"))
  ;; archive
  (org-archive-location (concat
                         (expand-file-name "archives/" org-directory)
                         "%s.archive::"))
  ;; agenda
  (org-agenda-files (expand-file-name "agendas.org" org-directory))
  ;; babel
  (org-confirm-babel-evaluate nil)
  ;; todo
  (org-todo-keywords '((sequence "TODO(t)" "MAYBE(m)" "DOING(d)" "POSTPONED(p)"
                        "|" "DONE(f)" "CANCELLED(x)"))))

(use-package org-transclusion
  :defer t
  :after org
  :bind ("<f12>" . org-transclusion-add))

(use-package org-download
  :defer t)

(use-package org-super-agenda
  :defer t)

(use-package org-noter
  :defer t
  :config
  ;; `org-noter' modules
  (require 'org-noter-pdf)
  (require 'org-noter-nov))

(use-package ox
  :ensure nil
  :defer t
  :custom
  ;; exporting
  (org-export-creator-string "Emacs (Org Mode)")
  (org-export-headline-levels 6))

(use-package ox-html
  :ensure nil
  :defer t
  :custom
  ;; HTML
  (org-html-doctype "html5")
  (org-html-html5-fancy t)
  (org-html-head-include-default-style nil)
  (org-html-postamble t)
  (org-html-postamble-format '(("en" "<span>- %d</span>")))
  (org-html-self-link-headlines t)
  (org-html-htmlize-output-type 'css))

(use-package ox-publish
  :ensure nil
  :defer t
  :custom
  ;; publishing
  (org-publish-project-alist `(("blog"
                                :base-directory "~/projects/blog/"
                                :publishing-directory "~/projects/blog/export/"
                                :publishing-function org-html-publish-to-html
                                :section-numbers nil
                                :with-toc nil
                                :html-head ,(concat
                                             "<link rel=\"stylesheet\" href=\"./static/style.css\" type=\"text/css\"/>\n"
                                             "<link rel=\"stylesheet\" href=\"./static/emacs-style.css\" type=\"text/css\"/>")
                                :html-preamble t)
                               ("blog-static"
                                :base-directory "~/projects/blog/static/"
                                :base-extension "jpg\\|gif\\|png\\|webp\\|css"
                                :publishing-directory "~/projects/blog/export/static/"
                                :publishing-function org-publish-attachment
                                :recursive t)
                               ("blog-website"
                                :components ("blog" "blog-static")))))

(use-package org-roam
  :defer t)

(use-package org-noter
  :defer 2
  :config
  ;; `org-noter' modules
  (require 'org-noter-djvu)
  (require 'org-noter-nov)
  (require 'org-noter-org-roam)
  (require 'org-noter-pdf)
  :custom
  (org-noter-notes-search-path (list org-directory)))

(use-package org-ql
  :defer t)


(provide 'λαω-org)

;;; λαω-org.el ends here

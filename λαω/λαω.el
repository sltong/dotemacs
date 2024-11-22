;;; λαω.el --- λαω -*- coding: utf-8; lexical-binding: t; -*-

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

;; "ἐγὼ τὸ ἄλφα καὶ τὸ ὦ, ὁ πρῶτος καὶ ὁ ἔσχατος, ἡ ἀρχὴ καὶ τὸ τέλος."
;; - Ἀποκάλυψις Ἰωάννου 22:13, Ἰησοῦς

;;; Code:

(require 'cl-lib)

;;; personal information
(setopt user-full-name "λαω")
(setopt user-mail-address "lambda.alpha.omega@proton.me")

;;; customizations
(defgroup λαω nil
  "λαω"
  :prefix "λαω-"
  :group 'local)

(defvar λαω-emacs-etc-directory (expand-file-name
                                     "etc/" user-emacs-directory)
  "\"etc\" directory containing miscellaneous Emacs configurations.")

(defvar λαω-emacs-var-directory (expand-file-name
                                     "var/" user-emacs-directory)
  "\"var\" directory holding Emacs compiled files and package data.

This directory contains Emacs Lisp packages, natively-compiled *.eln
files, and package data.")

(defvar λαω-emacs-directory (expand-file-name "λαω/" user-emacs-directory)
  "λαω directory in `user-emacs-directory'.")

(defvar λαω-treesit-language-grammars-directory (expand-file-name
                                                    "tree-sitter/"
                                                    λαω-emacs-var-directory)
  "The directory where tree-sitter language grammars are installed.

This directory can be passed to `treesit-install-language-grammar' as an
optional argument.")

(provide 'λαω)
;;; λαω.el ends here

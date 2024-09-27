;;; λαω-keys.el --- λαω keymaps and key bindings -*- coding: utf-8; lexical-binding: t; -*-

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

;; Keymaps and key bindings.

;;; Code:

(require 'λαω-functions)

;;; keymaps
(defvar-keymap λαω-map
  :doc "λαω keymap."
  :name "λαω")
(keymap-set global-map "C-l" (cons "λαω" λαω-map))

(defvar-keymap λαω-file-map
  :doc "Keymap for files."
  :name "files")
(keymap-set global-map "C-c f" (cons "λαω-files" λαω-file-map))
(keymap-set λαω-map "f" (cons "files" λαω-file-map))

(defvar-keymap λαω-config-files-map
  :doc "Keymap for configuration files."
  :name "config")
(keymap-set λαω-file-map "c" (cons "config" λαω-config-files-map))

(defvar-keymap λαω-emacs-config-files-map
  :doc "Keymap for Emacs configurations."
  :name "emacs-config")
(keymap-set λαω-config-files-map "e" (cons "emacs-config"
                                           λαω-emacs-config-files-map))

(defvar-keymap λαω-cli-config-files-map
  :doc "Keymap for command-line interface configurations."
  :name "cli-config")
(keymap-set λαω-config-files-map "c" (cons "cli-config"
                                           λαω-cli-config-files-map))

(defvar-keymap λαω-git-map
  :doc "Keymap for git-related commands."
  :name "git")
(keymap-set λαω-map "g" (cons "git" λαω-git-map))

(defvar-keymap λαω-cli-map
  :doc "Keymap for shells and terminals.")
(keymap-set global-map "C-c c" (cons "λαω-cli" λαω-cli-map))
(keymap-set λαω-map "c" (cons "cli" λαω-cli-map))

(defvar-keymap λαω-org-map
  :doc "Keymap for Org Mode."
  :name "org")
(keymap-set global-map "C-c o" (cons "λαω-org" λαω-org-map))
(keymap-set λαω-map "o" (cons "org" λαω-org-map))

;;; key bindings

(keymap-set λαω-map "s" 'scratch-buffer)

;; config key bindings

(keymap-set λαω-emacs-config-files-map
            "e" '("early-init" . λαω-find-emacs-early-init-file))

(keymap-set λαω-emacs-config-files-map
            "i" '("init" . λαω-find-emacs-init-file))

(keymap-set λαω-emacs-config-files-map
            "c" '("custom" . λαω-find-emacs-custom-file))

(keymap-set λαω-cli-config-files-map
            "b" '("bashrc" . λαω-find-bashrc-file))

;; the rest of the key bindings can be found in a package's respective
;; `use-package' macro in `init.el'

(provide 'λαω-keys)

;;; λαω-keys.el ends here

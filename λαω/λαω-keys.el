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

;; directory keymaps
(defvar-keymap λαω-dir-map
  :doc "Keymap for directories."
  :name "dir"
  "o" '("org" . λαω-find-org-directory)
  "e" '("emacs" . λαω-find-user-emacs-directory))
(keymap-set global-map
            "C-c d" (cons "λαω-dir" λαω-dir-map))
(keymap-set λαω-map
            "d" (cons "dir" λαω-dir-map))

;; file keymaps
(defvar-keymap λαω-file-map
  :doc "Keymap for files."
  :name "file")
(keymap-set global-map
            "C-c f" (cons "λαω-file" λαω-file-map))
(keymap-set λαω-map
            "f" (cons "file" λαω-file-map))

;; config file keymaps
(defvar-keymap λαω-file-config-map
  :doc "Keymap for configuration files."
  :name "file-config")
(keymap-set λαω-file-map
            "c" (cons "config" λαω-file-config-map))

(defvar-keymap λαω-file-config-λαω-map
  :doc "Keymap for λαω configurations."
  :name "config-λαω"
  "λ" '("λαω"       . λαω-find-λαω-λαω-file)
  "l" '("λαω"       . λαω-find-λαω-λαω-file)
  "c" '("custom"    . λαω-find-λαω-custom-file)
  "f" '("functions" . λαω-find-λαω-functions-file)
  "k" '("keys"      . λαω-find-λαω-keys-file)
  "o" '("org"       . λαω-find-λαω-org-file))

(keymap-set λαω-file-config-map
            "l" (cons "λαω" λαω-file-config-λαω-map))

(defvar-keymap λαω-file-config-emacs-map
  :doc "Keymap for Emacs configurations."
  :name "config-emacs"
  "c" '("custom"     . λαω-find-emacs-custom-file)
  "e" '("early-init" . λαω-find-emacs-early-init-file)
  "i" '("init"       . λαω-find-emacs-user-init-file))
(keymap-set λαω-file-config-map
            "e" (cons "emacs" λαω-file-config-emacs-map))

(defvar-keymap λαω-file-config-cli-map
  :doc "Keymap for command-line interface configurations."
  :name "config-cli"
  "b" '("bashrc" . λαω-find-bashrc-file))
(keymap-set λαω-file-config-map
            "c" (cons "cli" λαω-file-config-cli-map))

(defvar-keymap λαω-git-map
  :doc "Keymap for git-related commands."
  :name "git")
(keymap-set λαω-map
            "g" (cons "git" λαω-git-map))

(defvar-keymap λαω-cli-map
  :doc "Keymap for command-line interfaces."
  :name "cli")
(keymap-set global-map
            "C-c c" (cons "λαω-cli" λαω-cli-map))
(keymap-set λαω-map
            "c" (cons "cli" λαω-cli-map))

(defvar-keymap λαω-org-map
  :doc "Keymap for Org Mode."
  :name "org")
(keymap-set global-map
            "C-c o" (cons "λαω-org" λαω-org-map))
(keymap-set λαω-map
            "o" (cons "org" λαω-org-map))

(defvar-keymap λαω-text-map
  :doc "Keymap for text."
  :name "text")
(keymap-set global-map
            "C-c t" (cons "λαω-text" λαω-text-map))
(keymap-set λαω-map
            "t" (cons "text" λαω-text-map))

;; global key bindings
(keymap-set λαω-map "s" 'scratch-buffer)

;; the rest of the key bindings can be found in a package's respective
;; `use-package' macro in `init.el'

(provide 'λαω-keys)
;;; λαω-keys.el ends here

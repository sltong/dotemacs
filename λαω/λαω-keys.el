;;; λαω-keys.el --- λαω keymaps and key bindings -*- lexical-binding: t -*-

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

;; λαω keymaps and key bindings.

;;; Code:

;;; keymaps
(defvar-keymap λαω-map
  :doc "λαω keymap."
  :name "λαω")
(keymap-set global-map "C-l" λαω-map)

(defvar-keymap λαω-config-map
  :doc "Keymap for configuration files."
  :name "config")
(keymap-set global-map "C-c c" λαω-config-map)

(defvar-keymap λαω-emacs-config-map
  :doc "Keymap for Emacs configurations."
  :name "emacs-config")
(keymap-set λαω-config-map "e" λαω-emacs-config-map)

(defvar-keymap λαω-shell-config-map
  :doc "Keymap for shell configurations.")
(keymap-set λαω-config-map "s" λαω-shell-config-map)

(defvar-keymap λαω-git-map
  :doc "Keymap for git-related commands."
  :name "git")
(keymap-set λαω-map "g" λαω-git-map)

(defvar-keymap λαω-shell-map
  :doc "Keymap for shells.")
(keymap-set λαω-map "s" λαω-shell-map)

(defvar-keymap λαω-terminal-map
  :doc "Keymap for terminals.")
(keymap-set λαω-map "t" λαω-terminal-map)

;;; key bindings
;; config key bindings
(keymap-set λαω-emacs-config-map
            "e" '("early-init" . (lambda ()
                                   (interactive)
                                   (find-file early-init-file))))
(keymap-set λαω-emacs-config-map
            "i" '("init" . (lambda ()
                   (interactive)
                   (find-file user-init-file))))

(keymap-set λαω-shell-config-map
            "b" '("bashrc" . (lambda ()
                               (interactive)
                               (find-file "~/.bashrc"))))

(provide 'λαω-keys)

;;; λαω-keys.el ends here

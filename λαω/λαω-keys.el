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

;; "C-l" is globally unset and bound to `λαω-map'.

;; Global key unbindings are located here. Global key (re)binds may be
;; found either in this file (by `keymap-global-set' or in a λαω
;; keymap) if they're bound to built-in package commands, or in
;; `user-init-file' if they're for non-built-in packages.

;; First-level `λαω-map' commands are bound with a control modifier.
;; These are command shortcuts. For example, `recenter-top-bottom' is
;; bound to "C-l C-l".

;; Package-specific command key bindings can be found in their
;; respective package's `use-package' declaration in `init.el'.

;;; Code:

(require 'λαω-functions)

;;; global key unbindings
(keymap-global-unset "C-l") ; `recenter-top-bottom'
(keymap-global-unset "C-z") ; `suspend-frame'

;;; keymaps
(defvar-keymap λαω-map
  :doc "λαω keymap."
  :name "λαω")
(keymap-global-set "C-l" (cons "λαω" λαω-map))

;; file keymaps
(defvar-keymap λαω-files-map
  :doc "Keymap for files."
  :name "files")
(keymap-global-set "C-c f" (cons "λαω-file" λαω-files-map))
(keymap-set λαω-map "f" (cons "files" λαω-files-map))

;; directory keymaps
(defvar-keymap λαω-dirs-map
  :doc "Keymap for directories."
  :name "dirs"
  "~" '("home" . λαω-visit-home-directory)
  "o" '("org" . λαω-visit-org-directory)
  "e" '("emacs" . λαω-visit-user-emacs-directory))
(keymap-set λαω-files-map "d" (cons "dirs" λαω-dirs-map))

(defvar-keymap λαω-files-λαω-map
  :doc "Keymap for λαω configurations."
  :name "λαω-files"
  "\x3bb" '("λαω" . λαω-visit-λαω-file) ; λ
  "l"     '("λαω"       . λαω-visit-λαω-file)
  "f"     '("functions" . λαω-visit-λαω-functions-file)
  "k"     '("keys"      . λαω-visit-λαω-keys-file)
  "o"     '("org"       . λαω-visit-λαω-org-file))
(keymap-set λαω-files-map "l" (cons "λαω" λαω-files-λαω-map))

(defvar-keymap λαω-files-emacs-map
  :doc "Keymap for Emacs configurations."
  :name "emacs-files"
  "c" '("custom"     . λαω-visit-emacs-custom-file)
  "e" '("early-init" . λαω-visit-emacs-early-init-file)
  "i" '("init"       . λαω-visit-emacs-user-init-file))
(keymap-set λαω-files-map "e" (cons "emacs" λαω-files-emacs-map))

(defvar-keymap λαω-files-cli-map
  :doc "Keymap for command-line interface configurations."
  :name "cli-files"
  "b" '("bashrc" . λαω-visit-bashrc-file))
(keymap-set λαω-files-map "c" (cons "cli" λαω-files-cli-map))

;;; Emacs structures keymaps
(defvar-keymap λαω-buffer-map
  :doc "Keymap for Emacs buffers."
  :name "buffer"
  "s" #'scratch-buffer)
(keymap-global-set "C-c b" (cons "λαω-buffer" λαω-buffer-map))
(keymap-set λαω-map "b" (cons "buffer" λαω-buffer-map))

;; windows
(defvar-keymap λαω-window-map
  :doc "Keymap for Emacs windows."
  :name "window")
(keymap-global-set "C-c w" (cons "λαω-window" λαω-window-map))
(keymap-set λαω-map "w" (cons "window" λαω-window-map))

(defvar-keymap λαω-text-map
  :doc "Keymap for text."
  :name "text")
(keymap-global-set "C-c t" (cons "λαω-text" λαω-text-map))
(keymap-set λαω-map "t" (cons "text" λαω-text-map))

(defvar-keymap λαω-text-completion-map
  :doc "Keymap for text completions."
  :name "text-completion")
(keymap-set λαω-text-map "c" (cons "completion" λαω-text-completion-map))

;; (defvar-keymap λαω-dev-map
;;   :doc "Keymap for software development and programming."
;;   :name "software-dev")

;; (keymap-global-set "C-c d" (cons "λαω-dev" λαω-dev-map))
;; (keymap-set λαω-map "d" (cons "cli" λαω-dev-map))

(defvar-keymap λαω-cli-map
  :doc "Keymap for command-line interfaces."
  :name "cli")
(keymap-global-set "C-c c" (cons "λαω-cli" λαω-cli-map))
(keymap-set λαω-map "c" (cons "cli" λαω-cli-map))

(defvar-keymap λαω-git-map
  :doc "Keymap for git-related commands."
  :name "git")
(keymap-global-set "C-c g" (cons "λαω-git" λαω-git-map))
(keymap-set λαω-map "g" (cons "git" λαω-git-map))

(defvar-keymap λαω-org-map
  :doc "Keymap for Org Mode."
  :name "org")
(keymap-global-set "C-c o" (cons "λαω-org" λαω-org-map))
(keymap-set λαω-map "o" (cons "org" λαω-org-map))

;;; repeat keymaps
(defvar-keymap λαω-window-repeat-map
  :doc "Keymap for repeatable `window' commands."
  :name "window-repeat"
  :repeat t
  ;; resizing
  "-" #'shrink-window-horizontally
  "=" #'enlarge-window-horizontally
  "_" #'shrink-window
  "+" #'enlarge-window
  ;; scrolling
  "C-l" #'recenter-top-bottom
  "l" #'recenter-top-bottom)

(defvar-keymap λαω-text-repeat-map
  :doc "Keymap for text manipulation and management."
  :name "text-repeat"
  :repeat t
  ;; resizing
  "-" #'text-scale-decrease
  "=" #'text-scale-increase)

(provide 'λαω-keys)
;;; λαω-keys.el ends here

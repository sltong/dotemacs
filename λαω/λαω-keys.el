;;; λαω-keys.el --- λαω keymaps and key bindings -*- coding: utf-8; lexical-binding: t; -*-

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

;;; global key (re/un)bindings
(keymap-global-unset "C-l") ; `recenter-top-bottom'
;; `suspend-frame'
(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")
;; trackpad text zooming
(keymap-global-unset "<pinch>")

(keymap-global-set "s-b" #'switch-to-buffer)
(keymap-global-set "C-x C-k" #'kill-current-buffer)
(keymap-global-set "M-<RET>" #'electric-newline-and-maybe-indent)
(keymap-global-set "C-h F" #'describe-face)
(keymap-global-set "s-r" #'λαω-query-replace-region)
;; text resizing with trackpad
;; (keymap-global-set "<pinch>" #'ignore)

;;; hyper key bindings
;; save
(keymap-global-set "H-s H-s" #'save-buffer)
(keymap-global-set "H-b" #'previous-buffer)
(keymap-global-set "H-f" #'next-buffer)

;;; keymaps
(defvar-keymap λαω-map
  :doc "λαω keymap."
  :name "λαω"
  "C-a" #'apropos
  "C-l" #'λαω-recenter-fourths
  "C-r" #'query-replace-regexp
  "C-\\" #'toggle-input-method)
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
  "\x3bb" '("λαω" . λαω-visit-λαω-emacs-directory) ; λ
  "l"     '("λαω" . λαω-visit-λαω-emacs-directory)
  "~"     '("home" . λαω-visit-home-directory)
  "o"     '("org" . λαω-visit-org-directory)
  "e"     '("emacs" . λαω-visit-user-emacs-directory))
(keymap-set λαω-files-map "d" (cons "dirs" λαω-dirs-map))

(defvar-keymap λαω-files-λαω-map
  :doc "Keymap for λαω configurations."
  :name "λαω-files"
  "\x3bb" '("λαω" . λαω-visit-λαω-file) ; λ
  "l"     '("λαω"       . λαω-visit-λαω-file)
  "f"     '("functions" . λαω-visit-λαω-functions-file)
  "k"     '("keys"      . λαω-visit-λαω-keys-file)
  "o"     '("org"       . λαω-visit-λαω-org-file)
  "t"     '("themes"       . λαω-visit-λαω-themes-file))
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
  "b" '("bashrc" . λαω-visit-bashrc-file)
  "z" '("zshrc" . λαω-visit-zshrc-file))
(keymap-set λαω-files-map "c" (cons "cli" λαω-files-cli-map))

;;; Keymaps for Emacs and its structures
(defvar-keymap λαω-emacs-map
  :doc "Keymap for Emacs."
  :name "emacs"
  "c" #'customize-group
  "r" #'restart-emacs)
(keymap-set λαω-map "e" (cons "emacs" λαω-emacs-map))

(defvar-keymap λαω-buffer-map
  :doc "Keymap for Emacs buffers."
  :name "buffer"
  "s" #'scratch-buffer
  "m" '("messages" . λαω-visit-message-log-buffer)
  "n" #'switch-to-next-buffer
  "p" #'switch-to-prev-buffer)
(keymap-set λαω-map "b" (cons "buffer" λαω-buffer-map))

;; (defvar-keymap λαω-tab-keymap
;;   :doc "Keymap for Emacs buffers."
;;   :name "tab"
;;   "m" '("messages" . λαω-visit-message-log-tab))
;; (keymap-set λαω-map "t" (cons "tab" λαω-tab-map))

(defvar-keymap λαω-window-map
  :doc "Keymap for Emacs windows."
  :name "window")
(keymap-set λαω-map "w" (cons "window" λαω-window-map))

;;; Keymaps for text manipulation
(defvar-keymap λαω-text-map
  :doc "Keymap for text."
  :name "text"
  "r" #'query-replace
  "C-r" #'query-replace-regexp
  "M-r" #'λαω-query-replace-region
  "C-M-r" #'λαω-query-replace-regexp-region
  "-" #'text-scale-decrease
  "=" #'text-scale-increase)
(keymap-set λαω-map "t" (cons "text" λαω-text-map))

(defvar-keymap λαω-text-completion-map
  :doc "Keymap for text completions."
  :name "text-completion")
(keymap-set λαω-text-map "c" (cons "completion" λαω-text-completion-map))

;; (defvar-keymap λαω-dev-map
;;   :doc "Keymap for software development and programming."
;;   :name "software-dev")

;; (keymap-set λαω-map "d" (cons "cli" λαω-dev-map))

(defvar-keymap λαω-cli-map
  :doc "Keymap for command-line interfaces."
  :name "cli")
(keymap-set λαω-map "c" (cons "cli" λαω-cli-map))

(defvar-keymap λαω-git-map
  :doc "Keymap for git-related commands."
  :name "git")
(keymap-set λαω-map "g" (cons "git" λαω-git-map))

(defvar-keymap λαω-org-map
  :doc "Keymap for Org Mode."
  :name "org")
(keymap-set λαω-map "o" (cons "org" λαω-org-map))

;;; repeat keymaps
(defvar-keymap λαω-buffer-switch-repeat-map
  :doc "Keymap for repeatable buffer switching commands."
  :name "buffer-switch-repeat"
  :repeat t
  "n" #'switch-to-next-buffer
  "p" #'switch-to-prev-buffer)

(defvar-keymap λαω-window-resize-repeat-map
  :doc "Keymap for repeatable window resizing commands."
  :name "window-resize-repeat"
  :repeat t
  "-" #'shrink-window-horizontally
  "=" #'enlarge-window-horizontally
  "_" #'shrink-window
  "+" #'enlarge-window)

(defvar-keymap λαω-window-recenter-repeat-map
  :doc "Keymap for repeatable window recentering commands."
  :name "window-recenter-repeat"
  :repeat t
  "C-l" #'λαω-recenter-fourths
  "l" #'λαω-recenter-fourths)

(defvar-keymap λαω-text-repeat-map
  :doc "Keymap for text manipulation and management."
  :name "text-repeat"
  :repeat t
  "-" #'text-scale-decrease
  "=" #'text-scale-increase)

(defvar-keymap λαω-tab-repeat-map
  :doc "Keymap for tabs."
  :name "tab-repeat"
  :repeat t
  "f" #'tab-next
  "b" #'tab-previous
  "M-f" #'tab-bar-move-tab
  "M-b" #'tab-bar-move-tab-backward)

(provide 'λαω-keys)
;;; λαω-keys.el ends here

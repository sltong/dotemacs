;;; λαω-functions.el --- λαω functions -*- coding: utf-8; lexical-binding: t; -*-

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

;; you should have received a copy of the gnu affero general public
;; license along with this program. if not, see
;; <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Functions.

;;; Code:

(require 'λαω)
(defun λαω-display-init-time-message ()
  "Display an Emacs initialization time and garbage collections message."
  (run-with-idle-timer
   3 nil (lambda ()
           (message "Emacs loaded in %s with %d garbage collections."
                    (format "%.2f seconds"
                            (float-time
                             (time-subtract after-init-time before-init-time)))
                    gcs-done))))

(defun λαω-crm-prompt-indicator (args)
  "Prompt indicator for `completing-read-multiple'.

Indicator displays the `crm-separator'.

For example, the prompt will display \"[CRM,]\" if the separator is a
comma."
  (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))

(defun λαω-desktop-restore-display-line-numbers-mode ()
  "Activate `display-line-numbers-mode' for the correct buffers.

This solves a bug where duplicate `display-line-numbers-mode' in a saved
buffer's desktop `desktop-create-buffer' minor modes entry cause line
numbers to disappear and reappear multiple times."
  (if (derived-mode-p 'prog-mode)
      (display-line-numbers-mode)
    (display-line-numbers-mode -1)))

(defun λαω-remove-text-properties-in-region (region-start region-end)
    "Remove text properties in region."
    (interactive "r")
    (when (use-region-p)
      (save-excursion
      (set-text-properties region-start region-end nil))))

(defun λαω-remove-kill-ring-text-properties ()
    "Remove all text properties from `kill-ring' entries.

This is useful for optimizing `kill-ring' history size when it is saved
through `savehist-additional-variables', for example.

See Info node `(elisp)Creating Strings'.

Credit itsjeyd on the Emacs Stack Exchange:
URL `https://emacs.stackexchange.com/a/4191'"
    (setq kill-ring (mapcar 'substring-no-properties kill-ring)))

(defun λαω-local-truncate-lines ()
  "Locally enable `truncate-lines'."
  (setq-local truncate-lines t))

(defun λαω-reset-emacs ()
  "Reset Emacs by deleting all generated package, cache, and user data."
  (interactive)
  (let ((dirs-to-delete (list package-user-dir
                              λαω-emacs-var-directory
                              (expand-file-name "eln-cache/"
                                                user-emacs-directory)))
        (files-to-delete (mapcar
                          (lambda (file-name)
                            (expand-file-name file-name user-emacs-directory))
                          '("custom.el"
                            "history"
                            "recentf"
                            "package-quickstart.el"
                            "package-quickstart.elc"))))
    (when (y-or-n-p "Delete all generated Emacs data?")
      (message "Deleting generated files in `user-emacs-directory'...")
      (mapc (lambda (file)
                (when (file-exists-p file)
                  (funcall #'delete-file file delete-by-moving-to-trash)))
              files-to-delete)
      (message
       "Deleting generated directories and their files...")
      (mapc (lambda (dir)
                (when (file-exists-p (directory-file-name dir))
                  (funcall #'delete-directory dir t delete-by-moving-to-trash)))
              dirs-to-delete)
      (message "Generated Emacs data was deleted successfully."))))

;;; directories
(defun λαω-find-user-emacs-directory ()
  "Visit `user-emacs-directory'."
  (interactive)
  (find-file user-emacs-directory))

(defun λαω-find-org-directory ()
  "Visit `org-directory'."
  (interactive)
  (find-file org-directory))

;;; files
(defun λαω-expand-λαω-file-name (filename)
  "Concatenate \"λαω-\" with FILENAME and return the absolute file path."
  (expand-file-name (concat "λαω-" filename) λαω-emacs-directory))

(defun λαω-find-λαω-file ()
  "Edit `λαω.el'."
  (interactive)
  (find-file (expand-file-name "λαω.el" λαω-emacs-directory)))

(defun λαω-find-λαω-custom-file ()
  "Edit the λαω customizations file."
  (interactive)
  (find-file (λαω-expand-λαω-file-name "custom.el")))

(defun λαω-find-λαω-functions-file ()
  "Edit the λαω functions file."
  (interactive)
  (find-file (λαω-expand-λαω-file-name "functions.el")))

(defun λαω-find-λαω-keys-file ()
  "Edit the λαω keys file."
  (interactive)
  (find-file (λαω-expand-λαω-file-name "keys.el")))

(defun λαω-find-λαω-org-file ()
  "Edit the λαω org file."
  (interactive)
  (find-file (λαω-expand-λαω-file-name "org.el")))

(defun λαω-find-emacs-init-file ()
  "Edit the Emacs user init file."
  (interactive)
  (find-file user-init-file))

(defun λαω-find-emacs-custom-file ()
  "Edit the Emacs customizations file."
  (interactive)
  (find-file custom-file))

(defun λαω-find-bashrc-file ()
  "Edit the `bash' user startup file."
  (interactive)
  (find-file "~/.bashrc"))

(defun λαω-find-emacs-early-init-file ()
  "Edit the Emacs user early init file."
  (interactive)
  (find-file early-init-file))

(defun λαω-find-emacs-user-init-file ()
  "Edit the Emacs user init file."
  (interactive)
  (find-file user-init-file))

;;; utilities
(defun λαω-downcase-and-hyphenate-region (region-start region-end)
  "Downcase words in the region and concatenate them with hyphens.

Consecutive blank characters are replaced by a single hyphen.

Any non-blank, non-word characters (such as punctuation marks) will
break concatenation. For example, the function will transform \"Oh no!
Our word chain; it's broken.\", \"oh-no! our-word-chain; it's-broken.\"."
  (interactive "r")
  (when (use-region-p)
    (save-excursion
      (downcase-region region-start region-end)
      (goto-char region-start)
      (while (re-search-forward "\\b[[:blank:]]+\\b" region-end t)
        (replace-match "-" nil nil)))))

(defun λαω-scratch-other-window ()
  "Show or create the *scratch* buffer in the other window."
  (interactive)
  (switch-to-buffer-other-window (get-scratch-buffer-create)))

(provide 'λαω-functions)
;;; λαω-functions.el ends here

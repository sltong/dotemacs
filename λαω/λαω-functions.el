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

(defun λαω-remove-text-properties-in-region (region-start region-end)
    "Remove text properties in region."
    (interactive "r")
    (when (use-region-p)
      (save-excursion
      (set-text-properties region-start region-end nil))))

(defun λαω-local-truncate-lines ()
  "Locally enable `truncate-lines'."
  (setq-local truncate-lines t))

(defun λαω-reload-λαω-theme ()
  "Load the λαω theme.

Disable all other themes beforehand."
  (interactive)
  (let ((non-λαω-themes (remq 'law custom-enabled-themes)))
    (when non-λαω-themes
      (message "Disabling all other themes...")
      (mapc #'disable-theme non-λαω-themes))
    (message "Loading λαω theme...")
    (load-theme 'λαω t)))

(defun λαω-make-visit-file-function (file-name &optional doc function-suffix)
  "Create a function that visits FILE-NAME.

FILE-NAME is appended to \"λαω-visit-\" to define the function's suffix.
If FILE-NAME is a symbol, use that symbol's name. Optionally,
FUNCTION-SUFFIX can be explicitly passed instead.

An optional DOC string can be passed for the function's documentation."
  (let* ((function-suffix (or function-suffix
                              (if (symbolp file-name)
                                  (symbol-name file-name)
                                file-name)))
         (function-name (concat "λαω-visit-"
                                function-suffix)))
    (apply `(defalias ,(intern function-name)
              (lambda ()
                ,(or doc
                     (format "Visit %s."
                              (if (symbolp file-name)
                                  (concat "`" function-suffix "'")
                                function-suffix)))
               (interactive)
               (find-file ,file-name))))))

(defun λαω-expand-λαω-file-name (filename)
  "Return the absolute file path for the λαω FILENAME.

Concatenate \"λαω-\" with FILENAME and return its absolute file path
(relative to `λαω-emacs-directory')."
  (expand-file-name (concat "λαω-" filename) λαω-emacs-directory))

;; create functions to visit files and directories

(λαω-make-visit-file-function 'λαω-emacs-directory)
;; (defun λαω-visit-λαω-emacs-directory ()
;;   "Visit λαω Emacs directory."
;;   (interactive)
;;   (find-file λαω-emacs-directory))

(λαω-make-visit-file-function 'user-emacs-directory)
;; (defun λαω-visit-user-emacs-directory ()
;;   "Visit `user-emacs-directory'."
;;   (interactive)
;;   (find-file user-emacs-directory))

(λαω-make-visit-file-function
 (convert-standard-filename "~") "Visit home directory." "home-directory")
;; (defun λαω-visit-home-directory ()
;;   "Visit home directory."
;;   (interactive)
;;   (find-file "~/"))

(λαω-make-visit-file-function 'λαω-themes-directory)
;; (defun λαω-visit-λαω-themes-directory ()
;;   "Visit λαω themes directory."
;;   (interactive)
;;   (find-file λαω-themes-directory))

(λαω-make-visit-file-function 'custom-file nil "emacs-custom-file")
;; (defun λαω-visit-emacs-custom-file ()
;;   "Visit Emacs `custom-file'."
;;   (interactive)
;;   (find-file custom-file))

(λαω-make-visit-file-function 'early-init-file nil "emacs-early-init-file")
;; (defun λαω-visit-emacs-early-init-file ()
;;   "Visit Emacs `early-init-file'."
;;   (interactive)
;;   (find-file early-init-file))

(λαω-make-visit-file-function 'user-init-file nil "emacs-user-init-file")
;; (defun λαω-visit-emacs-user-init-file ()
;;   "Visit Emacs `user-init-file'."
;;   (interactive)
;;   (find-file user-init-file))

(λαω-make-visit-file-function "~/.bashrc" nil "bashrc-file")
;; (defun λαω-visit-bashrc-file ()
;;   "Visit \".bashrc\"."
;;   (interactive)
;;   (find-file "~/.bashrc"))

;; visit λαω files and directories
(λαω-make-visit-file-function
 (expand-file-name "λαω.el" λαω-emacs-directory) nil "λαω-file")
(λαω-make-visit-file-function
 (λαω-expand-λαω-file-name "functions.el") nil "λαω-functions-file")
(λαω-make-visit-file-function
 (λαω-expand-λαω-file-name "keys.el") nil "λαω-keys-file")
(λαω-make-visit-file-function
 (λαω-expand-λαω-file-name "org.el") nil "λαω-org-file")
(λαω-make-visit-file-function
 (λαω-expand-λαω-file-name "themes.el") nil "λαω-themes-file")

(defun λαω-wsl-visit-windows-user-directory ()
  "Visit the Windows user directory if it is mounted in WSL."
  nil)

;;; buffers
(defun λαω-visit-message-log-buffer ()
  "Visit the message log buffer."
  (interactive)
  (switch-to-buffer "*Messages*"))

;;; utilities
(defun λαω-newline-without-break (&optional arg interactive)
  "Insert a newline without breaking line at point.

Pass ARG and INTERACTIVE to `newline'."
  (interactive "*P\np")
  (move-end-of-line 1)
  (newline arg interactive))

(defun λαω-recenter-thirds (&optional arg)
  "Scroll the window so that current line is some third into it.

With prefix ARG, scroll the window one-third from the bottom.

If the current line is already positioned at the desired third, scroll
to the other third (respecting ARG)."
  (interactive "P")
  (let* ((window-height (window-body-height))
         (one-third (ceiling (/ window-height 3.0)))
         (two-thirds (- window-height one-third))
         (cur-line-win-pos (count-lines (window-start) (point)))
         (tolerance 1))
    (cond ((<= (abs (- cur-line-win-pos one-third)) tolerance)
           (recenter two-thirds))
          ((<= (abs (- cur-line-win-pos two-thirds)) tolerance)
           (recenter one-third))
          (arg
           (recenter (- one-third)))
          (t
           (recenter one-third)))))

(defun λαω-recenter-fourths (&optional arg)
    "Scroll the window so that current line is some fourth into it.

With prefix ARG, scroll the window from the bottom.

If the current line is already positioned at some fourth, scroll
to the next fourth (respecting ARG)."
  (interactive "P")
  (let* ((interval (/ (window-body-height) 4))
         (fourths '())
         (fourths (progn
                    (dotimes (nth-fourth 3)
                      (push (* interval (1+ nth-fourth)) fourths))
                    (setq fourths (nreverse fourths))))
         (one-fourth (car fourths))
         (three-fourths (car (last fourths)))
         (cur-line-number (count-lines (window-start) (point)))
         (tolerance 2)
         (matching-fourth-index (seq-position
                                 fourths
                                 cur-line-number
                                 (lambda (fourth cur-line-number)
                                   (<= (abs (- cur-line-number fourth))
                                       tolerance)))))
    (cond ((and arg (eq 0 matching-fourth-index))
           (recenter three-fourths))
          ((and (not arg) (eq 2 matching-fourth-index))
           (recenter one-fourth))
          (matching-fourth-index
           (let ((target-index (% (+ matching-fourth-index (if arg -1 1))
                                  3)))
             (recenter (elt fourths target-index))))
          (arg
           (recenter three-fourths))
          (t
           (recenter one-fourth)))))

(defun λαω-query-replace-region ()
  "Call `query-replace' starting with the region for matching.

The region is first saved to the kill ring. Once `query-replace' is
called, it is yanked to the minibuffer as input.

Since the region is used for matching, when the mark is active in
Transient Mark mode, `query-replace' will not operate on the region
contents."
  (interactive)
  (when (use-region-p)
    (kill-ring-save nil nil t)
    (deactivate-mark)
    ;; Move to REGION-START as to allow
    (minibuffer-with-setup-hook
        #'yank
        (call-interactively
         #'query-replace nil))))

(defun λαω-query-replace-regexp-region ()
  "Call `query-replace-regexp' starting with the region for matching.

The region is first saved to the kill ring. Once `query-replace-regexp'
is called, it is yanked to the minibuffer as input.

Since the region is used as the initial regular expression,
`query-replace-regexp' will not operate on its contents when the mark is
active in Transient Mark mode."
  (interactive)
  (when (use-region-p)
    (kill-ring-save nil nil t)
    (deactivate-mark)
    ;; Move to REGION-START as to allow
    (minibuffer-with-setup-hook
        #'yank
        (call-interactively
         #'query-replace-regexp nil))))

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

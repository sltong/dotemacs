;;; init.el --- Emacs user initialization file -*- coding: utf-8; lexical-binding: t; no-byte-compile: t; -*-

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

;; This is my init file. There are many like it, but this one is mine.

;; My init file is my best friend. It is my life. I must master it as
;; I must master my life.

;; Without me, my init file is useless. Without my init file, I am
;; useless. I must load my init file true. I must edit with Emacs
;; sharper than my enemy who is trying to outedit me. I must pwn him
;; before he pwns me. I will...

;; My init file and I know that what counts in editors is not the
;; start-up times, the backing by a tech corporation, nor the ricing
;; and anime catgirl theme backgrounds. We know that it is the edits
;; we make. We will edit...

;; My init file is human, even as I am human, because it is my
;; life. Thus, I will learn it as a brother. I will learn its
;; weaknesses, its strength, its parts, its dependencies, its bugs and
;; its syntax. I will keep my init file clean and ready, even as I am
;; clean and ready. We will become part of each other. We will...

;; Before God, I swear this creed. My init file and I are the
;; defenders of FOSS. We are the masters of our enemy. We are the
;; saviors of my life.

;; So be it, until victory is Richard Stallman's and there is no
;; enemy, but peace!

;;; Code:

(when init-file-debug
  (setq use-package-verbose t)
  (setq use-package-expand-minimally nil)
  (setq use-package-compute-statistics t)
  (setq debug-on-error t))

;; λαω
(require 'λαω)
(require 'λαω-functions)
(require 'λαω-keys)
(require 'λαω-languages)
(require 'λαω-themes)
(use-package mode-line-bell-pulse
  :ensure nil
  :defer 1
  :config (mode-line-bell-pulse-mode))

;;; package configurations
;; `package'
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(keymap-set help-map "p" #'describe-package)

;; `use-package'
(require 'use-package)
(require 'use-package-ensure)

(setq use-package-always-ensure t)
(setq use-package-hook-name-suffix nil)

;; `auto-compile'
(use-package auto-compile
  :demand t
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package benchmark-init
  :demand t)
;; To disable collection of benchmark data after init is done.
(add-hook 'after-init-hook #'benchmark-init/deactivate)

;;; Emacs initialization and (built-in package) customizations
(use-package emacs
  :demand t
  :ensure nil
  :init
  ;; custom file
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (if (file-exists-p custom-file)
      (load custom-file)
    (message
     "`custom.el' does not exist. Creating it..."
     custom-file)
    (make-empty-file custom-file t))

  ;; functions
  (defun λαω-display-init-time-message ()
  "Display an Emacs initialization time and garbage collections message."
  (run-with-idle-timer
   3.5 nil (lambda ()
           (message "Emacs loaded in %s with %d garbage collections."
                    (format "%.2f seconds"
                            (float-time
                             (time-subtract after-init-time before-init-time)))
                    gcs-done))))

  (defun λαω-remove-kill-ring-text-properties ()
    "Remove all text properties from `kill-ring' entries.

This is useful for optimizing `kill-ring' history size when it is saved
through `savehist-additional-variables', for example.

See Info node `(elisp)Creating Strings'.

Credit to itsjeyd on the Emacs Stack Exchange:
URL `https://emacs.stackexchange.com/a/4191'"
    (setq kill-ring (mapcar 'substring-no-properties kill-ring)))

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

  ;; hooks
  ;; "-100" ensures `λαω-remove-kill-ring-text-properties' is the first
  ;; function in `kill-emacs-hook'
  (add-hook 'kill-emacs-hook 'λαω-remove-kill-ring-text-properties -100)
  (add-hook 'input-method-activate-hook
            #'λαω-minibuffer-input-method-indicator-activate)
  (add-hook 'input-method-deactivate-hook
            #'λαω-minibuffer-input-method-indicator-deactivate)
  ;; default modes
  (setq-default indent-tabs-mode nil)
  :config
  (column-number-mode)

  :hook
  (after-init-hook . λαω-display-init-time-message)
  ;; Visual-Line mode
  (help-mode-hook . visual-line-mode)
  (org-mode-hook . visual-line-mode)
  (markdown-mode-hook . visual-line-mode)

  :custom
  (set-language-environment "UTF-8")
  ;; simple
  (inhibit-default-init t "Don't load `default.el'.")
  (selection-coding-system 'utf-8)
  (auto-save-timeout 4)
  (auto-save-interval 65)
  (kill-ring-max 512)
  (large-file-warning-threshold (* 1024 1024 128)) ; 128 MiB
  ;; undo
  (undo-limit (* 1024 1024 1) "Increase max undo information to 1MiB.")
  ;; last-ditch outer limit for single undo commands
  (undo-outer-limit (* 1024 1024 128)) ; 128 MiB
  (undo-strong-limit (* 1024 1024 8)) ; 8 MiB
  ;; (minibuffer) history
  (history-length 1024)
  (history-delete-duplicates t)
  ;; (mode-line-format '("%e" mode-line-front-space
  ;;                     (:propertize
  ;;                      ("%12b"
  ;;                       display (min-width (6.0))))
  ;;                     " "
  ;;                     (project-mode-line
  ;;                      project-mode-line-format)
  ;;                     " "
  ;;                     (vc-mode vc-mode)
  ;;                     mode-line-misc-info
  ;;                     mode-line-format-right-align
  ;;                     mode-line-modes
  ;;                     " "
  ;;                     (:propertize
  ;;                      (""
  ;;                       "%o"
  ;;                       display (min-width (2.0))))
  ;;                     " "
  ;;                     (:propertize
  ;;                      ("%l"
  ;;                       ":"
  ;;                       "%c"
  ;;                       display (min-width (10.0))))
  ;;                     mode-line-end-spaces))
  (enable-recursive-minibuffers t)
  (truncate-lines t)
  (find-file-visit-truename t)
  (vc-follow-symlinks t)
  (mode-line-right-align-edge 'right-fringe)
  (mode-line-percent-position '(-3 "%o"))
  (fill-column 80)
  ;; *scratch* buffer
  (initial-major-mode 'fundamental-mode
   "Set initial *scratch* buffer major mode to `fundamental-mode'.")
  (use-dialog-box nil "Disable pop-up dialog boxes when questioned.")
  (initial-scratch-message nil)
  ;; (visible-bell t) ; replace audible bell with visual one
  (scroll-preserve-screen-position t)
  (scroll-conservatively 0)
  (message-log-max 10000
   "Increase maximum number of lines in the message log buffer.")
  (use-short-answers t "Make `yes-or-no-p' accept \"y\" or \"n\".")
  (yes-or-no-prompt "(y or n)")
  (sentence-end-double-space nil
   "Make Emacs recognize single spaces as sentence-ending.")
  (delete-by-moving-to-trash t
   "Don't delete files, but move them to OS-specific trash can.")
  ;; Emacs 30 and newer: disable Ispell completion function. As an
  ;; alternative, try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  ;; Enable indentation/completion using the TAB key.
  (tab-always-indent 'complete)
  ;; don't set a limit on printed expression evaluations
  (eval-expression-print-level nil)
  (eval-expression-print-length nil)
  ;; macOS modifier keys
  (mac-option-modifier 'super)
  (mac-command-modifier 'meta))

;; load immediately, as soon as possible
;; later packages still explicitly set their modes' respective
;; directories or file paths for redundancy.
(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory λαω-emacs-etc-directory)
  (setq no-littering-var-directory λαω-emacs-var-directory)
  :config
  (no-littering-theme-backups))

(use-package exec-path-from-shell
  :if (or (memq window-system '(mac ns pgtk x))
          (daemonp))
  :demand t
  :config
  ;; (dolist (var '("SSH_AUTH_SOCK"))
  ;;   (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

;; OS


;;; early packages
;; put all minor modes on the mode line in one menu
(use-package minions
  :defer 0.25
  :commands (minions-mode glasses-mode)
  :config (minions-mode 1)
  :custom
  (minions-mode-line-lighter "m+"))

;;; built-in packages
;; these packages should have :ensure explicitly set to nil in order
;; to prevent fetching them from repositories
(use-package auth-source
  :ensure nil
  :defer 0.2
  :custom
  ;; add alternative port 23 for SSH
  ;; and add IMAP port 1143 and SMTP port 1025 for Proton Mail Bridge
  (auth-source-protocols '((imap "imap" "imaps" "143" "993" "1143")
                           (pop3 "pop3" "pop" "pop3s" "110" "995")
                           (ssh "ssh" "22" "23")
                           (sftp "sftp" "115")
                           (smtp "smtp" "25" "1025"))))

(use-package auth-source-pass
  :ensure nil
  :defer 0.75
  :config
  (auth-source-pass-enable))

(use-package autorevert
  :ensure nil
  :defer 1.5
  :config
  (global-auto-revert-mode))

(use-package bookmark
  :ensure nil
  :defer t
  :custom
  (bookmark-menu-confirm-deletion t)
  (bookmark-bmenu-file-column 40)
  (bookmark-menu-length 80))

(use-package cc-mode
  :ensure nil
  :defer 3
  :custom
  (c-basic-offset 4))

(use-package crm
  :ensure nil
  :defer 2
  :commands (completing-read-multiple)
  :init
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
  :config
  (advice-add #'completing-read-multiple
              :filter-args #'λαω-crm-prompt-indicator))

;; replace active region when doing a delete or replace action instead of
;; ignoring it
(use-package delsel
  :ensure nil
  :defer 1.25
  :config
  (delete-selection-mode))

;; (use-package desktop
;;   :ensure nil
;;   :defer nil
;; (defun λαω-desktop-restore-display-line-numbers-mode ()
;;   "Activate `display-line-numbers-mode' for the correct buffers.

;; This solves a bug where duplicate `display-line-numbers-mode' in a saved
;; buffer's desktop `desktop-create-buffer' minor modes entry cause line
;; numbers to disappear and reappear multiple times."
;;   (if (derived-mode-p 'prog-mode)
;;       (display-line-numbers-mode)
;;     (display-line-numbers-mode -1)))
;;   :config
;;   ;; prevent bug where line numbers disappear/reappear multiple times
;;   ;; on desktop restore
;;   (add-to-list 'desktop-minor-mode-handlers
;;                '(cons display-line-numbers-mode
;;                       λαω-desktop-restore-display-line-numbers-mode))
;;   (desktop-save-mode)
;;   :custom
;;   (desktop-base-file-name ".desktop-session")
;;   (desktop-base-lock-name ".desktop-session.lock")
;;   (desktop-missing-file-warning t
;;    "Offer to recreate the buffers of deleted files.")
;;   (desktop-auto-save-timeout 1.5)
;;   (desktop-auto-save-timeout 1.5)
;;   (desktop-restore-eager 3)
;;   (desktop-lazy-idle-delay 0.5)
;;   (desktop-lazy-verbose nil)
;;   (desktop-clear-preserve-buffers
;;    '("\\*scratch\\*"
;;      "\\*Messages\\*"
;;      "\\*server\\*"
;;      "\\*tramp/.+\\*"
;;      "\\*Warnings\\*"
;;      "\\*Flymake log\\*")
;;    "‘desktop-clear’ should not delete these buffers.")
;;   (desktop-globals-to-clear '()
;;    "Don't clear any global variables with `desktop-clear'."))

(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
         ("b" . dired-up-directory)
         ("+" . dired-create-empty-file)
         ("M-+" . dired-create-directory))
  :custom
  (dired-listing-switches "-ahl")
  (dired-auto-revert-buffer t))

(use-package display-fill-column-indicator
  :ensure nil
  :hook (prog-mode-hook . display-fill-column-indicator-mode))

(use-package display-line-numbers
  :ensure nil
  :bind (:map λαω-buffer-map
         ("l" . display-line-numbers-mode))
  :custom
  (display-line-numbers-grow-only t)
  (display-line-numbers-width 3))

(use-package eglot
  :ensure nil
  :hook
  (elixir-ts-mode-hook . eglot-ensure)
  (heex-ts-mode-hook . eglot-ensure)
  (python-ts-mode-hook . eglot-ensure))

(use-package eldoc
  :ensure nil
  :defer 2)

(use-package elec-pair
  :ensure nil
  :hook (prog-mode-hook . electric-pair-local-mode))

(use-package eshell
  :ensure nil
  :config
  (add-to-list 'eshell-modules-list 'eshell-tramp t)
  :bind (:map λαω-cli-map
         ("e" . eshell))
  :custom
  (eshell-buffer-maximum-lines 8192)
  ;; fix glitch where prompt gets partially hidden underneath modeline
  (eshell-scroll-to-bottom-on-input t)
  (eshell-scroll-to-bottom-on-output t)
  (eshell-scroll-show-maximum-output nil))

(use-package files
  :ensure nil
  :custom
  (backup-by-copying t) ; don't break hard or symbolic links
  (version-control t) ; always use numerically versioned backups
  (delete-old-versions t)
  (kept-old-versions 0)
  (kept-new-versions 8)
  (confirm-kill-emacs 'y-or-n-p)
  (require-final-newline t)
  (view-read-only t))

(use-package finder
  :ensure nil
  :bind ("C-h P" . finder-by-keyword))

(use-package flymake
  :ensure nil
  :hook (prog-mode-hook . flymake-mode)
  :custom
  (flymake-fringe-indicator-position nil))

(use-package gnus
  :ensure nil
  :defer t
  :custom
  (gnus-secondary-select-methods '((nntp "news.usenetserver.com")
                                   (nnimap "proton"
                                    (nnimap-address "127.0.0.1")
                                    (nnimap-server-port 1143)
                                    (nnimap-stream starttls)
                                    (nnimap-inbox "Inbox")
                                    (nnimap-split-methods default)
                                    (nnimap-record-commands t))))
  (gnus-use-cache t)
  (gnus-asynchronous t)
  (gnus-use-header-prefetch t)
  (gnus-verbose 10)
  (gnus-save-killed-list nil)
  (gnus-inhibit-startup-message t)
  (gnus-directory (expand-file-name "gnus/" λαω-emacs-var-directory)))

(use-package help-fns
  :ensure nil
  :bind (("C-h M" . describe-keymap)))

(use-package hideshow
  :ensure nil
  :hook (prog-mode-hook . hs-minor-mode)
  :bind ("C-<tab>" . hs-toggle-hiding)
  :custom
  (hs-isearch-open t "Open both code and comment blocks when doing `isearch'."))

(use-package hl-line
  :ensure nil
  :init
  (defun λαω-disable-hl-line-mode-temporarily (func &rest args)
    "Temporarily disable `global-hl-line-mode' when calling FUNC.

Credit to Sacha Chua. See:
URL https://sachachua.com/dotemacs/index.html#highlight-line-mode"
    (if hl-line-mode
        (progn
          (hl-line-mode -1)
          (prog1 (apply func args)
            (hl-line-mode 1)))
      (apply func args)))
  (advice-add #'face-at-point
              :around #'λαω-disable-hl-line-mode-temporarily)
  :hook
  (prog-mode-hook . hl-line-mode)
  (text-mode-hook . hl-line-mode))

(use-package ibuffer
  :ensure nil
  :bind (("C-x C-b" . ibuffer)
         :map λαω-buffer-map
         ("b" . ibuffer))
  :custom
  (ibuffer-formats '((mark modified read-only " "
                      (name 26 26 :left :elide) " "
                      (filename 26 26 :left :elide) " "
                      (size 8 -1 :right) " ")
                     (mark modified read-only " "
                      (name 26 -1 :left :elide) " "
                      filename-and-process))))

(use-package isearch
  :ensure nil
  :custom
  (isearch-repeat-on-direction-change t)
  (isearch-lazy-count t))

(use-package css-mode
  :ensure nil
  :defer t
  :custom
  (css-indent-offset 2))

(use-package lisp-mode
  :ensure nil
  :init
  (defun λαω-calculate-lisp-indent (&optional parse-start)
    "Add better indentation for quoted and backquoted lists.

Credit to Aquaactress on StackExchange:

URL https://emacs.stackexchange.com/a/52789

A.K.A. ouroborolisp on Reddit:

URL https://www.reddit.com/r/emacs/comments/d7x7x8/finally_fixing_indentation_of_quoted_lists/"
    ;; This line because `calculate-lisp-indent-last-sexp` was defined with
    ;; `defvar` with it's value ommited, marking it special and only defining it
    ;; locally. So if you don't have this, you'll get a void variable error.
    (defvar calculate-lisp-indent-last-sexp)
    (save-excursion
      (beginning-of-line)
      (let ((indent-point (point))
            state
            ;; setting this to a number inhibits calling hook
            (desired-indent nil)
            (retry t)
            calculate-lisp-indent-last-sexp containing-sexp)
        (cond ((or (markerp parse-start) (integerp parse-start))
               (goto-char parse-start))
              ((null parse-start) (beginning-of-defun))
              (t (setq state parse-start)))
        (unless state
          ;; Find outermost containing sexp
          (while (< (point) indent-point)
            (setq state (parse-partial-sexp (point) indent-point 0))))
        ;; Find innermost containing sexp
        (while (and retry
                    state
                    (> (elt state 0) 0))
          (setq retry nil)
          (setq calculate-lisp-indent-last-sexp (elt state 2))
          (setq containing-sexp (elt state 1))
          ;; Position following last unclosed open.
          (goto-char (1+ containing-sexp))
          ;; Is there a complete sexp since then?
          (if (and calculate-lisp-indent-last-sexp
                   (> calculate-lisp-indent-last-sexp (point)))
              ;; Yes, but is there a containing sexp after that?
              (let ((peek (parse-partial-sexp calculate-lisp-indent-last-sexp
                                              indent-point 0)))
                (if (setq retry (car (cdr peek))) (setq state peek)))))
        (if retry
            nil
          ;; Innermost containing sexp found
          (goto-char (1+ containing-sexp))
          (if (not calculate-lisp-indent-last-sexp)
              ;; indent-point immediately follows open paren.
              ;; Don't call hook.
              (setq desired-indent (current-column))
            ;; Find the start of first element of containing sexp.
            (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
            (cond ((looking-at "\\s(")
                   ;; First element of containing sexp is a list.
                   ;; Indent under that list.
                   )
                  ((> (save-excursion (forward-line 1) (point))
                      calculate-lisp-indent-last-sexp)
                   ;; This is the first line to start within the containing sexp.
                   ;; It's almost certainly a function call.
                   (if (or
                        ;; Containing sexp has nothing before this line
                        ;; except the first element. Indent under that element.
                        (= (point) calculate-lisp-indent-last-sexp)

                        ;; First sexp after `containing-sexp' is a keyword. This
                        ;; condition is more debatable. It's so that I can have
                        ;; unquoted plists in macros. It assumes that you won't
                        ;; make a function whose name is a keyword.
                        ;; (when-let (char-after (char-after (1+ containing-sexp)))
                        ;;   (char-equal char-after ?:))

                        ;; Check for quotes or backquotes around.
                        (let* ((positions (elt state 9))
                               (last (car (last positions)))
                               (rest (reverse (butlast positions)))
                               (any-quoted-p nil)
                               (point nil))
                          (or
                           (when-let (char (char-before last))
                             (or (char-equal char ?')
                                 (char-equal char ?`)))
                           (progn
                             (while (and rest (not any-quoted-p))
                               (setq point (pop rest))
                               (setq any-quoted-p
                                     (or
                                      (when-let (char (char-before point))
                                        (or (char-equal char ?')
                                            (char-equal char ?`)))
                                      (save-excursion
                                        (goto-char (1+ point))
                                        (looking-at-p
                                         "\\(?:back\\)?quote[\t\n\f\s]+(")))))
                             any-quoted-p))))
                       ;; Containing sexp has nothing before this line
                       ;; except the first element.  Indent under that element.
                       nil
                     ;; Skip the first element, find start of second (the first
                     ;; argument of the function call) and indent under.
                     (progn (forward-sexp 1)
                            (parse-partial-sexp (point)
                                                calculate-lisp-indent-last-sexp
                                                0 t)))
                   (backward-prefix-chars))
                  (t
                   ;; Indent beneath first sexp on same line as
                   ;; `calculate-lisp-indent-last-sexp'.  Again, it's
                   ;; almost certainly a function call.
                   (goto-char calculate-lisp-indent-last-sexp)
                   (beginning-of-line)
                   (parse-partial-sexp (point) calculate-lisp-indent-last-sexp
                                       0 t)
                   (backward-prefix-chars)))))
        ;; Point is at the point to indent under unless we are inside a string.
        ;; Call indentation hook except when overridden by lisp-indent-offset
        ;; or if the desired indentation has already been computed.
        (let ((normal-indent (current-column)))
          (cond ((elt state 3)
                 ;; Inside a string, don't change indentation.
                 nil)
                ((and (integerp lisp-indent-offset) containing-sexp)
                 ;; Indent by constant offset
                 (goto-char containing-sexp)
                 (+ (current-column) lisp-indent-offset))
                ;; in this case calculate-lisp-indent-last-sexp is not nil
                (calculate-lisp-indent-last-sexp
                 (or
                  ;; try to align the parameters of a known function
                  (and lisp-indent-function
                       (not retry)
                       (funcall lisp-indent-function indent-point state))
                  ;; If the function has no special alignment
                  ;; or it does not apply to this argument,
                  ;; try to align a constant-symbol under the last
                  ;; preceding constant symbol, if there is such one of
                  ;; the last 2 preceding symbols, in the previous
                  ;; uncommented line.
                  (and (save-excursion
                         (goto-char indent-point)
                         (skip-chars-forward " \t")
                         (looking-at ":"))
                       ;; The last sexp may not be at the indentation
                       ;; where it begins, so find that one, instead.
                       (save-excursion
                         (goto-char calculate-lisp-indent-last-sexp)
                         ;; Handle prefix characters and whitespace
                         ;; following an open paren.  (Bug#1012)
                         (backward-prefix-chars)
                         (while (not (or (looking-back "^[ \t]*\\|([ \t]+"
                                                       (line-beginning-position))
                                         (and containing-sexp
                                              (>= (1+ containing-sexp) (point)))))
                           (forward-sexp -1)
                           (backward-prefix-chars))
                         (setq calculate-lisp-indent-last-sexp (point)))
                       (> calculate-lisp-indent-last-sexp
                          (save-excursion
                            (goto-char (1+ containing-sexp))
                            (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
                            (point)))
                       (let ((parse-sexp-ignore-comments t)
                             indent)
                         (goto-char calculate-lisp-indent-last-sexp)
                         (or (and (looking-at ":")
                                  (setq indent (current-column)))
                             (and (< (line-beginning-position)
                                     (prog2 (backward-sexp) (point)))
                                  (looking-at ":")
                                  (setq indent (current-column))))
                         indent))
                  ;; another symbols or constants not preceded by a constant
                  ;; as defined above.
                  normal-indent))
                ;; in this case calculate-lisp-indent-last-sexp is nil
                (desired-indent)
                (t
                 normal-indent))))))
  (defalias 'elisp-mode 'emacs-lisp-mode)
  (advice-add #'calculate-lisp-indent :override #'λαω-calculate-lisp-indent))

(use-package mb-depth
  :ensure nil
  :defer 2
  :config
  (minibuffer-depth-indicate-mode))

(use-package minibuffer
  :ensure nil
  :commands minibuffer-mode
  :init
  ;; Show input method in minibuffer.
  ;;
  ;; Credit to Akito Mikami.
  ;; See: https://a64.work/posts/2023-01-14-emacs-input-method-minibuffer-indicator.html
  (defvar-local λαω-minibuffer-input-method-overlay nil
    "Overlay showing the active input method.")

  (defun λαω-minibuffer-input-method-indicator-activate ()
    "Show input method indicator in minibuffer."
    (when (minibufferp)
      (unless λαω-minibuffer-input-method-overlay
        (setq λαω-minibuffer-input-method-overlay
              (make-overlay (point-min) (point-min) nil nil t)))
      (overlay-put λαω-minibuffer-input-method-overlay 'after-string
                   (format "[%s] " current-input-method-title))))

  (defun λαω-minibuffer-input-method-indicator-deactivate ()
    "Hide input method indicator in minibuffer."
    (when (minibufferp)
      (overlay-put λαω-minibuffer-input-method-overlay 'after-string nil)))
  :custom
  ;; useful for `corfu'
  (completion-cycle-threshold 2
   "Cycle through completion candidates if there's only two."))

(use-package paren
  :ensure nil
  :hook (prog-mode-hook . show-paren-mode)
  :custom
  (show-paren-delay 0))

(use-package password-cache
  :ensure nil
  :defer 1.5
  :custom
  (password-cache-expiry (* 60 5))) ; 5 minutes

(use-package pixel-scroll
  :ensure nil
  :if (display-graphic-p)
  :defer 2
  :config
  (pixel-scroll-precision-mode))

(use-package re-builder
  :ensure nil
  :defer t
  :custom
  (reb-re-syntax 'string)
  (reb-auto-match-limit 512))

(use-package recentf
  :ensure nil
  :defer 1
  :config
  (recentf-mode)
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name λαω-emacs-var-directory))
  :bind (("C-c f r" . recentf)
         :map λαω-files-map
         ("r" . recentf))
  :custom
  (recentf-max-saved-items 64))

(use-package repeat
  :ensure nil
  :defer 1.25
  :config
  (repeat-mode)
  :custom
  (repeat-exit-timeout 1.25))

(use-package replace
  :ensure nil
  :bind (("C-c r" . query-replace-regexp)))

(use-package savehist
  :ensure nil
  :defer 0.75
  :config
  (savehist-mode)
  :custom
  (savehist-additional-variables '(kill-ring
                                   kmacro-ring
                                   regexp-search-ring
                                   search-ring)))

(use-package saveplace
  :ensure nil
  :defer 2
  :config
  (save-place-mode))

(use-package shr
  :ensure nil
  :defer t
  :custom
  (shr-use-colors nil))

(use-package time
  :disabled
  :ensure nil
  :config
  (display-time-mode)
  :custom
  (display-time-24hr-format t)
  (display-time-day-and-date t)
  (display-time-default-load-average
   nil
   "Don't show system load average (wtf?).")
  (display-time-format "%a %h %d %H:%M"))

(use-package tramp
  :ensure nil
  :defer 0.5
  :custom
  (tramp-default-method "ssh")
  (tramp-backup-directory-alist backup-directory-alist)
  ;; set default shell to bash
  (tramp-connection-properties '((nil "remote-shell" "/usr/bin/bash")))
  (tramp-encoding-shell "/usr/bin/bash"))

(use-package transient
  :defer t)

(use-package treesit
  :ensure nil
  :defer 2
  :init
  (defcustom λαω-treesit-language-grammars-directory
    "Directory for tree-sitter language grammars."
    (expand-file-name "treesit/language-grammars/" λαω-emacs-var-directory)
    :type 'directory)

  (defun λαω-install-treesit-language-grammars (&optional install-directory)
    "Install all language grammars in `treesit-language-source-alist'.

Optionally install the grammars in INSTALL-DIRECTORY. Otherwise, install
them in `λαω-treesit-language-grammars-directory'."
    (interactive)
    (if (featurep 'treesit)
        (let ((install-directory
               (directory-file-name
                (or install-directory
                    λαω-treesit-language-grammars-directory))))
          (mapcar (lambda (language)
                    (treesit-install-language-grammar language install-directory))
                  (mapcar #'car treesit-language-source-alist)))
      (error "`treesit' is not installed")))

  :config
  (add-to-list 'treesit-extra-load-path
               λαω-treesit-language-grammars-directory)
  (setq treesit-language-source-alist
        '((css "https://github.com/tree-sitter/tree-sitter-css" "v0.23.2")
          (elixir "https://github.com/elixir-lang/tree-sitter-elixir" "v0.3.4")
          (heex
           "https://github.com/phoenixframework/tree-sitter-heex" "v0.8.0")
          (html "https://github.com/tree-sitter/tree-sitter-html" "v0.23.2")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "v0.23.1")
          (json "https://github.com/tree-sitter/tree-sitter-json" "v0.24.8")
          (python "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
          ;; (markdown
          ;;  "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
          ;;  "v0.3.2"
          ;;  "tree-sitter-markdown/src")
          ;; (markdown-inline
          ;;  "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
          ;;  "v0.3.2"
          ;;  "tree-sitter-markdown-inline/src"))
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "typescript/src")
          (xml "https://github.com/tree-sitter-grammars/tree-sitter-xml" "v0.7.0" "xml/src")
          (yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml" "v0.7.0"))))

  ;; *-ts-mode setup
  (use-package elixir-ts-mode
    :ensure nil
    :mode "\\.ex[s]?\\'")

  (use-package heex-ts-mode
    :ensure nil
    :mode "\\.heex\\'")

  (use-package javascript-ts-mode
    :ensure nil
    :mode "\\.js[x]?\\'")

  (use-package json-ts-mode
    :ensure nil
    :mode "\\.json\\'")

  (use-package typescript-ts-mode
    :ensure nil
    :mode "\\.ts[x]?\\'")

  (use-package yaml-ts-mode
    :ensure nil
    :mode "\\.y[a]?ml\\'")

  ;; major mode remapping
  (add-to-list 'major-mode-remap-alist '(js-json-mode . json-ts-mode))
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

(use-package vc-hooks
  :ensure nil
  :custom
  (vc-make-backup-files t))

(use-package window
  :ensure nil
  :custom
  ;; See:
  ;; https://www.masteringemacs.org/article/demystifying-emacs-window-manager
  (switch-to-buffer-obey-display-actions t
   "Treat manual buffer switching the same as programmatic switching."))

(use-package winner
  :ensure nil
  :config
  (winner-mode)
  :bind (("C-c w C-/" . winner-undo)
         ("C-c w C-?" . winner-redo)))

(use-package which-key
  :ensure nil
  :defer 0.5
  :config
  (which-key-mode)
  :custom
  ;; (which-key-use-C-h-commands nil)
  (which-key-idle-delay 0.3)
  (which-key-preserve-window-configuration t)
  (which-key-max-description-length nil)
  (which-key-dont-use-unicode nil)
  (which-key-show-prefix 'top)
  (which-key-side-window-max-height 7)
  (which-key-prefix-prefix "*")
  (which-key-separator " → "))

(use-package whitespace
  :ensure nil
  :defer 1
  :config
  (global-whitespace-mode)
  :custom
  (whitespace-global-modes '(prog-mode))
  (whitespace-style '(face
                      trailing
                      tabs
                      missing-newline-at-eof
                      empty
                      indentation::space
                      space-after-tab
                      space-before-tab
                      tab-mark)))

(use-package window
  :ensure nil
  :bind (;; ("C-c C-l" . recenter-top-bottom)
         ;; ("C-c l" . recenter-top-bottom)
         ;; :map λαω-map
         ;; ("C-l" . recenter-top-bottom)
         :map λαω-window-map
         ("-" . shrink-window-horizontally)
         ("=" . enlarge-window-horizontally)
         ("_" . shrink-window)
         ("+" . enlarge-window)))

;;; third-party packages
(use-package pass
  :defer 1)

(use-package undo-fu-session
  :hook
  (text-mode-hook . undo-fu-session-mode)
  (prog-mode-hook . undo-fu-session-mode))

(use-package whole-line-or-region
  :defer 0.25
  :config
  (whole-line-or-region-global-mode))

(use-package avy
  :defer 0.5
  ;; default is `electric-newline-and-maybe-indent'
  :bind (("C-j" . avy-goto-char-timer))
  )

(use-package expreg
  :config
  (defun λαω-expreg-expand-sentences ()
    "Expand sentences with `expreg'.

This function adds the `expreg--sentence' expansion function to
`expreg-functions'."
    (add-to-list 'expreg-functions 'expreg--sentence))

  :hook (text-mode-hook . λαω-expreg-expand-sentences)
  :bind (("C-=" . expreg-expand)
         ("C-M-=" . expreg-contract)))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package eat
  :hook
  (eshell-load-hook . eat-eshell-visual-command-mode)
  :bind (:map λαω-cli-map
         ("t" . eat)))

(use-package vterm
  :defer t
  :commands (vterm vterm-other-window)
  :config
  (keymap-unset vterm-mode-map "C-l" t)
  :bind (:map λαω-cli-map
         ("v" . vterm)
         :map vterm-mode-map
         ("C-q" . vterm-send-next-key))
  :custom
  (vterm-max-scrollback 12000)
  (vterm-timer-delay 0.01)
  (vterm-always-compile-module t))

(use-package orderless
  :defer 0.5
  :init
  ;; efficient prefix filtering for inputs shorter than 4 characters
  (defun orderless-fast-dispatch (word index total)
    (and (= index 0) (= total 1) (length< word 4)
         (cons 'orderless-literal-prefix word)))
  :config
  (orderless-define-completion-style orderless-fast
    (orderless-style-dispatchers '(orderless-fast-dispatch))
    (orderless-matching-styles
     '(orderless-flex orderless-literal orderless-regexp)))
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; enable file wildcard support using partial completion
  (completion-category-overrides
   '((file (styles orderless basic partial-completion)))))

(use-package consult
  :init
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  (keymap-set consult-narrow-map
              (concat consult-narrow-key " ?") #'consult-narrow-help)

  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ; orig. project-switch-to-buffer
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ; orig. goto-line
         ("M-g o" . consult-outline)               ; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ; orig. next-matching-history-element
         ("M-r" . consult-history))                ; orig. previous-matching-history-element
  :custom
  (consult-preview-key 'any))

(use-package consult-dir
  :after consult
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package vertico
  :defer 0.5
  :config
  (vertico-mode)
  :custom
  (vertico-cycle t) ; enable cycling for `vertico-next/previous'
  (vertico-count 7)
  (vertico-resize nil)) ; affix minibuffer window size

(use-package corfu
  :init
  (defun λαω-disable-corfu-auto-locally ()
    "Locally disable `corfu-mode' automatic completion."
    (setq-local corfu-auto nil)
    (corfu-mode))
  (global-corfu-mode)
  (keymap-unset corfu-map "<RET>")
  (define-key corfu-map [remap next-line] nil)
  (define-key corfu-map [remap previous-line] nil)
  ;; corfu extensions
  (corfu-echo-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)
  :hook (eshell-mode-hook . λαω-disable-corfu-auto-locally)
  :bind (:map corfu-map
         ("M-n" . corfu-next)
         ("M-p" . corfu-previous)
         ;; configure SPC for separator insertion
         ("SPC" . corfu-insert-separator))
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.4)
  (corfu-quit-no-match 'separator)
  (corfu-cycle t) ; enable cycling for `corfu-next/previous'
  (corfu-separator ?\s) ; orderless field separator
  (corfu-scroll-margin 3)
  (corfu-popupinfo-delay '(1.0 . 0.2))
  (corfu-max-width 80)
  (corfu-popupinfo-hide nil)
  (corfu-popupinfo-max-height 12)
  (corfu-preview-current nil)
  (corfu-quit-no-match t)
  (corfu-count 7))

(use-package corfu-terminal
  :if (display-graphic-p)
  :defer 2
  :after corfu
  :config
  (corfu-terminal-mode))

(use-package cape
  :defer 0.8
  :config
  ;; Add to the global default value of
  ;; `completion-at-point-functions' which is used by
  ;; `completion-at-point'. The order of the functions matters, the
  ;; first function returning a result wins. Note that the list of
  ;; buffer-local completion functions takes precedence over the
  ;; global list.
  ;;  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-elisp-symbol)
  ;; (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-history)
  ;; (add-hook 'completion-at-point-functions #'cape-emoji)

  ;; use `cape''s cache buster to refresh completion table
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)

  (keymap-set λαω-text-completion-map "c" (cons "cape" cape-prefix-map)))

(use-package marginalia
  :defer 1
  :config
  (marginalia-mode)
  :bind (("M-A" . marginalia-cycle))
  :custom
  (marginalia-field-width 120))

(use-package embark
  :config
  ;; Hide the mode line of the Embark Live/Completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  :bind
  (("C-." . embark-act) ;; pick some comfortable binding
   ("C-;" . embark-dwim) ;; good alternative: M-.
   ("C-h B" . embark-bindings))) ;; alternative for `describe-bindings'

(use-package embark-consult
  ;; show consult previews as you move around an auto-updating embark
  ;; collect buffer
  :hook
  (embark-collect-mode-hook . consult-preview-at-point-mode))

(use-package magit
  :commands (magit-auto-revert-mode magit-mode magit-wip-mode)
  :defer 1
  :config
  (add-to-list 'magit-no-confirm 'safe-with-wip)
  (magit-wip-mode)
  :bind (:map λαω-git-map
         ("d" . magit-dispatch)
         ("f" . magit-file-dispatch)
         ("g" . magit-status)))

(use-package magit-todos
  :after magit
  :config
  (magit-todos-mode))

(use-package git-timemachine
  :bind (:map λαω-git-map
         ("t" . git-timemachine)))

(use-package diff-hl
  :defer 1
  :config
  (global-diff-hl-mode)
  ;; (diff-hl-margin-mode)
  (diff-hl-flydiff-mode)
  (global-diff-hl-show-hunk-mouse-mode)
  :hook
  (magit-pre-refresh-hook . diff-hl-magit-pre-refresh)
  (magit-post-refresh-hook . diff-hl-magit-post-refresh)
  (dired-mode-hook . diff-hl-dired-mode)
  :bind (:map λαω-git-map
         ("h" . diff-hl-show-hunk))
  :custom
  (diff-hl-update-async t)
  (diff-hl-side 'right))

(use-package yasnippet
  :disabled
  :config
  (yas-reload-all)
  (yas-minor-mode)
  :bind (("C-c y e" . yas-expand)
         :map λαω-map
         ("y" . yas-insert-snippet)))

(use-package yasnippet-snippets
  :disabled
  :after yasnippet)

(use-package whitespace-cleanup-mode
  :defer 2
  :config
  (global-whitespace-cleanup-mode))

(use-package ialign
  :bind (:map λαω-text-map
         ("a" . ialign)))

(use-package vundo
  :bind (("C-M-/" . vundo)))

(use-package goto-line-preview
  :bind ([remap goto-line] . goto-line-preview))

(use-package indent-bars
  :hook (prog-mode-hook . indent-bars-mode)
  :custom
  (indent-bars-color '(highlight
                       :face-bg t
                       :blend 0.5))
  (indent-bars-highlight-current-depth '(:pattern "."
                                         :blend 0.75))
  (indent-bars-pattern " . .")
  (indent-bars-width-frac 0.25)
  ;; For centering while taking into account `indent-bars-width-frac',
  ;; subtract half of its value from half of total possible offset:
  ;; pad-frac = 0.5 - (width-frac / 2)
  (indent-bars-pad-frac 0.375
   "Indent bar offset from leftmost character edges.")
  (indent-bars-display-on-blank-lines nil)
  (indent-bars-no-descend-lists nil)
  (indent-bars-color-by-depth nil)
  ;; treesit support
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  (indent-bars-treesit-scope '((function_definition
                                class_definition
                                for_statement
                                if_statement
                                with_statement
                                while_statement))))

(use-package indent-bars-ts
  :ensure nil ; provided by `indent-bars'
  :requires indent-bars)

(use-package colorful-mode
  :hook
  (text-mode-hook . colorful-mode)
  (custom-mode-hook . colorful-mode))

(use-package wgrep
  :defer t)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)))

(use-package sly
  :mode ("\\.lisp\\'" . sly-mode))

(use-package pdf-tools
  :vc (:url "https://github.com/aikrahguzar/pdf-tools"
       :branch "child-frame-preview"
       :lisp-dir "lisp/")
  :if (display-graphic-p)
  :defer 2
  :commands (pdf-view-mode pdf-view-roll-minor-mode)
  :config
  (pdf-loader-install)
  (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)
  :custom
  (pdf-cache-image-limit 128)
  (pdf-cache-prefetch-delay 0.1)
  (pdf-view-resize-factor 1.1)
  (pdf-view-max-image-width 1080))

(use-package djvu
  :if (display-graphic-p)
  :defer t)

(use-package nov
  :if (display-graphic-p)
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode-hook . visual-line-mode)
  :custom
  (nov-text-width t))

(require 'λαω-org)

(use-package saveplace-pdf-view
  :after pdf-tools
  :if (display-graphic-p)
  :defer t)

(use-package spacious-padding
  :config
  (spacious-padding-mode)
  :custom
  (spacious-padding-widths
   '(:internal-border-width 16
     :right-divider-width 8
     :header-line-width 3
     :mode-line-width 4)))

(use-package gptel
  :bind (("C-c M-g" . gptel-menu))
  :hook
  (gptel-post-stream-hook . gptel-auto-scroll)
  (gptel-post-response-functions-hook . gptel-end-of-response)
  :custom
  (gptel-model 'gpt-4o-mini))

(use-package unfill
  :defer t)

(use-package xkcd
  :defer t)

(use-package literate-calc-mode
  :defer t)

(use-package iedit
  :bind (:map λαω-text-map
              ("i" . iedit-mode)))

(use-package lorem-ipsum
  :defer t)

;; (use-package blimpy
;;   :vc (:url "https://github.com/progfolio/blimpy")
;;   :defer t)

(use-package visual-fill-column
  :hook ((Info-mode-hook . visual-fill-column-mode)
         (help-mode-hook . visual-fill-column-mode)
         (nov-mode-hook . visual-fill-column-mode))
  :bind (:map λαω-buffer-map
         ("f" . visual-fill-column-mode))
  :custom
  (visual-fill-column-center-text t))

(use-package dap-mode
  :defer t)

;; (use-package move-text
;;   :bind (("M-n" . move-text-down)
;;          ("M-p" . move-text-up)))

(use-package sicp
  :defer 3)

(use-package tex
  :ensure auctex
  :defer t
  :config
  (setq-default TeX-master nil)
  :hook
  ((LaTeX-mode-hook . visual-line-mode)
   (LaTeX-mode-hook . flymake-mode)
   (LaTeX-mode-hook . LaTeX-math-mode))
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-view-program-selection '(((output-dvi has-no-display-manager) "dvi2tty")
                               ((output-dvi style-pstricks) "dvips and gv")
                               (output-dvi "xdvi")
                               (output-pdf "Okular")
                               (output-html "xdg-open"))))

(use-package activities
  :init
  (defvar-keymap λαω-activities-map
    :doc "Keymap for Activities."
    :name "activities")
  (keymap-global-set "C-c a" (cons "λαω-activities" λαω-activities-map))
  (keymap-set λαω-map "a" (cons "activites" λαω-activities-map))
  :config
  (activities-mode)
  (activities-tabs-mode)
  ;; Prevent `edebug' default bindings from interfering.
  (setq edebug-inhibit-emacs-lisp-mode-bindings t)
  :bind
  (:map λαω-activities-map
   ("=" . activities-new)
   ("d" . activities-define)
   ("a" . activities-resume)
   ("s" . activities-suspend)
   ("k" . activities-kill)
   ("f" . tab-next)
   ("b" . tab-previous)
   ("M-f" . tab-bar-move-tab)
   ("M-b" . tab-bar-move-tab-backward)
   ("RET" . activities-switch)
   ;; ("b" . activities-switch-buffer)
   ("g" . activities-revert)
   ("l" . activities-list)))

(use-package citar
  :defer 1
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  :custom
  (citar-library-paths '("~/dump/library/"))
  (citar-bibliography "~/dump/library/bibliography.bib"))

(use-package citar-embark
  :after citar embark
  :config (citar-embark-mode))

(use-package edraw
  :vc (:url "https://github.com/misohena/el-easydraw")
  :defer t)

(use-package elfeed
  :defer t)

(use-package elfeed-tube
  :after elfeed
  :defer t
  :config
  (elfeed-tube-setup))

(use-package htmlize
  :defer t)

(use-package citar
  :defer 1
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  :custom
  (citar-library-paths '("~/dump/library/"))
  (citar-bibliography "~/dump/library/bibliography.bib"))

(use-package citar-embark
  :after citar embark
  :config (citar-embark-mode))

(use-package elfeed
  :defer t)

(use-package elfeed-tube
  :after elfeed
  :defer t
  :config
  (elfeed-tube-setup))

;;; init.el ends here

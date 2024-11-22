;;; λαω-themes.el --- λαω themes -*- coding: utf-8; lexical-binding: t; -*-

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

;; λαω themes.

;;; Code:

(require 'λαω)

(defvar λαω-themes-directory (expand-file-name
                                 "themes/" λαω-emacs-directory)
  "λαω themes directory.")

(add-to-list 'custom-theme-load-path λαω-themes-directory)

;; fonts
(defun λαω-set-default-fonts ()
  "Set default fonts."
  (interactive)
  (progn
    (when (member "Iosevka Law" (font-family-list))
      (custom-set-faces
       '(default ((t (:family "Iosevka Law"
                      :height 120)))))
      ;; (add-to-list 'initial-frame-alist
      ;;              '(font . "Iosevka Law-14"))
      ;; (add-to-list 'default-frame-alist
      ;;              '(font . "Iosevka Law-14"))
      (custom-set-faces
       '(fixed-pitch ((t (:family "Iosevka Law"
                          :height 120))))))
    (when (member "IBM Plex Sans" (font-family-list))
      (custom-set-faces
       '(variable-pitch ((t (:family "IBM Plex Sans"
                             :height 120))))
       '(variable-pitch-text ((t (:inherit (variable-pitch)
                                           :height 1.05))))))))

(defun λαω-set-emacs-server-frame-fonts ()
  "Set fonts when running Emacs as a server/daemon.

Remove this function from `server-before-make-frame-hook' so it only
runs for the initial, created frame."
  (message "Setting default ")
  (λαω-set-default-fonts)
  (remove-hook 'server-after-make-frame-hook
               #'λαω-set-emacs-server-frame-fonts))

(add-hook 'server-after-make-frame-hook
          #'λαω-set-emacs-server-frame-fonts)

;; Set fonts for non-daemon
(when (not (daemonp))
  (λαω-set-default-fonts))

(add-hook 'server-before-make-frame-hook #'λαω-set-emacs-server-frame-fonts)

(setq custom-theme-directory
        (expand-file-name "themes/" λαω-emacs-directory))

(load-theme 'λαω t)

(provide 'λαω-themes)
;;; λαω-themes.el ends here

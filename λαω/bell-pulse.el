;;; bell-pulse.el --- Pulse frame elements when the bell rings  -*- lexical-binding: t; -*-

;; Copyright (C) 2024-2025 Lao Tong

;; Author: Lao Tong <lao.s.t@pm.me>
;; Maintainer: Lao Tong <lao.s.t@pm.me>
;; Keywords: faces frames

;;; License:

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
;; License along with this program.  If not, see
;; <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A global minor mode to pulse the mode line when the bell rings.

;; When the bell rings, a pulse effect occurs where the mode line background
;; color briefly changes to that of `bell-pulse-highlight' and then
;; reverts. By default, the background color of `bell-pulse-highlight'
;; is that of the `warning' face.

;; This mode is inspired by Steve Purcell's `mode-line-bell' and Nicolas
;; Rougier's `nano-bell' packages.

;;; Code:

(require 'color)
(require 'face-remap)

(defgroup bell-pulse nil
  "Pulse the mode line when the bell rings."
  :group 'bell-pulse)

(defgroup bell-pulse-faces nil
  "Faces used by `bell-pulse-mode'."
  :group 'bell-pulse
  :group 'faces)

(defface bell-pulse-highlight `((t :inherit warning))
  "The highlight face of `bell-pulse-mode' pulse effect."
  :group 'bell-pulse-faces)

(defcustom bell-pulse-duration 0.2
  "Duration of the `bell-pulse-mode' pulse effect in seconds."
  :type 'float
  :group 'bell-pulse)

(defcustom bell-pulse-steps 6
  "Number of animation steps for the `bell-pulse-mode' pulse effect."
  :type 'number
  :group 'bell-pulse)

(defvar bell-pulse-color-sequence nil
  "The color sequence for `bell-pulse-mode' pulse effect.")

(defun bell-pulse--create-color-sequence (from to)
  "Create the color sequence for the `bell-pulse' pulse effect.

FROM and TO are hex strings.

If `bell-pulse-color-sequence' is nil, a reflected color
gradient is created, which ranges from the background color of the
`active' face to that of the FACE. If the background color of
`active' is unspecified, the background color of the `default'
face is used instead.

`bell-pulse-steps' determines the number of colors in the sequence."
  (unless bell-pulse-color-sequence
    (let* ((gradient (mapcar
                      (lambda (rgb)
                        (let ((r (nth 0 rgb))
                              (g (nth 1 rgb))
                              (b (nth 2 rgb)))
                          (color-rgb-to-hex r g b 2)))
                      (color-gradient
                       (color-name-to-rgb from)
                       (color-name-to-rgb to)
                       (/ bell-pulse-steps 2)))))
      (setq bell-pulse-color-sequence
            (append gradient (reverse gradient))))
    bell-pulse-color-sequence))

;;;###autoload
(defun bell-pulse-pulse ()
  "Pulse the mode line."
  (let ((time-step (/ bell-pulse-duration
                      bell-pulse-steps))
        ;; Inheriting the `mode-line' faces and then specifying one of its
        ;; `:box' properties would only override all of the box's face
        ;; attributes. Since we only want to change its color during the pulse
        ;; effect, keep its `:line-width' and `:style'.
        (box-line-width (plist-get (face-attribute 'mode-line :box)
                                   :line-width))
        (box-style (plist-get (face-attribute 'mode-line :box)
                              :style))
        face-remap-cookies)
    (unwind-protect
        (progn
          (bell-pulse--create-color-sequence
           (or (face-background 'mode-line
                                nil t)
               (face-background 'default nil t))
           (face-foreground 'bell-pulse-highlight nil t))
          (dolist (color bell-pulse-color-sequence)
            (push (face-remap-add-relative 'mode-line-active
                                           `(:background ,color
                                             :box (:color ,color
                                                   :line-width ,box-line-width
                                                   :style ,box-style)))
                  face-remap-cookies)
            (push (face-remap-add-relative 'tab-bar-tab
                                           `(:background ,color
                                             :box (:color ,color
                                                   :line-width ,box-line-width
                                                   :style ,box-style)))
                  face-remap-cookies)
            (sit-for time-step)))
      (dolist (cookie face-remap-cookies)
        (face-remap-remove-relative cookie)))))

;;;###autoload
(define-minor-mode bell-pulse-mode
  "Pulse the mode line when the bell rings."
  :lighter nil
  :global t
  (setq-default ring-bell-function (when bell-pulse-mode #'bell-pulse-pulse)))

(provide 'bell-pulse)
;;; bell-pulse.el ends here

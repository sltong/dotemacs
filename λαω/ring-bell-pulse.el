;;; ring-bell-pulse.el --- Pulse faces when the bell rings  -*- lexical-binding: t; -*-

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

;; A global minor mode to pulse faces when the bell rings.

;; When the bell rings, a pulse effect occurs where a face's background
;; color briefly changes to that of `ring-bell-pulse-highlight' and then
;; reverts. By default, the background color of `ring-bell-pulse-highlight'
;; is that of the `warning' face.

;; This mode is inspired by Steve Purcell's `mode-line-bell' and Nicolas
;; Rougier's `nano-bell' packages.

;;; Code:

(require 'color)
(require 'face-remap)

(defgroup ring-bell-pulse nil
  "Pulse the mode line or other faces when the bell rings."
  :group 'ring-bell-pulse)

(defcustom ring-bell-pulse-highlight "#353400"
  "The highlight face of `ring-bell-pulse-mode' pulse effect."
  :type 'color
  :group 'ring-bell-pulse
  :set (lambda (symbol value)
         ;; clear color sequence cache
         (setq ring-bell-pulse-color-sequence nil)
         (set-default symbol value)))

(defcustom ring-bell-pulse-faces '(mode-line-active)
  "Alist of faces to pulse."
  :type '(repeat face)
  :group 'ring-bell-pulse)

(defcustom ring-bell-pulse-duration 0.25
  "Duration of the `ring-bell-pulse-mode' pulse effect in seconds."
  :type 'float
  :group 'ring-bell-pulse)

(defcustom ring-bell-pulse-delay 0.03
  "Delay between animation steps of the `ring-bell-pulse-mode' pulse effect in seconds."
  :type 'float
  :group 'ring-bell-pulse)

(defcustom ring-bell-pulse-steps 6
  "Number of animation steps for the `ring-bell-pulse-mode' pulse effect."
  :type 'number
  :group 'ring-bell-pulse)

(defvar ring-bell-pulse-color-sequence nil
  "The color sequence for `ring-bell-pulse-mode' pulse effect.")

(defun ring-bell-pulse--create-color-sequence (from to)
  "Create the color sequence for the `ring-bell-pulse' pulse effect.

FROM and TO are hex strings.

If `ring-bell-pulse-color-sequence' is nil, a reflected color
gradient is created, which ranges from the background color of the
`active' face to that of the FACE. If the background color of
`active' is unspecified, the background color of the `default'
face is used instead.

`ring-bell-pulse-steps' determines the number of colors in the sequence."
  (unless ring-bell-pulse-color-sequence
    (let ((gradient (mapcar
                     (lambda (rgb)
                       (let ((r (nth 0 rgb))
                             (g (nth 1 rgb))
                             (b (nth 2 rgb)))
                         (color-rgb-to-hex r g b 2)))
                     (color-gradient
                      (color-name-to-rgb from)
                      (color-name-to-rgb to)
                      (/ ring-bell-pulse-steps 2)))))
      (setq ring-bell-pulse-color-sequence
            (append gradient (reverse gradient))))
    ring-bell-pulse-color-sequence))

;;;###autoload
(defun ring-bell-pulse-pulse (&optional faces)
  "Pulse the FACES."
  (let ((faces (or faces ring-bell-pulse-faces))
        (time-step (/ ring-bell-pulse-duration
                      ring-bell-pulse-steps))
        ;; ;; Inheriting the `mode-line' faces and then specifying one of its
        ;; ;; `:box' properties would only override all of the box's face
        ;; ;; attributes. Since we only want to change its color during the pulse
        ;; ;; effect, keep its `:line-width' and `:style'.
        ;; (box-line-width (plist-get (face-attribute 'mode-line :box)
        ;;                            :line-width))
        ;; (box-style (plist-get (face-attribute 'mode-line :box)
        ;;                       :style))
        face-remap-cookies)
    (unwind-protect
        (progn
          (ring-bell-pulse--create-color-sequence
           (or (face-background 'mode-line nil t)
               (face-background 'default nil t))
           ring-bell-pulse-highlight)
          (dolist (color ring-bell-pulse-color-sequence)
            (mapcar (lambda (face)
                      (push (face-remap-add-relative face
                                                     `(:background ,color))
                            face-remap-cookies))
                    faces)
            (sit-for time-step)))
          (dolist (cookie face-remap-cookies)
            (face-remap-remove-relative cookie)))))

;;;###autoload
(define-minor-mode ring-bell-pulse-mode
  "Pulse the mode line when the bell rings."
  :lighter nil
  :global t
  (setq ring-bell-function (when ring-bell-pulse-mode #'ring-bell-pulse-pulse)))

(provide 'ring-bell-pulse)

;;; ring-bell-pulse.el ends here

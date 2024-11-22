;;; mode-line-bell-pulse.el --- Pulse the mode line when the bell rings  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 λαω

;; Author: λαω <lambda.alpha.omega@proton.me>
;; Maintainer: λαω <lambda.alpha.omega@proton.me>
;; Keywords: frames faces

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

;; When the bell rings, the mode line background color changes to
;; `mode-line-bell-pulse-color' and then reverts back to its original.
;; By default, `mode-line-bell-pulse-color' is the background color of
;; the `warning' face.

;; This pulse effect is achieved by animating the color transition
;; over a series of time steps with a color gradient from the mode
;; line's background color to `mode-line-bell-pulse-color'.

;; This code is inspired by Steve Purcell's `mode-line-bell' and
;; Nicolas Rougier's `nano-bell' packages.

;;; Code:

(require 'color)
(require 'face-remap)

(defgroup mode-line-bell-pulse nil
  "Pulse the mode line when the bell rings."
  :group 'mode-line-bell-pulse)

(defgroup mode-line-bell-pulse-faces nil
  "Faces used by `mode-line-bell-pulse-mode'."
  :group 'mode-line-bell-pulse
  :group 'faces)

(defface mode-line-bell-pulse-highlight
  `((t :inherit warning))
  "Face to which the `mode-line' face changes in `mode-line-bell-pulse-mode'."
  :group 'mode-line-bell-pulse-faces)

(defcustom mode-line-bell-pulse-duration 0.2
  "Duration of the mode line pulse effect when the bell rings.

The unit of the duration is the second."
  :type 'float
  :group 'mode-line-bell-pulse)

(defcustom mode-line-bell-pulse-steps 6
  "Number of animation steps of the mode line pulse effect."
  :type 'number
  :group 'mode-line-bell-pulse)

(defcustom mode-line-bell-animate t
  "Animate the mode line pulse effect."
  :type 'boolean
  :group 'mode-line-bell-pulse)

(defcustom mode-line-bell-pulse-mode-line-box t
  "Pulse the mode line box color in `mode-line-bell-pulse-mode'."
  :type 'boolean
  :group 'mode-line-bell-pulse)

(defvar mode-line-bell-pulse-color-sequence nil
  "The color sequence for `mode-line-bell-pulse-mode' pulse effect.")

(defun mode-line-bell-pulse--create-color-sequence (face)
  "Create the color sequence for the `mode-line-bell-pulse' pulse.

FACE is the face to which the `mode-line' face changes.

First, create the color gradient from the background color of the
`mode-line' face to FACE. This gradient is a list of RGB hex colors.
Concatenate this list with its reverse."
  (unless (and mode-line-bell-pulse-color-sequence
               (= (safe-length mode-line-bell-pulse-color-sequence)
                  mode-line-bell-pulse-steps))
    (let* ((gradient (mapcar (lambda (rgb)
                               (let ((r (nth 0 rgb))
                                     (g (nth 1 rgb))
                                     (b (nth 2 rgb)))
                                 (color-rgb-to-hex r g b 2)))
                             (color-gradient
                              (color-name-to-rgb (face-background 'mode-line-active
                                                                  nil t))
                              (color-name-to-rgb (face-foreground face
                                                                  nil t))
                              (/ mode-line-bell-pulse-steps 2)))))
      (setq mode-line-bell-pulse-color-sequence
            (nconc gradient (reverse gradient)))))
  mode-line-bell-pulse-color-sequence)

;;;###autoload
(defun mode-line-bell-pulse-pulse ()
  "Pulse the mode line."
  (let* ((time-step (/ mode-line-bell-pulse-duration
                       mode-line-bell-pulse-steps))
         ;; Inheriting the `mode-line' face's and then specifying one of its
         ;; `:box' properties will override its entire `:box'. We only want to
         ;; change its color during the pulse animation.
         (mode-line-box-line-width (plist-get (face-attribute 'mode-line :box)
                                              :line-width))
         face-remap-cookies)
    (unwind-protect
        (progn
          (mode-line-bell-pulse--create-color-sequence
           'mode-line-bell-pulse-highlight)
          (dolist (color mode-line-bell-pulse-color-sequence)
            (push (face-remap-add-relative
                   'mode-line-active
                   `(:background ,color
                     :box (:line-width ,mode-line-box-line-width
                           :color ,color)))
                  face-remap-cookies)
            (sit-for time-step)))
      (dolist (cookie face-remap-cookies)
        (face-remap-remove-relative cookie)))))

;;;###autoload
(define-minor-mode mode-line-bell-pulse-mode
  "Pulse the mode line instead of ringing the bell."
  :lighter nil
  :global t
  (setq-default ring-bell-function (when mode-line-bell-pulse-mode
                                     #'mode-line-bell-pulse-pulse)))

(provide 'mode-line-bell-pulse)
;;; mode-line-bell-pulse.el ends here

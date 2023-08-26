;;; scroll-util.el --- scroll utilities -*- lexical-binding: t -*-

;; Author: berquerant
;; Maintainer: berquerant
;; Created: 27 Aug 2023
;; Version: 0.1.0
;; Keywords: scroll
;; URL: https://github.com/berquerant/emacs-scroll-util

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Scroll commands.

;;; Code:

(defgroup scroll-util nil
  "Scroll commands."
  :group 'scroll-util
  :prefix "scroll-util-")

(defcustom scroll-util-medium-lines 10
  "Define medium distance."
  :type 'integer)

;;;###autoload
(defun scroll-util-scroll-down (&optional arg)
  "Scroll down ARG lines.
Default ARG is 1."
  (interactive "P")
  (scroll-down (or (prefix-numeric-value arg) 1)))

;;;###autoload
(defun scroll-util-scroll-up (&optional arg)
  "Scroll up ARG lines.
Default ARG is 1."
  (interactive "P")
  (scroll-up (or (prefix-numeric-value arg) 1)))

;;;###autoload
(defun scroll-util-scroll-down-relationally (&optional arg)
  "Scroll down ARG lines while keeping relative location of
the cursor on the buffer.
Default ARG is 1."
  (interactive "P")
  (let ((lines (or (prefix-numeric-value arg) 1)))
    (scroll-down lines)
    (forward-line (- lines))))

;;;###autoload
(defun scroll-util-scroll-up-relationally (&optional arg)
  "Scroll up ARG lines while keeping relative location of
the cursor on the buffer.
Default ARG is 1."
  (interactive "P")
  (let ((lines (or (prefix-numeric-value arg) 1)))
    (scroll-up lines)
    (forward-line lines)))

(defmacro scroll-util--medium (f)
  "Define `scroll-util-XXX-medium' function."
  (let* ((fname (symbol-name f))
         (name (format "%s-medium" fname))
         (doc-string (format "Call `%s' `scroll-util-medium-lines' times." fname)))
    `(progn
       (defun ,(read name)
           ()
         ,doc-string
         (interactive)
         (,f scroll-util-medium-lines))
       (autoload ',(read name) "scroll-util"))))

(scroll-util--medium scroll-util-scroll-up)
(scroll-util--medium scroll-util-scroll-down)
(scroll-util--medium scroll-util-scroll-up-relationally)
(scroll-util--medium scroll-util-scroll-down-relationally)

(provide 'scroll-util)
;;; scroll-util.el ends here

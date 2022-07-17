;;; compat.el --- Emacs Lisp Compatibility Library -*- lexical-binding: t; -*-

;; Copyright (C) 2021, 2022 Free Software Foundation, Inc.

;; Author: Philip Kaludercic <philipk@posteo.net>
;; Maintainer: Compat Development <~pkal/compat-devel@lists.sr.ht>
;; Version: 28.1.1.3
;; URL: https://sr.ht/~pkal/compat
;; Package-Requires: ((emacs "24.3") (nadvice "0.3"))
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; To allow for the usage of Emacs functions and macros that are
;; defined in newer versions of Emacs, compat.el provides definitions
;; that are installed ONLY if necessary.  These reimplementations of
;; functions and macros are at least subsets of the actual
;; implementations.  Be sure to read the documentation string to make
;; sure.
;;
;; Not every function provided in newer versions of Emacs is provided
;; here.  Some depend on new features from the core, others cannot be
;; implemented to a meaningful degree.  The main audience for this
;; library are not regular users, but package maintainers.  Therefore
;; commands and user options are usually not implemented here.

;;; Code:

(eval-when-compile (require 'compat-macs))

;; We load all the components of Compat with a copied value of
;; `features' list, that will prevent the list being modified, and all
;; the files can be loaded again.  This is done so that
;; `compat--inhibit-prefixed' can take effect when loading `compat',
;; and do nothing when loading each sub-feature manually.

(defvar compat--inhibit-prefixed)
(let* ((compat--inhibit-prefixed (not (bound-and-true-p compat-testing)))
       (load-suffixes
        (if (bound-and-true-p compat-testing)
            (cons ".el" (remove ".el" load-suffixes))
          load-suffixes))
       (features (copy-sequence features)))
  (ignore features)                     ;for the byte compiler
  (require 'compat-24)
  (require 'compat-25)
  (require 'compat-26)
  (require 'compat-27)
  (require 'compat-28))

(provide 'compat)
;;; compat.el ends here

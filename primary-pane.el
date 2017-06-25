;;; primary-pane.el --- Track the primary pane. -*- lexical-binding: t -*-
(eval-when-compile
  (require 'umr))

(mapc #'require
      [hooker])

;;; Track primary pane.
(defvar primary-pane (frame-selected-window)
  "The pane that has an active mode-line.")

(defun primary-pane-set ()
  "Set the primary pane."
  (umr-let
   p (frame-selected-window)
   (unless (minibuffer-window-active-p p)
     (setq primary-pane p))))

(defun primary-pane-active? ()
  (eq primary-pane (selected-window)))

(hooker-make-hook :after select-frame)

(hooker-make-hook :after handle-select-window)

(hooker-hook-up
 [
  after-handle-select-window-hook
  after-select-frame-hook
  buffer-list-update-hook
  focus-in-hook
  window-configuration-change-hook
  ]
 [primary-pane-set])

(provide 'primary-pane)

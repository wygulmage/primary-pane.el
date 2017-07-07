;;; primary-pane.el --- Track the primary pane. -*- lexical-binding: t -*-
(mapc #'require
      [hook-up])

;;; Track primary pane.
(defvar primary-pane (frame-selected-window)
  "The pane that has an active mode-line.")

(defun primary-pane ()
  "Get and possibly set the primary pane."
  (let ((p (frame-selected-window)))
    (unless (minibuffer-window-active-p p)
      (setq primary-pane p))
    primary-pane))

(defun primary-pane-active? ()
  (eq primary-pane (selected-window)))

(hook-up-make-hook :after select-frame)

(hook-up-make-hook :after handle-select-window)

(hook-up
 [after-handle-select-window-hook
  after-select-frame-hook
  buffer-list-update-hook
  focus-in-hook
  window-configuration-change-hook]
 [primary-pane])

(provide 'primary-pane)

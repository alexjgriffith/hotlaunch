;;; hotlaunch.el --- Link programs with buffers -*- lexical-binding: t; -*-

;; Copyright (C) 2016 Alexander Griffith

;; Author: Alexander Griffith <griffita@gmail.com>
;; keyword: open programs keybindings meta
;; Created: Nov 22 2015
;; version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Hotlaunch is used to assign keybindings to buffer name / program names.
;; Using the keybinding first the predefined buffer name is searched for
;; If the predefined buffer name is not found than the function assosiated with
;; the keybinding is launched. If the buffer is found it is opened in the current
;; window. If the buffer is currently visable the pointer context is moved to the
;; window displaying the buffer of interest.

;;; Code:

;;;###autoload
(require 'cl)

(defvar hotlaunch-version "0.0.1"
  "Version of `hotlaunch.el`.")

(defvar hotlaunch-ignored-buffers '()
  "The list of buffers that are currently ignored")

(defun hotlaunch-switch-start-open (name function)
  "Switches to buffer if found, if not executes function in current window"
  (if (get-buffer name)
      (if (get-buffer-window name)
	  (select-window (get-buffer-window name))
	(switch-to-buffer name)
	)
    (funcall-interactively function)
    ))

(defun hotlaunch-set-key-buffer (combo buffer function)
  "sets a global key binding for a specific combo to a buffer and function 
if the buffer is not found than the function is executed. Function should 
create a new buffer with the name `buffer`"
  (interactive "sCombo: \nsBuffer: \naFunction:")
  (lexical-let (( b buffer)(f     function))
    (global-set-key (kbd combo) (lambda () (interactive)(switch-start-open b f)))
    ))

(defun hotlaunch-set-current-buffer-to-key (key)
  "Set the current buffer to a hot key for rapid access. Convinient if you 
are working with a few key files that you wish to cycle through"
  (interactive "sKey: \n")
  (lexical-let ((buffer (buffer-name)))
    (set-key-buffer  key buffer (lambda()(switch-to-buffer buffer)))))


(defun hotlaunch-ignore-buffer()
  "Adds the current buffer to the `hotlaunch-ignored-buffers` list"
  (interactive)
  (let ((cb (current-buffer)))
    (unless (member cb hotlaunch-ignored-buffers)
      (push cb hotlaunch-ignored-buffers))))


(defun hotlaunch-love-buffer()
  "Removes the current buffer to the `hotlaunch-ignored-buffers` list"
  (interactive)
  (let ((cb (current-buffer)))
    (when (member cb hotlaunch-ignored-buffers)
      (setq hotlaunch-ignored-buffers (remove cb hotlaunch-ignored-buffers)))))


(defun hotlaunch-other-window(&optional cbi)
  "Switches to the next window, so long as its buffer is not in the ignore list"
  (interactive)
  (let* ((sw (if cbi cbi (selected-window)))
	 (nw (next-window sw nil nil)))	 
  (cond ((member (window-buffer nw) hotlaunch-ignored-buffers) 
	 (hotlaunch-other-window nw))
	(( not (eq (current-buffer) (window-buffer nw)))
	 (progn
	   (select-window nw)))	
	(t (message "Current Window")))))

(provide 'hotlaunch)
;;; hotlaunch.el ends here

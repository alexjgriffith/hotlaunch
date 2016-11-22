# Emacs package Hotlaunch
Hotlaunch is used to assign keybindings to buffer name / program names.  Using the keybinding first the predefined buffer name is searched for If the predefined buffer name is not found than the function assosiated with the keybinding is launched. If the buffer is found it is opened in the current window. If the buffer is currently visable the pointer context is moved to the window displaying the buffer of interest.

## Installing
From your shell download the source from github:

```bash
## Change to a subdirectory in your local emacs folder
cd ~/.emacs/lisp/
curl --location -O https://raw.github.com/alexjgriffith/hotlaunch/master/hotlaunch.el
```

Within your emacs init file (~/.emacs or ~/.emacs.d/init.el) add the following lines

```elisp
;; Make sure that emacs can see hotlaunch
(add-to-list `load-path "~/.emacs/lisp")
(require 'hotlaunch)
```

## Utilization
I use R and ESS daily. Hotlaunch lets me add a keybinding that looks for my current *"\*R\*"* buffer and if it fails to find one, it opens a new session.

```elisp
;; Using ESS' default buffer name for a single R session (*R*)
(hl-set-key-buffer "M-0" "*R*" #'R)

;; or if you want the buffer name to be different
(defun my-R()
	(interactive)
	(R)
	(rename-buffer "*My-R*"))
(hl-set-key-buffer "M-0" "*My-R*" #'my-R)
```

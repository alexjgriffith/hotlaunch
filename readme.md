# Emacs Package: Hotlaunch V 0.0.1
Hotlaunch is used to assign keybindings to buffer name / program names.  Using the keybinding first the predefined buffer name is searched for If the predefined buffer name is not found than the function associated with the keybinding is launched. If the buffer is found it is opened in the current window. If the buffer is currently visible the pointer context is moved to the window displaying the buffer of interest.

## Installing
From your shell download the source from github:

```bash
## Change to a subdirectory in your local emacs folder
cd ~/.emacs.d/lisp/
curl --location -O https://raw.github.com/alexjgriffith/hotlaunch/master/hotlaunch.el
```

Within your emacs init file (~/.emacs or ~/.emacs.d/init.el) add the following lines

```elisp
;; Make sure that emacs can see hotlaunch
(add-to-list `load-path "~/.emacs/lisp")
(require 'hotlaunch)
```

## Utilization
I use R and ESS daily. Hotlaunch lets me add a keybinding that looks for my current \*R\* buffer and if it fails to find one, it opens a new session.

```elisp
;; Using ESS' default buffer name for a single R session (*R*)
(hotlaunch-set-key-buffer "M-0" "*R*" #'R)

;; or if you want the buffer name to be different
(defun my-R()
	(interactive)
	(R)
	(rename-buffer "*My-R*"))
(hotlaunch-set-key-buffer "M-0" "*My-R*" #'my-R)
```

## Future Work
1. Currently working an alternate other-window function that will skip over buffers in an ignore list.
2. Make a helper function for `hotlaunch-set-key-buffer` that forces `function` to open a buffer with the name `buffer`

;;; frames-only-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "frames-only-mode" "frames-only-mode.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from frames-only-mode.el

(defvar frames-only-mode nil "\
Non-nil if Frames-Only mode is enabled.
See the `frames-only-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `frames-only-mode'.")

(custom-autoload 'frames-only-mode "frames-only-mode" nil)

(autoload 'frames-only-mode "frames-only-mode" "\
Use frames instead of emacs windows.

This is a minor mode.  If called interactively, toggle the
`Frames-Only mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='frames-only-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "frames-only-mode" '("frames-only-mode-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; frames-only-mode-autoloads.el ends here

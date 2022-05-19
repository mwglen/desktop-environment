;;; exwm-firefox-evil-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "exwm-firefox-evil" "exwm-firefox-evil.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from exwm-firefox-evil.el

(autoload 'exwm-firefox-evil-mode "exwm-firefox-evil" "\
Toggle Exwm-Firefox-Evil mode on or off.

This is a minor mode.  If called interactively, toggle the
`Exwm-Firefox-Evil mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `exwm-firefox-evil-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\\{exwm-firefox-evil-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'exwm-firefox-evil-activate-if-firefox "exwm-firefox-evil" "\
Activates exwm-firefox mode when buffer is firefox.
Firefox variant can be assigned in 'exwm-firefox-evil-firefox-name`" t nil)

(register-definition-prefixes "exwm-firefox-evil" '("exwm-firefox-evil-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; exwm-firefox-evil-autoloads.el ends here

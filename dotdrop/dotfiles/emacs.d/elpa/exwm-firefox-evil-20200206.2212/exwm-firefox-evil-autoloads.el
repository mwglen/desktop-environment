;;; exwm-firefox-evil-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "exwm-firefox-evil" "exwm-firefox-evil.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from exwm-firefox-evil.el

(autoload 'exwm-firefox-evil-mode "exwm-firefox-evil" "\
Toggle Exwm-Firefox-Evil mode on or off.

If called interactively, enable Exwm-Firefox-Evil mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\\{exwm-firefox-evil-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'exwm-firefox-evil-activate-if-firefox "exwm-firefox-evil" "\
Activates exwm-firefox mode when buffer is firefox.
Firefox variant can be assigned in 'exwm-firefox-evil-firefox-name`" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "exwm-firefox-evil" '("exwm-firefox-evil-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; exwm-firefox-evil-autoloads.el ends here

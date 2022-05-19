;;; exwm-firefox-core-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "exwm-firefox-core" "exwm-firefox-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from exwm-firefox-core.el

(autoload 'exwm-firefox-core-up "exwm-firefox-core" "\
Move up." t nil)

(autoload 'exwm-firefox-core-down "exwm-firefox-core" "\
Move down." t nil)

(autoload 'exwm-firefox-core-left "exwm-firefox-core" "\
Move left." t nil)

(autoload 'exwm-firefox-core-right "exwm-firefox-core" "\
Move right." t nil)

(autoload 'exwm-firefox-core-up-select "exwm-firefox-core" "\
Move up and select." t nil)

(autoload 'exwm-firefox-core-down-select "exwm-firefox-core" "\
Move down and select." t nil)

(autoload 'exwm-firefox-core-left-select "exwm-firefox-core" "\
Move left and select." t nil)

(autoload 'exwm-firefox-core-right-select "exwm-firefox-core" "\
Move right and select." t nil)

(autoload 'exwm-firefox-core-top "exwm-firefox-core" "\
Move to top of page." t nil)

(autoload 'exwm-firefox-core-bottom "exwm-firefox-core" "\
Move to bottom of page." t nil)

(autoload 'exwm-firefox-core-bottom-select "exwm-firefox-core" "\
Move to bottom of page and select." t nil)

(autoload 'exwm-firefox-core-page-up "exwm-firefox-core" "\
Move one page up." t nil)

(autoload 'exwm-firefox-core-page-down "exwm-firefox-core" "\
Move one page down." t nil)

(autoload 'exwm-firefox-core-page-down-select "exwm-firefox-core" "\
Move one page down and select." t nil)

(autoload 'exwm-firefox-core-half-page-down "exwm-firefox-core" "\
Move down half a page." t nil)

(autoload 'exwm-firefox-core-half-page-up "exwm-firefox-core" "\
Move up half a page." t nil)

(autoload 'exwm-firefox-core-half-page-down-select "exwm-firefox-core" "\
Move down half a page and select." t nil)

(autoload 'exwm-firefox-core-half-page-up-select "exwm-firefox-core" "\
Move up half a page and select." t nil)

(autoload 'exwm-firefox-core-history-forward "exwm-firefox-core" "\
Forward in history.

\(fn &optional ARG)" t nil)

(autoload 'exwm-firefox-core-history-back "exwm-firefox-core" "\
Back in history.

\(fn &optional ARG)" t nil)

(autoload 'exwm-firefox-core-history-sidebar "exwm-firefox-core" "\
Forward in history." t nil)

(autoload 'exwm-firefox-core-history-menu "exwm-firefox-core" "\
Forward in history." t nil)

(autoload 'exwm-firefox-core-home-page "exwm-firefox-core" "\
Goto home page." t nil)

(autoload 'exwm-firefox-core-reload "exwm-firefox-core" "\
Reload page." t nil)

(autoload 'exwm-firefox-core-reload-override-cache "exwm-firefox-core" "\
Reload page, override cache." t nil)

(autoload 'exwm-firefox-core-tab-close "exwm-firefox-core" "\
Close tab." t nil)

(autoload 'exwm-firefox-core-tab-close-undo "exwm-firefox-core" "\
Undo close tab." t nil)

(autoload 'exwm-firefox-core-tab-new "exwm-firefox-core" "\
New tab." t nil)

(autoload 'exwm-firefox-core-tab-next "exwm-firefox-core" "\
Next tab." t nil)

(autoload 'exwm-firefox-core-tab-previous "exwm-firefox-core" "\
Previous tab." t nil)

(autoload 'exwm-firefox-core-tab-first "exwm-firefox-core" "\
First tab." t nil)

(autoload 'exwm-firefox-core-tab-last "exwm-firefox-core" "\
Last tab." t nil)

(autoload 'exwm-firefox-core-tab-move-right "exwm-firefox-core" "\
Move tab right." t nil)

(autoload 'exwm-firefox-core-tab-move-left "exwm-firefox-core" "\
Move tab left." t nil)

(autoload 'exwm-firefox-core-tab-mute "exwm-firefox-core" "\
Mute tab." t nil)

(autoload 'exwm-firefox-core-window-new "exwm-firefox-core" "\
New window." t nil)

(autoload 'exwm-firefox-core-window-new-private "exwm-firefox-core" "\
New private window." t nil)

(autoload 'exwm-firefox-core-window-close "exwm-firefox-core" "\
Close window." t nil)

(autoload 'exwm-firefox-core-window-close-undo "exwm-firefox-core" "\
Undo close window." t nil)

(autoload 'exwm-firefox-core-find "exwm-firefox-core" "\
Find." t nil)

(autoload 'exwm-firefox-core-quick-find "exwm-firefox-core" "\
Quick find." t nil)

(autoload 'exwm-firefox-core-find-next "exwm-firefox-core" "\
Find next." t nil)

(autoload 'exwm-firefox-core-find-previous "exwm-firefox-core" "\
Find previous." t nil)

(autoload 'exwm-firefox-core-copy "exwm-firefox-core" "\
Copy text." t nil)

(autoload 'exwm-firefox-core-cut "exwm-firefox-core" "\
Cut text." t nil)

(autoload 'exwm-firefox-core-paste "exwm-firefox-core" "\
Paste text." t nil)

(autoload 'exwm-firefox-core-delete "exwm-firefox-core" "\
Delete text." t nil)

(autoload 'exwm-firefox-core-undo "exwm-firefox-core" "\
Undo." t nil)

(autoload 'exwm-firefox-core-redo "exwm-firefox-core" "\
Redo." t nil)

(autoload 'exwm-firefox-core-forward-word "exwm-firefox-core" "\
Move word forward." t nil)

(autoload 'exwm-firefox-core-back-word "exwm-firefox-core" "\
Move word backward." t nil)

(autoload 'exwm-firefox-core-forward-word-select "exwm-firefox-core" "\
Move word forward and select." t nil)

(autoload 'exwm-firefox-core-back-word-select "exwm-firefox-core" "\
Move word backward and select." t nil)

(autoload 'exwm-firefox-core-select-all "exwm-firefox-core" "\
Select whole page." t nil)

(autoload 'exwm-firefox-core-bookmark-new "exwm-firefox-core" "\
Create new bookmark." t nil)

(autoload 'exwm-firefox-core-bookmark-sidebar "exwm-firefox-core" "\
Open bookmark sidebar." t nil)

(autoload 'exwm-firefox-core-bookmark-menu "exwm-firefox-core" "\
Open bookmark menu." t nil)

(autoload 'exwm-firefox-core-focus-search-bar "exwm-firefox-core" "\
Toggle focus between the search bar and the page." t nil)

(autoload 'exwm-firefox-core-toggle-focus-search-bar "exwm-firefox-core" "\
Toggle focus between the search bar and the page." t nil)

(autoload 'exwm-firefox-core-cancel "exwm-firefox-core" "\
General cancel action." t nil)

(autoload 'exwm-firefox-core-open-file "exwm-firefox-core" "\
Open file." t nil)

(autoload 'exwm-firefox-core-save-page "exwm-firefox-core" "\
Save page to file." t nil)

(autoload 'exwm-firefox-core-quit "exwm-firefox-core" "\
Quit firefox." t nil)

(autoload 'exwm-firefox-core-downloads-menu "exwm-firefox-core" "\
Open downloads menu." t nil)

(autoload 'exwm-firefox-core-reader-mode "exwm-firefox-core" "\
Open current page in firefox reader-mode." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "exwm-firefox-core" '("exwm-firefox-core-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; exwm-firefox-core-autoloads.el ends here

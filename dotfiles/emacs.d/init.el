;; NOTE: This file is generated from emacs.org

(setq gc-cons-threshold (* 1 1000 1000 1000))

(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;;; init.el
;; NOTE: This file is generated from emacs.org

(add-to-list 'load-path "~/.emacs.d/lisp")

(setq package-native-compile t)

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :after gcmh
  :custom
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq make-backup-files nil)
(setq auto-save-default nil)

(use-package restart-emacs
  :commands (restart-emacs))

(use-package async
  :init (dired-async-mode 1))

(setq inhibit-startup-message t)
(setq confirm-kill-processes nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)

(blink-cursor-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(menu-bar-mode 0)

(set-fringe-mode 10)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(dolist (mode '(term-mode-hook
                org-mode-hook
                markdown-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package good-scroll
  :config
  (good-scroll-mode 1))

(set-face-attribute 'default nil
  :family "Hack Nerd Font Mono"
  :height 120)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
  :family "Hack Nerd Font Mono"
  :height 1.0)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
  :family "NotoSans Nerd Font"
  :height 1.0)

(use-package mixed-pitch
  :hook (text-mode . mixed-pitch-mode))

;; Good Dark Themes: doom-moonless doom-tomorrow-night
;; Good Light Themes: doom-acario-light
(use-package doom-themes)
(use-package ewal-doom-themes
  :config (progn
    (load-theme 'ewal-doom-vibrant t)
    (enable-theme 'ewal-doom-vibrant)))
(use-package ewal-evil-cursors
  :after ewal-doom-themes)

(defconst frameTransparency 80)

(defun transparency/on ()
    (interactive)
    (set-frame-parameter
     (selected-frame) 'alpha
     '(80 . 100))
    (add-to-list
     'default-frame-alist
     '(alpha . (80 . 100))))

(defun transparency/off ()
    (interactive)
    (set-frame-parameter (selected-frame) 'alpha '(100 . 100))
    (add-to-list 'default-frame-alist '(alpha . (100 . 100))))

(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(use-package all-the-icons)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  ;; (setq dashboard-startup-banner nil)
  (setq dashboard-week-agenda t)
  (setq initial-buffer-choice 
        (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-set-init-info t)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5))))

(use-package fcitx
  :config
  (fcitx-aggressive-setup)
  (setq fcitx-use-dbus t))

(use-package edwina
  :config
  :after exwm
  :config
  (setq display-buffer-base-action
        '(display-buffer-below-selected))
  (edwina-setup-dwm-keys 'super)
  (edwina-mode 1))

(use-package buffer-move
  :commands (buf-move-up
             buf-move-down
             buf-move-left
             buf-move-right))
(global-set-key [?\s-k] 'buf-move-up)
(global-set-key [?\s-j] 'buf-move-down)
(global-set-key [?\s-h] 'buf-move-left)
(global-set-key [?\s-l] 'buf-move-right)

(use-package frames-only-mode
  :config
  (frames-only-mode))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 1)
  (doom-modeline-bar-width 2)
  (defcustom doom-modeline-hud nil)
  (doom-modeline-window-width-limit 'fill-column)
  
  (doom-modeline-buffer-file-name-style 'auto)
  (doom-modeline-irc-stylize 'identity)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-vcs-max-length 12)
  (doom-modeline-number-limit 99)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-indent-info nil)
  (doom-modeline-persp-icon nil)
  (doom-modeline-workspace-name nil)
  (doom-modeline-lsp nil)
  (doom-modeline-icon t)
  (doom-modeline-color-icon t)
  (doom-modeline-github nil)
  (doom-modeline-env-version nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-major-mode-color-icon nil)
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-minor-modes nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-gnus-timer nil)
  (doom-modeline-github-timer nil)
  (doom-modeline-buffer-encoding nil))
  ;; (set-face-attribute 'mode-line nil :height 0.9)
  ;; (set-face-attribute 'mode-line-inactive nil :height 0.9)

(defun wallpaper/use-default ()
  (interactive)
  (start-process-shell-command
   "feh" nil "feh --bg-scale $BACKGROUNDS/nge1.jpeg"))

(defun wallpaper/set ()
  (interactive)
  (start-process-shell-command
   "feh" nil (concat "feh --bg-scale " (counsel-find-file))))

(defvar polybar/process nil
  "Holds the process of the running Polybar instance, if any")

(defun polybar/kill ()
  (interactive)
  (when polybar/process
    (ignore-errors
      (kill-process polybar/process)))
  (setq polybar/process nil))

(defun polybar/start ()
  (interactive)
  (polybar/kill)
  (setq polybar/process
        (start-process-shell-command
         "polybar" nil "polybar exwm")))

(defconst transsetDefault ".6")
(defun transset/on ()
  (interactive)
  (dolist (id (butlast
               (split-string
                (shell-command-to-string
                 "wmctrl -l | cut -f -1 -d ' '")
                "\n")))
    (start-process "transset" nil
     "transset" "-i" id transsetDefault)))

(defun transset/off ()
  (interactive)
  (dolist (id (butlast
               (split-string
                (shell-command-to-string
                 "wmctrl -l | cut -f -1 -d ' '")
                "\n")))
    (start-process "transset" nil
                   "transset" "-i" id "1")))

(defun process/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil
                            ,@(cdr command-parts)))))

(defun exwm/start-polybar ()
    (polybar/start)
    (add-hook 'exwm-workspace-switch-hook
              #'polybar/send-exwm-workspace))

(defun polybar/send-hook (module-name hook-index)
  (start-process-shell-command
   "polybar-msg" nil
   (format "polybar-msg hook %s %s" module-name hook-index)))

(defun polybar/send-exwm-workspace ()
  (polybar/send-hook "exwm-workspace" 1))

;; Let emacs handle queries for gpg passwords
(defun pinentry-emacs (desc prompt ok error)
  (let ((str (read-passwd
              (concat (replace-regexp-in-string
                       "%22" "\"" (replace-regexp-in-string
                                   "%OA" "\n" desc)) prompt ": "))))
    str))

(defun exwm/set-prefix-keys ()
  (setq exwm-input-prefix-keys
        '(?\C-x   ;; Basic Emacs Prefix
          ?\M-x   ;; Basic Emacs Prefix
          ?\C-h   ;; Help Prefix
          ?\C-\;  ;; Change Input Method
          ?\C-u   ;;
          ?\C-w   ;; Change Window
          ?\M-:   ;; Eval expression
          
          ;; Move Buffers
          ?\s-J
          ?\s-k

          ;; Grow Window
          ?\s-h
          ?\s-l

          ?\s-C

          ;; Switch Buffers
          ?\s-j
          ?\s-k
          
          ?\M-p       ;; Open X-Application
          ?\s-P       ;; Open X-Application in new window

          ?\:
          escape
          ?\C-\M-j
          ?\C-\ )))

(defun exwm/set-global-keys ()
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to
          ;; char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Launch applications via shell command
          ([?\s-p] . (lambda (command)
                       (interactive
                        (list (read-shell-command "$ ")))
                       (start-process-shell-command
                        command nil command)))
          ([?\s-w] . exwm-workspace-switch)

          ;; Fullscreen and Floating Windows
          ([?\s-f] . exwm-layout-toggle-fullscreen)
          ([?\s-F] . exwm-floating-toggle-floating)

          ;; Switch between line mode and char mode
          ([?\s-i] . exwm-input-toggle-keyboard)

          ;; 's-N': Switch to certain workspacw with Super 
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i )) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))
          ;; Switch to workspace 0 using S-`
          ([?\s-`] . (lambda () (interactive)
                       (exwm-workspace-switch-create 0)))

          )))

(defun exwm/update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(defun exwm/update-title ()
  (pcase exwm-class-name
    ("qutebrowser" (exwm-workspace-rename-buffer exwm-title))
    ("baka-mplayer" (exwm-workspace-rename-buffer exwm-title))
    ("firefox" (exwm-workspace-rename-buffer exwm-title))))

(defun exwm/position-window (x y)
  (interactive)
  (let* ((pos (frame-position))
         (pos-x (car pos))
         (pos-y (cdr pos)))
    (exwm-floating-move
     (+ (- pos-x) x) (+ (- pos-y) y))))

(when (get-buffer "*window-manager*")
  (kill-buffer "*window-manager*"))
(when (get-buffer "*window-manager-error*")
  (kill-buffer "*window-manager-error*"))
(when (executable-find "wmctrl")
  (shell-command
   "wmctrl -m ; echo $?"
   "*window-manager*"
   "*window-manager-error*"))

(when (and (get-buffer "*window-manager-error*")
           (eq window-system 'x)) 
  (use-package exwm
    :config
    (add-hook 'exwm-update-class-hook #'exwm/update-class)
    (add-hook 'exwm-update-title-hook #'exwm/update-title)
    (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
    (setq exwm-workspace-number 5)
    (transparency/on)
    ;(setq exwm-layout-show-all-buffers t)
    ;(setq exwm-workspace-show-all-buffers t)
    (require 'exwm-systemtray)
    (exwm-systemtray-enable)
    (setq exwm-systemtray-height 32)

    (custom-set-variables
     '(exwm-manage-configurations
       '(((and
           (stringp exwm-class-name)
           (string-match-p "qutebrowser" exwm-class-name))
          floating-mode-line nil tiling-mode-line  nil))))
    
    (exwm/set-prefix-keys)
    (exwm/set-global-keys)
    (server-start)
    (setf epg-pinentry-mode 'loopback)
    (exwm/start-polybar)
    (exwm-enable)))

(use-package exwm-firefox-evil
  :after exwm
  :hook (exwm-manage-finish-hook
         . exwm-firefox-evil-activate-if-firefox))

(use-package bluetooth)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-;") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "C-;") 'keyboard-quit)
  (define-key evil-insert-state-map (kbd "C-h")
    'evil-delete-backward-char-and-join)

  (define-key evil-motion-state-map
    (kbd "<remap> <evil-next-line>") #'evil-next-visual-line)
  (define-key evil-motion-state-map
    (kbd "<remap> <evil-previous-line>") #'evil-previous-visual-line)
  (define-key evil-operator-state-map
    (kbd "<remap> <evil-next-line>") #'evil-next-line)
  (define-key evil-operator-state-map
    (kbd "<remap> <evil-previous-line>") #'evil-previous-line)
  (global-unset-key (kbd "C-x ESC"))
  (global-unset-key (kbd "C-c ESC")))

;; (dolist (mode '(term-mode-hook
;;                 org-mode-hook
;;                 shell-mode-hook
;;                 treemacs-mode-hook
;;                 eshell-mode-hook
;;                 vterm-mode-hook))
;;   (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-create-definer my/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my/leader-keys
    "tt" '(counsel-load-theme)))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1))

(use-package ivy-posframe
  :after ivy
  :config
  (setq ivy-posframe-width (frame-width)
        ivy-posframe-height (/ (frame-height) 5))
  (setq ivy-posframe-display-functions-alist
        '((t . ivy-posframe-display-at-frame-bottom-left)))
  (set-face-attribute
   'ivy-posframe nil
   :foreground "white"
   :background "black")
  (ivy-posframe-mode 1))

(use-package ivy-clipmenu)

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function
   #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package helpful
  :commands (helpful-callable
             helpful-variable
             helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package focus)

(use-package solaire-mode
  :config
  (solaire-global-mode 1))

(defun org/font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region
                    (match-beginning 1)
                    (match-end 1) "•")))))))

(use-package org-roam
  :custom
  (org-roam-directory "~/RoamNotes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(setq-default
 help-window-select t
 debug-on-error t
 indent-tabs-mode nil
 jit-lock-defer-time 0
 window-combination-resize t
 history-delete-duplicates t)

(defun org/setup ()
  (org-indent-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . org/setup)
  :config
  (org/font-setup)
  (setq-default
   org-ellipsis " ▾"
   org-pretty-entities t
   org-hide-emphasis-markers t
   org-edit-src-content-indentation 0))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list
   '("◉" "○" "●" "○" "●" "○" "●")))

(setq-default fill-column 80)
(use-package olivetti
  :hook (org-mode . olivetti-mode)
  :hook (markdown-mode . olivetti-mode))

(use-package org-download
  :after org
  :config
  (org-download-enable))

(use-package auctex
  :defer t
  :config
  (setq TeX-auto-save t
        TeX-parse-self t)
  (setq org-format-latex-options (plist-put org-format-latex-options
                                            :scale 2.0)))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (haskell . t)
     (shell . t)))
  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("hs" . "src haskell")))

(defun babel/tangle-config ()
  (when (member (file-name-nondirectory (buffer-file-name))
                '("emacs.org"
                  "config.org"))
    (let ((org-confirm-babel-evaluate nil)) (org-babel-tangle)))) 

(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook #'babel/tangle-config)))

(use-package org-alert
  :ensure t
  :config
  (setq alert-default-style 'libnotify
        org-alert-notify-cutoff (* 2 24 60 60))
  (org-alert-enable))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path '("~/Repositories")
        projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1))

;; (use-package forge
;;  :after magit)

(use-package evil-commentary
  :config (evil-commentary-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :config (show-paren-mode 1))

(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode t))

(defun lsp/mode-setup ()
  (setq lsp-headerline-breadcrumb-segments
        '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . lsp/mode-setup)
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package company
  :defer t
  :after lsp
  :init (global-company-mode t)
  :config
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
              ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-alh --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :after dired)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :after dired
  :config
  (setq dired-open-extensions
        '(("png" . "feh")
          ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(use-package treemacs
  :after general
  :config
  (my/leader-keys
    "C-d" 'treemacs))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-persp
  :after (treemacs persp-mode))

(use-package vimrc-mode
  :mode "\\.vim\\'")

(use-package haskell-mode
  :mode "\\.hs\\'")

(use-package json-mode)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode-hook . lsp-deferred))

(use-package make-mode
  :mode (("Makefile" . makefile-gmake-mode)))

(use-package transient)
(use-package pyvenv)
(use-package poetry)

(use-package verilog-mode
  :defer t
  :config
  (require 'lsp)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("svls"))
   :major-modes '(verilog-mode)
   :priority -1
   ))
  :hook (verilog-mode . (lambda()
      (lsp)
      (flycheck-mode t)
      (add-to-list 'lsp-language-id-configuration '(verilog-mode . "verilog")))))

(use-package make-mode
  :mode (("Makefile" . makefile-gmake-mode)))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "zsh"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "zsh")
  (setq vterm-max-scrollback 10000))

(use-package notmuch)

(setq gc-cons-threshold (* 1 1000 1000 1000))
(setq garbage-collection-messages t)

(setq file-name-handler-alist
      file-name-handler-alist-original)

(use-package gcmh
  :config
  (setq gcmh-high-cons-threshold (* 100 1000 1000))
  (gcmh-mode 1))

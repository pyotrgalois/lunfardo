;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message "guerry")

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(load-theme 'misterioso)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'cl)
;; Guarantee all packages are installed on start
(defvar packages-list
  '(rainbow-mode
    rainbow-delimiters
    multiple-cursors
    whitespace-cleanup-mode
    restclient
    httprepl
    flycheck
    projectile
    project-explorer
    smartparens
    yasnippet
    jedi
    ido-vertical-mode
    ace-jump-mode
    highlight-indentation
    highlight-symbol
    smex
    undo-tree
    flx-ido
    rvm)
  "List of packages needs to be installed at launch")

(defun has-package-not-installed ()
  (loop for p in packages-list
        when (not (package-installed-p p)) do (return t)
        finally (return nil)))
(when (has-package-not-installed)
  ;; Check for new packages (package versions)
  (message "%s" "Get latest versions of all packages...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; Install the missing packages
  (dolist (p packages-list)
    (when (not (package-installed-p p))
      (package-install p))))

(add-to-list 'load-path user-emacs-directory)
(require 'sane-defaults)
(require 'key-bindings)

(require 'ido)
(ido-mode 1)
(ido-everywhere 1)

(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-use-faces nil)

(projectile-global-mode)
(ido-vertical-mode 1)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; load-path で ~/.emacs.d とか書かなくてよくなる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; 行番号表示
(global-linum-mode t)
;;ツールバー非表示
(when (display-graphic-p)
  (tool-bar-mode -1))
;;Font
(set-fontset-font t 'japanese-jisx0208 "Ricty-Regular")
;; color-theme
(load-theme 'manoj-dark t)
;;警告音off
(setq ring-bell-function 'ignore)
;;点滅対策
(setq redisplay-dont-pause nil)
;; 対応する括弧を光らせる。
(show-paren-mode 1)
;;; 現在行を目立たせる ハイライト
(global-hl-line-mode)

;; "C-t"でウインドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; buffer-expose
 (defvar buffer-expose-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<s-tab>") 'buffer-expose)
    (define-key map (kbd "<C-tab>") 'buffer-expose-no-stars)
    (define-key map (kbd "C-c <C-tab>") 'buffer-expose-current-mode)
    (define-key map (kbd "C-c C-m") 'buffer-expose-major-mode)
    (define-key map (kbd "C-c C-d") 'buffer-expose-dired-buffers)
    (define-key map (kbd "C-c C-*") 'buffer-expose-stars)
    map)
  "Mode map for command `buffer-expose-mode'.")

(require 'package)
(setq package-archives
  '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
;  '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages (quote (git-gutter+ ## buffer-expose))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

  ;;straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
  
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; ~/.emacs.d/init/ 以下のファイルを全部読み込む
(use-package init-loader)
(init-loader-load "~/.emacs.d/init")
;;dashboard
(straight-use-package 'dashboard)
(dashboard-setup-startup-hook)

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        ;;(projects . 5)
                        ;;(agenda . 5)
                        ;;(registers . 5)
                        ))
;; company                        
(use-package company
    :init
    (setq company-selection-wrap-around t)
    :bind
    (:map company-active-map
        ("M-n" . nil)
        ("M-p" . nil)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-h" . nil))
    :config
    (global-company-mode))
;; Undo関連
(straight-use-package 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo) ;; redo
(straight-use-package 'flycheck)
(global-flycheck-mode)
(straight-use-package 'dimmer)
(dimmer-mode)
;;(dimmer-use-colorspace '0.7)
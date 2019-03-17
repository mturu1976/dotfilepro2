;; init.el --- Commentary:Mac用のinit.el
;; Copyright(c) 2019 by Hidenori Akiyama

;; Author:Hidenori Akiyama<marusez@gmail.com>
;; URL: 
;; Version: 0.01
;;; Code:

;;load-path で ~/.emacs.d とか書かなくてよくなる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; 行番号表示
					;(global-linum-mode t)
;;バッファの再読み込み
(global-auto-revert-mode 1)

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

;; ファイル末尾の改行を削除

;; "C-t"でウインドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;;Ctrl+TAB で次のバッファーへ移動する
;;(global-set-key (kbd "<C-tab>") 'next-buffer)

;;yesをyにする
(defalias 'yes-or-no-p 'y-or-n-p)
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

;; dimmer
(straight-use-package 'dimmer)
(use-package dimmer
  :init
    (dimmer-mode t)
  :config
    (setq dimmer-fraction '0.34)
)

;;Color Identifiers Mode
(straight-use-package 'color-identifiers-mode)
(add-hook 'after-init-hook 'global-color-identifiers-mode)
;; (defun myfunc-color-identifiers-mode-hook ()
;;   (let ((faces '(font-lock-comment-face font-lock-comment-delimiter-face font-lock-constant-face font-lock-type-face font-lock-function-name-face font-lock-variable-name-face font-lock-keyword-face font-lock-string-face font-lock-builtin-face font-lock-preprocessor-face font-lock-warning-face font-lock-doc-face font-lock-negation-char-face font-lock-regexp-grouping-construct font-lock-regexp-grouping-backslash)))
;;     (dolist (face faces)
;;       (face-remap-add-relative face '((:foreground "" :weight normal :slant normal)))))
;;   (face-remap-add-relative 'font-lock-keyword-face '((:weight bold)))
;;   (face-remap-add-relative 'font-lock-comment-face '((:slant italic)))
;;   (face-remap-add-relative 'font-lock-builtin-face '((:weight bold)))
;;   (face-remap-add-relative 'font-lock-preprocessor-face '((:weight bold)))
;;   (face-remap-add-relative 'font-lock-function-name-face '((:slant italic)))
;;   (face-remap-add-relative 'font-lock-string-face '((:slant italic)))
;;   (face-remap-add-relative 'font-lock-constant-face '((:weight bold))))
;; (add-hook 'color-identifiers-mode-hook 'myfunc-color-identifiers-mode-hook)

;;junknote
(straight-use-package 'open-junk-file)
(use-package open-junk-file
  ;;(setq open-junk-file-format "~/Dropbox/emacs/junk/%Y-%m%d-%H%M%S.org")
  ;;(setq open-junk-file-format "~/Dropbox/emacs/junk/%Y-%m%d-memo.org") ;;今まで通りの設定
  ;;(setq open-junk-file-format "~/Dropbox/アプリ/synchronator-pomeradm200/junk/%Y-%m%d-memo.org") ;;pomera
  :config (setq open-junk-file-format "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/%Y-%m%d-memo.org") ;;beorg
  :bind (("\C-xj". 'open-junk-file)
  )
)

(straight-use-package 'volatile-highlights)
(use-package volatile-highlights

)
;;beacon
(straight-use-package 'beacon)
(use-package beacon
  :init
    (beacon-mode 1)
  :config
    (setq beacon-color "red")
)


;;All The Icons
(use-package all-the-icons :ensure t)

;; neotree
(straight-use-package 'neotree)
(use-package neotree
  :init
  (setq neo-show-hidden-files t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (bind-keys([f8]. neotree-toggle)
)
)
;;writeroom-mode
(straight-use-package 'writeroom-mode)
(use-package writeroom-mode
  :init
  (bind-keys([f9]. writeroom-mode)
  )
)

;;emacs-which-key

;;scrapbox
(defun my-index-scrapbox ()
	(interactive)
	(async-shell-command
		"/Users/siroen/Documents/projects/dotfilepro2/packages/scrapbox-on-emacs-sample-master/get_scrapbox_page_titles.sh"))

;; coding pyhon
(use-package elpy
  :commands python-mode
  :config
  (setq elpy-rpc-python-command "python3")
  (elpy-enable))

(use-package jedi
  :disabled t
  :after python-mode)



;; coding php
(straight-use-package 'php-mode)
(use-package php-mode :ensure t
  :mode
  ("\\.php\\'" . php-mode)
  ("\\.inc\\'" . php-mode)
  :config
  (progn
    (use-package ac-php
      :ensure t)
    (use-package php-eldoc
      :ensure t
      :after php-mode)
    )
  )

(straight-use-package 'cl)
(use-package cl

)

(straight-use-package 'company-php)
(use-package company-php)

;; phpmode
(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
;;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; php関連をuse-packageで綺麗に書きたい

;;helm
(straight-use-package 'helm)
(use-package helm
 :bind (("M-y" . helm-show-kill-ring)
         ("C-x C-f" . helm-find-files)
         ("C-x C-r" . helm-recentf)
         ("C-h" . helm-ff-delete-char-backward)
   ;;      ("TAB" . helm-execute-persistent-action)
         ("TAB" . helm-find-files-map)
)
 :config (setq dumb-jump-selector 'ivy)
 ;;:ensure t
  )

;; dumb-jump
(straight-use-package 'dumb-jump)
(use-package dumb-jump
 :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
 :config 
;;(setq dumb-jump-selector 'ivy)
(setq dumb-jump-selector 'helm)
 ;;:ensure t
  )

;;yaml
(straight-use-package 'yaml-mode)
(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" . yaml-mode)
)

;; auto-package-update
(use-package auto-package-update
  :ensure t
  :bind ("C-x P" . auto-package-update-now)
  :config
(setq auto-package-update-delete-old-versions t))

;;markdown
(straight-use-package 'markdown-mode)
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("CONTRIBUTING\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
:init (setq markdown-command "multimarkdown"))

;;(straight-use-package 'flymake-yaml)
;;(use-package flymake-yaml

;;)


;;project
(straight-use-package 'projectile)
(projectile-global-mode)

;;行番号
(straight-use-package 'nlinum)
(use-package linum
:init
(add-hook 'after-init-hook 'global-linum-mode t)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))
(setq linum-disabled-modes-list
 	'(eshell-mode
	  wl-summary-mode
	  compilation-mode
	  dired-mode
	  doc-view-mode
	  image-mode
	  pdf-view-mode
	  eww-mode)))

;;スムーズにスクロールさせる
(straight-use-package 'smooth-scroll)
(use-package smooth-scroll
  :disabled t
  :config
  (smooth-scroll-mode t))

;;; init.el ends here

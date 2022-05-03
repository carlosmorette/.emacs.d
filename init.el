;;; Emacs config
;;; Carlos Morette

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-linum-mode t)
(global-hl-line-mode t)

; melpa
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))

; Syntax highlight
(use-package alchemist
  :ensure t
  :config
  (elixir-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode))

; Code navigation and more...
(use-package ido
  :config
  (ido-mode t))
	
(use-package neotree
  :ensure t
  :bind
  ("C-\\" . neotree-toggle))
 
(use-package web-mode
  :ensure t
  :config
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode)))

;; UI show error
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package color-theme-sanityinc-tomorrow
  :ensure t)

;; Tab
((lambda ()
   (tab-bar-mode)
   (global-set-key (kbd "C-c n") 'tab-bar-switch-to-next-tab)
   (global-set-key (kbd "C-c b") 'tab-bar-switch-to-prev-tab)

   (global-set-key (kbd "C-c j") 'tab-bar-new-tab)
   (global-set-key (kbd "C-c k") 'tab-bar-close-tab)))


; Find something in the project
(use-package deadgrep
  :ensure t
  :config
  (global-set-key (kbd "<f5>") #'deadgrep))

(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  (add-to-list 'exec-path "elixir-config/elixir-ls-1.12")
  (setq lsp-elixir-suggest-specs nil))

; Show error in UI
(use-package lsp-ui
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package racket-mode
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets")))


(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\postgres_data\\'"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-night))
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default))
 '(package-selected-packages
   '(yasnippet color-theme-sanityinc-tomorrow racket-mode haskell-mode lsp-ui lsp-mode deadgrep spacemacs-theme flycheck web-mode neotree alchemist which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

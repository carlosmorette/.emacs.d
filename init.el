
;; TODO: Configurar lsp-ui para conseguir acessar facilmente as declaracoes e para ele mostrar warnings e mensagens de erro na linha
;; TODO: Desabilitar C-z

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
  (add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode)))

; UI show error
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package spacemacs-theme
  :defer t
  :ensure t)

(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "slant")
  :bind
  ("C-c n" . centaur-tabs-forward)
  ("C-c b" . centaur-tabs-backward)
  ("C-c j" . 'centaur-tabs--create-new-tab))

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
  (add-to-list 'exec-path "elixir-config/elixir-ls-1.12"))

; Show error in UI
(use-package lsp-ui
  :ensure t)

(use-package haskell-mode
  :ensure t)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\postgres_data\\'"))

;; emacs stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#080808" "#d70000" "#67b11d" "#875f00" "#268bd2" "#af00df" "#00ffff" "#b2b2b2"])
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "ba72dfc6bb260a9d8609136b9166e04ad0292b9760a3e2431cf0cd0679f83c3a" "41098e2f8fa67dc51bbe89cce4fb7109f53a164e3a92356964c72f76d068587e" default))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2aa198")
     ("PROG" . "#268bd2")
     ("OKAY" . "#268bd2")
     ("DONT" . "#d70000")
     ("FAIL" . "#d70000")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#875f00")
     ("KLUDGE" . "#875f00")
     ("HACK" . "#875f00")
     ("TEMP" . "#875f00")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(org-fontify-done-headline nil)
 '(org-fontify-todo-headline nil)
 '(package-selected-packages
   '(haskell-mode deadgrep ewal-spacemacs-themes flycheck web-mode neotree alchemist which-key use-package))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#262626")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

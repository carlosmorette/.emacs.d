;;; init.el --- My config file                       -*- lexical-binding: t; -*-

;; Copyright (C) 2022  morette

;; Author: morette;;; init.el <carlos.morette@outlook.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This module contains my personal config file

;;; Code:

(provide 'init)

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-linum-mode t)
(scroll-bar-mode -1)
;; (global-hl-line-mode t)

; melpa
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

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
  (erlang-mode . lsp)
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

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
	 (typescript-mode . tide-hl-identifier-mode)
	 (before-save . tide-format-before-save)))

;; tide config
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal (or "tsx" "ts") (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\postgres_data\\'"))

(use-package clojure-mode
  :ensure t)

(setq erlang-indent-level 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(beacon-color "#cc6666")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(gruvbox-dark-soft))
 '(custom-safe-themes
   '("e80b1078c4ce2225f6f8d7621a55d3b675c86cad505b22b20243d4d075f491f5" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "6bdcff29f32f85a2d99f48377d6bfa362768e86189656f63adbf715ac5c1340b" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "a3e99dbdaa138996bb0c9c806bc3c3c6b4fd61d6973b946d750b555af8b7555b" "dcdeb40026f98c4b4b5a4545736cd3716e70e3183b66c29493f87a52c5eee081" "3a2e0c5597f6d74d99daa2b5bbbc2a653d02d6b88fcd73d3c84ebf25cde37b3f" "10a4bd4ea3de6e62ada1aa793526e4f86a9cd3bde5eda7b21d345ab09d09598a" "d683be98842eb8ea4d3dc6dc53c87eec23fdd8586431b05fa3106014c03c7af0" "e9e7dddb7a23bf9d108863ef25f4abdda0b09a18beabb0edd0ac2c22fc9c22c9" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(tron-legacy-theme kotlin-mode erlang exwm flycheck-credo clojure-mode cider gruvbox-theme tide yasnippet color-theme-sanityinc-tomorrow racket-mode haskell-mode lsp-ui lsp-mode deadgrep spacemacs-theme flycheck web-mode neotree which-key use-package))
 '(pdf-view-midnight-colors '("#282828" . "#f2e5bc"))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:extend t :background "black")))))

;;; init.el ends here

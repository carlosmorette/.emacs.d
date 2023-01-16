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
 '(custom-enabled-themes '(moe-dark))
 '(custom-safe-themes
   '("df1cbfd16a8af6e821c3299d92c84a0601e961f1be6efd761d6dd40621fde9eb" "d537a9d42c6f5349d1716ae9be9a0645cc168f7aff2a8353819d570e5d02c0b3" "3c451787cee570710bff441154a7db8b644cdbb7d270189b2724c6041a262381" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-prompt ((t (:background "magenta" :foreground "color-16")))))

;;; init.el ends here

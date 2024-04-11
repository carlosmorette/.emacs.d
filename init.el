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

(defconst erlang-indent-level 2)
(defconst js-indent-level 2)

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-linum-mode t)
(scroll-bar-mode -1)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Tab
((lambda ()
   (tab-bar-mode)
   (global-set-key (kbd "C-c n") 'tab-bar-switch-to-next-tab)
   (global-set-key (kbd "C-c b") 'tab-bar-switch-to-prev-tab)

   (global-set-key (kbd "C-c j") 'tab-bar-new-tab)
   (global-set-key (kbd "C-c k") 'tab-bar-close-tab)))

;; melpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(eval-when-compile
  (require 'use-package))

(use-package seq
  :ensure t)

(setq package-install-upgrade-built-in t)
(progn (unload-feature 'seq t) (require 'seq))
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))

; Code navigation and more...
(use-package ido
  :config
  (ido-mode t))
	
;; UI show error
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (setq flycheck-elixir-credo-strict t))

; Find something in the project
(use-package deadgrep
  :ensure t
  :config
  (global-set-key (kbd "<f5>") #'deadgrep))

(use-package elixir-mode
  :ensure t)

(use-package lsp-mode
  :commands lsp
  :ensure t
  ;; :hook
  ;; (elixir-mode . lsp)
  ;; (java-mode . lsp)
  :init
  (add-to-list
   'exec-path
   "lsp/elixir-ls-0.20"
   "lsp/jdt-language-server-1.27.1-202309140221"))

; Show error in UI
(use-package lsp-ui
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets")))

(use-package clojure-mode
  :ensure t)

(use-package magit
  :ensure t)

;; Autocomplete
(use-package company
  :ensure t
  :config
  (global-company-mode))

(use-package javadoc-lookup
  :ensure t
  :config
  (global-set-key (kbd "C-h j") 'javadoc-lookup))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\postgres_data\\'"))
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(nova))
 '(custom-safe-themes
   '("fffd03886983720ef3e4dd2df3cb65b51fa9ab5ec7fb5d6b5da838e64da6cc7d" "1a6d120936f9df3f44953124dbf9e56b399e021702ca7d1844e6c5e1658b692b" "1bad38d6e4e7b2e6a59aef82e27639e7a1d8e8b06bbeac6730f3e492d4f5ba46" "551629d1e63bb66423dd80b3ec2d1a67611d1fa570e7238201e65b25a3b3834f" default))
 '(package-selected-packages
   '(javadoc-lookup nova-theme magit clojure-mode yasnippet lsp-ui lsp-mode elixir-mode deadgrep flycheck which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

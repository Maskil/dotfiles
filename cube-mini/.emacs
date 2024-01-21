(set-language-environment "utf-8")
(require 'package)
(require 'use-package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'same-window-buffer-names "*compilation*")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

;; fundemental settings
(add-to-list 'default-frame-alist '(height . 150))
(add-to-list 'default-frame-alist '(width . 150))
(set-frame-font "Inconsolata 18" nil t)
(setq inhibit-startup-screen t)
(menu-bar-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-so-long-mode 1)
(setq split-width-threshold nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq kill-whole-line t)
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq compilation-environment '("TERM=xterm-256color"))
(setq ring-bell-function 'ignore)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "s-<up>") 'toggle-frame-maximized)
;; (setq display-line-numbers-type 'relative)
;; (global-display-line-numbers-mode)

;;Compiling shit
(global-set-key (kbd "<f4>") 'arduino-mode)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)
(ignore-errors ; ANSI color
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))


;; tmp files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.Trash")))

;; lsp & company
(global-company-mode)
(setq company-idle-delay 0)

;; aucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'latex-math-mode)
(add-hook 'latex-mode-hook 'turn-on-reftex)
(setq reftx-plug-into-AUCTex t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(compile-command "zsh build.sh")
 '(custom-enabled-themes '(modus-vivendi-tritanopia))
 '(custom-safe-themes
   '("15604b083d03519b0c2ed7b32da6d7b2dc2f6630bef62608def60cdcf9216184" "58264887d7ab17702ef85bbd96e11bd7f613622ff9c63990be860b958c978f09" "c7737b9fc3471779c8e51ea0a37834d24aa80a0d6a79b215e7501227ada39855" default))
 '(highlight-indent-guides-method 'bitmap)
 '(lsp-clients-clangd-executable nil)
 '(package-selected-packages
   '(modus-themes skewer-mode multiple-cursors smtpmail-multi arduino-mode which-key company xterm-color magit highlight-indent-guides auto-sudoedit auctex anti-zenburn-theme))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-method 'bitmap))
(put 'narrow-to-region 'disabled nil)

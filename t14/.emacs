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
(set-frame-font "FreeMono 12" nil t)
(setq inhibit-startup-screen t)
(pixel-scroll-precision-mode t)
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
 '(custom-enabled-themes '(anti-zenburn))
 '(custom-safe-themes
   '("c171012778b7cf795ac215b91e1ecab8e3946738d03095397a790ed41e0a3386" "c7737b9fc3471779c8e51ea0a37834d24aa80a0d6a79b215e7501227ada39855" default))
 '(highlight-indent-guides-method 'bitmap)
 '(lsp-clients-clangd-executable nil)
 '(package-selected-packages
   '(modus-themes smtpmail-multi arduino-mode which-key company xterm-color magit highlight-indent-guides auto-sudoedit auctex anti-zenburn-theme))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-method 'bitmap))
(put 'narrow-to-region 'disabled nil)

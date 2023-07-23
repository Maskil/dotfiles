;; packages & formats
(require 'package)
(require 'use-package)
(require 'company)
(require 'jedi-core)
(require 'grip-mode)
(require 'markdown-mode)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'same-window-buffer-names "*compilation*")
(load "~/.emacs.d/compile-modes.el")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
(add-to-list 'load-path "~/.emacs.d/almost-mono-themes")
(add-to-list 'custom-theme-load-path "./.emacs.d/almost-mono-themes")


;; fundemental settings
(set-frame-font "Iosevka 14" nil t)
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(display-time)
(global-so-long-mode 1)
(setq split-width-threshold nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2) ; tab 2 spaces
(setq kill-whole-line t)
(electric-pair-mode 1) ; bracket pairing
(setq electric-pair-preserve-balance nil)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode) ; idention
(setq display-line-numbers-type 'relative) ; relative line number
(global-display-line-numbers-mode)

;; key-bindings
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")
(global-unset-key (kbd "C-z"))
(global-set-key  [C-backspace] 'backward-kill-char-or-word)

;; japanese
;;(require 'mozc)
;;(setq default-input-method "japanese-mozc")
;;(prefer-coding-system 'utf-8)

;; tmp files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.Trash")))

;; Company
(global-company-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)
(define-key company-active-map (kbd "C-f") 'company-complete-selection)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map [tab] 'company-complete-selection)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)

;; Markdown
(use-package grip-mode
  :ensure t
  :bind (:map markdown-mode-command-map
              ("g" . grip-mode)))
(setq grip-github-user "Maskil")
(setq grip-github-password "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")
(define-key markdown-mode-command-map (kbd "g") 'grip-mode)

;; aucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'latex-math-mode)
(add-hook 'latex-mode-hook 'turn-on-reftex)
(setq reftx-plug-into-AUCTex t)


;; shift tab 
(global-set-key (kbd "<backtab>") 'un-indent-by-removing-2-spaces)
(defun un-indent-by-removing-2-spaces ()
  "remove 2 spaces from beginning of of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;; get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
        (untabify (match-beginning 0) (match-end 0)))
      (when (looking-at "^    ")
        (replace-match "")))))

;; python indention (or it will guess)
(add-hook 'python-mode-hook #'(lambda ()
 (setq python-indent 2)))

(defun backward-kill-char-or-word ()
  (interactive)
  (if (looking-back "\\w" 1)
      (backward-kill-word 1)
    (backward-delete-char 1)))


;; other stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes '(almost-mono-gray))
 '(custom-safe-themes
   '("8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" "cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "d0fd069415ef23ccc21ccb0e54d93bdbb996a6cce48ffce7f810826bb243502c" "ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7" "13bfea3096a0bdc791cb2d992b5a93d93eeec3e1b2ae5a4f94f47aa48f35fb99" "bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" default))
 '(highlight-indent-guides-method 'bitmap)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(org-src-preserve-indentation nil)
 '(package-selected-packages
   '(magit latex-math-preview auctex use-package so-long mozc matlab-mode highlight-indent-guides gruber-darker-theme grip-mode flycheck exec-path-from-shell company-jedi auto-sudoedit))
 '(sql-sqlite-options nil)
 '(tex-start-options ""))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'magit-clean 'disabled nil)

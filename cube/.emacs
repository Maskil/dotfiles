(global-so-long-mode 1)
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "pat")
(require 'package)
(require 'use-package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-mozc")
(add-to-list 'same-window-buffer-names "*compilation*")
(load "~/.emacs.d/compile-modes.el")

(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

(set-face-attribute 'default nil :height 120)

;; japanese
(require 'mozc)
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)

;; tmp files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist            '((".*" . "~/.Trash")))

;; Company
(require 'company)
(require 'jedi-core)
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
(require 'grip-mode)
(require 'markdown-mode)
(use-package grip-mode
  :ensure t
  :bind (:map markdown-mode-command-map
              ("g" . grip-mode)))
(setq grip-github-user "Maskil")
(setq grip-github-password "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")
(define-key markdown-mode-command-map (kbd "g") 'grip-mode)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(package-initialize)

(menu-bar-mode 0)
(tool-bar-mode 0)
(display-time)
(setq split-width-threshold nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(ansi-color-faces-vector
     [default default default italic underline success warning error])
  '(ansi-color-names-vector
     ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes '(gruber-darker))
  '(custom-safe-themes
     '("bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" default))
 '(highlight-indent-guides-method 'bitmap)
 '(inhibit-startup-screen t)
 '(lisp-indent-offset 2)
  '(package-selected-packages
     '(matlab-mode so-long mozc company-jedi exec-path-from-shell markdown-mode use-package grip-mode highlight-indent-guides auto-sudoedit gruber-darker-theme))
 '(python-indent-guess-indent-offset t)
 '(python-indent-offset 2)
 '(sh-basic-offset 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

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

(add-hook 'python-mode-hook '(lambda ()
 (setq python-indent 2)))

(defun backward-kill-char-or-word ()
  "Delete the character or word before point."
  (interactive)
  (if (looking-back "\\w" 1)
      (backward-kill-word 1)
    (backward-delete-char 1)))

(global-set-key  [C-backspace]
								 'backward-kill-char-or-word)

(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

(add-hook 'c-mode-hook
					(lambda()
						(set (make-local-variable 'compile-command)
								 (concat "gcc -Wall " (shell-quote-argument (file-name-sans-extension buffer-file-name))))))

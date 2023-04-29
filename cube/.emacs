(require 'package)
(require 'use-package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))

(exec-path-from-shell-copy-env "PATH")

(exec-path-from-shell-initialize)

(setq shell-command-switch "-lc")

(require 'company)
(global-company-mode)
(define-key company-active-map (kbd "C-f") 'company-complete-selection)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map [tab] 'company-complete-selection)

;; Markdown
(require 'grip-mode)
(require 'markdown-mode)
(use-package grip-mode
  :ensure t
  :bind (:map markdown-mode-command-map
              ("g" . grip-mode)))
(setq grip-github-user "")
(define-key markdown-mode-command-map (kbd "g") 'grip-mode)


;;(defvar company-mode/enable-yas t
;;  "Enable yasnippet for all backends.")
;;(defun company-mode/backend-with-yas (backend)
;;  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
;;      backend
;;    (append (if (consp backend) backend (list backend))
;;            '(:with company-yasnippet))))
;;(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(package-initialize)

(menu-bar-mode 0)
(tool-bar-mode 0)
(display-time)

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
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
	 '(exec-path-from-shell markdown-mode use-package grip-mode highlight-indent-guides auto-sudoedit gruber-darker-theme))
 '(tab-width 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(setq-default c-basic-offset 2)
;(setq-default c-basic-indent 2)
(setq-default python-indent-guess-indent-offset t)

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

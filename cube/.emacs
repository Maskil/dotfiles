(set-locale-environment "en_US.UTF-8")
(require 'package)
(require 'use-package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'same-window-buffer-names "*compilation*")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

;; fundemental settings
;; (add-to-list 'default-frame-alist '(height . 150))
;; (add-to-list 'default-frame-alist '(width . 150))
(set-frame-font "Source Code Pro 13" nil t)
(set-fontset-font t 'cjk-misc (font-spec :family "Noto Sans Mono CJK JP" :weight 'normal :slant 'normal))
(set-fontset-font t 'han (font-spec :family "Noto Sans Mono CJK JP" :weight 'normal :slant 'normal))
(set-fontset-font t 'kana (font-spec :family "Noto Sans Mono CJK JP" :weight 'normal :slant 'normal))
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-so-long-mode 1)
(global-visual-line-mode t)
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
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(delete-selection-mode 1)
(compilation-shell-minor-mode)

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; render html
(load-library "shr.el")

;;Compiling shit
(global-set-key (kbd "<f4>") 'arduino-mode)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)
(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
;; (ignore-errors
;;   (require 'ansi-color)
;;   (defun my-colorize-compilation-buffer ()
;;     (when (eq major-mode 'compilation-mode)
;;       (ansi-color-apply-on-region compilation-filter-start (point-max))))
;;   (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

;; tmp files
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.emacs-saves")))

;; lsp & company
(global-company-mode)
(setq company-idle-delay 0)

;; aucTeX
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'latex-math-mode)
(add-hook 'latex-mode-hook 'turn-on-reftex)
(setq reftx-plug-into-AUCTex t)
(setq font-latex-fontify-script nil)
(setq font-latex-fontify-sectioning 'color)
(add-hook 'LaTeX-mode-hook
  (lambda ()
    (define-key LaTeX-mode-map (kbd "C-c p") "\\par\n")
  )
);; (define-key LaTeX-mode-map (kbd "C-c p") "\\par\n")
(auctex-latexmk-setup)

;; mozc japanese shit
(require 'mozc)
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)
(global-set-key (kbd "C-\\") 'toggle-input-method)

(defun delete-line-no-kill ()
  (interactive)
  (delete-region (point) (line-end-position)))
(global-set-key (kbd "C-S-k") 'delete-line-no-kill)

(defun ryanmarcus/backward-kill-word ()
  "Remove all whitespace if the character behind the cursor is whitespace, otherwise remove a word."
  (interactive)
  (if (looking-back "[ \n]")
      ;; delete horizontal space before us and then check to see if we
      ;; are looking at a newline
      (progn (delete-horizontal-space 't)
             (while (looking-back "[ \n]")
               (backward-delete-char 1)))
    ;; otherwise, just do the normal kill word.
    (backward-kill-word 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(auto-sudoedit-mode t)
 '(compilation-read-command t)
 '(compile-command "bash build.sh")
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "efd849c804148b88536914ccdee08285fd7376e2e3334522c9afc00fd7e594da" "f6ebeda62bbc9308bcdbe8ca777b215a9d50455f883a0cc02c61ab5471c567fb" "15604b083d03519b0c2ed7b32da6d7b2dc2f6630bef62608def60cdcf9216184" "58264887d7ab17702ef85bbd96e11bd7f613622ff9c63990be860b958c978f09" "c7737b9fc3471779c8e51ea0a37834d24aa80a0d6a79b215e7501227ada39855" default))
 '(highlight-indent-guides-method 'bitmap)
 '(japanese-TeX-engine-default 'uptex)
 '(lsp-clients-clangd-executable nil)
 '(package-selected-packages
   '(ansi unicode-fonts csharp-mode gruber-darker-theme mozc python-environment flames-of-freedom grip-mode smex lsp-mode auctex-latexmk typescript-mode fireplace modus-themes skewer-mode multiple-cursors smtpmail-multi arduino-mode which-key company xterm-color magit highlight-indent-guides auto-sudoedit auctex anti-zenburn-theme))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-method 'bitmap))
(put 'narrow-to-region 'disabled nil)

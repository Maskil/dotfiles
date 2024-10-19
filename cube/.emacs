(package-initialize)
(setq custom-file "~/.emacs.custom.el")
(add-to-list 'load-path "~/.emacs.local/")
(load-file "~/.emacs.rc/rc.el")

(rc/require 'magit)
(rc/require 'auctex)
(rc/require 'auctex-latexmk)
(add-to-list 'same-window-buffer-names "*compilation*")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

;; theme
(rc/require-theme 'gruber-darker)

;; fundemental settings
;; (add-to-list 'default-frame-alist '(height . 150))
;; (add-to-list 'default-frame-alist '(width . 150))
(add-to-list 'default-frame-alist `(font . "Source Code Pro 13"))
(set-fontset-font t 'cjk-misc (font-spec :family "Noto Sans Mono CJK JP" :weight 'normal :slant 'normal))
(set-fontset-font t 'han (font-spec :family "Noto Sans Mono CJK JP" :weight 'normal :slant 'normal))
(set-fontset-font t 'kana (font-spec :family "Noto Sans Mono CJK JP" :weight 'normal :slant 'normal))
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(ido-mode 1)
(global-so-long-mode 1)
(global-visual-line-mode t)
(setq split-width-threshold nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq kill-whole-line t)
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq compilation-environment '("TERM=xterm-256color"))
(setq ring-bell-function 'ignore)
(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "s-<up>") 'toggle-frame-maximized)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(delete-selection-mode 1)
(compilation-shell-minor-mode)

;; smex
;; (require 'smex 'ido-completing-read+)
(rc/require 'ido-completing-read+)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

;; render html
(load-library "shr.el")

;;Compiling shit
(global-set-key (kbd "<f4>") 'arduino-mode)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)
(rc/require 'ansi-color)
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
(rc/require 'company)
(global-company-mode)
(setq company-idle-delay 0)

;; aucTeX
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))
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
(rc/require 'mozc)
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

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(load-file custom-file)

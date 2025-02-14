(package-initialize)
(setq custom-file "~/.emacs.custom.el")
(add-to-list 'load-path "~/.emacs.local/")
(load-file "~/.emacs.rc/rc.el")

(rc/require 'exec-path-from-shell)
(rc/require 'magit)
(rc/require 'auctex)
(rc/require 'auctex-latexmk)
(add-to-list 'same-window-buffer-names "*compilation*")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

;; theme
;; (rc/require-theme 'sexy-monochrome)

;; fundemental settings
;; (add-to-list 'default-frame-alist `(font . "Sarasa Mono J"))
(exec-path-from-shell-initialize)
(set-face-attribute 'default nil :font "Sarasa Mono J" :height 128)
(set-frame-font "Sarasa Mono J" nil t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq inhibit-splash-screen 1)
(scroll-bar-mode 0)
(ido-mode 1)
(define-key ido-file-completion-map "C-f" 'ido-fallback-command)
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
(setq highlight-indent-guides-auto-enabled nil)
(set-face-background 'highlight-indent-guides-odd-face "darkgray")
(set-face-background 'highlight-indent-guides-even-face "dimgray")
(set-face-foreground 'highlight-indent-guides-character-face "dimgray")
(setq compilation-environment '("TERM=xterm-256color"))
(setq ring-bell-function 'ignore)
(rc/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "s-<up>") 'toggle-frame-maximized)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(delete-selection-mode 1)
(compilation-shell-minor-mode)
(pixel-scroll-precision-mode)
(global-visual-line-mode)

;; smex
(rc/require 'smex 'ido-completing-read+)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

;; pdf-tools
(rc/require 'pdf-tools)
(pdf-loader-install)
(add-hook 'pdf-tools-enabled-hook (lambda () (display-line-numbers-mode -1)))

;; render html
(load-library "shr.el")

;; old reddit
(defun eww-redirect-reddit ()
  "Redirect 'https://www.reddit.com' to 'https://old.reddit.com' in EWW."
  (when-let ((url (eww-current-url)))
    (when (string-prefix-p "https://www.reddit.com" url)
      (eww-browse-url (replace-regexp-in-string
                       "^https://www\\.reddit\\.com" "https://old.reddit.com" url)))))
(defun eww-enable-visual-line-mode ()
  "Enable visual-line-mode after EWW finishes rendering."
  (run-at-time 0.1 nil #'visual-line-mode 1))
(add-hook 'eww-after-render-hook #'eww-redirect-reddit #'eww-enable-visual-line-mode)

;;Compiling shit
(global-set-key (kbd "<f7>") 'arduino-mode)
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
(rc/require 'company-jedi)
(global-company-mode)
(setq company-idle-delay 0)
(add-to-list 'company-backends 'company-jedi)
(require 'python)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'company-mode-hook
          (lambda ()
            (setq company-filter-always-p t)
            (setf company-filter '(lambda (candidates)
                                    (cl-remove-if-not
                                     (lambda (dir) (not (string-match "^\\./|^\\.\\/" dir)))
                                     candidates)))))

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
(defalias 'japanese-change-line
  (kmacro "C-\\ % <return> C-\\"))
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "C-c p") 'japanese-change-line)))
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

;; do not split window for error messages
(setq same-window-regexps '("."))

;; auto revert
(global-auto-revert-mode t)

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(defun company-remove-dot-and-dotdot (candidates)
  "Remove `.` and `..` from the COMPANY completion CANDIDATES."
  (seq-remove (lambda (candidate)
                (or (string-equal candidate "./")
                    (string-equal candidate "../")))
              candidates))

(setq company-transformers '(company-remove-dot-and-dotdot))

;; remove trailing whitespaces
(defun rm-trailing-spaces ()
  "Remove spaces at ends of all lines"
  (interactive)
  (save-excursion
    (let ((current (point)))
      (goto-char 0)
      (while (re-search-forward "[ \t]+$" nil t)
        (replace-match "" nil nil))
      (goto-char current))))

(use-package grip-mode
  :ensure t
  :config (setq grip-use-mdopen t) ;; to use `mdopen` instead of `grip`
  :bind (:map markdown-mode-command-map
         ("g" . grip-mode)))

(load-file custom-file)


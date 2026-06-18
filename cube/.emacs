(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq-default auto-fill-function #'do-auto-fill)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setenv "LANG" "en_US.UTF-8")
(setenv "DICTIONARY" "en_US")

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref "27c2889f66368bde12b4e243582e343ed9cb75e3" :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))
(setq elpaca-log-functions nil)

(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))
(setq use-package-always-ensure t)

(elpaca 'ef-themes)
(elpaca dimmer)
(when (eq system-type 'darwin)
  (setq shell-file-name "/opt/homebrew/bin/bash")
  (setq vterm-shell "/opt/homebrew/bin/bash"))
(elpaca vterm)

;; Block until the queued packages above are installed,
;; are installed, so the rest of the config can use use-package safely.
(elpaca-wait)

(load-theme 'ef-melissa-dark t)

(dolist (dir '("~/.emacs-saves" "~/.emacs.local"))
  (unless (file-exists-p dir)
    (make-directory dir t)))

(unless (file-exists-p "~/.emacs.custom.el")
  (with-temp-buffer (write-file "~/.emacs.custom.el")))

(add-to-list 'load-path "~/.emacs.local/")

(setq custom-file "~/.emacs.custom.el")

;; ============================================================
;; Core packages
;; ============================================================

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package flycheck
  :commands flycheck-mode)

(use-package compat
  :ensure (:repo "https://github.com/emacs-compat/compat.git"
           :files (:defaults "compat-*.el")))
(use-package llama)
(use-package transient
  :ensure (:repo "https://github.com/magit/transient.git"
           :files (:defaults)))
(use-package magit)

(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-transformers '(company-remove-dot-and-dotdot)))

(defun company-remove-dot-and-dotdot (candidates)
  "Remove `.` and `..` from COMPANY completion CANDIDATES."
  (seq-remove (lambda (candidate)
                (or (string-equal candidate "./")
                    (string-equal candidate "../")))
              candidates))

(use-package company-jedi
  :after company
  :config
  (add-to-list 'company-backends 'company-jedi)
  (add-hook 'python-mode-hook 'jedi:setup))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . 'mc/mark-next-like-this)
         ("C-<" . 'mc/mark-previous-like-this)
         ("C-c C-<" . 'mc/mark-all-like-this)))

(use-package smex
  :bind (("M-x" . smex)
         ("C-c C-c M-x" . execute-extended-command)))

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1))

(elpaca virtual-auto-fill)
(use-package adaptive-wrap
  :hook (visual-line-mode . adaptive-wrap-prefix-mode))

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-auto-enabled nil)
  (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  (set-face-background 'highlight-indent-guides-even-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray"))

(use-package ansi-color
  :ensure nil ;; built-in
  :hook (compilation-filter . ansi-color-compilation-filter))

(use-package dumb-jump
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-loader-install)
  :hook
  (pdf-view-mode . (lambda ()
                     (display-line-numbers-mode -1))))

(use-package auctex
  :ensure (:type git :host github :repo "emacs-straight/auctex"
           :branch "master"
           :files ("*.el" "*.info" "dir" "doc" "etc" "images" "latex" "style")
           :pre-build (("./autogen.sh")
                       ("./configure" "--without-texmf-dir" "--with-lispdir=.")
                       ("make")))
  :mode ("\\.tex\\'" . LaTeX-mode)
  :config
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq font-latex-fontify-script nil)
  (setq font-latex-fontify-sectioning 'color)
  (fset 'tex-font-lock-suscript 'ignore)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  (setq reftex-plug-into-AUCTeX t))

(use-package auctex-latexmk
  :after auctex
  :config
  (auctex-latexmk-setup))

(defalias 'japanese-change-line
  (kmacro "C-\\ % <return> C-\\"))
(with-eval-after-load 'latex
  (define-key LaTeX-mode-map (kbd "C-c p") 'japanese-change-line))

(use-package mozc
  :config
  (setq default-input-method "japanese-mozc"))
(prefer-coding-system 'utf-8)

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :hook (markdown-mode . auto-fill-mode)
  :config
  (setq markdown-enable-wiki-links t
        markdown-italic-underscore t
        markdown-asymmetric-header t
        markdown-make-gfm-checkboxes-buttons t
        markdown-gfm-uppercase-checkbox t
        markdown-enable-math t
        markdown-content-type "application/xhtml+xml"
        markdown-css-paths
        '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css")
        markdown-xhtml-header-content
        "<style>
body {
  box-sizing: border-box;
  max-width: 1200px;
  width: 100%;
  margin: 40px auto;
  padding: 0 10px;
}
</style>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.body.classList.add('markdown-body');
});
</script>"))

(elpaca (simple-httpd :host github :repo "skeeto/emacs-web-server"
                      :local-repo "emacs-web-server"))

(use-package impatient-mode
  :commands (impatient-mode)
  :config
  (defun markdown-filter-impatient-mode (buffer)
    "Markdown filter for impatient-mode."
    (princ
     (with-temp-buffer
       (let ((tmpname (buffer-name)))
         (set-buffer buffer)
         (set-buffer (markdown tmpname))
         (format "<!DOCTYPE html>
<html><head>
<title>Markdown Preview</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/4.0.0/github-markdown.min.css'>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/styles/github.min.css'>
<style>
.markdown-body { box-sizing: border-box; margin: 0 auto; max-width: 1200px; min-width: 200px; padding: 45px; }
@media (max-width: 767px) { .markdown-body { padding: 15px; } }
</style>
</head><body>
<article class='markdown-body'>%s</article>
<script src='https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/highlight.min.js'></script>
<script>hljs.highlightAll();</script>
</body></html>"
                 (buffer-string))))
     (current-buffer)))
  (defun md-preview ()
    "Preview current markdown buffer in browser."
    (interactive)
    (impatient-mode)
    (imp-set-user-filter 'markdown-filter-impatient-mode)
    (httpd-start)
    (imp-visit-buffer)))

(use-package claude-code-ide
  :ensure (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c C-'" . claude-code-ide-menu)
  :config
  (claude-code-ide-emacs-tools-setup))

(use-package codex-cli
  :ensure t
  :bind (("C-c c t" . codex-cli-toggle)
         ("C-c c s" . codex-cli-start)
         ("C-c c q" . codex-cli-stop)
         ("C-c c Q" . codex-cli-stop-all)
         ("C-c c p" . codex-cli-send-prompt)
         ("C-c c r" . codex-cli-send-region)
         ("C-c c f" . codex-cli-send-file)
         ;; Show-all layout + paging
         ("C-c c a" . codex-cli-toggle-all)
         ("C-c c n" . codex-cli-toggle-all-next-page)
         ("C-c c b" . codex-cli-toggle-all-prev-page))
  :init
  (setq codex-cli-executable "codex"
        codex-cli-terminal-backend 'vterm
        codex-cli-side 'right
        codex-cli-width 90))

(use-package matlab-mode
  :mode ("\\.m\\'" . matlab-mode))

(defun my-configure-font (frame)
  "Configure font for FRAME (works with daemon and non-daemon)."
  (with-selected-frame frame
    (set-face-attribute 'default nil :font "Sarasa Mono J" :height 135)
    (set-fontset-font "fontset-default" 'han "Sarasa Mono J")))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'my-configure-font)
  (add-hook 'after-init-hook (lambda () (my-configure-font (selected-frame)))))

;; EWW
(with-eval-after-load 'eww
  (set-face-attribute 'shr-text nil :family "Sarasa Mono J" :height 135))

(defun eww-save-image (filename)
  "Save an image opened in an *eww* buffer to FILENAME."
  (interactive "G")
  (let ((image (get-text-property (point-min) 'display)))
    (with-temp-buffer
      (setq buffer-file-name filename)
      (insert (plist-get (if (eq (car image) 'image) (cdr image)) :data))
      (save-buffer))))

(defun eww-redirect-reddit ()
  "Redirect www.reddit.com to old.reddit.com in EWW."
  (when-let ((url (eww-current-url)))
    (when (string-prefix-p "https://www.reddit.com" url)
      (eww-browse-url (replace-regexp-in-string
                       "^https://www\\.reddit\\.com" "https://old.reddit.com" url)))))

(defun eww-enable-visual-line-mode ()
  "Enable visual-line-mode after EWW finishes rendering."
  (run-at-time 0.1 nil #'visual-line-mode 1))

(add-hook 'eww-after-render-hook #'eww-redirect-reddit)
(add-hook 'eww-after-render-hook #'eww-enable-visual-line-mode)

;; Load shr for HTML rendering
(with-eval-after-load 'eww (require 'shr))

;; ============================================================
;; Fundamental settings
;; ============================================================
(ido-mode 1)
(ido-everywhere 1)

(column-number-mode 1)
(global-so-long-mode 1)
(global-visual-line-mode t)
(global-auto-revert-mode t)
(delete-selection-mode 1)
(electric-pair-mode 1)
(pixel-scroll-precision-mode)

(setq split-width-threshold nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq kill-whole-line t)
(setq electric-pair-preserve-balance nil)
(setq compilation-environment '("TERM=xterm-256color"))
(setq ring-bell-function 'ignore)
(setq display-line-numbers-type 'relative)
(defcustom my/display-line-numbers-exempt-modes '(pdf-view-mode)
  "Major modes in which `display-line-numbers-mode' should stay off."
  :type '(repeat symbol))
(define-globalized-minor-mode my/global-display-line-numbers-mode
  display-line-numbers-mode
  (lambda ()
    (unless (or (minibufferp)
                (apply #'derived-mode-p my/display-line-numbers-exempt-modes))
      (display-line-numbers-mode))))
(my/global-display-line-numbers-mode)

;; Temp/backup files
(setq auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.emacs-saves")))

;; Compilation
(add-to-list 'same-window-buffer-names "*compilation*")

;; ============================================================
;; Keybindings
;; ============================================================
(global-set-key (kbd "C-\\") 'toggle-input-method)
(global-set-key (kbd "s-<up>") 'toggle-frame-maximized)
(global-set-key (kbd "<C-prior>") #'previous-buffer)
(global-set-key (kbd "<C-next>")  #'next-buffer)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)
(global-set-key (kbd "<f7>") 'arduino-mode)
(global-set-key (kbd "C-S-k") 'delete-line-no-kill)
(global-set-key (kbd "<C-f1>") 'show-file-name)

;; ============================================================
;; Custom functions
;; ============================================================
(defun y-or-n-p-with-return (orig-func &rest args)
  "Allow RET to act as 'y' in y-or-n-p prompts."
  (let ((query-replace-map (copy-keymap query-replace-map)))
    (define-key query-replace-map (kbd "RET") 'act)
    (apply orig-func args)))
(advice-add 'y-or-n-p :around #'y-or-n-p-with-return)

(defun delete-line-no-kill ()
  "Delete to end of line without adding to kill ring."
  (interactive)
  (delete-region (point) (line-end-position)))

(defun ryanmarcus/backward-kill-word ()
  "Remove whitespace or a word backward."
  (interactive)
  (if (looking-back "[ \n]")
      (progn (delete-horizontal-space 't)
             (while (looking-back "[ \n]")
               (backward-delete-char 1)))
    (backward-kill-word 1)))

(defun rm-trailing-spaces ()
  "Remove trailing whitespace from all lines."
  (interactive)
  (save-excursion
    (let ((current (point)))
      (goto-char (point-min))
      (while (re-search-forward "[ \t]+$" nil t)
        (replace-match "" nil nil))
      (goto-char current))))

(defun show-file-name ()
  "Show the full path of the current file in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(load custom-file 'noerror)

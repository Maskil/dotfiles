(defvar my/gc-cons-threshold-after-startup (* 64 1024 1024))
(setq gc-cons-threshold (* 64 1024 1024)
      gc-cons-percentage 0.3)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold my/gc-cons-threshold-after-startup
                  gc-cons-percentage 0.1)
            (garbage-collect)))

(setq custom-file (file-truename "~/.emacs.custom.el"))
(unless (file-exists-p custom-file)
  (with-temp-buffer (write-file custom-file)))

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
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
                  ((zerop (apply #'call-process
                                 `("git" nil ,buffer t "clone"
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

(elpaca elpaca-use-package (elpaca-use-package-mode))
(elpaca gruber-darker-theme
  (load-theme 'gruber-darker t))
;; Activate the theme before loading Custom, then apply preferences before
;; declaring the remaining packages.  Their defcustom forms use saved values.
(elpaca-wait)
(setq use-package-always-ensure t)
(load custom-file 'noerror)

(use-package dimmer :defer t)
(when (eq system-type 'darwin)
  (setq shell-file-name "/opt/homebrew/bin/bash")
  (setq vterm-shell "/opt/homebrew/bin/bash"))
(use-package vterm
  :commands vterm)

;; Skip TRAMP's extra shell setup for long-lived remote agent/Git processes.
;; This host must authenticate without an interactive password prompt.
(with-eval-after-load 'tramp
  (connection-local-set-profile-variables
   'my/remote-direct-async
   '((tramp-direct-async-process . t)))
  (connection-local-set-profiles
   '(:application tramp :machine "nakaolab")
   'my/remote-direct-async)
  ;; ACP needs a pipe: a remote terminal can echo requests into its replies.
  (add-to-list 'tramp-connection-properties
               (list (regexp-quote "/ssh:nakaolab:") "direct-async" t))
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(use-package agent-shell
  :commands agent-shell
  :config
  (setq agent-shell-google-authentication
      (agent-shell-google-make-authentication
       :api-key '(getenv "GEMINI_API"))))
(use-package agent-shell-tramp
  :ensure (:host github :repo "junyi-hou/agent-shell-tramp")
  :after agent-shell
  :config
  (agent-shell-tramp-mode 1))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setenv "LANG" "en_US.UTF-8")
(setenv "DICTIONARY" "en_US")
(blink-cursor-mode -1)

(dolist (dir '("~/.emacs-saves" "~/.emacs.local"))
  (unless (file-exists-p dir)
    (make-directory dir t)))

(add-to-list 'load-path "~/.emacs.local/")

(defvar my/exwm-randr-process nil)

(defun my/exwm-monitor-change ()
  "Apply the appropriate monitor profile."
  (unless (process-live-p my/exwm-randr-process)
    (setq my/exwm-randr-process
          (make-process
           :name "autorandr"
           :command '("autorandr" "--change")
           :noquery t
           :sentinel
           (lambda (process _event)
             (when (memq (process-status process)
                         '(exit signal))
               (when (and (eq (process-status process) 'exit)
                          (= (process-exit-status process) 0))
                 (exwm-randr-refresh))))))))

;; ============================================================
;; Core packages
;; ============================================================

(use-package exec-path-from-shell
  ;; On Debian/EXWM the standard /usr/bin PATH is already available.  Avoid
  ;; spawning a login shell unless Emacs is a daemon or runs on macOS.
  :if (or (daemonp) (memq window-system '(mac ns)))
  :defer 1
  :config
  (exec-path-from-shell-initialize))
(dolist (line (process-lines "/bin/bash" "-c" "source ~/.bashrc >/dev/null 2>&1; env"))
  (when (string-match "\\`\\([^=]+\\)=\\(.*\\)\\'" line)
    (setenv (match-string 1 line) (match-string 2 line))))

(use-package flycheck
  :commands flycheck-mode)

(use-package compat
  :ensure (:repo "https://github.com/emacs-compat/compat.git"
           :files (:defaults "compat-*.el"))
  :defer t)
(use-package llama
  :defer t)
(use-package transient
  :ensure (:repo "https://github.com/magit/transient.git"
           :files (:defaults))
  :defer t)
(use-package magit
  :commands (magit-status magit-dispatch magit-file-dispatch)
  :config
  ;; Magit requires a PTY when staging hunks over TRAMP direct async.
  (setq magit-tramp-pipe-stty-settings 'pty))

(defun company-remove-dot-and-dotdot (candidates)
  "Remove `.` and `..` from COMPANY completion CANDIDATES."
  (seq-remove (lambda (candidate)
                (or (string-equal candidate "./")
                    (string-equal candidate "../")))
              candidates))

(use-package company
  ;; Do not run completion machinery in every special/internal buffer.
  :hook ((prog-mode . company-mode)
         (text-mode . company-mode)))

(defun my/python-company-jedi-setup ()
  "Enable Jedi completion only in Python buffers."
  (require 'company-jedi)
  (jedi:setup)
  (setq-local company-backends
              (cons 'company-jedi (remove 'company-jedi company-backends))))

(use-package company-jedi
  :commands company-jedi
  :hook (python-mode . my/python-company-jedi-setup))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . 'mc/mark-next-like-this)
         ("C-<" . 'mc/mark-previous-like-this)
         ("C-c C-<" . 'mc/mark-all-like-this)))

(use-package smex
  :bind (("M-x" . smex)
         ("C-c C-c M-x" . execute-extended-command)))

(use-package ido-completing-read+
  :defer 1
  :config
  (ido-ubiquitous-mode 1))

(setq-default auto-fill-function nil)
(require 'kinsoku)

;; Visual wrapping is useful for prose, but expensive when enabled globally.
(defun my/enable-text-wrapping ()
  (visual-line-mode 1)
  (visual-wrap-prefix-mode 1))
(add-hook 'text-mode-hook #'my/enable-text-wrapping)

;; visual-fill-column performs extra window/display work.  Restrict it to the
;; two document modes where the centered text column is actually useful.
(use-package visual-fill-column
  :ensure t
  :commands visual-fill-column-mode
  :hook ((markdown-mode . visual-fill-column-mode)
         (LaTeX-mode . visual-fill-column-mode)))

(use-package highlight-indent-guides
  ;; Deliberately not enabled globally: it adds font-lock work and an idle
  ;; timer to each enabled buffer.  Use M-x highlight-indent-guides-mode when
  ;; needed.
  :commands highlight-indent-guides-mode
  :config
  (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  (set-face-background 'highlight-indent-guides-even-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray"))

(use-package ansi-color
  :ensure nil ;; built-in
  :hook (compilation-filter . ansi-color-compilation-filter))

(use-package dumb-jump
  :commands dumb-jump-xref-activate
  :init
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
  :hook ((LaTeX-mode . visual-line-mode)
         (LaTeX-mode . flyspell-mode)
         (LaTeX-mode . LaTeX-math-mode)
         (LaTeX-mode . turn-on-reftex)
         (LaTeX-mode . (lambda () (setq-local fill-column 100)))
         (TeX-after-compilation-finished-functions . TeX-revert-document-buffer))
  :config
  (fset 'tex-font-lock-suscript #'ignore))

;; --- make C-c C-a use latexmk, letting latexmkrc pick the engine ---
(with-eval-after-load 'tex
  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk %t" TeX-run-TeX nil t
                 :help "Run latexmk; engine & pdf-mode come from latexmkrc")))

;; typst
(with-eval-after-load 'treesit
  (dolist (grammar
           '((typst "https://github.com/uben0/tree-sitter-typst")
             (bash "https://github.com/tree-sitter/tree-sitter-bash" "v0.23.3")
             (c "https://github.com/tree-sitter/tree-sitter-c" "v0.23.6")
             (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")))
    (add-to-list 'treesit-language-source-alist grammar)))
(use-package treesit
  :ensure nil
  :config
  (setq major-mode-remap-alist
        '((c-mode . c-ts-mode)
          (c++-mode . c++-ts-mode)
          (sh-mode . bash-ts-mode))))

(defalias 'japanese-change-line
  (kmacro "C-\\ % <return> C-\\"))
(with-eval-after-load 'latex
  (define-key LaTeX-mode-map (kbd "C-c p") 'japanese-change-line))

(use-package mozc
  :defer t)
(prefer-coding-system 'utf-8)

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :hook (markdown-mode . auto-fill-mode))

(elpaca (simple-httpd :host github :repo "skeeto/emacs-web-server"
                      :local-repo "emacs-web-server"))

(use-package impatient-mode
  :commands (impatient-mode imp-visit-buffer)
  :config
  (defun markdown-filter-impatient-mode (buffer)
    "Render BUFFER as lightweight Markdown HTML for impatient-mode."
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
<style>
.markdown-body { box-sizing: border-box; margin: 0 auto; max-width: 1200px; min-width: 200px; padding: 45px; }
@media (max-width: 767px) { .markdown-body { padding: 15px; } }
</style>
<script>
window.MathJax = { options: { enableMenu: false } };
</script>
<script defer src='https://cdn.jsdelivr.net/npm/mathjax@4/tex-chtml.js'></script>
</head><body>
<article class='markdown-body'>%s</article>
</body></html>"
                 (buffer-string))))
     (current-buffer)))

  (defun md-preview ()
    "Preview current Markdown buffer in a browser."
    (interactive)
    (impatient-mode 1)
    (imp-set-user-filter #'markdown-filter-impatient-mode)
    (unless (httpd-running-p)
      (httpd-start))
    (imp-visit-buffer)))

(use-package matlab-mode
  :mode ("\\.m\\'" . matlab-mode))

(defun my-configure-font (frame)
  "Configure font for FRAME (works with daemon and non-daemon)."
  (with-selected-frame frame
    (set-face-attribute 'default nil :font "Sarasa Mono J" :height 165)
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
  "Enable inexpensive visual wrapping after EWW finishes rendering."
  (run-at-time 0.1 nil
               (lambda ()
                 (visual-line-mode 1)
                 (visual-wrap-prefix-mode 1))))

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

(global-auto-revert-mode 1)

(delete-selection-mode 1)
(electric-pair-mode 1)

;; Pixel-precision scrolling causes substantially more redisplay work on weak
;; GPUs/CPUs.  Normal scrolling is deliberately retained.
(when (bound-and-true-p pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode -1))

;; Relative numbers must be recomputed whenever point moves.  Absolute numbers
;; are cheaper, and line numbers are restricted to ordinary editing buffers.
(defun my/maybe-enable-line-numbers ()
  "Enable line numbers in normal editing buffers, except large files."
  (when (and (< (buffer-size) (* 500 1024))
             (not (minibufferp)))
    (display-line-numbers-mode 1)))
(add-hook 'prog-mode-hook #'my/maybe-enable-line-numbers)
(add-hook 'text-mode-hook #'my/maybe-enable-line-numbers)

;; Compilation
(add-to-list 'same-window-buffer-names "*compilation*")

;; ============================================================
;; Keybindings
;; ============================================================
(global-set-key (kbd "C-\\") 'toggle-input-method)
(global-set-key (kbd "s-<up>") 'toggle-frame-maximized)
(global-set-key (kbd "<C-prior>") #'previous-buffer)
(global-set-key (kbd "C-{") #'previous-buffer)
(global-set-key (kbd "<C-next>")  #'next-buffer)
(global-set-key (kbd "C-}")  #'next-buffer)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)
(global-set-key (kbd "<f7>") 'arduino-mode)
(global-set-key (kbd "C-S-k") 'delete-line-no-kill)
(global-set-key (kbd "<C-f1>") 'show-file-name)
(global-set-key (kbd "s-p") #'enlarge-window)
(global-set-key (kbd "s-n") #'shrink-window)
(global-set-key (kbd "s-f") #'enlarge-window-horizontally)
(global-set-key (kbd "s-b") #'shrink-window-horizontally)

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

(use-package mu4e
  :config
  (defun sign-or-encrypt-message ()
    (let ((answer (read-from-minibuffer "Sign or encrypt?\nEmpty to do nothing.\n[s/e]: ")))
      (cond
       ((string-equal answer "s") (progn
                                    (message "Signing message.")
                                    (mml-secure-message-sign-pgpmime)))
       ((string-equal answer "e") (progn
                                    (message "Encrypt and signing message.")
                                    (mml-secure-message-encrypt-pgpmime)))
       (t (progn
            (message "Dont signing or encrypting message.")
            nil)))))

  (add-hook 'message-send-hook 'sign-or-encrypt-message))

(use-package radio :ensure t)
(use-package empv
  :ensure (:host github :repo "isamert/empv.el"))

(use-package alert
  :commands (alert))

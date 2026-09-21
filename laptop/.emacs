(defun my-configure-font (frame)
  "Configure font given initial non-daemon FRAME.
Intended for `after-make-frame-functions'."
  (set-face-attribute 'default nil :font "Sarasa Mono J" :height 140)
  (set-fontset-font "fontset-default" 'han "Sarasa Mono J"))

(add-hook 'after-make-frame-functions #'my-configure-font)

(package-initialize)
(setq custom-file "~/.emacs.custom.el")
(add-to-list 'load-path "~/.emacs.local/")
(load-file "~/.emacs.rc/rc.el")

(require 'exwm)
(exwm-enable)

(push '(fullscreen . maximized) default-frame-alist)
(rc/require 'exec-path-from-shell)
(rc/require 'magit)
(rc/require 'auctex)
(rc/require 'auctex-latexmk)
(add-to-list 'same-window-buffer-names "*compilation*")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

(display-battery-mode 1)
(setq battery-mode-line-format "[BTR %p%%]")

;; fundemental settings
;; (add-to-list 'default-frame-alist `(font . "Sarasa Mono J"))
(exec-path-from-shell-initialize)
(set-face-attribute 'default nil :font "Sarasa Mono J" :height 132)
(set-face-attribute 'variable-pitch nil :family "Sarasa Mono J")
(set-face-attribute 'fixed-pitch nil :family "Sarasa Mono J")
(set-frame-font "Sarasa Mono J" nil t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq inhibit-splash-screen 1)
(scroll-bar-mode 0)
(ido-mode 1)
(define-key ido-file-completion-map "C-f" 'ido-fallback-command)
(column-number-mode 1)
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
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "s-<up>") 'toggle-frame-maximized)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(delete-selection-mode 1)
(compilation-shell-minor-mode)
(pixel-scroll-precision-mode)
(global-visual-line-mode t)

(defun y-or-n-p-with-return (orig-func &rest args)
  (let ((query-replace-map (copy-keymap query-replace-map)))
    (define-key query-replace-map (kbd "RET") 'act)
    (apply orig-func args)))

(advice-add 'y-or-n-p :around #'y-or-n-p-with-return)

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
(eval-after-load 'shr ;; should not truncate lines in eww
  '(progn (setq shr-width -1)
          (defun shr-fill-text (text) text)
          (defun shr-fill-lines (start end) nil)
          (defun shr-fill-line () nil)))


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

;; Compiling shit
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
;; (setq same-window-regexps '("."))

;; auto revert
(global-auto-revert-mode t)

;; (require 'simpc-mode)
;; (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

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

(use-package markdown-mode
  :hook ((markdown-mode . auto-fill-mode))
  :mode ((".md\\'" . gfm-mode))
  :config
  (setq
   markdown-enable-wiki-links t
   markdown-italic-underscore t
   markdown-asymmetric-header t
   markdown-make-gfm-checkboxes-buttons t
   markdown-gfm-uppercase-checkbox t
   markdown-enable-math t
   markdown-content-type "application/xhtml+xml"
   markdown-css-paths '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css")
   markdown-xhtml-header-content "
      <style>
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
      </script>
      " ))

(defun markdown-filter-impatient-mode (buffer)
  "Markdown filter for impatient-mode"
  (princ
   (with-temp-buffer
     (let ((tmpname (buffer-name)))
       (set-buffer buffer)
       (set-buffer (markdown tmpname))
       (format "
 <!DOCTYPE html>
  <html>
  <head>
      <title>Markdown Preview</title>
      <meta name='viewport' content=
      'width=device-width, initial-scale=1'>
      <link rel='stylesheet' href=
      'https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/4.0.0/github-markdown.min.css'
      integrity=
      'sha512-Oy18vBnbSJkXTndr2n6lDMO5NN31UljR8e/ICzVPrGpSud4Gkckb8yUpqhKuUNoE+o9gAb4O/rAxxw1ojyUVzg=='
      crossorigin='anonymous'>
      <!-- https://github.com/sindresorhus/github-markdown-css -->
      <link rel='stylesheet' href=
      'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/styles/github.min.css'>
      <!-- https://highlightjs.org -->

      <style>
      .markdown-body {
          box-sizing: border-box;
          margin: 0 auto;
          max-width: 1200px;
          min-width: 200px;
          padding: 45px;
       }

       @media (max-width: 767px) {
           .markdown-body {
               padding: 15px;
           }
       }
      </style>
  </head>
  <body>
      <article class='markdown-body'>
          %s
      </article>
      <script src=
      'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/highlight.min.js'></script>

      <script>

      hljs.highlightAll();
      </script>
  </body>
  </html>"
               (buffer-string))))
   (current-buffer)))

(defun md-preview ()
  (interactive)
  (impatient-mode)
  (imp-set-user-filter `markdown-filter-impatient-mode)
  (httpd-start)
  (imp-visit-buffer))

(setq epg-pinentry-mode 'loopback)
(use-package mu4e
  :config
  (setq mu4e-maildir "~/.mail/personal/"
        mu4e-get-mail-command "mbsync personal"
        mu4e-update-interval 300
        mu4e-inbox-folder "/Inbox"
        mu4e-sent-folder "/Sent"
        mu4e-drafts-folder "/Draft"
        mu4e-trash-folder "/Trash"
        mu4e-refile-folder "/Junk"
        mu4e-sent-messages-behavior 'sent
        mu4e-compose-signature-include-separator nil
        mu4e-compose-signature "Makihiro"
        user-mail-address "makigo@aubsebian.net"
        user-full-name "Makihiro GO")
  (setq sendmail-program "msmtp"
        send-mail-function #'sendmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments (list "--read-envelope-from" "-C" (expand-file-name "~/.config/msmtprc") "-a" "personal")        
        message-send-mail-function #'message-send-mail-with-sendmail)
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

(setq empv-mpv-args '("--vo=x11" "--force-window=yes"))

(use-package slack
  :bind (("C-c S K" . slack-stop)
         ("C-c S c" . slack-select-rooms)
         ("C-c S u" . slack-select-unread-rooms)
         ("C-c S U" . slack-user-select)
         ("C-c S s" . slack-search-from-messages)
         ("C-c S J" . slack-jump-to-browser)
         ("C-c S j" . slack-jump-to-app)
         ("C-c S e" . slack-insert-emoji)
         ("C-c S E" . slack-message-edit)
         ("C-c S r" . slack-message-add-reaction)
         ("C-c S t" . slack-thread-show-or-create)
         ("C-c S g" . slack-message-redisplay)
         ("C-c S G" . slack-conversations-list-update-quick)
         ("C-c S q" . slack-quote-and-reply)
         ("C-c S Q" . slack-quote-and-reply-with-link)
         (:map slack-mode-map
               (("@" . slack-message-embed-mention)
                ("#" . slack-message-embed-channel)))
         (:map slack-thread-message-buffer-mode-map
               (("C-c '" . slack-message-write-another-buffer)
                ("@" . slack-message-embed-mention)
                ("#" . slack-message-embed-channel)))
         (:map slack-message-buffer-mode-map
               (("C-c '" . slack-message-write-another-buffer)))
         (:map slack-message-compose-buffer-mode-map
               (("C-c '" . slack-message-send-from-buffer)))
         )
  :custom
  (slack-extra-subscribed-channels (mapcar 'intern (list "some-channel")))
  :config
  (slack-register-team
     :name "Nakaolab"
     :token "xoxc-133736533442-8707262827895-10944013290022-57aa0612137bbb2622e167e536f7d8f4b07ac0b6610137ff79872db0fc7f18a9"
     :cookie "xoxd-pxSXPlms6srv4PzRiuk54SlCjHH0wWyrj4PC1x%2BDdza7Lo%2FdvGrj08ENRYn2hFfjUsUHRpFYq1h9O%2FisUxVYOSTIZ%2FCEjN%2BKUFfQf9Bn2RGA0pF07%2BuvTc%2FWS7jKaeo0b9Xf3jrjdLhXVeSTwPCdKpGGzROlin99KEknT4xC9AUYLY2b3UhssMlF6ZIV8IzhxpukQ752wLwszdbRr%2FqZm%2BNLMcs%3D; d-s=1776538243; lc=1776538265"
     :full-and-display-names t
     :default t
     :subscribed-channels nil ;; using slack-extra-subscribed-channels because I can change it dynamically
     ))

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(load-file custom-file)

(put 'list-timers 'disabled nil)

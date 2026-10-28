(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7"
     default))
 '(mu4e-mu-binary "/opt/homebrew/bin/mu")
 '(TeX-command-default "LatexMk")
 '(TeX-master nil)
 '(TeX-parse-self t)
 '(agent-shell-session-restore-verbosity 'last)
 '(agent-shell-text-file-capabilities nil)
 '(agent-shell-xai-acp-command '("grok" "agent" "stdio"))
 '(alert-default-style 'notifier)
 '(auto-revert-avoid-polling t)
 '(auto-revert-check-vc-info nil)
 '(auto-revert-interval 5)
 '(auto-save-file-name-transforms `((".*" "~/.emacs-saves/" t)))
 '(backup-directory-alist '((".*" . "~/.emacs-saves")))
 '(company-idle-delay 0.25)
 '(company-minimum-prefix-length 2)
 '(company-tooltip-limit 10)
 '(company-transformers '(company-remove-dot-and-dotdot))
 '(compilation-environment '("TERM=xterm-256color"))
 '(default-input-method "japanese-mozc")
 '(display-line-numbers-type 'relative)
 '(electric-pair-preserve-balance nil)
 '(empv-mpv-args '("--vo=x11" "--force-window=yes"))
 '(epg-pinentry-mode 'loopback)
 '(fast-but-imprecise-scrolling t)
 '(font-latex-fontify-script nil)
 '(font-latex-fontify-sectioning 'color)
 '(frame-resize-pixelwise t)
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-indent-guides-method 'character)
 '(highlight-indent-guides-responsive nil)
 '(httpd-log-buffer nil)
 '(impatient-mode-delay 1)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(kill-whole-line t)
 '(markdown-asymmetric-header t)
 '(markdown-command '("pandoc" "-f" "gfm+tex_math_dollars" "-t" "html" "--mathjax" "--no-highlight"))
 '(markdown-content-type "application/xhtml+xml")
 '(markdown-css-paths '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css"))
 '(markdown-enable-highlighting-syntax nil)
 '(markdown-enable-math t)
 '(markdown-enable-wiki-links t)
 '(markdown-gfm-uppercase-checkbox t)
 '(markdown-italic-underscore t)
 '(markdown-make-gfm-checkboxes-buttons t)
 '(markdown-wiki-link-fontify-missing nil)
 '(markdown-xhtml-header-content "<style>
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
</script>")
 '(message-kill-buffer-on-exit t)
 '(message-send-mail-function #'message-send-mail-with-sendmail)
 '(message-sendmail-extra-arguments (list "--read-envelope-from" "-C" (expand-file-name "~/.config/msmtprc") "-a" "personal"))
 '(message-sendmail-f-is-evil t)
 '(mml-secure-openpgp-signers '("11A3971B9BA9E60A746D232B866448C97C66F9CA"))
 '(mu4e-compose-signature "Makihiro")
 '(mu4e-compose-signature-include-separator nil t)
 '(mu4e-drafts-folder "/personal/Draft")
 '(mu4e-get-mail-command "mbsync personal")
 '(mu4e-inbox-folder "/personal/Inbox" t)
 '(mu4e-maildir "~/.mail/personal/" t)
 '(mu4e-refile-folder "/personal/Junk")
 '(mu4e-sent-folder "/personal/Sent")
 '(mu4e-sent-messages-behavior 'sent)
 '(mu4e-trash-folder "/personal/Trash")
 '(mu4e-update-interval 300)
 '(radio-stations-alist '(("40s" . "http://uk3.internet-radio.com:8082/live.m3u")))
 '(redisplay-skip-fontification-on-input t)
 '(reftex-plug-into-AUCTeX t)
 '(ring-bell-function 'ignore)
 '(send-mail-function #'sendmail-send-it)
 '(sendmail-program "msmtp")
 '(split-width-threshold nil)
 '(tab-width 2)
 '(user-full-name "Makihiro GO")
 '(user-mail-address "makigo@aubsebian.net")
 '(visual-fill-column-width 90)
 '(visual-wrap-extra-indent 0)
 '(window-resize-pixelwise t)
 '(word-wrap-by-category t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)

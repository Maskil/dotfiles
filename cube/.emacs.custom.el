(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(TeX-view-program-selection nil)
 '(c-basic-offset 4)
 '(compile-command "bash build.sh ")
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" "7c83927617afdf71cc90801ffee5965939505b7cfecdcbe15961fc32a0d9bd02" default))
 '(font-latex-fontify-script nil t)
 '(font-latex-fontify-sectioning 'color t)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(mozc-candidate-style 'echo-area)
 '(package-selected-packages
   '(magit-vcsh magit gruber-darker-theme markdown-mode yaml-mode vterm php-mode adaptive-wrap dumb-jump smex pdf-tools multiple-cursors mozc ido-completing-read+ exec-path-from-shell dash-functional company-jedi auctex-latexmk))
 '(tex-fontify-script nil)
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))))
 '(font-latex-sectioning-5-face ((t (:foreground "blue4"))))
 '(font-latex-slide-title-face ((t (:weight bold))))
 '(info-title-1 ((t (:inherit info-title-2))))
 '(info-title-2 ((t (:inherit info-title-3))))
 '(info-title-3 ((t (:inherit info-title-4))))
 '(info-title-4 ((t (:weight bold)))))
(put 'narrow-to-region 'disabled nil)

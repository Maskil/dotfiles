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
 '(custom-enabled-themes '(ef-melissa-dark))
 '(custom-safe-themes
   '("bfe496f60aa427b47e71cfd9c0fba269004066d490c8b9679d786459df2adc7f" "93bacb3aa7b23184ce645d642b8ae7a01dc9d01122c1b54693d89afa8003114e"
     "900281c07b74cb241028f2b65a02dc2073f256b67d3c7c0d878154b3cd8a9433" "e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7"
     "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" "7c83927617afdf71cc90801ffee5965939505b7cfecdcbe15961fc32a0d9bd02" default))
 '(fill-column 150)
 '(font-latex-fontify-script nil)
 '(font-latex-fontify-sectioning 'color)
 '(global-display-fill-column-indicator-mode t)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(mozc-candidate-style 'echo-area)
 '(package-selected-packages
   '(magit-vcsh magit gruber-darker-theme markdown-mode yaml-mode vterm php-mode adaptive-wrap dumb-jump smex pdf-tools multiple-cursors mozc
                ido-completing-read+ exec-path-from-shell dash-functional company-jedi auctex-latexmk))
 '(tex-fontify-script nil)
 '(warning-suppress-log-types '((native-compiler) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-doctex-preprocessor-face ((t nil)))
 '(font-latex-italic-face ((t (:foreground "OliveDrab2" :inherit italic))))
 '(font-latex-sectioning-0-face ((t nil)))
 '(font-latex-sectioning-1-face ((t nil)))
 '(font-latex-sectioning-2-face ((t nil)))
 '(font-latex-sectioning-3-face ((t nil)))
 '(font-latex-sectioning-4-face ((t nil)))
 '(font-latex-sectioning-5-face ((t nil)))
 '(font-latex-slide-title-face ((t nil)))
 '(region ((t (:extend t :background "gray12" :foreground "#ffffff")))))
(put 'narrow-to-region 'disabled nil)

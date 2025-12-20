(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(TeX-view-program-selection nil)
 '(compile-command "bash build.sh ")
 '(custom-enabled-themes '(pierson))
 '(custom-safe-themes
   '("7c83927617afdf71cc90801ffee5965939505b7cfecdcbe15961fc32a0d9bd02" default))
 '(font-latex-fontify-script nil)
 '(font-latex-fontify-sectioning 'color)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(mozc-candidate-style 'echo-area)
 '(package-selected-packages
   '(adaptive-wrap dumb-jump smex pdf-tools multiple-cursors mozc magit ido-completing-read+ exec-path-from-shell dash-functional company-jedi auctex-latexmk))
 '(tex-fontify-script nil)
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-doctex-preprocessor-face ((t nil)))
 '(font-latex-italic-face ((t (:foreground "OliveDrab2" :inherit italic))))
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

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
 '(custom-enabled-themes '(almost-mono-black))
 '(custom-safe-themes
   '("ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7" "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" "fed90b0cf3dd7b00b5f0b048542c25d6c19d5335bdf121d8b54e59766f17daae" "e6fb17048752ae4f07e8a689f59fb909a7e3008c5db75af3d870b701ce6506ef" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(face-font-family-alternatives '(("Sarasa Mono J" "courier" "fixed")))
 '(fill-column 800)
 '(font-latex-fontify-script nil)
 '(font-latex-fontify-script-max-level 0)
 '(font-latex-fontify-sectioning 'color)
 '(font-use-system-font t)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(markdown-command "/usr/bin/pandoc")
 '(package-selected-packages
   '(speed-type almost-mono-themes image+ yaml-mode dumb-jump impatient-mode markdown-mode gruber-darker-theme auctex-latexmk auctex magit exec-path-from-shell dash-functional dash))
 '(tex-fontify-script t))
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

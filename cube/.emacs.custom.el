(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open")))
 '(compile-command "bash build.sh ")
 '(custom-safe-themes
   '("01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(highlight-indent-guides-auto-character-face-perc 50)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(magit-bury-buffer-function 'magit-restore-window-configuration)
 '(package-selected-packages
   '(company-jedi pdf-tools markdown-mode gruber-darker-theme auctex-latexmk auctex magit dash-functional dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-character-face ((t (:foreground "#1a801a801a80"))))
 '(highlight-indent-guides-stack-character-face ((t (:foreground "#bebebe"))))
 '(highlight-indent-guides-top-character-face ((t (:foreground "#bebebe"))))
 '(highlight-indent-guides-top-even-face ((t (:background "#bebebe")))))
(put 'narrow-to-region 'disabled nil)

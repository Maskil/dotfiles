(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")))
 '(auto-revert-use-notify nil)
 '(compile-command "bash build.sh ")
 '(completion-styles '(basic partial-completion emacs22))
 '(custom-enabled-themes '(immaterial-dark))
 '(custom-safe-themes
   '("409e4d689f1e29e5a18f536507e6dc760ee9da76dc56481aaa0696705e6be968" "a6c5f5581d1d0783aec7dc50b2656727a3a6f3755a38e9d76938c8ec040a77a0" default))
 '(global-auto-revert-mode t)
 '(grip-github-password "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")
 '(grip-github-user "Maskil")
 '(highlight-indent-guides-auto-character-face-perc 20)
 '(highlight-indent-guides-auto-even-face-perc 15)
 '(highlight-indent-guides-auto-odd-face-perc 15)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(japanese-TeX-engine-default 'ptex)
 '(mozc-candidate-style 'echo-area)
 '(package-selected-packages
   '(grip-mode immaterial-theme exec-path-from-shell company-auctex sexy-monochrome-theme poet-theme slime-theme-theme smex pdf-tools multiple-cursors mozc markdown-mode magit ido-completing-read+ gruber-darker-theme ein dash-functional csv-mode company-jedi auctex-latexmk))
 '(safe-local-variable-values '((TeX-master . main)))
 '(warning-suppress-log-types '((pdf-view) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shr-text ((t (:inherit \"Sarasa\ Mono\ J\")))))
(put 'narrow-to-region 'disabled nil)

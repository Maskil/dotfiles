(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-command-list
   '(("LatexMk" "latexmk %(-PDF)%S%(mode) %(file-line-error) %(extraopts) %t" TeX-run-latexmk nil
      (plain-tex-mode latex-mode doctex-mode)
      :help "Run LatexMk")
     ("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %(output-dir) %t" TeX-run-TeX nil
      (plain-TeX-mode AmSTeX-mode Texinfo-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
      (LaTeX-mode docTeX-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %(extraopts) %(o-dir) %t" TeX-run-compile nil
      (Texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo %(extraopts) %(o-dir) --html %t" TeX-run-compile nil
      (Texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "amstex %(PDFout) %`%(extraopts) %S%(mode)%' %(output-dir) %t" TeX-run-TeX nil
      (AmSTeX-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "%(cntxcom) --once %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (ConTeXt-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (ConTeXt-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "bibtex %(O?aux)" TeX-run-BibTeX nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode ConTeXt-mode)
      :help "Run BibTeX")
     ("Biber" "biber %(output-dir) %s" TeX-run-Biber nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Run Biber")
     ("Texindex" "texindex %s.??" TeX-run-command nil
      (Texinfo-mode)
      :help "Run Texindex")
     ("Texi2dvi" "%(PDF)texi2dvi %t" TeX-run-command nil
      (Texinfo-mode)
      :help "Run Texi2dvi or Texi2pdf")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-dvips t
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Generate PostScript file")
     ("Dvips" "%(o?)dvips %d -o %f " TeX-run-dvips nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Convert DVI file to PostScript")
     ("Dvipdfmx" "dvipdfmx -o %(O?pdf) %d" TeX-run-dvipdfmx nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Convert DVI file to PDF with dvipdfmx")
     ("Ps2pdf" "ps2pdf %f %(O?pdf)" TeX-run-ps2pdf nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Convert PostScript file to PDF")
     ("LaTeXMk" "latexmk %(latexmk-out) %(file-line-error) %(output-dir) %`%(extraopts) %S%(mode)%' %t" TeX-run-TeX nil
      (LaTeX-mode docTeX-mode)
      :help "Run LaTeXMk")
     ("Glossaries" "makeglossaries %(d-dir) %s" TeX-run-command nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Run makeglossaries to create glossary file")
     ("Index" "makeindex %(O?idx)" TeX-run-index nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Run makeindex to create index file")
     ("upMendex" "upmendex %(O?idx)" TeX-run-index t
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Run upmendex to create index file")
     ("Xindy" "texindy %s" TeX-run-command nil
      (plain-TeX-mode LaTeX-mode docTeX-mode AmSTeX-mode Texinfo-mode)
      :help "Run xindy to create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (LaTeX-mode)
      :help "Check LaTeX file for correctness")
     ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
      (LaTeX-mode)
      :help "Check LaTeX file for common mistakes")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
 '(TeX-engine 'luatex)
 '(TeX-view-program-selection nil)
 '(c-basic-offset 4)
 '(compile-command "bash build.sh ")
 '(custom-enabled-themes '(almost-mono-black))
 '(custom-safe-themes
   '("ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7" "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" "fed90b0cf3dd7b00b5f0b048542c25d6c19d5335bdf121d8b54e59766f17daae" "e6fb17048752ae4f07e8a689f59fb909a7e3008c5db75af3d870b701ce6506ef" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(default-frame-alist '((vertical-scroll-bars)))
 '(face-font-family-alternatives '(("Sarasa Mono J" "fixed")))
 '(fill-column 800)
 '(font-latex-fontify-script nil t)
 '(font-latex-fontify-script-max-level 0)
 '(font-latex-fontify-sectioning 'color t)
 '(font-use-system-font nil)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(markdown-command "/usr/bin/pandoc")
 '(mozc-candidate-style 'echo-area)
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

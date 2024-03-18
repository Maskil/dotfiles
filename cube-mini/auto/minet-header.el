(TeX-add-style-hook
 "minet-header"
 (lambda ()
   (setq TeX-command-extra-options
         "-shell-escape")
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("bxjsarticle" "uplatex" "dvi=dvipdfmx" "ja=standard" "base=10pt" "magstyle=nomag*" "twocolumn" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("hyperref" "hidelinks") ("graphicx" "dvipdfmx")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "bxjsarticle"
    "bxjsarticle10"
    "mylab-techrep"
    "hyperref"
    "graphicx"
    "tikz"
    "mathtools"
    "minted")
   (TeX-add-symbols
    "numberthis")
   (LaTeX-add-bibliographies
    "ref")
   (LaTeX-add-mathtools-DeclarePairedDelimiters
    '("abs" "")
    '("norm" ""))
   (LaTeX-add-minted-newmints
    '("inline" "text" "inline")
    '("inlinec" "c" "inline")))
 :latex)


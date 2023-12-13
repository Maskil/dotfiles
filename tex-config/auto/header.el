(TeX-add-style-hook
 "header"
 (lambda ()
   (setq TeX-command-extra-options
         "-shell-escape")
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("ltjarticle" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "a4paper" "margin=0.5in") ("datetime2" "en-US")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "inlinec")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "inline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "inlinec")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "inline")
   (TeX-run-style-hooks
    "latex2e"
    "ltjarticle"
    "ltjarticle11"
    "geometry"
    "datetime2"
    "minted"
    "amssymb"
    "graphicx"
    "caption"
    "tabularx"
    "multicol"
    "float"
    "luatexja-fontspec"
    "xpatch"
    "hyperref")
   (TeX-add-symbols
    '("inlinec" [TeX-arg-key-val (LaTeX-minted-key-val-options)] TeX-arg-verb-delim-or-brace)
    '("inline" [TeX-arg-key-val (LaTeX-minted-key-val-options)] TeX-arg-verb-delim-or-brace)
    "itshape"))
 :latex)


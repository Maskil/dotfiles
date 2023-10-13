(deftheme maskil
  "Created 2023-10-08.")

(custom-theme-set-variables
 'maskil
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-engine 'luatex)
 '(ansi-color-faces-vector [default default default italic underline success warning error])
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "dark gray" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(compile-command "sh build.sh ")
 '(highlight-indent-guides-method 'bitmap)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(org-src-preserve-indentation nil)
 '(sql-sqlite-options nil)
 '(tab-width 2)
 '(tex-start-options "")
 '(custom-safe-themes '("9b39b25c3a23b1be6e99a3648b91ebaf2a7efdde236e3472aa95f1708ec61d4f" "c7737b9fc3471779c8e51ea0a37834d24aa80a0d6a79b215e7501227ada39855" "e93c4567f5d30365064747972b179e80939cee875627034dc76cd50477c6b998" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "c0dd134ecd6ede6508c30f7d4ac92334229531df62284fc6572f65b4d0cde43f" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" "cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "d0fd069415ef23ccc21ccb0e54d93bdbb996a6cce48ffce7f810826bb243502c" "ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7" "13bfea3096a0bdc791cb2d992b5a93d93eeec3e1b2ae5a4f94f47aa48f35fb99" "bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" default))
 '(package-selected-packages '(anti-zenburn-theme xterm-color zenburn-theme magit latex-math-preview auctex use-package so-long mozc matlab-mode highlight-indent-guides gruber-darker-theme grip-mode flycheck exec-path-from-shell company-jedi auto-sudoedit)))

(custom-theme-set-faces
 'maskil
 '(default ((t (:slant normal :weight regular :height 180 :width normal :foundry "nil" :family "Iosevka")))))

(provide-theme 'maskil)

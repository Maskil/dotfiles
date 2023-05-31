(add-hook 'c-mode-hook
	(lambda()
		(unless (or (file-exists-p "makefile") (file-exists-p "Makefile"))
			(set (make-local-variable 'compile-command)
				(concat "gcc -Wall " (shell-quote-argument buffer-file-name) " && .\a.exe")))))

(add-hook 'c++-mode-hook
	(lambda()
		(unless (or (file-exists-p "makefile") (file-exists-p "Makefile"))
			(set (make-local-variable 'compile-command)
				(concat "g++ -std=c++11 -Wall " (shell-quote-argument buffer-file-name) " && .\a.exe")))))

(add-hook 'python-mode-hook
	(lambda()
		(set (make-local-variable 'compile-command)
			(concat "python " (shell-quote-argument buffer-file-name)))))

(add-hook 'markdown-mode-hook
  (lambda()
    (set (make-local-variable 'compile-command)
      (concat "pandoc -F pandoc-crossref " buffer-file-name " -o " (file-name-sans-extension buffer-file-name)
        ".pdf --pdf-engine=lualatex --highlight-style monochrome -V documentclass=ltjarticle -V CJKmainfont=SourceHanSerif -V mainfont=SourceHanSerif -V fontsize=11.5pt -V geometry=a4paper -V geometry:margin=1in --lua-filter=%HOME%/pandoc-config/header.lua"))))


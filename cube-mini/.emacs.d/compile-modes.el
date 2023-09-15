(add-hook 'c-mode-hook
	        (lambda()
		        (unless (or (file-exists-p "makefile") (file-exists-p "Makefile"))
			        (set (make-local-variable 'compile-command)
				           (concat "gcc -Wall " (shell-quote-argument buffer-file-name) " && ./a.out")))))

(add-hook 'c++-mode-hook
	        (lambda()
		        (unless (or (file-exists-p "makefile") (file-exists-p "Makefile"))
			        (set (make-local-variable 'compile-command)
				           (concat "g++ -std=c++11 -Wall " (shell-quote-argument buffer-file-name) " && ./a.out")))))

(add-hook 'python-mode-hook
	        (lambda()
		        (set (make-local-variable 'compile-command)
			           (concat "python3 " (shell-quote-argument buffer-file-name)))))

;; (add-hook 'markdown-mode-hook
;;           (lambda()
;;             (set (make-local-variable 'compile-command)
;;                  (concat "pandoc -F pandoc-crossref " buffer-file-name " -o " (file-name-sans-extension buffer-file-name)
;;                          ".pdf --pdf-engine=lualatex --highlight-style monochrome -V documentclass=ltjarticle -V CJKmainfont=SourceHanSerif -V mainfont=SourceHanSerif -V fontsize=10.5pt -V geometry:margin=1in --lua-filter=~/dot_files/cube/pandoc-config/columns.lua"))))

;; (add-hook 'markdown-mode-hook
;;           (lambda()
;;             (set (make-local-variable 'compile-command)
;;                  (concat "pandoc -F pandoc-crossref --katex -f markdown+tex_math_single_backslash --filter pandoc-sidenote -t html5+smart --template=template --css=/Users/maskil/dot_files/cube-mini/aubsebian/theme.css --toc --wrap=none --highlight-style zenburn --embed-resources --standalone " buffer-file-name " -o " (file-name-sans-extension buffer-file-name)
;;                          ".html"))))

(add-hook 'LaTeX-mode-hook
          (lambda()
            (set (make-local-variable 'compile-command)
                 (concat "lualatex " buffer-file-name))))

(add-hook 'c-mode-hook
	(lambda()
		(unless (or (file-exists-p "makefile") (file-exists-p "Makefile"))
			(set (make-local-variable 'compile-command)
				(concat "gcc -Wall " (shell-quote-argument buffer-file-name))))))

(add-hook 'c++-mode-hook
	(lambda()
		(unless (or (file-exists-p "makefile") (file-exists-p "Makefile"))
			(set (make-local-variable 'compile-command)
				(concat "g++ -std=c++11 -Wall " (shell-quote-argument buffer-file-name))))))

(add-hook 'python-mode-hook
	(lambda()
		(set (make-local-variable 'compile-command)
			(concat "python3 " (shell-quote-argument buffer-file-name)))))

(add-hook 'markdown-mode-hook
  (lambda()
    (set (make-local-variable 'compile-command)
      (concat "pandoc " buffer-file-name " -o " (file-name-sans-extension buffer-file-name)
        ".pdf -V geometry:margin=1in -V mainfont=IPAPGothic -V fontsize=16pt --pdf-engine=lualatex"))))


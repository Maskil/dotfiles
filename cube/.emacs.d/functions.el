(defun sanityinc/add-subdirs-to-load-path (parent-dir)
  "Add every non-hidden subdir of PARENT-DIR to `load-path'."
  (let ((default-directory parent-dir))
    (setq load-path
      (append
        (cl-remove-if-not
          #'file-directory-p
          (directory-files (expand-file-name parent-dir) t "^[^\\.]"))
        load-path))))

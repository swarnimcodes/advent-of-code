;; solution.el

(defun read-relative-file (rel-file-path)
  (interactive)


  
  (message "File Path: %s" rel-file-path)
  (message "Current Directory: %s" default-directory)
  (message (f-join default-directory rel-file-path))
  (let ((abs-file-path (f-join default-directory rel-file-path)))
    (message "Absolute File Path: %s" abs-file-path)
    (message "File Exists: %s" (file-exists-p abs-file-path))
    (when (file-exists-p abs-file-path)
      (f-read-text abs-file-path)
      )
    )
  )


(defun main ()
  (interactive)
  (setq-local pointer 50) ;; starts at 0
  (setq-local zero-count 0) ;; count how many times points to zero
  (setq-local file-contents (read-relative-file "input.txt"))

  (setq-local net-steps nil)

  ;; loop over
  (dolist (elem (split-string file-contents))
    (let ((current-move elem))
      ;; (message "Current Move: %s" current-move)

      ;; cyclic 100       ::   (100 + (-90 % 100))%100
      ;; cyclic elisp     ::   (% (+ 100 (% -90 100)) 100)

      (when (string-match "\\([A-Z]\\)\\([0-9]+\\)$" elem)
        (setq-local direction (string-trim (match-string 1 elem)))
        (setq-local steps (string-to-number (string-trim (match-string 2 elem))))
        (when (equal "L" direction)
          ;; do stuff
          (setq-local pointer (% (+ 100 (% (+ pointer (* steps -1)) 100)) 100))
          )

        (when (equal "R" direction)
          ;; do stuff
          (setq-local pointer (% (+ 100 (% (+ pointer steps) 100)) 100))
          )
        
        )
      
      )
    (when (equal pointer 0)
      (setq-local zero-count (+ zero-count 1))    
      )
    )
  (message "Pointer final:: %d" pointer)
  (message "Number of Zero Pointers:: %d" zero-count)
  )

(main)

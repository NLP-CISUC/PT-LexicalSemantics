
(ql:quickload '(:cl-ppcre :yason))

(defun filename (url)
  (multiple-value-bind (a b)
      (cl-ppcre:scan-to-strings "<https://w3id.org/own-pt/wn30/schema/([a-zA-Z]+)>" url)
    (declare (ignore a))
    (format nil "~a.txt" (aref b 0))))

(defun collect-wn (jfile stats)
  (let ((tb (make-hash-table :test #'equal)))
    (dolist (res (gethash "values" (yason:parse jfile)) tb)
      (destructuring-bind (a b c)
	  res
	(let* ((target (string-downcase (string-trim '(#\" #\_ #\Space) a)))
	       (rel    (filename b))
	       (tmp-c  (mapcar #'string-downcase (cl-ppcre:split "/" (string-trim '(#\") c))))
	       (words  (remove-if-not (lambda (w) (> (gethash w stats 0) 1))
				      (mapcar (lambda (w) (string-trim '(#\_ #\Space) w))
					      (remove target (remove-duplicates tmp-c :test #'equal)
						      :test #'equal)))))
	  (if words
	      (push (cons target (format nil "~{~a~^/~}" words))
		    (gethash rel tb))))))))

(defun collect-stats (fn)
  (let ((tb (make-hash-table :test #'equal)))
    (with-open-file (in fn)
      (loop for line = (read-line in nil nil)
	    while line
	    do (let ((r (cl-ppcre:split "\\t" line)))
		 (if (cadr r) (setf (gethash (substitute #\_ #\= (cadr r)) tb)
				    (parse-integer (car r)))))
	    finally (return tb)))))

(defun save ()
  (let ((stats (collect-stats #P"stats/lemas.cetempublico.tsv")))
    (maphash (lambda (k vs)
	       (with-open-file (out k :direction :output :if-exists :supersede)
		 (dolist (v (sort vs #'> :key (lambda (v) (gethash (car v) stats 0))))
		   (if (> (gethash (car v) stats 0) 1)
		       (format out "~a~a~a~%" (car v) #\Tab (cdr v))))))
	     (collect-wn #P"query.json" stats))))

;; sbcl --load process.lisp --eval '(save)' --eval '(sb-ext:quit)'

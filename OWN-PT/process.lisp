
(ql:quickload '(:cl-ppcre :yason))

(defun localname (url)
  (multiple-value-bind (a b)
      (cl-ppcre:scan-to-strings "<https://w3id.org/own-pt/wn30/schema/([a-zA-Z]+)>" url)
    (declare (ignore a))
    (aref b 0)))

(defun filename (type1 rel type2)
  (format nil "~a-~a-~a.txt" (localname rel) (localname type1) (localname type2)))

(defun collect-wn (jfile stats)
  (let ((tb (make-hash-table :test #'equal)))
    (dolist (res (gethash "values" (yason:parse jfile)) tb)
      (destructuring-bind (p t1 rel t2 rs)
	  res
	(let* ((target (string-downcase (string-trim '(#\" #\_ #\Space) p)))
	       (fn     (filename t1 rel t2))
	       (tmp    (mapcar #'string-downcase (cl-ppcre:split "/" (string-trim '(#\") rs))))
	       (words  (remove-if-not (lambda (w) (> (gethash w stats 0) 1))
				      (mapcar (lambda (w) (string-trim '(#\_ #\Space) w))
					      (remove target (remove-duplicates tmp :test #'equal)
						      :test #'equal)))))
	  (if words
	      (push (cons target (format nil "~{~a~^/~}" words))
		    (gethash fn tb))))))))

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

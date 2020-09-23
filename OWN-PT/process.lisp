
(ql:quickload '(:cl-ppcre :fare-csv))

(defparameter data
  (fare-csv:read-csv-file "/Users/ar/work/wn/PT-LexicalSemantics/OWN-PT/query.csv"))


(defun clean-aux (target words)
  (remove target
	  (format nil "~{~a~^/~}" (remove-duplicates (cl-ppcre:split "/" words) :test #'equal))
	  :test #'equal))

(defun clean (data)
  (mapcar (lambda (tr)
	    (destructuring-bind (target rel words)
		tr
	      (list target rel (clean-aux target words))))
	  data))

(defun collect ()
  (let ((tb (make-hash-table :test #'equal)))
    (dolist (trio (clean (cdr data)) tb)
      (push (cons (car trio) (caddr trio))
	    (gethash (cadr trio) tb)))))

(defun filename (url)
  (multiple-value-bind (a b)
      (cl-ppcre:scan-to-strings "<https://w3id.org/own-pt/wn30/schema/([a-zA-Z]+)>" url)
    (declare (ignore a))
    (format nil "~a.txt" (aref b 0))))


(defun save ()
  (maphash (lambda (k vs)
	     (with-open-file (out (filename k) :direction :output :if-exists :supersede)
	       (dolist (v vs)
		 (format out "~a~a~a~%" (car v) #\Tab (cdr v)))))
	   (collect)))



;; sbcl --load process.lisp --eval '(save)' --eval '(sb-ext:quit)'

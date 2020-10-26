;;;;;; This stratum describes a language to create picture primitives from two
;;;;;; dimensional vectors

;;; Takes a list of shapes (lines, curves) and returns a picture function 
(define primitive-picture
  (lambda (los)
    (let ((shapes los))
      (lambda (box)
        (list (map (lambda (shape) (mapper box shape))
             shapes))))))

;;; This functions applies a box to a vector
(define mapper 
  (lambda (box vec)
    (let ((offset (car box))
          (horiz (cadr box))
          (vert (caddr box))
          (x (car vec))
          (y (cadr vec)))
      (+vec offset 
            (+vec (*vec horiz x)
                  (*vec vert y))))))
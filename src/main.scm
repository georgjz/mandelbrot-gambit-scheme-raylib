;;;;;; Simple example of using raylib in Scheme for a Mandelbrot Rendering

;;; Some constants 
(define SCREEN-WIDTH 800)
(define SCREEN-HEIGHT 600)
(define MAX-ITER 100)      ; this used to interpolate between colors, where 100 is black
(define RE-START -2)
(define RE-END 1)
(define IM-START -1)
(define IM-END 1)

;;; Functions! Everything is a function!

;;; Bunch of helper -you guessed it- functions
(define 1+ (lambda (x) (+ x 1)))

(define 1- (lambda (x) (- x 1)))

(define cartesian-map 
  (lambda (list1 list2)
    (apply append 
           (map (lambda (x)
                  (map (lambda (y) (vector x y))
                       list2))
                list1))))

(define make-sequence 
  (lambda (n)
    (letrec ((S (lambda (i acc)
                  (cond 
                    ((zero? i) (cons 0 acc))
                    (else (S (1- i) (cons i acc)))))))
      (S n '()))))
    
;;; Actual stuff for Mandelbrot rendering
(define mandelbrot 
  (lambda (c)
    (letrec ((M (lambda (z i)
                  (cond 
                    ((and (<= (magnitude z) 2)
                          (< i MAX-ITER))
                     (M (+ (* z z) c) (1+ i)))
                    (else i)))))
      (M 0+0i 0))))

(define pixel->complex 
  (lambda (x y)
    (letrec ((make-complex (lambda (x y) (+ x (sqrt (- 0 (* y y))))))
             (a (+ RE-START
                   (* (/ (exact->inexact x) SCREEN-WIDTH)
                      (- RE-END RE-START))))
             (b (+ IM-START
                   (* (/ (exact->inexact y) SCREEN-HEIGHT)
                      (- IM-END IM-START)))))
      (make-complex a b))))

(define colorize*
  (lambda (coords)
    (let* ((c (apply pixel->complex coords))
           (m (exact->inexact (mandelbrot c)))
           (color (inexact->exact (floor (- 255 (/ (* m 255) MAX-ITER))))))
      (list color color color 255))))

(define colorize 
  (lambda (screen)
    (let ((colors (map colorize* screen)))
      (map cons colors screen))))

(define draw 
  (lambda (pixel)
    (let ((vector (map exact->inexact (cdr pixel)))
          (color (car pixel)))
      (draw-pixel-v vector color))))

;;; This represents the screen, each pixel is a proper list (x y)
(define screen-map (map vector->list 
                        (cartesian-map (make-sequence (1- SCREEN-WIDTH))
                                       (make-sequence (1- SCREEN-HEIGHT)))))

;;; Initialize the game
(define init-game 
  (lambda ()
    (begin
     (init-window SCREEN-WIDTH 
                  SCREEN-HEIGHT
                  "Mandelbrot with Gambit Scheme")
     (set-target-fps 60))))

(define main-loop 
  (lambda () 
    (if (not (window-should-close))
        (begin (begin-drawing)
               (clear-background '(255 255 255 255))
               (map draw (colorize screen-map))
              ;  (draw '((255 0 0 255) 300 300))
               (end-drawing)
               (main-loop))
        (begin 
         (close-window)))))

(init-game)
(main-loop)

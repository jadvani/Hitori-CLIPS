;;; IC: Trabajo (2018/2019)
;;; Resolución deductiva del puzlue Hitori
;;; Departamento de Ciencias de la Computación e Inteligencia Artificial 
;;; Universidad de Sevilla
;;;============================================================================


;;;============================================================================
;;; Apellidos: Advani Aguilar	
;;; Nombre: Javier Ivar
;;;============================================================================

;;;============================================================================
;;; HONESTIDAD ACADÉMICA Y COPIAS: un trabajo práctico es un examen, por lo que
;;; debe realizarse de manera individual. La discusión y el intercambio de
;;; información de carácter general con los compañeros se permite (e incluso se
;;; recomienda), pero NO AL NIVEL DE CÓDIGO. Igualmente el remitir código de
;;; terceros, OBTENIDO A TRAVÉS DE LA RED o cualquier otro medio, se considerará
;;; plagio. 
;;;
;;; Cualquier plagio o compartición de código que se detecte significará
;;; automáticamente la calificación de CERO EN LA ASIGNATURA para TODOS los
;;; alumnos involucrados. Por tanto a estos alumnos NO se les conservará, para
;;; futuras convocatorias, ninguna nota que hubiesen obtenido hasta el
;;; momento. SIN PERJUICIO DE OTRAS MEDIDAS DE CARÁCTER DISCIPLINARIO QUE SE
;;; PUDIERAN TOMAR.  
;;;============================================================================

;;;============================================================================
;;; Introducción
;;;============================================================================

;;;   Hitori es uno de los pasatiempos lógicos popularizados por la revista
;;; japonesa Nikoli. El objetivo del juego consiste en, dada una cuadrícula
;;; con cifras, determinar cuales hay que quitar para conseguir que no haya
;;; elementos repetidos ni en las filas ni en las columnas. También hay otras
;;; restricciones sobre la forma en que se puede eliminar estos elementos y las
;;; veremos un poco más adelante.
;;;
;;;   En concreto vamos a considerar cuadrículas de tamaño 9x9 con cifras del 1
;;; al 9 como la siguiente:
;;;
;;;                  ╔═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╗
;;;                  ║ 2 │ 9 │ 8 │ 7 │ 4 │ 6 │ 4 │ 7 │ 6 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 7 │ 4 │ 9 │ 2 │ 8 │ 3 │ 4 │ 3 │ 5 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 4 │ 7 │ 5 │ 3 │ 6 │ 5 │ 6 │ 6 │ 5 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 6 │ 1 │ 3 │ 7 │ 6 │ 9 │ 7 │ 2 │ 4 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 1 │ 3 │ 3 │ 7 │ 2 │ 8 │ 6 │ 5 │ 1 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 9 │ 8 │ 6 │ 2 │ 3 │ 8 │ 5 │ 5 │ 2 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 8 │ 4 │ 7 │ 9 │ 3 │ 3 │ 2 │ 1 │ 6 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 6 │ 2 │ 4 │ 1 │ 7 │ 4 │ 4 │ 9 │ 3 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 8 │ 4 │ 1 │ 3 │ 5 │ 1 │ 9 │ 8 │ 1 ║
;;;                  ╚═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╝
;;;
;;;   El puzle resuelto es el siguiente:
;;;
;;;                  ╔═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╗
;;;                  ║ 2 │ 9 │ 8 │▓▓▓│ 4 │ 6 │▓▓▓│ 7 │▓▓▓║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 7 │▓▓▓│ 9 │ 2 │ 8 │▓▓▓│ 4 │ 3 │ 5 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 4 │ 7 │▓▓▓│ 3 │▓▓▓│ 5 │▓▓▓│ 6 │▓▓▓║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║▓▓▓│ 1 │ 3 │▓▓▓│ 6 │ 9 │ 7 │ 2 │ 4 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 1 │ 3 │▓▓▓│ 7 │ 2 │ 8 │ 6 │ 5 │▓▓▓║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 9 │ 8 │ 6 │▓▓▓│ 3 │▓▓▓│ 5 │▓▓▓│ 2 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 8 │▓▓▓│ 7 │ 9 │▓▓▓│ 3 │ 2 │ 1 │ 6 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 6 │ 2 │▓▓▓│ 1 │ 7 │ 4 │▓▓▓│ 9 │ 3 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║▓▓▓│ 4 │ 1 │▓▓▓│ 5 │▓▓▓│ 9 │ 8 │▓▓▓║
;;;                  ╚═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╝
;;;
;;;   Se deben cumplir dos restricciones adicionales sobre los elementos
;;; eliminados:
;;; 1) No pueden eliminarse elementos en celdas colindantes horizontal o
;;;    verticalmente. 
;;; 2) Todas las celdas cuyo valor se mantiene deben formar una única
;;;    componente conectada horizontal o verticalmente
;;;
;;;   La primera restricción impide que se puedan hacer cosas como esta:
;;;
;;;                  ┼───┼───┼───┼───┼
;;;                  │ 3 │▓▓▓│▓▓▓│ 6 │
;;;                  ┼───┼───┼───┼───┼
;;;
;;;   La segunda restricción impide que se puedan hacer cosas como esta:
;;;
;;;                  ┼───┼───┼───┼
;;;                  │ 3 │▓▓▓│ 7 │
;;;                  ┼───┼───┼───┼
;;;                  │▓▓▓│ 3 │▓▓▓│
;;;                  ┼───┼───┼───┼
;;;                  │ 9 │▓▓▓│ 3 │
;;;                  ┼───┼───┼───┼
;;;
;;;   También es importante tener en cuenta que el puzle tiene solución única,
;;; algo que puede ayudar a obtener dicha solución.
;;;
;;;   Para ello se proporciona un fichero de ejemplos que contiene 50 puzles
;;; Hitori con solución única de tamaño 9x9 representados como una única línea
;;; en la que también se indica la solución. Si se transcribe esta línea 
;;; separando las 9 filas tendríamos lo siguiente:
;;;
;;;     w2 w9 w8 b7 w4 w6 b4 w7 b6 
;;;     w7 b4 w9 w2 w8 b3 w4 w3 w5 
;;;     w4 w7 b5 w3 b6 w5 b6 w6 b5 
;;;     b6 w1 w3 b7 w6 w9 w7 w2 w4 
;;;     w1 w3 b3 w7 w2 w8 w6 w5 b1 
;;;     w9 w8 w6 b2 w3 b8 w5 b5 w2 
;;;     w8 b4 w7 w9 b3 w3 w2 w1 w6 
;;;     w6 w2 b4 w1 w7 w4 b4 w9 w3 
;;;     b8 w4 w1 b3 w5 b1 w9 w8 b1 
;;;
;;; donde cada número se corresponde con la cifra que originalmente hay en cada
;;; celda y las letras w y b representan si en la solución dicho número se
;;; mantiene (w) o se elimina (b).

;;;============================================================================
;;; Representación del Hitori
;;;============================================================================

;;;   Utilizaremos la siguiente plantilla para representar las celdas del
;;; Hitori. Cada celda tiene los siguientes campos:
;;; - fila: Número de fila en la que se encuentra la celda
;;; - columna: Número de columna en la que se encuentra la celda
;;; - valor: Valor numérico de la celda
;;; - estado: Estado de la celda. Puede ser 'desconocido', que indica que
;;;   todavía no se ha tomado ninguna decisión sobre la celda; 'asignado', que
;;;   incida que el valor de la celda se mantiene en la solución; y
;;;   'eliminado', que indica que el valor de la celda es eliminado en la
;;;   solución. El valor por defecto es 'desconocido'.

(deftemplate celda
  (slot fila)
  (slot columna)
  (slot valor)
  (slot estado
	(allowed-values desconocido asignado eliminado)
	(default desconocido)))

;;;============================================================================
;;; Estrategias de resolución
;;;============================================================================

;;;   El objetivo de este trabajo es implementar un programa CLIPS que resuelva
;;; un Hitori de forma deductiva, es decir, deduciendo si el número de una
;;; celda debe eliminarse o debe mantenerse a partir de reglas que analicen los
;;; valores y situaciones de las celdas relacionadas.

(defrule repetido-tres-columna
  ?h1<-(celda (fila ?f1) (columna ?c) (valor ?v) (estado desconocido))
  ?h2<-(celda (fila ?f2) (columna ?c) (valor ?v) (estado desconocido))
  ?h3<-(celda (fila ?f3) (columna ?c) (valor ?v) (estado desconocido))
  (test ( and 
	(eq (- ?f1 ?f2) 1) 
	(eq (- ?f2 ?f3) 1)))
  =>
  (modify ?h1 (estado eliminado))
  (modify ?h2 (estado asignado))
  (modify ?h3 (estado eliminado)))

(defrule repetido-tres-fila
  ?h1<-(celda (fila ?f) (columna ?c1) (valor ?v) (estado desconocido))
  ?h2<-(celda (fila ?f) (columna ?c2) (valor ?v) (estado desconocido))
  ?h3<-(celda (fila ?f) (columna ?c3) (valor ?v) (estado desconocido))
  (test ( and (eq (- ?c1 ?c2) 1) (eq (- ?c2 ?c3) 1))) 
  =>
  (modify ?h1 (estado eliminado))
  (modify ?h2 (estado asignado))
  (modify ?h3 (estado eliminado))) 

(defrule pair-induction-fila
  ?h1<-(celda (fila ?f) (columna ?c1) (valor ?v) (estado desconocido))
  ?h2<-(celda (fila ?f) (columna ?c2) (valor ?v) (estado desconocido))
  ?h3<-(celda (fila ?f) (columna ?c3) (valor ?v) (estado desconocido))
  (test (and (eq (- ?c1 ?c2) 1) (and (neq ?c3 ?c2) (neq ?c1 ?c3))))
  =>
  (modify ?h3 (estado eliminado))) 
  
(defrule pair-induction-columna
  ?h1<-(celda (fila ?f1) (columna ?c) (valor ?v) (estado desconocido))
  ?h2<-(celda (fila ?f2) (columna ?c) (valor ?v) (estado desconocido))
  ?h3<-(celda (fila ?f3) (columna ?c) (valor ?v) (estado desconocido))
  (test (and (eq (- ?f1 ?f2) 1) (and (neq ?f3 ?f2) (neq ?f1 ?f3))))
  =>
  (modify ?h3 (estado eliminado))) 

(defrule assign-around-cell-left
  (celda (fila ?f) (columna ?c1) (estado eliminado))
  ?h1<-(celda (fila ?f) (columna ?c2) (estado desconocido))
  (test (eq (- ?c1 ?c2) 1))
    =>
  (modify ?h1 (estado asignado))
)

(defrule assign-around-cell-right
  (celda (fila ?f) (columna ?c1) (estado eliminado))
  ?h1<-(celda (fila ?f) (columna ?c2) (estado desconocido))
  (test (eq (- ?c1 ?c2) -1))
    =>
  (modify ?h1 (estado asignado))
)

(defrule assign-around-cell-up
  (celda (fila ?f1) (columna ?c) (estado eliminado))
  ?h1<-(celda (fila ?f2) (columna ?c) (estado desconocido))
  (test (eq (- ?f1 ?f2) 1))
    =>
  (modify ?h1 (estado asignado))
)

(defrule assign-around-cell-down
  (celda (fila ?f1) (columna ?c) (estado eliminado))
  ?h1<-(celda (fila ?f2) (columna ?c) (estado desconocido))
  (test (eq (- ?f1 ?f2) -1))
    =>
  (modify ?h1 (estado asignado))
)

(defrule delete-same-row-value
  (celda (fila ?f1) (columna ?c) (valor ?v) (estado asignado))
  ?h1<-(celda (fila ?f2) (columna ?c) (valor ?v) (estado desconocido))
  (test (neq ?f1 ?f2))
    =>
  (modify ?h1 (estado eliminado))
)

(defrule delete-same-column-value
  (celda (fila ?f) (columna ?c1) (valor ?v) (estado asignado))
  ?h1<-(celda (fila ?f) (columna ?c2) (valor ?v) (estado desconocido))
  (test (neq ?c1 ?c2))
    =>
  (modify ?h1 (estado eliminado))
)

(defrule square-between-a-pair-row
  (celda (fila ?f) (columna ?c1) (valor ?v1))
  (celda (fila ?f) (columna ?c3) (valor ?v1))
  ?h1<-(celda (fila ?f) (columna ?c2) (valor ?v2) (estado desconocido))
  (test (and (and (eq (- ?c1 ?c2) 1) (eq (- ?c2 ?c3) 1)) (neq ?v1 ?v2)))
    =>
  (modify ?h1 (estado asignado))
)

(defrule square-between-a-pair-column
  (celda (fila ?f1) (columna ?c) (valor ?v1))
  (celda (fila ?f3) (columna ?c) (valor ?v1))
  ?h1<-(celda (fila ?f2) (columna ?c) (valor ?v2) (estado desconocido))
  (test (and (and (eq (- ?f1 ?f2) 1) (eq (- ?f2 ?f3) 1)) (neq ?v1 ?v2)))
    =>
  (modify ?h1 (estado asignado))
)

(defrule unassigned-unique-value-row-column
  (declare (salience -7))
  (celda (fila ?f1) (columna ?c1) (valor ?v1) (estado asignado))
  (celda (fila ?f2) (columna ?c2) (valor ?v2) (estado asignado))
  ?h1<-(celda (fila ?f1) (columna ?c2) (valor ?v3) (estado desconocido))
  (test (and (and (neq ?f1 ?f2) (neq ?c1 ?c2)) (and (neq ?v1 ?v3) (neq ?v2 ?v3))))
    =>
  (modify ?h1 (estado asignado))
)


;;;============================================================================
;;; Reglas para imprimir el resultado
;;;============================================================================

;;;   Las siguientes reglas permiten visualizar el estado del hitori, una vez
;;; aplicadas todas las reglas que implementan las estrategias de resolución.
;;; La prioridad de estas reglas es -10 para que sean las últimas en aplicarse.

;;;   Para cualquier puzle se muestra a la izquierda el estado inicial del
;;; tablero y a la derecha la situación a la que se llega tras aplicar todas
;;; las estrategias de resolución. En el tablero de la derecha, las celdas que
;;; tienen un estado 'asignado' contienen el valor numérico asociado, las
;;; celdas que tienen un estado 'eliminado' contienen un espacio en blanco y
;;; las celdas con el estado 'desconocido' contienen un símbolo '?'.

(defrule imprime-solucion
  (declare (salience -10))
  =>
  (printout t " Original           Solución " crlf)  
  (printout t "+---------+        +---------+" crlf)
  (assert (imprime 1)))

(defrule imprime-fila
  (declare (salience -10))
  ?h <- (imprime ?i&:(<= ?i 9))
  (celda (fila ?i) (columna 1) (valor ?v1) (estado ?s1))
  (celda (fila ?i) (columna 2) (valor ?v2) (estado ?s2))
  (celda (fila ?i) (columna 3) (valor ?v3) (estado ?s3))
  (celda (fila ?i) (columna 4) (valor ?v4) (estado ?s4))
  (celda (fila ?i) (columna 5) (valor ?v5) (estado ?s5))
  (celda (fila ?i) (columna 6) (valor ?v6) (estado ?s6))
  (celda (fila ?i) (columna 7) (valor ?v7) (estado ?s7))
  (celda (fila ?i) (columna 8) (valor ?v8) (estado ?s8))
  (celda (fila ?i) (columna 9) (valor ?v9) (estado ?s9))
  =>
  (retract ?h)
  (bind ?fila1 (sym-cat ?v1 ?v2 ?v3 ?v4 ?v5 ?v6 ?v7 ?v8 ?v9))
  (bind ?w1 (if (eq ?s1 asignado) then ?v1
	      else (if (eq ?s1 eliminado) then " " else "?")))
  (bind ?w2 (if (eq ?s2 asignado) then ?v2
	      else (if (eq ?s2 eliminado) then " " else "?")))
  (bind ?w3 (if (eq ?s3 asignado) then ?v3
	      else (if (eq ?s3 eliminado) then " " else "?")))
  (bind ?w4 (if (eq ?s4 asignado) then ?v4
	      else (if (eq ?s4 eliminado) then " " else "?")))
  (bind ?w5 (if (eq ?s5 asignado) then ?v5
	      else (if (eq ?s5 eliminado) then " " else "?")))
  (bind ?w6 (if (eq ?s6 asignado) then ?v6
	      else (if (eq ?s6 eliminado) then " " else "?")))
  (bind ?w7 (if (eq ?s7 asignado) then ?v7
	      else (if (eq ?s7 eliminado) then " " else "?")))
  (bind ?w8 (if (eq ?s8 asignado) then ?v8
	      else (if (eq ?s8 eliminado) then " " else "?")))
  (bind ?w9 (if (eq ?s9 asignado) then ?v9
	      else (if (eq ?s9 eliminado) then " " else "?")))
  (bind ?fila2 (sym-cat ?w1 ?w2 ?w3 ?w4 ?w5 ?w6 ?w7 ?w8 ?w9))
  (printout t "|" ?fila1 "|        |" ?fila2 "|" crlf)
  (if (= ?i 9)
      then (printout t "+---------+        +---------+" crlf)
    else (assert (imprime (+ ?i 1)))))

;;;============================================================================
;;; Funcionalidad para leer los puzles del fichero de ejemplos
;;;============================================================================

;;;   Esta función construye los hechos que describen un puzle a partir de una
;;; línea leida del fichero de ejemplos.

(deffunction procesa-datos-ejemplo (?datos)
  (loop-for-count
   (?i 1 9)
   (loop-for-count
    (?j 1 9)
    (bind ?s1 (* 2 (+ ?j (* 9 (- ?i 1)))))
    (bind ?v (sub-string ?s1 ?s1 ?datos))
    (assert (celda (fila ?i) (columna ?j) (valor ?v))))))

;;;   Esta función localiza el puzle que se quiere resolver en el fichero de
;;; ejemplos. 

(deffunction lee-puzle (?n)
  (open "ejemplos.txt" data "r")
  (loop-for-count (?i 1 (- ?n 1))
                  (readline data))
  (bind ?datos (readline data))
  (reset)
  (procesa-datos-ejemplo ?datos)
  (run)
  (close data))

;;;   Esta función comprueba todos los puzles de un fichero que se pasa como
;;; argumento. Se usa:
;;; CLIPS> (procesa-ejemplos)

(deffunction procesa-ejemplos ()
  (open "ejemplos.txt" data "r")
  (bind ?datos (readline data))
  (bind ?i 1)
  (while (neq ?datos EOF)
    (reset)
    (procesa-datos-ejemplo ?datos)
    (printout t "ejemplos.txt :" ?i crlf)
    (run)
    (bind ?datos (readline data))
    (bind ?i (+ ?i 1)))
  (close data))

;;;============================================================================


// FALLA A LA HORA DE IMPRIMIR

func listruta(rut,tit)
local oldarea,rutero:=rut,pag:=0,bandera:=0,contador:=0,cont:=0,bandera2:=0
oldarea:=select()
use clientes new
dbgotop()
do while !eof()
        if ruta==rutero
                contador:=contador+1
        endif
        dbskip()
enddo
dbgotop()
set device to printer
do while !eof()
        if bandera=0
                @ 2,0 say tit
                @ 4,0 say "Ru."
                @ 4,5 SAY 'C¢d.'
                @ 4,16 SAY 'Nombre'
                @ 4,56 SAY 'Observaciones'
                FOR COL=0 TO 77
                        @ 5,COL SAY 'Ä' COLOR ("G+/B")
                NEXT
                @ 5,3 say 'Â'
                @ 5,10 say 'Â'
                @ 5,46 say 'Â'
                bandera:=1
        endif
        contador:=contador+6
        fil:=6
        do while fil!=contador
                if ruta==rutero
                        @ fil,1 say ruta
                        @ fil,3 say '³'
                        @ fil,4 say codcli
                        @ fil,10 say '³'
                        @ fil,11 say nombre
                        @ fil,46 say '³'
                        @ fil,48 say observa
                        bandera2:=1
                endif
                if bandera2=1
                        fil++
                        bandera2:=0
                endif
                dbskip()
        enddo
        for cont=contador to 60
             @ cont,3 say '³'
             @ cont,10 say '³'
             @ cont,46 say '³'
        next
        FOR COL=0 TO 77
                @ 61,COL SAY 'Ä' COLOR ("G+/B")
        NEXT
        @ 61,3 say 'Á'
        @ 61,10 say 'Á'
        @ 61,46 say 'Á'
        if eof()
                pag++
                @ 63,19 SAY 'Pagina:'
                @ 63,27 say pag
                exit
        endif
        if fil==60 .or. !eof()
                pag++
                @ 63,19 SAY 'Pagina:'
                @ 63,27 say pag
                bandera:=0
        endif
        if eof()
                exit
        endif
enddo
close clientes
select(oldarea)
set printer off
set device to screen
MSON()
return






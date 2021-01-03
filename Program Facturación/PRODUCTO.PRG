*******************************************************************
FUNC ALTpro()
*******************************************************************
local OPC,cod:=space(4),nom:=space(40),prec:=0
local oldarea,PAN
PRIV TECLA
set scoreboard off
set confirm on
set escape on
set bell on
msoff()
OLDAREA:=SELECT()
USE producto NEW
INDEX ON CODpro TO producto UNIQUE
SET INDEX TO producto
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 4,20 SAY "                  Nuevo producto                  " color ("W+/R")
        @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
        COD:=SPACE(4)
        nom:=SPACE(40)
        @ 7,22 SAY "C¢digo del producto:" color ("W+/B")
        @ 9,22 say "Nombre:" COLOR ("W+/B")
        //@ 11,22 say "Precio:" color ("W+/B")
        SET CURSOR ON
        @ 7,43 get cod color ("W+/G")
        read
        seek cod
        if found()
                MSGBOX('Ese c¢digo ya fue utilizado')
        else
                @ 9,30 GET Nom COLOR ("W+/G")
               // @ 11,30 get prec color ("W+/G")
                read
                SET CURSOR OFF
                if !lastkey()==27
                        append blank
                        replace codpro with cod,nompro with nom //precio with prec
                endif
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
ENDDO
CLOSE producto
SELECT(OLDAREA)
MSON()
return
******************************************************************
FUNC BORpro()
******************************************************************
local oldarea,pan,cod:=space(4),nom:=space(40),prec:=0,opc,OPCION
priv bandera:=0
set delete on
set scoreboard off
set confirm on
set escape on
set bell on
oldarea:=select()
use producto new
set index to producto
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        bandera:=0
        @ 4,20 SAY "                  Borrar producto                  " color ("W+/R")
        @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
        Nom:=SPACE(40)
        cod:=SPACE(4)
        @ 7,22 SAY "C¢digo del producto" color ("W+/B")
        @ 9,22 say "Nombre" COLOR ("W+/B")
        //@ 11,22 say "Precio:" color ("W+/B")
        set cursor on
        @ 7,43 get cod color ("W+/G")
        read
        set cursor off
        seek cod
        if found()
                @ 7,43 say codpro color ("W+/G")
                @ 9,30 say nompro COLOR ("W+/G")
          //      @ 11,30 say precio color ("W+/G")
                INKEY(0)
                opc:=ALERT('®Desea borrar la ficha?',{'Si','No'})
                do case
                        case opc = 1
                                bandera:=1
                                delete
                        case opc = 2
                                MSGBOX('Ficha no borrada a petici¢n del usuario')
                endcase
        else
                MSGBOX('Ficha no encontrada ¢ no existe')
        endif
        RESTORE SCREEN FROM PAN
        if bandera = 1
                MSGBOX('Se va a proceder a compactar el fichero')
                pack
                MSGBOX('Fichero compactado')
        endif
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
enddo
set delete off
close producto
SELECT(OLDAREA)
MSON()
return
****************************************************************************
FUNC CONpro()
****************************************************************************
LOCAL OLDAREA,cod:=space(4),nom:=space(40),prec:=0
local tecla
OLDAREA:=SELECT()
USE producto NEW
index on codpro to producto unique
set index to producto
set scoreboard off
set confirm on
set escape on
set bell on
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 4,20 SAY "                  Nuevo producto                  " color ("W+/R")
        @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
        Nom:=SPACE(40)
        cod:=SPACE(4)
        //prec:=0
        @ 7,22 SAY "C¢digo del producto:" color ("W+/B")
        @ 9,22 say "Nombre:" COLOR ("W+/B")
       // @ 11,22 say "Precio:" color ("W+/B")
        @ 7,43 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
                @ 7,43 say codpro color ("W+/G")
                @ 9,30 say nompro COLOR ("W+/G")
         //       @ 11,30 say precio color ("W+/G")
                inkey(0)
        else
                MSGBOX('Ese producto no existe')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close producto
SELECT(OLDAREA)
MSON()
return
*************************************************************************
FUNC MODpro()
*************************************************************************
LOCAL OLDAREA,pan,pan2,cod:=space(4),nom:=space(40),prec:=0
local tecla,res:=space(1)
OLDAREA:=SELECT()
USE producto NEW
index on codpro to producto unique
set index to producto
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 4,20 SAY "                  Nuevo producto                  " color ("W+/R")
        @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
        Nom:=SPACE(40)
        cod:=SPACE(4)
        //prec:=0
        @ 7,22 SAY "C¢digo del producto:" color ("W+/B")
        @ 9,22 say "Nombre:" COLOR ("W+/B")
       // @ 11,22 say "Precio:" color ("W+/B")
        @ 7,43 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
                @ 7,43 say codpro color ("W+/G")
                @ 9,30 say nompro COLOR ("W+/G")
         //       @ 11,30 say precio color ("W+/G")
                inkey(0)
                save screen to pan2
                res:=alert('Desea modificar el producto',{'Si','No'})
                if res == 1
                        nom:=nompro
           //             prec:=precio
                        @ 7,43 get cod color ("W+/G")
                        @ 9,30 GET Nom COLOR ("W+/G")
             //           @ 11,30 get prec COLOR ("W+/G")
                        SET CURSOR ON
                        READ
                        SET CURSOR OFF
                        if !lastkey()==27
                                replace codpro with cod,nompro with nom //precio with prec
                        endif

                ELSE
                        MSGBOX("Ficha no modificada")
                endif
        else
                MSGBOX('Ese producto no existe')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close producto
SELECT(OLDAREA)
MSON()
return
*************************************************************************
func listpanpro()
*************************************************************************
local oldarea,pantalla,fil:=0,COL:=0,f:=0
oldarea:=select()
msoff()
use producto
set scoreboard off
dbgotop()
save screen to pantalla
@ 2,4 say '                    Listado de productos                       ' color("W+/R")
@ 3,5,20,67 box ('≤≤≤≤≤≤≤≤≤') color ("N+")
@ 3,4,19,66 box ('€€€€€€€€€') color ("B")
@ 4,5 SAY 'C¢digo' color ("G+/B")
@ 4,25 SAY 'Producto' color ("G+/B")
//@ 4,55 say 'Precio' color ("G+/B")
FOR COL=4 TO 66
        @ 5,COL SAY 'ƒ' COLOR ("G+/B")
NEXT
@ 5,12 say '¬' color ("G+/B")
for f=6 to 19
        @ f,12 say '≥' color ("G+/B")
next
do while !eof()
        for fil=7 to 18
                @ 5,12 say '¬' color ("G+/B")
                for f=6 to 19
                        @ f,12 say '≥' color ("G+/B")
                next
                        @ fil,5 say codpro color ("W+/B")
                        @ fil,15 say nompro color ("W+/B")
  //                      @ fil,55 say precio color ("W+/B")
                        dbskip()
                if fil==18 .and. !eof()
                        @ 24,13 SAY '        Pulse cualquier tecla para continuar...          ' color ("W+/B")
                        INKEY(0)
                ENDIF
        next
        if eof()
                inkey(0)
                exit
        endif
enddo
restore screen from pantalla
close producto
select(oldarea)
MSON()
return

*****************************************
func listimpPRO()
*****************************************
local oldarea,pantalla,fil:=0,COL:=0,f:=0,pag:=0
oldarea:=select()
msoff()
use PRODUCTO new
set device to print
//do while isprinter()=.f. or lastkey()=27
  //      if !isprinter()
    //            ALERT('La impresora no funciona')
      //  endif
//enddo
//if isprinter()=.f.
  //      alert('Se aborta la impresion a peticion del usuario')
    //    exit
//endif
dbgotop()
do while !eof()
        @ 2,0 say '                             Listado de productos                              '
        @ 4,5 SAY 'C¢digo'
        @ 4,25 SAY 'Producto'
        FOR COL=0 TO 77
                @ 5,COL SAY 'ƒ' COLOR ("G+/B")
        NEXT
        @ 5,10 say '¬'
        for fil=6 to 60
                        @ fil,4 say codpro
                        @ fil,10 say '≥'
                        @ fil,11 say nompro
                        dbskip()
        next
        FOR COL=0 TO 77
                @ 61,COL SAY 'ƒ' COLOR ("G+/B")
        NEXT
        @ 61,10 say '¡'
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
                eject
        endif
enddo
close producto
select(oldarea)
set device to screen
MSON()
return













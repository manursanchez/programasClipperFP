FUNC AltCli()
*******************************************************************
local RUT:=SPACE(1),COD:=SPACE(4),NIF:=SPACE(16),NOM:=SPACE(40),DOM:=SPACE(30),TLF:=space(10)
LOCAL OBS:=SPACE(30)
local oldarea,PAN,OPC
PRIV TECLA
set scoreboard off
set confirm on
set escape on
msoff()
OLDAREA:=SELECT()
USE clientes NEW
INDEX ON CODCLI TO indice1
SET INDEX TO indice1
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 3,14 SAY "                  Nuevo cliente                    " color ("W+/B+")
        @ 4,15,20,65 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 4,14,19,64 box ('€€€€€€€€€') color ("B")
        RUT:=SPACE(1)
        COD:=SPACE(4)
        NIF:=SPACE(15)
        NOM:=SPACE(40)
        DOM:=SPACE(30)
        OBS:=SPACE(30)
        TLF:=space(10)
        @ 5,15 SAY "Ruta:" color ("W+/B")
        @ 7,15 SAY "C¢digo de cliente:" color ("W+/B")
        @ 9,15 say "DNI:" COLOR ("W+/B")
        @ 11,15 SAY "Nombre:" COLOR ("W+/B")
        @ 13,15 say "Domicilio:" COLOR ("W+/B")
        @ 15,15 say "Observaciones:" COLOR ("W+/B")
        @ 17,15 say "Telefono:" COLOR ("W+/B")
        @ 5,21 get rut PICT "!" valid rut $ "LMXJV" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        SET CURSOR ON
        read
        seek cod
        if found()
                MSGBOX('El cliente ya fue introducido por ese c¢digo')
        else
                @ 9,20 GET nif COLOR ("W+/G")
                @ 11,23 GET nom COLOR ("W+/G")
                @ 13,32 GET dom COLOR ("W+/G")
                @ 15,32 GET obs COLOR ("W+/G")
                @ 17,32 GET tlf COLOR ("W+/G")
                read
                SET CURSOR OFF
                if !lastkey()==27
                        append blank
                        replace codcli with cod,nombre with nom,;
                                domicilio with dom,telefono with tlf,;
                                dni with nif,ruta with rut,observa with obs
                endif
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
ENDDO
CLOSE clientes
SELECT(OLDAREA)
MSON()
return
******************************************************************
FUNC BorCli()
******************************************************************
local RUT:=SPACE(1),COD:=SPACE(4),NIF:=SPACE(15),NOM:=SPACE(40),DOM:=SPACE(30),TLF:=space(10)
LOCAL OBS:=SPACE(30)
local oldarea,pan,opc,OPCION
priv bandera:=0
set delete on
set scoreboard off
set confirm on
set escape on
set bell on
oldarea:=select()
use clientes new
set index to indice1
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        bandera:=0
        @ 3,14 SAY "                  Borrar clientes                  " color ("W+/B+")
        @ 4,15,20,65 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 4,14,19,64 box ('€€€€€€€€€') color ("B")
        RUT:=SPACE(1)
        COD:=SPACE(4)
        NIF:=SPACE(15)
        NOM:=SPACE(40)
        DOM:=SPACE(30)
        OBS:=SPACE(30)
        TLF:=space(10)
        @ 5,15 SAY "Ruta:" color ("W+/B")
        @ 7,15 SAY "C¢digo de cliente:" color ("W+/B")
        @ 9,15 say "DNI:" COLOR ("W+/B")
        @ 11,15 SAY "Nombre:" COLOR ("W+/B")
        @ 13,15 say "Domicilio:" COLOR ("W+/B")
        @ 15,15 say "Observaciones:" COLOR ("W+/B")
        @ 17,15 say "Telefono:" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
                @ 5,21 SAY Ruta color ("W+/G")
                @ 7,40 say codcli color ("W+/G")
                @ 9,20 say dni COLOR ("W+/G")
                @ 11,23 say nombre COLOR ("W+/G")
                @ 13,32 say domicilio COLOR ("W+/G")
                @ 15,32 say observa COLOR ("W+/G")
                @ 17,32 say telefono COLOR ("W+/G")
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
close clientes
SELECT(OLDAREA)
MSON()
return
****************************************************************************
FUNC ConCli()
****************************************************************************
local RUT:=SPACE(1),COD:=SPACE(4),NIF:=SPACE(15),NOM:=SPACE(40),DOM:=SPACE(30),TLF:=space(10)
LOCAL OLDAREA,OBS:=SPACE(30)
OLDAREA:=SELECT()
USE clientes NEW
set index to indice1
set scoreboard off
set confirm on
set escape on
set bell on
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 3,14 SAY "                Consultar cliente                  " color ("W+/B+")
        @ 4,15,20,65 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 4,14,19,64 box ('€€€€€€€€€') color ("B")
        RUT:=SPACE(1)
        COD:=SPACE(4)
        NIF:=SPACE(15)
        NOM:=SPACE(40)
        DOM:=SPACE(30)
        OBS:=SPACE(30)
        TLF:=space(10)
        @ 5,15 say "Ruta:" color ("W+/B")
        @ 7,15 SAY "C¢digo de cliente:" color ("W+/B")
        @ 9,15 say "DNI:" COLOR ("W+/B")
        @ 11,15 SAY "Nombre:" COLOR ("W+/B")
        @ 13,15 say "Domicilio:" COLOR ("W+/B")
        @ 15,15 say "Observaciones:" COLOR ("W+/B")
        @ 17,15 say "Telefono:" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
                @ 5,21 say ruta color ("W+/B")
                @ 7,40 say codcli color ("W+/G")
                @ 9,20 say dni COLOR ("W+/G")
                @ 11,23 say nombre COLOR ("W+/G")
                @ 13,32 say domicilio COLOR ("W+/G")
                @ 15,32 say observa COLOR ("W+/G")
                @ 17,32 say telefono COLOR ("W+/G")
                inkey(0)
        else
                MSGBOX('Ese cliente no se encuentra')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close clientes
SELECT(OLDAREA)
MSON()
return
*************************************************************************
FUNC ModCli()
*************************************************************************
local RUT:=SPACE(1),COD:=SPACE(4),NIF:=SPACE(15),NOM:=SPACE(40),DOM:=SPACE(30),TLF:=space(10)
LOCAL OLDAREA,pan,pan2,OBS:=SPACE(30)
local tecla,res:=space(1)
OLDAREA:=SELECT()
USE clientes NEW
set index to INDICE1
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 3,14 SAY "                Modificar cliente                  " color ("W+/B+")
        @ 4,15,20,65 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 4,14,19,64 box ('€€€€€€€€€') color ("B")
        RUT:=SPACE(1)
        COD:=SPACE(4)
        NIF:=SPACE(15)
        NOM:=SPACE(40)
        DOM:=SPACE(30)
        OBS:=SPACE(30)
        TLF:=space(10)
        @ 5,15 SAY "Ruta:" color ("W+/B")
        @ 7,15 SAY "C¢digo de cliente:" color ("W+/B")
        @ 9,15 say "DNI:" COLOR ("W+/B")
        @ 11,15 SAY "Nombre:" COLOR ("W+/B")
        @ 13,15 say "Domicilio:" COLOR ("W+/B")
        @ 15,15 say "Observaciones:" COLOR ("W+/B")
        @ 17,15 say "Telefono:" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
                @ 5,21 say ruta color ("W+/B")
                @ 7,40 say codcli color ("W+/G")
                @ 9,20 say dni COLOR ("W+/G")
                @ 11,23 say nombre COLOR ("W+/G")
                @ 13,32 say domicilio COLOR ("W+/G")
                @ 15,32 say observa COLOR ("W+/G")
                @ 17,32 say telefono COLOR ("W+/G")
                inkey(0)
                save screen to pan2
                res:=alert('Est† seguro que quiere modificar el cliente',{'Si','No'})
                read
                restore screen from pan2
                if res == 1
                        rut:=ruta
                        cod:=codcli
                        nif:=dni
                        nom:=nombre
                        dom:=domicilio
                        obs:=observa
                        tlf:=telefono
                        @ 5,21 get rut PICT "!" valid rut $ "LMXJV" COLOR ("W+/B")
                        @ 7,40 get cod color ("W+/G")
                        @ 9,20 GET nif COLOR ("W+/G")
                        @ 11,23 GET nom COLOR ("W+/G")
                        @ 13,32 GET dom COLOR ("W+/G")
                        @ 15,32 GET obs COLOR ("W+/G")
                        @ 17,32 GET tlf COLOR ("W+/G")
                        SET CURSOR ON
                        READ
                        SET CURSOR OFF
                        if !lastkey()==27
                                replace codcli with cod,nombre with nom,;
                                        domicilio with dom,telefono with tlf,;
                                        dni with nif,ruta with rut,observa with obs
                        endif

                ELSE
                        MSGBOX("Ficha no modificada")
                endif
        else
                MSGBOX('Ese cliente no existe')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'Si','No'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close clientes
SELECT(OLDAREA)
MSON()
return
*************************************************************************
func listpan()
*************************************************************************
local oldarea,pantalla,fil:=0,COL:=0,f:=0
oldarea:=select()
msoff()
use clientes new
set scoreboard off
dbgotop()
save screen to pantalla
@ 2,0 say '                             Listado de clientes                              ' color("W+/B+")
@ 3,1,20,78 box ('≤≤≤≤≤≤≤≤≤') color ("N+")
@ 3,0,19,77 box ('€€€€€€€€€') color ("B")
@ 4,0 say "Ru." color ("G+/B")
@ 4,5 SAY 'C¢d.' color ("G+/B")
@ 4,29 SAY 'Nombre' color ("G+/B")
@ 4,56 SAY 'Observaciones' color ("G+/B")
FOR COL=0 TO 77
        @ 5,COL SAY 'ƒ' COLOR ("G+/B")
NEXT
@ 5,3 say '¬' color ("G+/B")
@ 5,10 say '¬' color ("G+/B")
@ 5,46 say '¬' color ("G+/B")
for f=6 to 19
        @ f,3 say '≥' color ("G+/B")
        @ f,10 say '≥' color ("G+/B")
        @ f,46 say '≥' color ("G+/B")
next
do while !eof()
        for fil=7 to 18
                        @ fil,1 say ruta color ("W+/B")
                        @ fil,4 say codcli color ("W+/B")
                        @ fil,11 say nombre color ("W+/B")
                        @ fil,48 say observa color ("W+/B")
                        for f=6 to 19
                                @ f,46 say '≥' color ("G+/B")
                        next
                        dbskip()
                if fil==18 .and. !eof()
                        @ 25,19 SAY '        Pulse cualquier tecla para continuar...   ' color ("W+/B")
                        INKEY(0)
                ENDIF
        next
        if eof()
                inkey(0)
                exit
        endif
enddo
restore screen from pantalla
close clientes
select(oldarea)
MSON()
return
*****************************************
func listimp()
*****************************************
local oldarea,pantalla,fil:=0,COL:=0,f:=0,pag:=0
oldarea:=select()
msoff()
use clientes new
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
        @ 2,0 say '                             Listado de clientes                              '
        @ 4,0 say "Ru."
        @ 4,5 SAY 'C¢d.'
        @ 4,16 SAY 'Nombre'
        @ 4,56 SAY 'Observaciones'
        FOR COL=0 TO 77
                @ 5,COL SAY 'ƒ' COLOR ("G+/B")
        NEXT
        @ 5,3 say '¬'
        @ 5,10 say '¬'
        @ 5,46 say '¬'
        for fil=6 to 60
                        @ fil,1 say ruta
                        @ fil,3 say '≥'
                        @ fil,4 say codcli
                        @ fil,10 say '≥'
                        @ fil,11 say nombre
                        @ fil,46 say '≥'
                        @ fil,48 say observa
                        dbskip()
        next
        FOR COL=0 TO 77
                @ 61,COL SAY 'ƒ' COLOR ("G+/B")
        NEXT
        @ 61,3 say '¡'
        @ 61,10 say '¡'
        @ 61,46 say '¡'
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
close clientes
select(oldarea)
set device to screen
MSON()
return





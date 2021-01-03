
FUNC CONSULTAS_E()
res:="S"
use editori
do while res=="S"
        CUADROS1()
        @ 1,25 say ' CONSULTAS '
        cod:=space(4)
        @ 23,18 say 'Codigo de la editorial' get cod valid cod>space(4)
        read
        locate for codigo==cod
        if found()
                        @ 5,25 say 'CODIGO:'
                        ?? codigo
                        @ 7,12 say 'EDITORIAL:'
                        ?? editorial
        else
                alert ('Ficha no encontrada ¢ no existe')
        endif
        res:=space(1)
        @ 23,18 say '¨Quiere consultar mas [S/N]?';
        get res pict "!" valid res $ "SN"
        read
enddo
close editori
RETURN

FUNC ALTAS_E()
res:='S'
use editori
do while res=='S'
        CUADROS1()
        @ 1,25 say ' ALTAS '
        cod:=space(4);edit:=space(30)
        @ 5,25 say 'CODIGO:' get cod valid cod>space(4)
        read
        locate for codigo==cod
        if found()
                alert ('Este codigo ya ha sido utilizado')
        else
                @ 7,12 say 'EDITORIAL:' get edit
               // pict "@s10"
                read
                res:= space(1)
                @ 23,18 say '¨Esta conforme con los datos [S/N]?';
                        get res pict "!" valid res $ "SN"
                read

                if res == "S"
                        append blank
                        replace codigo with cod,editorial with edit
                endif
        endif
        res:=space(1)
        @ 23,18 say '¨Quieres introducir mas altas [s/n]? ';
                    get res pict "!" valid res $ "SN"
        read
enddo
close editori
RETURN

FUNC BAJAS_E()
set deleted on
res:='S';bandera:=0
use editori
do while res == "S"
        CUADROS1()
        @ 1,25 say ' BAJAS '
        cod:=space(4)
        @ 18,18 say 'Codigo de la editorial' get cod valid cod>space(4)
        read
        locate for codigo==cod
        if found()
                        @ 7,12 say 'EDITORIAL:'
                        ?? edit
                        res:=space(1)
                        @ 23,18 say '¨Quiere dar de baja [S/N]?';
                        get res pict "!" valid res $ "SN"
                        read
                        if res=="S"
                                bandera:=1
                                delete
                        else
                                @ 23,18 say 'Editorial no dada de baja'
                                inkey(0)
                        endif
        else
                alert ('No existe ese c¢digo')
        endif
        res:=space(1)
        @ 23,18 say '¨Quieres dar mas de baja [s/n]? ';
                    get res pict "!" valid res $ "SN"
        read
enddo
if bandera==1
        alert ('Se va a proceder a una compactaci¢n del fichero')
        pack
endif
set delete off
close editori
RETURN

FUNC MODIFICA_E()
res:="S"
use editori
do while res=="S"
        CUADROS1()
        @ 1,25 say ' MODIFICACIONES '
        cod:=space(4);edit:=space(30)
        @ 18,18 say 'Codigo de la editorial' get cod valid cod>space(4)
        read
        locate for codigo=cod
        if found()
                cod:=codigo;edit:=editorial
                @ 5,25 say 'CODIGO:'
                ?? codigo
                @ 7,12 say 'EDITORIAL:'
                ?? editorial
                res=space(1)
                @ 23,18 say '¨Modificar la ficha [S/N]?';
                    get res pict "!" valid res $ "SN"
                read
                if res="S"
                        @ 5,25 say 'CODIGO:' get cod
                        @ 7,12 say 'EDITORIAL:' get edit
                        read
                        replace codigo with cod,editorial with edit
                else
                        alert ('Ficha no modificada a peticion del usuario')
                endif
        else
                alert ('No existe esa ficha')
        endif
        res=space(1)
        @ 23,18 say '¨Hacer otra modificacion [S/N]?';
                get res pict "!" valid res $ "SN"
        read
enddo
close editori
RETURN

*******************************************************************
func listar_pantalla_E(fich,campos,indi,tit,condicion,ncol,nlipa)
*******************************************************************

local fi:=0,nElem, I, contapag, lin, c
*set key K_F1 TO listar2()

if fich==nil
   fich:=alias()
endif

if campos==nil
      campos:=Array(Fcount())
      afields(campos)
endif

nElem:=Len(campos)

*if indi==nil
*  indi:=campos[1]
*endif

if tit==nil
   tit:=upper('listado '+alias())     //upper cambia a may£sculas
endif

if condicion==nil
   condicion:='.t.'
endif

if ncol==nil
        ncol:=13
endif

if nlipa==nil          //  n§ de l¡neas por p gina
        nlipa:=18      //  î     îî         îî
endif

@ 1,1 say padc(tit,78)      //  centra el t¡tulo del listado
nombcampos:=aclone(campos)
use editori
DbGotop()
c:=13
lin:=9
conpag:=0

CUADROS2()
Do While !Eof()
   If &Condicion
      if lin==9
         conpag++
         mascara(nombcampos,ncol,conpag)
      endif
      visualiza(c,lin,nelem,campos)
      lin++
      c:=13
      if lin==nlipa
            Parada()
            lin:=9
*           CUADROCENTROB()
      endif
   EndIf
   DbSkip()
EndDo

If conpag==0
   @ 23,1 say padc('No hay fichas en el archivo',78)
Else
   If Lin!=5
             Parada()
   EndIf
endif
close editori
return


*************
Func Parada()
*************

   @ 23,1 say padc('Pulse una tecla para continuar',78)
   Set Cursor Off
   inkey(0)
   Set Cursor On
Return


***************************************
func mascara(nombrecamp,titul,contapag) // PANTALLA
***************************************

local c:=13
total:=len(nombrecamp)
for i:=1 to total
    @ 7,c say nombrecamp[i]
    c:=c+20
next
@ 21,35 say ('P gina:')
@ 21,44 say contapag pict "9999"
return


**********************************
func visualiza(col,lin,nel,campos)
**********************************

local var,I
For I:=1 To nEl
    Var:=campos[i]
    @ lin,col say &Var
    col:=col+20
Next
return


********************************************************************
func listar_impresora_E(fich,campos,indi,tit,condicion,ncol,nlipa)
********************************************************************

local fi:=0,nElem, I, contapag, lin, c
*set key K_F1 TO listar2()

if fich==nil
   fich:=alias()
endif

if campos==nil
      campos:=Array(Fcount())
      afields(campos)
endif

nElem:=Len(campos)

*if indi==nil
*  indi:=campos[1]
*endif

if tit==nil
   tit:=upper('listado '+alias()) //upper cambia a may£sculas
endif

if condicion==nil
   condicion:='.t.'
endif

if ncol==nil
        ncol:=5
endif

if nlipa==nil          //  n§ de l¡neas por p gina
        nlipa:=50      //  î     îî         îî
endif

@ 1,1 say padc(tit,80)      //  centra el t¡tulo del listado
nombcampos:=aclone(campos)
use editori
DbGotop()
c:=5
lin:=5
conpag:=0

Do While !Eof()
   If &Condicion
     if lin==5
        conpag++
        mascara_imp(nombcampos,ncol,conpag)
     endif
     visualiza(c,lin,nelem,campos)
     lin++
     c:=5
     if lin==nlipa
           lin:=5
           eject
           fila:=nlipa+2
           @ fila,35 say ('P gina:')
           @ fila,44 say conpag pict "9999"
     endif
   EndIf
   DbSkip()
EndDo

if conpag == 1
   fila:=nlipa+2
   @ fila,35 say ('P gina:')
   @ fila,44 say conpag pict "9999"
endif

If conpag==0
   @ 24,1 say padc('No hay fichas en el archivo',79)
endif
close editori
return

*******************************************
func mascara_imp(nombrecamp,titul,contapag)
*******************************************

local c:=5
total:=len(nombrecamp)
for i:=1 to total
    @ 3,c say nombrecamp[i]
    c:=c+20
next
return

FUNC CUADRO()
@ 5,10 clear to 15,69
@ 5,10 to 15,69 double

FUNC CUADROCENTROB()
@ 5,10 clear to 19,69
@ 5,10 to 19,69 double

FUNC CUADRITOABAJO()
@ 22,0 clear to 24,79
@ 22,0 to 24,79 double

FUNC CUADRITOARRIBA()
@ 0,0 clear to 2,79
@ 0,0 to 2,79 double

FUNC CUADROS1()
setcolor ("W+/B")
CUADRITOARRIBA()
CUADRO()
CUADRITOABAJO()

FUNC CUADROS2()
setcolor ("W+/B")
CUADRITOARRIBA()
CUADROCENTROB()
CUADRITOABAJO()

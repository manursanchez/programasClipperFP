#include "inkey.ch"
#include "box.ch"
#include "dbstruct.ch"

local oldarea,bandera:=0,aux,i,j
PRIV cod:=space(4),nom:=space(30),ciu:=space(10),SIONO:=.f.

CLS
use editori new
oldarea:=select()
bandera:=1
if bandera==0
        browse()
endif
cuadros2()
salida:=2
LISTAR_PANTALLA(,,,,,,,salida)
salida:=alert(' ',{'IMPRIMIR','SALIR'})
DO CASE
    CASE SALIDA==1
        SET DEVICE TO PRINTER
        LISTAR_IMPRESORA(,,,,,,,salida)
        SET DEVICE TO SCREEN
ENDCASE
close editori
cls
quit


*******************************************************************
function listar_pantalla(fich,campos,indi,tit,condicion,ncol,nlipa)
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

if indi==nil
  indi:=campos[1]
endif

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
DbGotop()
c:=13
lin:=9
conpag:=0
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
            CUADROCENTROB()
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
function listar_impresora(fich,campos,indi,tit,condicion,ncol,nlipa)
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

if indi==nil
  indi:=campos[1]
endif

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

FUNC CUADROCENTROB()
@ 5,10 clear to 19,69
@ 5,10 to 19,69 double

FUNC CUADRITOABAJO()
@ 22,0 clear to 24,79
@ 22,0 to 24,79 double

FUNC CUADRITOARRIBA()
@ 0,0 clear to 2,79
@ 0,0 to 2,79 double

FUNC CUADROS2()
setcolor ("W+/B")
CUADRITOARRIBA()
CUADROCENTROB()
CUADRITOABAJO()


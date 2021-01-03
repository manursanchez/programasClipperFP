#include "inkey.ch"
#include "box.ch"
#include "dbstruct.ch"
local oldarea,bandera:=0,aux,i,j
PRIV cod:=space(4),nom:=space(30),ciu:=space(10),SIONO:=.f.
if !file('clientes.dbf')
        dbcreate('clientes',{;
                       {'CODIGO  ','C',04,00},;
                       {'NOMBRE  ','C',30,00},;
                       {'CIUDAD  ','C',10,00}})
endif
CLS
use menu new
oldarea:=select()
bandera:=1
if bandera==0
        browse()
endif
salida:=alert('SALIDA',{'IMPRESORA','PANTALLA','ME VOY'})
DO CASE
    CASE SALIDA==1
        SET DEVICE TO PRINTER
        LISTAR2(,,{'CODIGO','FILA','COLUMNA'},,,,)
        SET DEVICE TO SCREEN
    CASE SALIDA==2
        LISTAR()
ENDCASE
close menu
cls
quit

function listar(fich,indi,campos,tit,condicion,ncol,nlipa)
local fi:=0,nElem, I, contapag, lin, c
set key K_F1 TO listar2()
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
        ncol:=3
endif
if nlipa==nil
        nlipa:=20
endif

@ 1,1 say padc(tit,80)
nombcampos:=aclone(campos)
DbGotop()
c:=3
lin:=5
conpag:=0
Do While !Eof()
   If &Condicion
     if lin==5
        conpag++
        mascara(nombcampos,tit,ncol,conpag)
     endif
        visualiza(c,lin,nelem,campos)
        lin++
        c:=3
        if lin==nlipa
           if salida==2
              Parada()
              lin:=5
              cls
           else
              lin:=5
           endif
        endif
   EndIf
   DbSkip()
EndDo
if salida==2
   If conpag==0
      @ 24,1 say padc('No hay fichas en el archivo',79)
   Else
      If Lin!=5
                Parada()
      EndIf
   endif
EndIf
return

*************
Func Parada()
*************
   @ 24,1 say padc('Pulse una tecla para continuar',79)
   Set Cursor Off
   inkey(0)
   Set Cursor On
Return

***************************************
func mascara(nombrecamp,titul,concol,contapag) // PANTALLA
***************************************
local c:=3
total:=len(nombrecamp)
for i:=1 to total
    @ 3,c say nombrecamp[i]
    c:=c+25
next
@ 23,35 say ('P gina:')
@ 23,44 say contapag pict "9999"
return
**********************************
func visualiza(col,lin,nel,campos)
**********************************
local var,I
For I:=1 To nEl
    Var:=campos[i]
    @ lin,col say &Var
    col:=col+25
Next
return
***************************************************************************
function listar2(fich,indi,campos,tit,condicion,ncol,nlipa)
***************************************************************************
local fi:=0,nElem, I, contapag, lin, c
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
   tit:=upper('listado '+alias())
endif

if condicion==nil
   condicion:='.t.'
endif

if ncol==nil
        ncol:=3
endif
if nlipa==nil
        nlipa:=15
endif

@ 1,1 say padc(tit,80)
nombcampos:=aclone(campos)
DbGotop()
c:=3          // Columna en el que va a aparecer el listado
lin:=5        // Linea en la que aparece el listado
conpag:=0     // Contador de pagina
Do While !Eof()
   If &Condicion
     if lin==5
        conpag++
        mascara2(nombcampos,ncol,conpag)
     endif
        visualiza2(c,lin,nelem,campos)
        lin++
        c:=3
        if lin==nlipa
              lin:=5
              @ 17,35 say ('P gina:')
              @ 17,44 say conpag pict "9999"
              eject
        endif
   EndIf
   DbSkip()
EndDo
return


***************************************
func mascara2(nombrecamp,titul,contapag) // PANTALLA
***************************************
local c:=3
total:=len(nombrecamp)
for i:=1 to total
    @ 3,c say nombrecamp[i]
    c:=c+25
next
return
**********************************
func visualiza2(col,lin,nel,campos)
**********************************
local var,I
For I:=1 To nEl
    Var:=campos[i]
    @ lin,col say &Var
    col:=col+25
Next
return

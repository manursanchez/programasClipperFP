# include "dbstruct.ch"
# include "inkey.ch"
# include "achoice.ch"
priv tecla
set wrap on
set date british
clear
if !file('libros.dbf')
        dbcreate("libros",;
                {{"codigo    ","c",04,00},;
                 {"titulo    ","c",30,00},;
                 {"autor     ","c",30,00},;
                 {"quedan    ","n",03,00},;
                 {"estante   ","c",04,00},;
                 {"disponible","c",01,00}})
endif
inicializar()
do while tecla!=0
        @ 2,5  prompt 'ALTAS'
        @ 2,13 prompt 'BAJAS'
        @ 2,20 prompt 'MODIFICACIONES'
        @ 2,36 prompt 'LISTADOS'
        @ 2,47 prompt 'CONSULTAS'
        @ 2,58 prompt 'SALIR'
        menu to tecla
        do case
                case tecla==1
                        altas()
                case tecla==2
                        bajas()
                case tecla==3
                        modificaciones()
                case tecla==4
                        listados({'codigo','editorial'})
                case tecla==5
                        consultas()
                case tecla==6
                        tecla:=0
                endcase
enddo
clear
quit


// ************** FUNCION QUE DA DE ALTAS EN EL FICHERO *******************


function altas_L()        // Funci¢n que da de altas en el fichero
private res:="S"
use libros
do while res == 'S'
        @ 2,3 clear to 2,69
        @ 2,25 say ' ALTAS '
        private cod:=space(4),aut:=space(30),tit:=space(30),cant:=0
        private est:=space(03)
        @ 5,25 say 'CODIGO:' get cod valid cod>space(4)
        read
        locate for codigo==cod
        if found()
                alert ('Este codigo ya ha sido utilizado')
        else
                @ 7,4 say 'TITULO  :' get tit
                @ 8,4 say 'AUTOR   :' get aut
                @ 9,4 say 'CANTIDAD:' get cant
                @ 10,4 say 'ESTANTE :' get est
                read
                res:= space(1)
                @ 18,3 clear to 18,69
                @ 18,18 say '¨Esta conforme con los datos [S/N]?';
                        get res pict "!" valid res $ "SN"
                read

                if res == "S"
                        append blank
                        replace codigo with cod,titulo with tit,;
                           autor with aut,estante with est,quedan with cant
                           disponible:="S"
                endif
        endif
        res=space(1)
        @ 18,3 clear to 18,69
        @ 18,18 say '¨Quieres introducir mas altas [s/n]? ';
                    get res pict "!" valid res $ "SN"
        read
        inicializar()
enddo
close libros
inicializar()
return

// ***************** FUNCION QUE DA DE BAJAS EN EL FICHERO ***************

function bajas_L()
set deleted on
private res:="S",bandera:=0
use libros
do while res == "S"
        @ 2,3 clear to 2,69
        @ 2,25 say ' BAJAS '
        @ 5,3 clear to 15,69
        private cod:=space(4)
        @ 18,3 clear to 18,69
        @ 18,18 say 'Codigo del libro' get cod valid cod>space(4)
        read
        locate for codigo=cod
        if found()
                        @ 7,4  say 'TITULO  : ' + tit
                        @ 8,4  say 'AUTOR   : ' + aut
                        @ 9,4  say 'CANTIDAD: ' + cant
                        @ 10,4 say 'ESTANTE : ' + est
                        res=space(1)
                        @ 18,3 clear to 18,69
                        @ 18,18 say '¨Quiere dar de baja [S/N]?';
                        get res pict "!" valid res $ "SN"
                        read
                        if res="S"
                                bandera=1
                                delete
                        else
                                @ 18,3 clear to 18,69
                                @ 18,18 say 'Editorial no dada de baja'
                                inkey(0)
                        endif
        else
                @ 18,3 clear to 18,69
                alert ('No existe ese c¢digo')
        endif
        res=space(1)
        @ 18,3 clear to 18,69
        @ 18,18 say '¨Quieres dar mas de baja [s/n]? ';
                    get res pict "!" valid res $ "SN"
        read
enddo
if bandera=1
        alert ('Se va a proceder a una compactaci¢n del fichero')
        pack
endif
set delete off
use libros
inicializar()
return



// ************ FUNCION QUE PERMITE MODIFICAR ALGUN REGISTRO ************



function modificaciones_L()
private res:="S"
use editori
do while res="S"
        @ 2,3 clear to 2,69
        @ 2,25 say ' MODIFICACIONES '
        @ 5,3 clear to 15,69
        private cod:=space(4),edit:=space(30)
        @ 18,3 clear to 18,69
        @ 18,18 say 'Codigo de la editorial' get cod valid cod>space(4)
        read
        locate for codigo=cod
        if found()
                cod:=codigo;edit:=editorial
                @ 5,25 say 'CODIGO:'
                ?? codigo
                @ 7,4 say 'EDITORIAL:'
                ?? editorial
                res=space(1)
                @ 18,3 clear to 18,69
                @ 18,18 say '¨Modificar la ficha [S/N]?';
                    get res pict "!" valid res $ "SN"
                read
                @ 5,3 clear to 15,69
                if res="S"
                        @ 5,25 say 'CODIGO:' get cod
                        @ 7,4 say 'EDITORIAL:' get edit
                        read
                        replace codigo with cod,editorial with edit
                else
                        alert ('Ficha no modificada a peticion del usuario')
                endif
        else
                alert ('No existe esa ficha')
        endif
        res=space(1)
        @ 18,3 clear to 18,69
        @ 18,18 say '¨Hacer otra modificacion [S/N]?';
                get res pict "!" valid res $ "SN"
        read
enddo
inicializar()
return


// ************* FUNCION QUE LISTA LOS CAMPOS QUE SE ELIJAN **************


function listados_L(arr)
use editori
priv aux
dbgotop()
tabla3:=SeleDatos(2,2,24,78,arr,{},)
ventanaparalistados()
do while !eof()
    for n:=1 to len(tabla3)
      Aux:=tabla3[n]
      visual_nombres_campos(aux)
      ?? &Aux
      ??  ' '
    next
    inkey(0)
    ?
    dbskip()
EndDo
inicializar()
return


************************************************************
*                 FUNCION SELEDATOS                        *
************************************************************
* An lisis:                                                *
*      Funci¢n que permite seleccionar los datos de        *
*                       un array.                          *
************************************************************
* Par metros:                                              *
*      -Entrada: y1:  posici¢n l¡nea1                      *
*                y2:  posici¢n l¡nea2                      *
*                x1: posici¢n col. 1                       *
*                x2: posici¢n col. 2                       *
*                array1:array de todos los elementos.      *
*                array2:array de elementos seleccionados.  *
*      -Salida: un array con los datos seleccionados.      *
************************************************************
* Ej: seleccion:=seledatos(2,10,20,70,{1,2,3,4,5,6},{2,3}) *
************************************************************

FUNCTION SeleDatos(y1,x1,y2,x2,tDatos,tDatosSelect)
local tecla,felemento,interruptor:=0,cont,tablatemp:={},tablatemp2:={}
cls

if x2-x1<45;  // PARAMETROS "x" PASADOS NO VALIDOS, CAMBIADOS A POR DEFECTO
   .or. x1>35 .or. x2>79
        x1:=15;x2:=64
        alert("PARAMETROS x NO VALIDOS, PARAMETROS POR DEFECTO")
endif
if y2-y1<12; // PARAMETROS "y" PASADOS NO VALIDOS, CAMBIADOS A POR DEFECTO
   .or. y1>13 .or. y2>24
        y1:=5;y2:=19
        alert("PARAMETROS y NO VALIDOS, PARAMETROS POR DEFECTO")
endif

// VENTANA GRANDE
setcolor('G')
@ y1,x1,y2-6,x2 box ('ÚÄ¿³´ÄÃ³±')
@ y2-6,x1,y2,x2 box ('ÃÄ´³ÙÄÀ³±')
xcentra(y1,x1,x2," VENTANA DE SELECCION ")

// VENTANITAS

setcolor("B+")
@ y1+2,x1+2,y2-8,x1+23 box ('ÚÄ¿³ÙÄÀ³')
@ y1+2,x2-23,y2-8,x2-2 box ('ÚÄ¿³ÙÄÀ³')

// COMENTARIOS DE LAS VENTANITAS
setcolor("B+")
xcentra(y1+2,x1+2,x1+23,"CAMPOS PARA SELECCION")
xcentra(y1+2,x2-23,x2-2,"CAMPOS SELECCIONADOS")



// TECLAS DE OPCIONES
xcentra (y2-6,x1,x2," OPCIONES ")
SetColor ("I")
@ y2-4,x1+2 say "  ENTER: SELECCIONAR  "
@ y2-2,x1+2 say "      ESC: SALIR      "
@ y2-4,x2-22 say " F10: GRABAR Y SALIR "
@ y2-2,x2-22 say "        Ä Ä        "
SetColor ("W")
tablatemp2:=aclone(tDatosSelect)
for cont:=1 to len(tdatos)
       pos:=ascan(tDatosSelec,tDatos[cont])
       if pos==0
             aadd (tablatemp,tDatos[cont])
       endif
next

keyboard chr(K_LEFT)
achoice(y1+3,x2-22,y2-9,x2-3,tDatosSelect,"FuncionUsuario")
do while interruptor!=1                                 // Bucle Principal
        felemento:=achoice(y1+3,x1+3,y2-9,x1+22,tablatemp,.T.,;
                            "FuncionUsuario")
        ntecla:=lastkey()
        do case
         case nTecla==K_F10
                alert("Grabar y Salir al Dos")
                interruptor:=1
         case nTecla==K_ESC
                alert("Cancelar cambios y Salir al Dos")
                tDatosSelect:=(tablatemp2)
                interruptor:=1
        endcase
        if felemento!=0                 // un elemento ha sido seleccionado
                aadd(tDatosSelect,tablatemp[felemento])
                adel(tablatemp,felemento)
                asize(tablatemp,len(tablatemp)-1)
                @ y1+2,x1+2,y2-8,x1+23 box ('ÚÄ¿³ÙÄÀ³')
                @ y1+2,x2-23,y2-8,x2-2 box ('ÚÄ¿³ÙÄÀ³')
                setcolor("I")
                xcentra(y1+2,x1+2,x1+23,"CAMPOS PARA SELECCION")
                xcentra(y1+2,x2-22,x2-2,"CAMPOS SELECCIONADOS")
                setcolor("W")
                keyboard chr(K_ESC) // para que entre y salga del
                                    // achoice de la derecha
                achoice(y1+3,x2-22,y2-9,x2-3,tDatosSelect,;
                                        "FuncionUsuario")
        endif


        // MENU DERECHA
        if felemento==0 .and. interruptor!=1
          felemento:=1
          do while felemento!=0 .and. len(tDatosSelect)!=0

                felemento:=achoice(y1+3,x2-22,y2-9,x2-3,tDatosSelect,.T.,;
                                    "FuncionUsuario")
                ntecla:=lastkey()
                do case
                 case ntecla==K_F10
                        alert("Grabar y Salir al Dos")
                        interruptor:=1
                 case ntecla==K_ESC
                        alert("Cancelar cambios y Salir al Dos")
                        tDatosSelect:=(tablatemp2)
                        interruptor:=1
                endcase
                if felemento!=0         // un elemento ha sido seleccionado
                        aadd(tablatemp,tDatosSelect[felemento])
                        adel(tDatosSelect,felemento)
                        asize(tDatosSelect,len(tDatosSelect)-1)
                        @ y1+2,x1+2,y2-8,x1+23 box ('ÚÄ¿³ÙÄÀ³')
                        @ y1+2,x2-23,y2-8,x2-2 box ('ÚÄ¿³ÙÄÀ³')
                        setcolor("I")
                        xcentra(y1+2,x1+2,x1+23,"CAMPOS PARA SELECCION")
                        xcentra(y1+2,x2-23,x2-2,"CAMPOS SELECCIONADOS")
                        setcolor("W")
                        keyboard chr(K_ESC) // para que entre y salga del
                                            // achoice de la izquierda
                        achoice(y1+3,x1+3,y2-9,x1+22,tablatemp,.T.,;
                                "FuncionUsuario")
                endif

          enddo        // del tecla..
        endif
enddo  // del while interruptor!=1

return(tDatosSelect) // FIN DE LA FUNCION SELEDATOS

**************************************
*         FUNCION XCENTRA            *
**************************************
* An lisis:                          *
*      Funci¢n que centra una frase  *
**************************************
* Par metros:                        *
*      -Entrada: y.  posici¢n l¡nea  *
*                x1. posici¢n col. 1 *
*                x2. posici¢n col. 2 *
*      -Salida: NADA.                *
**************************************
FUNCTION xcentra(y,x1,x2,literal,especial)
lon:=(len(literal))/2
c:=( ( ( x2-x1 ) / 2 ) + x1 ) - lon + 1
@ y,c say literal
return

**************************************
*      FUNCION FUNCIONUSUARIO        *
**************************************
FUNCTION FuncionUsuario(nModo)
local nValDev
nTecla:=lastkey()
nValDev:=AC_CONT
do case
    case nModo==AC_HITTOP  // Pita si intentas subir m s all  del 1er elemento
        Tone(100,3)
    case nModo==AC_HITBOTTOM // Pita si ... el £ltimo elemento
        Tone(100,3)
    case nModo==AC_EXCEPT
        do case
            case nTecla==K_RETURN
                 nValDev:=AC_SELECT
            case nTecla==K_ESC   .or.;
                 nTecla==K_F10   .or.;
                 nTecla==K_RIGHT .or.;
                 nTecla==K_LEFT
                 nValDev:=AC_ABORT
            otherwise
                 nValDev:=AC_GOTO
         endcase
endcase
return(nValDev)

// ************ FUNCION QUE PERMITE CONSULTAR ALGUNA FICHA *********

function consul_L()
private res:="S"
use editori
do while res = "S"
        @ 2,3 clear to 2,69
        @ 2,25 say ' CONSULTAS '
        @ 5,3 clear to 15,69
        private cod:=space(4)
        @ 18,3 clear to 18,69
        @ 18,18 say 'Codigo de la editorial' get cod valid cod>space(4)
        read
        locate for codigo=cod
        if found()
                        @ 5,25 say 'CODIGO:'
                        ?? codigo
                        @ 7,4 say 'EDITORIAL:'
                        ?? editorial
        else
                alert ('Ficha no encontrada ¢ no existe')
        endif
        res=space(1)
        @ 18,3 clear to 18,69
        @ 18,18 say '¨Quiere consultar mas [S/N]?';
        get res pict "!" valid res $ "SN"
        read
enddo
inicializar()
return
// ********** FUNCION QUE INICIALIZA LA PANTALLA PRESENTACION ***********

function inicializar()
clear
setcolor("B")
@ 1,2 to 3,70
setcolor("W")
setcolor("R")
@ 4,2 to 16,70
setcolor("W")
setcolor("GR+")
@ 17,2 to 20,70
setcolor("W")
return

function ventanaparalistados()
priv f:=0,col:=0
clear
setcolor("B+")
@ 1,2 to 3,70
setcolor("W")
setcolor("RB+")
@ 2,30 say 'LISTADOS'
setcolor("W")
setcolor("B+")
@ 4,2 to 16,70
setcolor("W")
return
function visual_nombres_campos(campo)


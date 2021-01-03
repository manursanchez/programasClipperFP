# include "inkey.ch"
# include "DBSTRUCT.CH"
# include "box.ch"
local cod:=space(7),berrotulo,cont,berprograma,tecla,opcion,RES:="S"
priv rot1:=space(30),rot2:=space(30),rot3:=space(30),rot4:=space(30),rot5:=space(30)
priv rot6:=space(30),rot7:=space(30),rot8:=space(30),rot9:=space(30)
priv prog1:=space(20),prog2:=space(20),prog3:=space(20),prog4:=space(20)
priv prog5:=space(20),prog6:=space(20),prog7:=space(20),prog8:=space(20),prog9:=space(20)
priv fil:=0,col:=0,auxrot,auxprog
IF !FILE('MENU.DBF')
   ALERT ('NO EXISTE EL FICHERO')
   DBCREATE('MENU',{;
                    {'codigo    ','C',07,00},;
                    {'fila      ','N',02,00},;
                    {'columna   ','N',02,00},;
                    {'rotulo1   ','C',30,00},;
                    {'rotulo2   ','C',30,00},;
                    {'rotulo3   ','C',30,00},;
                    {'rotulo4   ','C',30,00},;
                    {'rotulo5   ','C',30,00},;
                    {'rotulo6   ','C',30,00},;
                    {'rotulo7   ','C',30,00},;
                    {'rotulo8   ','C',30,00},;
                    {'rotulo9   ','C',30,00},;
                    {'programa1 ','C',20,00},;
                    {'programa2 ','C',20,00},;
                    {'programa3 ','C',20,00},;
                    {'programa4 ','C',20,00},;
                    {'programa5 ','C',20,00},;
                    {'programa6 ','C',20,00},;
                    {'programa7 ','C',20,00},;
                    {'programa8 ','C',20,00},;
                    {'programa9 ','C',20,00}})
ENDIF
DO WHILE RES = "S"
USE MENU
cls
INDEX ON CODIGO TO MENU UNIQUE
DO WHILE TECLA!=K_ESC
   @ 1,1 to 23,78 double
   @ 4,3 SAY "CODIGO :"
   @ 5,3 SAY "FILA   :"
   @ 6,3 SAY "COLUMNA:"
   @ 9,2 to 20,33
   @ 8,5 SAY ("ROTULO")
   @ 9,46 to 20,77
   @ 8,50 SAY ("PROGRAMA")
   tecla:=lastkey()
   if tecla != K_ESC
        @ 4,10 get cod
        read
        seek cod
        if found()
                @ 4,12 say codigo
                @ 5,12 say fila
                @ 6,12 say columna
                for cont=1 to 9
                        berrotulo:="rotulo"+str(cont,1)
                        @ 10+cont,3 say &berrotulo
                        berprograma:="programa"+str(cont,1)
                        @ 10+cont,57 say &berprograma
                next
                alert('¨Quiere modificar la ficha?',{'Si','No'})
                do case
                        case opcion = 1
                                introducir()

                        case opcion = 2
                                alert('Ficha no modificada')
                endcase
        else
            introducir()
        endif
   endif
   tecla:=lastkey()
enddo
opcion:=alert ('¨Configuraci¢n del men£ correcta?',{'Si','No'})
do case
        case opcion = 1
                append blank
                replace codigo with cod,fila with fil,columna with col,;
                        rotulo1 with rot1,rotulo2 with rot2,rotulo3 with rot3,rotulo4 with rot4,;
                        rotulo5 with rot5,rotulo6 with rot6,rotulo7 with rot7,rotulo8 with rot8,;
                        rotulo9 with rot9,programa1 with prog1,programa2 with prog2,programa3 with prog3,;
                        programa4 with prog4,programa5 with prog5,programa6 with prog6,programa7 with prog7,;
                        programa8 with prog8,programa9 with prog9
         case opcion =  2
                         alert('Configuraci¢n de menu incorrecta')
         endcase
use menu
@ 22,1 SAY "¨Quiere volver a meter un men£?";
        get RES pict "!" valid RES $ "SN"
READ
ENDDO
quit
function introducir()
@ 5,10 get fil valid fil <=  24
@ 6,10 get col valid col <=  79
for cont=1 to 9
        auxrot:="rot"+str(cont,1)
        @ 10+cont,3 get &auxrot
        auxprog:="prog"+str(cont,1)
        @ 10+cont,57 get &auxprog
next
return






















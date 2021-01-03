# include "inkey.ch"
# include "DBSTRUCT.CH"
# include "box.ch"
local cod:=space(7),berrotulo,berprograma,tecla
priv rot1:=space(30),rot2:=space(30),rot3:=space(30),rot4:=space(30),rot5:=space(30)
priv rot6:=space(30),rot7:=space(30),rot8:=space(30),rot9:=space(30)
priv prog1:=space(20),prog2:=space(20),prog3:=space(20),prog4:=space(20)
priv prog5:=space(20),prog6:=space(20),prog7:=space(20),prog8:=space(20),prog9:=space(20)
priv fil:=0,col:=0,cont:=0
IF !FILE('MENU.DBF')
   ALERT ('FICHERO INEXISTENTE,SE VA A PROCEDER A CREARLO')
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
USE MENU
cls
INDEX ON CODIGO TO MENU UNIQUE
# DEFINE ESC 27
DO WHILE TECLA!=ESC
   SETCOLOR("R")
   @ 0,0 to 24,79 double
   SETCOLOR("W")
   @ 4,3 SAY "CODIGO :"
   @ 5,3 SAY "FILA   :"
   @ 6,3 SAY "COLUMNA:"
   SETCOLOR("G")
   @ 9,2 to 21,33
   SETCOLOR("W")
   @ 8,12 SAY ("ROTULO")
   SETCOLOR("G")
   @ 9,46 to 21,77
   SETCOLOR("W")
   @ 8,57 SAY ("PROGRAMA")
   @ 4,12 get cod
   read
   seek cod
   @ 4,15 say "                                   "
   if found()
        @ 4,12 say codigo
        @ 5,12 say fila
        @ 6,12 say columna
        for cont=1 to 9
        // berrotulo es una variable auxiliar
               berrotulo:="rotulo"+str(cont,1)
               @ 10+cont,3 say &berrotulo
        // berprograma es una variable auxiliar
        // el & lo que hace es convertir un literal en una variable
               berprograma:="programa"+str(cont,1)
               @ 10+cont,57 say &berprograma
        next
   else
               @ 5,12 get fil pict "99" valid fil <= 25
               @ 6,12 get col pict "99" valid col <= 79
               read
               for cont=1 to 9
                        auxrot:="rot"+str(cont,1)
                        @ 10+cont,3 get &auxrot
                        auxprog:="prog"+str(cont,1)
                        @ 10+cont,57 get &auxprog
                        read
                        IF LASTKEY() = ESC
                                CONT=9
                        ENDIF
                next
               append blank
               replace codigo with cod,fila with fil,columna with col,;
                       rotulo1 with rot1,rotulo2 with rot2,rotulo3 with rot3,;
                       rotulo4 with rot4,rotulo5 with rot5,rotulo6 with rot6,;
                       rotulo7 with rot7,rotulo8 with rot8,rotulo9 with rot9,;
                       programa1 with prog1,programa2 with prog2,programa3 with prog3,;
                       programa4 with prog4,programa5 with prog5,programa6 with prog6,;
                       programa7 with prog7,programa8 with prog8,programa9 with prog9
   endif
   if lastkey() = ESC
        tecla:=alert('¨Desea salir?',{'SI','NO'})
        do case
                case tecla = 1
                        exit
                case tecla = 2
                        alert('¨Entonces para que pulsas Escape?')
        endcase
   endif
enddo
use menu
quit
























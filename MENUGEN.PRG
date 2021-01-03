# include "inkey.ch"
# include "dbstruct.ch"
# include "box.ch"
SET PROCEDURE TO "PRU.PRG" // ESTE ARCHIVO SE METEN TODAS LAS FUNCIONES
                           // QUE SE VAYAN HA UTILIZAR.

CLS
Use Menu
Set Index To Menu
KeyBoard Chr(13)
HazMenu('1')
Use
Return

*********************
Func HazMenu(CodMenu)
*********************
Local aux,tecla, Pan, Rotu, Program, F, C, I, Op
Priv _CodM:=CodMenu

   Dbseek(CodMenu)
   If Found()
      Rotu:={}
      Program:={}
      f:=MENU->FILA
      c:=MENU->COLUMNA
      For I:=1 To 9
        Aux:="MENU->ROTULO"+Str(I,1)
        If !Empty(&Aux)
          Aadd(Rotu,&Aux)
          Aux:="MENU->PROGRAMA"+Str(I,1)
          Aadd(Program,&Aux)
        Else
          Exit
        EndIf
      Next
      Op:=1
      Save Screen To Pan
      Do While .t.
          Op:=makeMenu(f,c,Rotu,Op,Len(CodMenu))
          if op != 0
             If !Empty(Program[Op])
                       aux := program[op]
                       aux := &aux
             Else
                HazMenu(CODMENU+STR(OP,1))
             EndIf
          else
             IF CODMENU == '1'
                If Alert('Desea Salir',{'No','Si'})==2
                  Exit
                Endif
             ELSE
                Exit
             ENDIF
          endif
      EndDo
      Restore Screen From Pan
   ELSE
           ALERT('NO EXISTE EL CODIGO')
   EndIf
Return

FUNCTION MAKEMENU(Y1,X1,CAMPOS, Op, Nivel)
LOCAL X2,Y2,LMAX,N,M,CAMP,A
CAMP:=LEN(CAMPOS)
Y2:=Y1 + CAMP + 1
FOR N=1 TO CAMP
      CAMPOS[N]:=AllTrim(Campos[n])
NEXT
LMAX:=0
FOR N=1 TO CAMP
      A:=LEN(CAMPOS[N])
      IF A>LMAX
            LMAX:=A
      ENDIF
NEXT
FOR N=1 TO CAMP
      CAMPOS[N]:=Padr(Campos[n],Lmax)
NEXT
if Nivel==1
        M:=0
        FOR N:=1 TO CAMP
               @ Y1,X1 PROMPT CAMPOS[N]
               M:=LEN(CAMPOS[N])+7
               X1:=X1+M
        NEXT
        MENU TO OP
else
        X2:=X1 + LMAX + 1
        @ Y1,X1 TO Y2,X2 DOUBLE
        Set Key K_LEFT  To Izquierda()
        Set Key K_RIGHT To Derecha()
        FOR N:=1 TO CAMP
                @ Y1+N,X1+1 PROMPT CAMPOS[N]
        NEXT
        MENU TO OP
        Set Key K_LEFT  To
        Set Key K_RIGHT To
endif
RETURN(OP)


Func Izquierda()
 KeyBoard Replicate(Chr(K_ESC),Len(_CodM)-1)+Chr(K_LEFT)+Chr(13)
Return
Func Derecha()
 KeyBoard Replicate(Chr(K_ESC),Len(_CodM)-1)+Chr(K_RIGHT )+Chr(13)
Return

# include "clvision.ch"
# include "inkey.ch"
cls
IF !FILE('CLIENTES.DBF')
    ALERT ('No existe el fichero')
else
    use clientes new

    Rdinsertrec(ntiempo:=5,BBLOCK:=mensaje())
ENDIF
    close clientes
Return
FUNction rdinsertrec(ntiempo,BBLOCK)
local yes_or_no:=.F.,CALIAS,SALIDA:=.F.
    CALIAS:=ALIAS()
    if ntiempo==nil
       ntiempo:=0
    endif
    if !empty(calias)
        append blank
        if !neterr()
            yes_or_no:=.T.
        else
            TIEMPO:=0
            do while !SALIDA
               append blank
               if !neterr()
                  yes_or_no:=.T.
                  SALIDA:=.T.
               else
                  tiempo:=tiempo+inkey(1)
                  IF LASTKEY()==K_ESC
                      SALIDA:=.T.
                      YES_OR_NO:=.F.
                  ENDIF
               endif
               IF NTIEMPO==TIEMPO
                  SALIDA:=.T.
               ENDIF
            enddo
        ENDIF
    else
        ALERT('NO HAY NINGUN AREA ACTIVA')
    ENDIF
    IF BBLOCK==NIL
       MSGBOX('Dejame en paz no ves que estoy intentando incluir un registro')
    else
        MENSAJE()
    endif
RETURN(YES_OR_NO)
func MENSAJE()
@ 16,20 say 'CAPULLO'
RETURN

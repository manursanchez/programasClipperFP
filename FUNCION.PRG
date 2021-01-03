# include "inkey.ch"
# include "box.ch"
# include "clvision.ch"
# INCLUDE "DBSTRUCT.CH"
pulldown omenu colors "W+/B","N/BG","GR+/B"
    MENU "&Archivo"
        menuitem "Datos de la &cacer°a" execute caceria()
    ENDMENU
    MENU "&Fincas"
        MENUITEM "&Nueva finca" EXECUTE ALTFIN()
        MENUITEM "&Borrar finca" EXECUTE BORFIN()
        MENUITEM "&Consultar finca" execute confin()
        MENUITEM "&Modificar finca" execute modfin()
        MENUITEM SEPARATOR
        MENUITEM "Listar por &pantalla";
                execute listpan()
        MENUITEM "Listar por &impresora";
                execute listimpresora()
    ENDMENU
    MENU "&Organicas"
        MENUITEM "&Nueva Org†nica" execute altorga()
        MENUITEM "&Borrar Org†nica" execute bororga()
        MENUITEM "&Consultar Org†nica" execute conorga()
        MENUITEM "&Modificar Org†nica" execute modorga()
        MENUITEM "&Listar por pantalla";
                execute listpanorga()
    ENDMENU
    MENU "&Salir" message "Salir al sistema operativo"
        MENUITEM "&Acerca de..."
        MENUITEM "&Salir" SHORTKEY K_ALT_X;
                EXECUTE OMENU:lend:=.T.
    ENDMENU
ENDPULLDOWN
RUNMENU OMENU
CLS
QUIT
*******************************************************************
FUNC ALTFIN()  // FINCAS
*******************************************************************
local NFIN:=SPACE(30),COD:=SPACE(4),LOCALI:=SPACE(20),HECTA:=0,AMO:=SPACE(30),OPC
local oldarea,PAN
PRIV TECLA
set scoreboard off
set confirm on
set escape on
set bell on
IF !FILE('FINCAS.DBF')
        DBCREATE("FINCAS",{;
                {'CODFIN   ','C',04,00},;
                {'NOMFINCA ','C',30,00},;
                {'LOCALIDAD','C',20,00},;
                {'HECTAREAS','N',05,00},;
                {'DUENO    ','C',30,00}})

Else
        msoff()
        OLDAREA:=SELECT()
        USE FINCAS NEW
        INDEX ON CODFIN TO FINCAS UNIQUE
        SET INDEX TO FINCAS
        DO WHILE .T.
                SAVE SCREEN TO PAN
                @ 4,20 SAY "              Nueva finca                " color ("W+/B")
                @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
                COD:=SPACE(4)
                NFIN:=SPACE(30)
                LOCALI:=SPACE(20)
                HECTA:=0
                AMO:=SPACE(30)
                @ 7,22 SAY "C¢digo de finca" color ("W+/B")
                @ 9,22 say "Finca" COLOR ("W+/B")
                @ 11,22 SAY "Localidad" COLOR ("W+/B")
                @ 13,22 SAY "Due§o" COLOR ("W+/B")
                @ 15,22 say "Hectareas" COLOR ("W+/B")
                @ 7,40 get cod color ("W+/G")
                SET CURSOR ON
                read
                seek cod
                if found()
                        MSGBOX('La finca ya fue introducida por ese c¢digo')
                else
                        @ 9,30 GET NFIN COLOR ("W+/G")
                        @ 11,32 GET LOCALI COLOR ("W+/G")
                        @ 13,30 GET AMO COLOR ("W+/G")
                        @ 15,32 GET HECTA COLOR ("W+/G") valid hecta >= 00000
                        read
                        SET CURSOR OFF
                        append blank
                        replace codfin with cod,nomfinca with nfin,;
                                localidad with locali,dueno with amo,;
                                hectareas with hecta
                endif
                RESTORE SCREEN FROM PAN
                opc:=alert('®Desea continuar?',{'SI','NO'})
                IF OPC=2
                        EXIT
                ENDIF
        ENDDO
endif
CLOSE FINCAS
SELECT(OLDAREA)
MSON()
return
******************************************************************
FUNC BORFIN() // FINCAS
******************************************************************
local oldarea,pan,cod:=SPACE(4),nfin:=space(30),LOCALI:=SPACE(20),HECTA:=0,AMO:=SPACE(30),opc,OPCION
priv bandera:=0
set delete on
set scoreboard off
set confirm on
set escape on
set bell on
oldarea:=select()
use fincas new
set index to fincas
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        bandera:=0
        @ 4,20 SAY "             Borrar finca                " color ("W+/B")
        @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
        NFIN:=SPACE(30)
        cod:=SPACE(4)
        LOCALI:=SPACE(20)
        HECTA:=0
        AMO:=SPACE(30)
        @ 7,22 SAY "C¢digo de finca" color ("W+/B")
        @ 9,22 say "Finca" COLOR ("W+/B")
        @ 11,22 SAY "Localidad" COLOR ("W+/B")
        @ 13,22 SAY "Due§o" COLOR ("W+/B")
        @ 15,22 say "Hectareas" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        read
        seek cod
        if found()
                @ 7,40 say codfin color ("W+/G")
                @ 9,30 say nomfinca COLOR ("W+/G")
                @ 11,32 say localidad COLOR ("W+/G")
                @ 13,30 say dueno COLOR ("W+/G")
                @ 15,32 say hectareas COLOR ("W+/G")
                INKEY(0)
                opc:=ALERT('®Desea borrar la ficha?',{'SI','NO'})
                do case
                        case opc = 1
                                bandera:=1
                                delete
                        case opc = 2
                                MSGBOX('Ficha no borrada a peticion del usuario')
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
        opc:=alert('®Desea continuar?',{'SI','NO'})
        IF OPC=2
                EXIT
        ENDIF
enddo
set delete off
close fincas
SELECT(OLDAREA)
MSON()
return
****************************************************************************
FUNC CONFIN()  // FINCAS
****************************************************************************
LOCAL OLDAREA,COD:=SPACE(4),NFIN:=SPACE(30),LOCALI:=SPACE(20),HECTA:=0,AMO:=SPACE(30)
local tecla
OLDAREA:=SELECT()
USE FINCAS NEW
index on codfin to fincas unique
set index to fincas
set scoreboard off
set confirm on
set escape on
set bell on
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 4,20 SAY "            Consultar finca              " color ("W+/B")
        @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
        NFIN:=SPACE(30)
        cod:=SPACE(4)
        LOCALI:=SPACE(20)
        HECTA:=0
        AMO:=SPACE(30)
        @ 7,22 SAY "C¢digo de finca" color ("W+/B")
        @ 9,22 say "Finca" COLOR ("W+/B")
        @ 11,22 SAY "Localidad" COLOR ("W+/B")
        @ 13,22 SAY "Due§o" COLOR ("W+/B")
        @ 15,22 say "Hectareas" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        read
        seek cod
        if found()
                @ 7,40 say codfin color ("W+/G")
                @ 9,30 say nomfinca COLOR ("W+/G")
                @ 11,32 say localidad COLOR ("W+/G")
                @ 13,30 say dueno COLOR ("W+/G")
                @ 15,32 say hectareas COLOR ("W+/G")
                inkey(0)
        else
                MSGBOX('Esa finca no existe')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'SI','NO'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close fincas
SELECT(OLDAREA)
MSON()
return
*************************************************************************
FUNC MODFIN()  //FINCAS
*************************************************************************
LOCAL OLDAREA,COD:=SPACE(4),NFIN:=SPACE(30),pan,pan2,LOCALI:=SPACE(20),HECTA:=0,AMO:=SPACE(30)
local tecla,res:=space(1)
OLDAREA:=SELECT()
USE FINCAS NEW
index on codfin to fincas unique
set index to fincas
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 9,20 SAY "            Modificar finca              " color ("W+/B")
        @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
        NFIN:=SPACE(30)
        cod:=SPACE(4)
        LOCALI:=SPACE(20)
        HECTA:=0
        AMO:=SPACE(30)
        @ 7,22 SAY "C¢digo de finca" color ("W+/B")
        @ 9,22 say "Finca" COLOR ("W+/B")
        @ 11,22 SAY "Localidad" COLOR ("W+/B")
        @ 13,22 SAY "Due§o" COLOR ("W+/B")
        @ 15,22 say "Hectareas" COLOR ("W+/B")
        @ 7,40 get cod color ("W+/G")
        read
        seek cod
        if found()
                @ 7,40 say codfin color ("W+/G")
                @ 9,30 say nomfinca COLOR ("W+/G")
                @ 11,32 say localidad COLOR ("W+/G")
                @ 13,30 say dueno COLOR ("W+/G")
                @ 15,32 say hectareas COLOR ("W+/G")
                inkey(0)
                save screen to pan2
                @ 18,21,22,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                @ 18,20,21,60 box ('€€€€€€€€€') color ("GR")
                @ 19,22 say "®Desea modificar la finca? [s/n]" COLOR ("W+/GR");
                        get res pict "!" valid res $ "SN" COLOR ("W+/GR")
                read
                restore screen from pan2
                if res == "S"
                        cod:=SPACE(4)
                        nfin:=space(30)
                        LOCALI:=SPACE(20)
                        HECTA:=0
                        AMO:=SPACE(30)
                        @ 7,40 get cod color ("W+/G")
                        @ 9,30 GET NFIN COLOR ("W+/G")
                        @ 11,32 GET LOCALI COLOR ("W+/G")
                        @ 13,30 GET AMO COLOR ("W+/G")
                        @ 15,32 GET HECTA COLOR ("W+/G")
                        SET CURSOR ON
                        READ
                        SET CURSOR OFF
                        replace codfin with cod,nomfinca with nfin,;
                                localidad with locali,dueno with amo,;
                                hectareas with hecta

                ELSE
                        MSGBOX("Ficha no modificada")
                endif
        else
                MSGBOX('Esa finca no existe')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'SI','NO'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close fincas
SELECT(OLDAREA)
MSON()
return
*************************************************************************
func listpan()  //FINCAS
*************************************************************************
local oldarea,pantalla,fil:=0,COL:=0,f:=0
oldarea:=select()
msoff()
use fincas new
set scoreboard off
dbgotop()
save screen to pantalla
@ 2,14 say '                Listado de fincas                  ' color("W+/B")
@ 3,15,20,65 box ('≤≤≤≤≤≤≤≤≤') color ("N+")
@ 3,14,19,64 box ('€€€€€€€€€') color ("B")
@ 4,22 SAY 'C¢digo' color ("G+/B")
@ 4,39 SAY 'Finca' color ("G+/B")
FOR COL=14 TO 64
        @ 5,COL SAY 'ƒ' COLOR ("G+/B")
NEXT
@ 5,30 say '¬' color ("G+/B")
for f=6 to 19
        @ f,30 say '≥' color ("G+/B")
next
do while !eof()
        for fil=7 to 18
                @ 5,30 say '¬' color ("G+/B")
                for f=6 to 19
                        @ f,30 say '≥' color ("G+/B")
                next
                        @ fil,23 say codfin color ("W+/B")
                        @ fil,35 say nomfinca color ("W+/B")
                        dbskip()
                if fil==18 .and. !eof()
                        @ 24,19 SAY ' Pulse cualquier tecla para continuar...   ' color ("W+/B")
                        INKEY(0)
                ENDIF
        next
        if eof()
                inkey(0)
                exit
        endif
enddo
restore screen from pantalla
close fincas
select(oldarea)
MSON()
return
func listimp()
return
*******************************************************************
FUNC ALTORGA()  // ORGANICAS
*******************************************************************
local NORGA:=SPACE(30),CODORGA:=SPACE(4),direc:=space(30),tele:=space(14)
local prov:=space(20),f:=space(14),reor:=space(30),dite:=space(30)
local opc
local oldarea,PAN
PRIV TECLA
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
IF !FILE('ORGANICA.DBF')
        DBCREATE("ORGANICA",{;
                {'CODIGOORGA  ','C',04,00},;
                {'NOMORGA     ','C',30,00},;
                {'DIRECCION   ','C',30,00},;
                {'TELEFONO    ','C',14,00},;
                {'PROVINCIA   ','C',20,00},;
                {'FAX         ','C',14,00},;
                {'REORGA      ','C',30,00},;
                {'DIRECTECNI  ','C',30,00}})
Else
        msoff()
        OLDAREA:=SELECT()
        USE ORGANICA NEW
        INDEX ON CODIGOORGA TO ORGANICA UNIQUE
        SET INDEX TO ORGANICA
        DO WHILE .T.
                SAVE SCREEN TO PAN
                @ 2,20 SAY "             Nueva organica              " color ("W+/B")
                @ 3,21,20,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                @ 3,20,19,60 box ('€€€€€€€€€') color ("B")
                CODorga:=SPACE(4)
                NORGA:=SPACE(30)
                direc:=space(30)
                tele:=space(14)
                prov:=space(20)
                f:=space(14)
                reor:=space(30)
                dite:=space(30)
                @ 4,22 SAY "C¢digo de organica" color ("W+/B")
                @ 6,22 say "Organica" COLOR ("W+/B")
                @ 8,22 say "Direccion" COLOR ("W+/B")
                @ 10,22 say "TelÇfono" COLOR ("W+/B")
                @ 12,22 say "Fax" COLOR ("W+/B")
                @ 14,22 say "Provincia" COLOR ("W+/B")
                @ 16,22 say "R.Organica" COLOR ("W+/B")
                @ 18,22 say "D.TÇcnica" COLOR ("W+/B")
                @ 4,42 get codorga color ("W+/G")
                SET CURSOR ON
                read
                seek codorga
                if found()
                        MSGBOX('La organica ya fue introducida por ese c¢digo')
                else
                        @ 6,30 GET Norga COLOR ("W+/G")
                        @ 8,33 get direc COLOR ("W+/G")
                        @ 10,32 get tele COLOR ("W+/G")
                        @ 12,27 get f COLOR ("W+/G")
                        @ 14,33 get prov COLOR ("W+/G")
                        @ 16,34 get reor COLOR ("W+/G")
                        @ 18,33 get dite COLOR ("W+/G")
                        read
                        SET CURSOR OFF
                        append blank
                        replace codigoorga with codorga,nomorga with norga,;
                                direccion with direc,telefono with tele,;
                                fax with f,provincia with prov,reorga with reor,;
                                directecni with dite
                endif
                RESTORE SCREEN FROM PAN
                opc:=alert('®Desea continuar?',{'SI','NO'})
                IF OPC=2
                        EXIT
                ENDIF
        ENDDO
endif
CLOSE ORGANICA
SELECT(OLDAREA)
MSON()
return
******************************************************************
FUNC BORORGA() // ORGANICAS
******************************************************************
local oldarea,pan,opc,OPCION
local NORGA:=SPACE(30),CODORGA:=SPACE(4),direc:=space(30),tele:=space(14)
local prov:=space(20),f:=space(14),reor:=space(30),dite:=space(30)
priv bandera:=0
set delete on
oldarea:=select()
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
use organica new
set index to organica
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        bandera:=0
        @ 9,20 SAY "            Borrar organica              " color ("W+/B")
        @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
        Norga:=SPACE(30)
        codorga:=SPACE(4)
        direc:=space(30)
        tele:=space(14)
        prov:=space(20)
        f:=space(14)
        reor:=space(30)
        dite:=space(30)
        @ 12,22 SAY "C¢digo de la organica" color ("W+/B")
        @ 14,22 say "Organica" COLOR ("W+/B")
        @ 12,40 get codorga color ("W+/G")
        read
        seek codorga
        if found()
                @ 12,40 say codigoorga color ("W+/G")
                @ 14,30 say nomorga COLOR ("W+/G")
                INKEY(0)
                opc:=ALERT('®Desea borrar la ficha?',{'SI','NO'})
                do case
                        case opc = 1
                                bandera:=1
                                delete
                        case opc = 2
                                MSGBOX('Ficha no borrada a peticion del usuario')
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
        opc:=alert('®Desea continuar?',{'SI','NO'})
        IF OPC=2
                EXIT
        ENDIF
enddo
set delete off
close organica
SELECT(OLDAREA)
MSON()
return
****************************************************************************
FUNC CONORGA()  // ORGANICAS
****************************************************************************
LOCAL OLDAREA
local NORGA:=SPACE(30),CODORGA:=SPACE(4),direc:=space(30),tele:=space(14)
local prov:=space(20),f:=space(14),reor:=space(30),dite:=space(30)
local tecla
OLDAREA:=SELECT()
msoff()
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
USE organica NEW
index on codigoorga to organica unique
set index to organica
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 9,20 SAY "           Consultar organica            " color ("W+/B")
        @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
        Norga:=SPACE(30)
        codorga:=SPACE(4)
        direc:=space(30)
        tele:=space(14)
        prov:=space(20)
        f:=space(14)
        reor:=space(30)
        dite:=space(30)
        @ 12,22 SAY "C¢digo de la organica" color ("W+/B")
        @ 14,22 say "Organica" COLOR ("W+/B")
        @ 12,46 get codorga color ("W+/G")
        read
        seek codorga
        if found()
                @ 12,46 say codigoorga COLOR ("W+/G")
                @ 14,30 say nomorga COLOR ("W+/G")
                inkey(0)
        else
                MSGBOX('Organica inexistente')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'SI','NO'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close organica
SELECT(OLDAREA)
MSON()
return
*************************************************************************
FUNC MODORGA()  //ORGANICAS
*************************************************************************
LOCAL OLDAREA,pan,pan2
local NORGA:=SPACE(30),CODORGA:=SPACE(4),direc:=space(30),tele:=space(14)
local prov:=space(20),f:=space(14),reor:=space(30),dite:=space(30)
local tecla,res:=space(1)
OLDAREA:=SELECT()
SET SCOREBOARD OFF
set confirm on
set escape on
set bell on
USE organica NEW
index on codigoorga to organica unique
set index to organica
msoff()
DO WHILE .T.
        SAVE SCREEN TO PAN
        @ 9,20 SAY "           Modificar organica            " color ("W+/B")
        @ 5,21,18,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,17,60 box ('€€€€€€€€€') color ("B")
        Norga:=SPACE(30)
        codorga:=SPACE(4)
        direc:=space(30)
        tele:=space(14)
        prov:=space(20)
        f:=space(14)
        reor:=space(30)
        dite:=space(30)
        @ 12,22 SAY "C¢digo de la organica" color ("W+/B")
        @ 14,22 say "Organica" COLOR ("W+/B")
        @ 12,45 get codorga color ("W+/G")
        read
        seek codorga
        if found()
                @ 12,40 say codigoorga COLOR ("W+/G")
                @ 14,30 say nomorga COLOR ("W+/G")
                inkey(0)
                save screen to pan2
                @ 18,21,22,61 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                @ 18,20,21,60 box ('€€€€€€€€€') color ("GR")
                @ 19,22 say "®Desea modificar la organica? [s/n]" COLOR ("W+/GR");
                        get res pict "!" valid res $ "SN" COLOR ("W+/GR")
                read
                restore screen from pan2
                if res == "S"
                        codorga:=space(4)
                        norga:=space(30)
                        @ 12,40 get codorga COLOR ("W+/G")
                        @ 14,30 get norga COLOR ("W+/G")
                        SET CURSOR ON
                        READ
                        SET CURSOR OFF
                        replace codigoorga with codorga,nomorga with norga
                ELSE
                        MSGBOX("Ficha no modificada")
                endif
        else
                MSGBOX('Organica inexistente')
        endif
        RESTORE SCREEN FROM PAN
        opc:=alert('®Desea continuar?',{'SI','NO'})
        IF OPC=2
                EXIT
        ENDIF
enddo
close organica
SELECT(OLDAREA)
MSON()
return
*************************************************************************
func listpanorga()  //ORGANICAS
*************************************************************************
local oldarea,pantalla,fil:=0,COL:=0,f:=0
oldarea:=select()
msoff()
use organica new
dbgotop()
save screen to pantalla
@ 2,14 say '               Listado de organicas                ' color("W+/B")
@ 3,15,20,65 box ('≤≤≤≤≤≤≤≤≤') color ("N+")
@ 3,14,19,64 box ('€€€€€€€€€') color ("B")
@ 4,22 SAY 'C¢digo' color ("G+/B")
@ 4,39 SAY 'Org†nica' color ("G+/B")
FOR COL=14 TO 64
        @ 5,COL SAY 'ƒ' COLOR ("G+/B")
NEXT
@ 5,30 say '¬' color ("G+/B")
for f=7 to 19
        @ f,30 say '≥' color ("G+/B")
next
do while !eof()
        for fil=7 to 18
                @ 5,30 say '¬' color ("G+/B")
                for f=6 to 19
                        @ f,30 say '≥' color ("G+/B")
                next
                        @ fil,23 say codigoorga color ("W+/B")
                        @ fil,35 say nomorga color ("W+/B")
                        dbskip()
                if fil==18 .and. !eof()
                        @ 24,19 SAY ' Pulse cualquier tecla para continuar...   ' color ("W+/B")
                        INKEY(0)
                ENDIF
        next
        if eof()
                inkey(0)
                exit
        endif
enddo
restore screen from pantalla
close organica
select(oldarea)
MSON()
return
//func listimp()
//return
******************************************************
FUNC CACERIA()  // DATOS DE LA CACERIA
******************************************************
LOCAL OLDAREA,PAN3,TECLA,PANTALLA
local   MANC:=SPACE(50),FECH:=CTOD(SPACE(8)),PREC:=0,;
        NRES:=0,NJAV:=0,NCIER:=0,NMUF:=0,NPUES:=0,NREAL:=0,NRESPUEST:=0,;
        NVEN:=0,PRECRES:=0,CODFINCA:=SPACE(4),NFINCA:=SPACE(30),CODORGA:=SPACE(4),;
        NORGA:=SPACE(30),PROV:=SPACE(20),OR1:=0,PLA1:=0,BRO1:=0,OR2:=0,PLA2:=0,BRO2:=0,;
        OR3:=0,PLA3:=0,BRO3:=0,OR4:=0,PLA4:=0,BRO4:=0,col:=0
IF !FILE('CACERIA.DBF')
        ALERT('FICHERO NO CREADO,SE VA HA PROCEDER A CREARLO')
        dbcreate('CACERIA',{;
                           {'CODIGOFINCA ','C',04,00},;
                           {'NOMBREFINCA ','C',30,00},;
                           {'CODIGOORGANI','C',04,00},;
                           {'NOMBREORGANI','C',30,00},;
                           {'PROVINCIA   ','C',20,00},;
                           {'MANCHA      ','C',50,00},;
                           {'FECHA       ','D',08,00},;
                           {'PRECIO      ','N',07,00},;
                           {'ORO1        ','N',03,00},;
                           {'PLATA1      ','N',03,00},;
                           {'BRONCE1     ','N',03,00},;
                           {'ORO2        ','N',03,00},;
                           {'PLATA2      ','N',03,00},;
                           {'BRONCE2     ','N',03,00},;
                           {'ORO3        ','N',03,00},;
                           {'PLATA3      ','N',03,00},;
                           {'BRONCE3     ','N',03,00},;
                           {'ORO4        ','N',03,00},;
                           {'PLATA4      ','N',03,00},;
                           {'BRONCE4     ','N',03,00},;
                           {'NRESES      ','N',05,00},;
                           {'NJAVALIES   ','N',05,00},;
                           {'NCIERVOS    ','N',05,00},;
                           {'NMUFLONES   ','N',05,00},;
                           {'NVENADOS    ','N',05,00},;
                           {'NPUESTOS    ','N',06,00},;
                           {'NREALES     ','N',05,00},;
                           {'NRESESPUESTO','N',06,00},;
                           {'PRECIORES   ','N',07,00}})
ELSE
        MSOFF()
        set key K_F2 to listpan()
        set key K_F3 to listpanorga()
        SET SCOREBOARD OFF
        set confirm on
        set escape on
        PRIV RESPUESTA:='S'
        OLDAREA:=SELECT()
        USE CACERIA NEW
        INDEX ON CODIGOFINCA TO CACERIA UNIQUE
        SET INDEX TO CACERIA
        DO WHILE RESPUESTA=='S'
                CODFINCA:=SPACE(4)
                NFINCA:=SPACE(30)
                CODORGA:=SPACE(4)
                NORGA:=SPACE(30)
                MANC:=SPACE(50)
                FECH:=CTOD(SPACE(8))
                PROV:=SPACE(20)
                OR1:=0
                PLA1:=0
                BRO1:=0
                OR2:=0
                PLA2:=0
                BRO2:=0
                OR3:=0
                PLA3:=0
                BRO3:=0
                OR4:=0
                PLA4:=0
                BRO4:=0
                PREC:=0
                NRES:=0
                NJAV:=0
                NCIER:=0
                NMUF:=0
                NPUES:=0
                NREAL:=0
                NRESPUEST:=0
                NVEN:=0
                PRECRES:=0
                SAVE SCREEN TO PAN3
                @ 2,2 say '                          Datos de la cacer°a                               ' color("W+/B")
                @ 3,3,22,78 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                @ 3,2,21,77 box ('€€€€€€€€€') color ("B+")
                @ 4,4 SAY 'C¢digo de la finca' color ("W+/B+") GET CODFINCA COLOR("W+/G")
                set cursor on
                READ
                OLDAREA:=SELECT()
                USE FINCAS NEW
                SET INDEX TO FINCAS
                DBGOTOP()
                SEEK CODFINCA
                *********************
                IF FOUND()
                *********************
                        @ 4,32 SAY 'Finca' color ("W+/B+")
                        @ 4,42 SAY NOMFINCA COLOR ("W+/G")
                        NFINCA:=NOMFINCA
                        CODFINCA:=CODFIN
                        CLOSE FINCAS
                        SELECT(OLDAREA)
                        @ 6,4 say "C¢digo de la org†nica" color ("W+/B+") GET CODORGA COLOR ("W+/G")
                        set cursor on
                        READ
                        OLDAREA:=SELECT()
                        USE ORGANICA NEW
                        SET INDEX TO ORGANICA
                        DBGOTOP()
                        SEEK CODORGA
                        IF FOUND()
                                @ 6,32 SAY "Organica" COLOR ("W+/B+")
                                @ 6,42 say nomorga COLOR ("W+/G")
                                NORGA:=NOMORGA
                                codorga:=codigoorga
                                CLOSE ORGANICA
                                SELECT(OLDAREA)
                                @ 8,4 say 'Mancha' color ("W+/B+") get MANC COLOR ("W+/G")
                                @ 10,4 say 'Fecha' color ("W+/B+") get FECH VALID FECH<=DATE() color ("W+/G")
                                @ 10,25 say 'Precio' color ("W+/B+") get PREC color ("W+/G")
                                @ 10,44 SAY 'Provincia' color ("W+/B+") get prov color ("W+/G")
                                ***************************
                                @ 12,4 say 'Nß de Javal°es' color ("W+/B+") get NJAV color ("W+/G")
                                ***************************
                                ****************************
                                @ 12,32 say 'Nß de Ciervos' color ("W+/B+") get NCIER color ("W+/G")
                                ****************************
                                ****************************
                                @ 14,4 say 'Nß de Muflones' color ("W+/B+") GET NMUF color ("W+/G")
                                ****************************
                                *************************
                                @ 14,32 SAY 'Nß de Venados' COLOR ("W+/B+") GET NVEN COLOR ("W+/G")
                                *************************
                                @ 16,4 say 'Nß de Puestos' color ("W+/B+") GET NPUES color ("W+/G")
                                @ 16,32 say 'Nß de Realas' color ("W+/B+") GET NREAL color ("W+/G")
                                SET CURSOR ON
                                read
                                @ 20,4 say 'Nß de Reses por puesto' color ("W+/B+")
                                @ 18,20 say 'Nß de Reses' color ("W+/B+")
                                nres:=njav+ncier+nmuf+nven   // CALCULA EL NUMERO DE RESES
                                @ 18,33 say NRES color ("W+/G")
                                @ 20,42 say 'Precio de la res' color ("W+/B+")
                                precres:=prec/nres     // CALCULA EL PRECIO DE LA RES
                                @ 20,60 say PRECRES COLOR ("W+/G")
                                nrespuest:=nres/npues  // CALCULA LAS RESES POR PUESTO
                                @ 20,28 say NRESPUEST COLOR ("W+/G")
                                SCRCROSS(0,0,24,79,PAN3)
                                ****************************************************
                                ****************************************************
                                save screen to pantalla
                                @ 4,1,13,78 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                                @ 5,0,12,77 box ('€€€€€€€€€') color ("B+")
                                for col:=0 to 77
                                        @ 3,col say ' ' color ("W+/B")
                                        @ 4,col say ' ' color ("W+/R")
                                next
                                @ 3,35 say "Trofeos" color ("W+/B")
                                @ 4,2 say '    Javal°es    ' color ("W+/R")
                                @ 7,2 SAY 'Oros' COLOR ("W+/B+") GET OR1 COLOR ("W+/G")
                                @ 9,2 SAY 'Platas' COLOR ("W+/B+") GET PLA1 COLOR ("W+/G")
                                @ 11,2 SAY 'Bronces' COLOR ("W+/B+") GET BRO1 COLOR ("W+/G")
                                ***************************************************
                                ***************************************************
                                @ 4,19 say '    Ciervos    ' color ("W+/R")
                                @ 7,21 SAY 'Oros' COLOR ("W+/B+") GET OR2 COLOR ("W+/G")
                                @ 9,21 SAY 'Platas' COLOR ("W+/B+") GET PLA2 COLOR ("W+/G")
                                @ 11,21 SAY 'Bronces' COLOR ("W+/B+") GET BRO2 COLOR ("W+/G")
                                ***************************************************
                                ***************************************************
                                @ 4,38 say '    Muflones    ' color ("W+/R")
                                @ 7,40 SAY 'Oros' COLOR ("W+/B+") GET OR3 COLOR ("W+/G")
                                @ 9,40 SAY 'Platas' COLOR ("W+/B+") GET PLA3 COLOR ("W+/G")
                                @ 11,40 SAY 'Bronces' COLOR ("W+/B+") GET BRO3 COLOR ("W+/G")
                                ***************************************************
                                ***************************************************
                                @ 4,57 say '    Venados     ' color ("W+/R")
                                @ 7,59 SAY 'Oros' COLOR ("W+/B+") GET OR4 COLOR ("W+/G")
                                @ 9,59 SAY 'Platas' COLOR ("W+/B+") GET PLA4 COLOR ("W+/G")
                                @ 11,59 SAY 'Bronces' COLOR ("W+/B+") GET BRO4 COLOR ("W+/G")
                                *****************************************************
                                *****************************************************
                                read
                                SET CURSOR OFF
                                INKEY(0)
                                IF alert('®Esta conforme con los datos',{'NO','SI'})==2
                                        append blank
                                        replace MANCHA with MANC,NOMBREFINCA WITH NFINCA,;
                                                CODIGOFINC WITH CODFINCA,FECHA with FECH,PRECIO with PREC,;
                                                NRESES with NRES,NJAVALIES with NJAV,NCIERVOS with NCIER,;
                                                NMUFLONES with NMUF, NPUESTOS with NPUES,;
                                                NREALES with NREAL, NRESESPUESTO with NRESPUEST,;
                                                PRECIORES with PRECRES,CODIGOORGANI with CODORGA,;
                                                NOMBREORGANI with NORGA,PROVINCIA with PROV,;
                                                ORO1 with OR1,PLATA1 with PLA1,BRONCE1 with BRO1,;
                                                ORO2 with OR2,PLATA2 with PLA2,BRONCE2 with BRO2,;
                                                ORO3 with OR3,PLATA3 with PLA3,BRONCE3 with BRO3,;
                                                ORO4 with OR4,PLATA4 with PLA4,BRONCE4 with BRO4
                                ELSE
                                        MSGBOX('FICHA INCORRECTA')
                                ENDIF
                                IF ALERT('®Quiere introducir otra finca?',{'SI','NO'})==2
                                        RESPUESTA:='N'
                                ENDIF
                                restore screen from pantalla
                        ELSE
                                MSGBOX ('Organica inexistente')
                                IF ALERT('®Desea darla de alta?',{'Si','No'})==1
                                        close organica
                                        select(oldarea)
                                        altorga()
                                else
                                        CLOSE ORGANICA
                                        SELECT(OLDAREA)
                                endif
                        ENDIF
                *************
                ELSE
                *************
                        MSGBOX('Finca inexistente')
                        if alert('®Desea darla de alta?',{'Si','No'})==1
                                CLOSE FINCAS
                                SELECT(OLDAREA)
                                ALTFIN()
                        ELSE
                                CLOSE FINCAS
                                SELECT(OLDAREA)
                        ENDIF
                *************
                ENDIF
                *************
                SELECT(OLDAREA)
                SCRCROSS(0,0,24,79,PAN3)
        ENDDO
        CLOSE CACERIA
ENDIF
MSON()
RETURN

function listimpresora()

local oldarea,bandera:=0,aux,i,j
PRIV cod:=space(4),nom:=space(30),ciu:=space(10),SIONO:=.f.
oldarea:=select()
SET DEVICE TO PRINTER
LISTAR()
SET DEVICE TO SCREEN

return
*****************************************************************
function listar(fich,indi,campos,tit,condicion,ncol,nlipa)
*****************************************************************
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
@ 23,35 say ('P†gina:')
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
              @ 17,35 say ('P†gina:')
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




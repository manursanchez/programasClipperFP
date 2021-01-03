
# include "inkey.ch"
# include "clvision.ch"
# INCLUDE "BOX.CH"
# include "dbstruct.ch"
# include "achoice.ch"

pulldown omenu colors "W+/B","N/BG","GR+/B"
    clear
    MENU "Ar&chivo" MESSAGE "Operaciones de archivos"
        menuitem "&nuevo" message "crea un nuevo archivo" execute nuevo();
             execute                                                  ;
             menuanida(11,61,{                                      ;
                   {"&sombras normales"},                           ;
                   {"sombras &reales",,{||                          ;
                     menuanida(13,79,{                              ;
                         {"&activar",,{|| omenu:ltrueshadow := .T.}}, ;
                         {"&desactivar",,{|| omenu:ltrueshadow := .F.}}},omenu);
                     }}},omenu)
        menuitem "&abrir" message "carga un archivo" shortkey K_F3;
             EXECUTE ABRIR()
        menuitem "&grabar" message "grava un archivo" shortkey K_F2;
             EXECUTE grabar()
        menuitem separator
        menuitem "&imprimir" message "imprime un archivo"  EXECUTE imprimir()
        menuitem separator
        menuitem "&salir" message "salir" shortkey K_ALT_X;
             EXECUTE OMENU:lend := .T.
    ENDMENU
    MENU "SOCIOS" Message "Mantenimiento de Socios"
        MENUITEM "&ALTAS" execute ALTAS()
        MENUITEM "&BAJAS" execute BAJAS()
        MENUITEM "&CONSULTAS " execute CONSULTAS()
        MENUITEM "&MODIFICACIONES" execute MODIFICA()
        MENUITEM separator
        MENUITEM "LISTADOS" execute LISTADOS()
    ENDMENU
    MENU "EDITORIAL" message "Mantenimiento de Editoriales"
        menuitem "CONSULTAS"      execute CONSULTAS()
        menuitem separator
        menuitem "ALTAS"          execute ALTAS()
        menuitem "BAJAS"          execute BAJAS()
        menuitem "MODIFICACIONES" execute MODIFICA()
        menuitem separator
        menuitem "LISTADOS"       execute LISTADOS()
    endmenu
    clear
ENDPULLDOWN

clear
if !file('editori.dbf')
        dbcreate("editori",;
                {{"codigo        ","c",04,00},;
                 {"editorial     ","c",30,00}})
endif
If !File('socios.dbf')
        dbcreate('socios.dbf',;
                {{"dni       ","c",10,00},;
                 {"nombre    ","c",30,00},;
                 {"apel1     ","c",30,00},;
                 {"apel2     ","c",30,00},;
                 {"direc     ","c",30,00},;
                 {"codigopos ","n",05,00},;
                 {"ciudad    ","c",15,00},;
                 {"telefono  ","n",10,00},;
                 {"sancionado","c",01,00}})
endif
RUNMENU OMENU
CLEAR
QUIT

FUNC NUEVO()
RETURN
FUNC ABRIR()
RETURN
FUNC IMPRIMIR()
RETURN
FUNC CORTAR()
RETURN
FUNC GRABAR()
RETURN
FUNC COPIAR()
RETURN
FUNC PEGAR()
RETURN
****************
FUNC CONSULTAS()
****************
local res:="S",cod:=space(10)
use socios new
index on dni to socios unique
set index to socios
do while res=="S"
        CUADROS1()
        @ 1,25 say ' CONSULTAS '
        @ 23,18 say 'DNI:' get cod valid cod>space(10)
        read
        locate for dni=cod
        if found()
           @ 5,25 say 'DNI:'
           ?? dni
           @ 6,12 say 'NOMBRE:'
           ?? nombre
           @ 7,12 say 'APELLIDO 1§:'
           ?? apel1
           @ 8,12 say 'APELLIDO 2§:'
           ?? apel2
           @ 9,12 say 'DIRECCION:'
           ?? direc
           @ 10,12 say 'CODIGO POSTAL:'
           ?? codigopos
           @ 11,12 say 'CIUDAD:'
           ?? ciudad
           @ 12,12 say 'TELEFONO:'
           ?? telefono
           @ 6,12 say 'SANCIONADO:'
           ?? sancionado
        else
           alert ('Ficha no encontrada ¢ no existe')
        endif
        res:=space(1)
        @ 23,18 say '¨Quiere consultar m s [S/N]?';
        get res pict "!" valid res $ "SN"
        read
enddo
close socios
Return
************
FUNC ALTAS()
************
local res:='S',cod:=space(10),nomb:=space(30),ape1:=space(30),ape2:=space(30)
local dir:=space(30),codpos:=0,ciud:=space(15),telef:=0,sancion:=space(01)
use socios new
index on dni to socios unique
set index to socios
do while res=='S'
        CUADROS1()
        @ 1,25 say ' ALTAS '
        @ 5,12 say 'DNI:' get cod valid cod>space(10)
        read
        locate for dni==cod
        if found()
                alert ('Este DNI ya ha sido utilizado')
        else
            @ 6,12 say 'NOMBRE        :' get nomb
            @ 7,12 say 'APELLIDO 1§   :' get ape1
            @ 8,12 say 'APELLIDO 2§   :' get ape2
            @ 9,12 say 'DIRECCION     :' get dir
            @ 10,12 say 'CODIGO POSTAL:' get codpos
            @ 11,12 say 'CIUDAD       :' get ciud
            @ 12,12 say 'TELEFONO     :' get telef
            @ 13,12 say 'SANCIONADO   :' get sancion
            read
            res:= space(1)
            @ 23,18 say '¨Esta conforme con los datos [S/N]?';
                    get res pict "!" valid res $ "SN"
            read

            if res == "S"
               append blank
               replace dni with cod,nombre with nomb,apel1 with ape1,;
                 apel2 with ape2,direc with dir,codigopos with codpos,;
                 ciudad with ciud,telefono with telef,;
                 sancionado with sancion
            endif
        endif
        res:=space(1)
        @ 23,18 say '¨Quieres introducir m s altas [s/n]? ';
                    get res pict "!" valid res $ "SN"
        read
enddo
close socios
Return
************
FUNC BAJAS()
************
local res:='S',bandera:=0,cod:=space(10)
set deleted on
use socios new
index on dni to socios unique
set index to socios
do while res == "S"
        CUADROS1()
        @ 1,25 say ' BAJAS '
        @ 5,18 say 'DNI' get cod valid cod>space(10)
        read
        locate for dni==cod
        if found()
                @ 6,12  say 'NOMBRE       : '+ nombre
                @ 7,12  say 'APELLIDO 1§  : '+ apel1
                @ 8,12  say 'APELLIDO 2§  : '+ apel2
                @ 9,12  say 'DIRECCION    : '+ direc
                @ 10,12 say 'CODIGO POSTAL: '+ codigopos
                @ 11,12 say 'CIUDAD       : '+ ciudad
                @ 12,12 say 'TELEFONO     : '+ telefono
                @ 13,12 say 'SANCIONADO   : '+ sancionado
                res:=space(1)
                @ 23,18 say '¨Quiere dar de baja [S/N]?';
                get res pict "!" valid res $ "SN"
                read
                if res=="S"
                     bandera:=1
                     delete
                 else
                     @ 23,18 say 'Socio no dado de baja'
                     inkey(0)
                 endif
        else
                alert ('No existe socio con ese DNI')
        endif
        res:=space(1)
        @ 23,18 say '¨Quieres dar m s de baja [s/n]? ';
                    get res pict "!" valid res $ "SN"
        read
enddo
if bandera==1
        alert ('Se va a proceder a una compactaci¢n del fichero')
        pack
endif
set delete off
close socios
Return
***************
FUNC MODIFICA()
***************
local res:="S",cod:=space(10),nomb:=space(30),ape1:=space(30),ape2:=space(30)
local dir:=space(30),codpos:=0,ciud:=space(15),telef:=0,sancion:=space(01)
use socios new
index on dni to socios unique
set index to socios
do while res=="S"
        CUADROS1()
        @ 1,25 say ' MODIFICACIONES '
        @ 18,18 say 'DNI:' get cod valid cod>space(10)
        read
        seek dni
        if found()
        // cod:=codigo;edit:=editorial
           @ 6,12  say 'NOMBRE       : '+ nombre
           @ 7,12  say 'APELLIDO 1§  : '+ apel1
           @ 8,12  say 'APELLIDO 2§  : '+ apel2
           @ 9,12  say 'DIRECCION    : '+ direc
           @ 10,12 say 'CODIGO POSTAL: '+ codigopos
           @ 11,12 say 'CIUDAD       : '+ ciudad
           @ 12,12 say 'TELEFONO     : '+ telefono
           @ 13,12 say 'SANCIONADO   : '+ sancionado
           res=space(1)
           @ 23,18 say '¨Modificar la ficha [S/N]?';
               get res pict "!" valid res $ "SN"
           read
           if res="S"
              @ 6,12 say 'NOMBRE        :' get nomb
              @ 7,12 say 'APELLIDO 1§   :' get ape1
              @ 8,12 say 'APELLIDO 2§   :' get ape2
              @ 9,12 say 'DIRECCION     :' get dir
              @ 10,12 say 'CODIGO POSTAL:' get codpos
              @ 11,12 say 'CIUDAD       :' get ciud
              @ 12,12 say 'TELEFONO     :' get telef
              @ 13,12 say 'SANCIONADO   :' get sancion
              read
              replace dni with cod,nombre with nomb,apel1 with ape1,;
                apel2 with ape2,direc with dir,codigopos with codpos,;
                ciudad with ciud,telefono with telef,sancionado with sancion
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
close socios
Return
***************
FUNC LISTADOS() // #################### PROCEDURE LISTADOS ####################
***************
LOCAL LI:=8
use socios new
index on dni to socios unique
set index to socios
cuadros2()
DO WHILE !EOF()
        @ 1,25 say 'LISTADO DE EDITORIALES'
        @ 6,1 say 'DNI'
        @ 6,12 say 'NOMBRE'
        @ 6,43 say 'APELLIDO 1§'
        @ 6,74 say 'APELLIDO 2§'
        @ 6,76 say 'SANCIONADO'

        @ LI,1 say trim(dni)
        @ LI,12 SAY trim(nombre)
        @ LI,43 SAY trim(apel1)
        @ LI,74 SAY trim(apel2)
        @ LI,76 SAY trim(sancionado)
        LI++
        SKIP
        IF LI=17 .AND. !EOF()
              @ 23,28 say 'PULSE UNA TECLA PARA CONTINUAR'
              INKEY(0)
              LI:=8
              cuadros2()
        ENDIF
ENDDO
IF LI !=7
      @ 23,28 say 'PULSE UNA TECLA PARA CONTINUAR'
      INKEY(0)
endif
close socios
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
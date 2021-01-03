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
    MENU "&Edicion" MESSAGE "OPCIONES DE BLOQUES"
        MENUITEM "&CORTAR" EXECUTE CORTAR()
        MENUITEM "&COPIAR" EXECUTE COPIAR()
        MENUITEM "&PEGAR " EXECUTE PEGAR() DISABLED
    ENDMENU
    MENU "EDITORIAL" message "Mantenimiento de Editoriales"
        menuitem "CONSULTAS"      execute CONSULTAS_E()
        menuitem separator
        menuitem "ALTAS"          execute ALTAS_E()
        menuitem "BAJAS"          execute BAJAS_E()
        menuitem "MODIFICACIONES" execute MODIFICA_E()
        menuitem separator
        menuitem "LISTADOS"
        menuitem "POR PANTALLA"  execute LISTAR_PANTALLA_E()
        menuitem "POR IMPRESORA" execute LISTAR_IMPRESORA_E()
    endmenu
ENDPULLDOWN

set procedure to "editor"
set procedure to "libros"
set procedure to "socios"
set procedure to "prestamo"

if !file('editori.dbf')
        dbcreate("editori",;
                {{"codigo   ","c",04,00},;
                 {"editorial","c",30,00}})
endif
if !file('libros.dbf')
        dbcreate("libros",;
                {{"codigo    ","c",04,00},;
                 {"titulo    ","c",30,00},;
                 {"autor     ","c",30,00},;
                 {"quedan    ","n",03,00},;
                 {"estante   ","c",04,00},;
                 {"disponible","c",01,00}})
endif
if !file('SOCIOS.dbf')
        dbcreate("socios",;
                {{"dni       ","c",10,00},;
                 {"nombre    ","c",30,00},;
                 {"apel1     ","c",30,00},;
                 {"apel2     ","c",30,00},;
                 {"direc     ","c",30,00},;
                 {"codigopos ","n",05,00},;
                 {"ciudad    ","c",15,00},;
                 {"telefono  ","n",09,00},;
                 {"sancionado","c",01,00}})
endif
if !file('prestamo.dbf')
        dbcreate("prestamo",;
                {{"codisoc  ","c",10,00},;
                 {"codilib  ","c",04,00},;
                 {"fechadel ","d",10,00},;
                 {"fechapres","d",10,00}})
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


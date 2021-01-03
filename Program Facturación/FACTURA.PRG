# include "inkey.ch"
# include "box.ch"
# include "clvision.ch"
# INCLUDE "DBSTRUCT.CH"
pulldown omenu colors "W+/B","N/BG","GR+/B"
    MENU "&Facturas"
        menuitem "&Facturas de clientes" execute fact1()
        menuitem "Facturas en &blanco" execute fact2()
        menuitem "&Seleccion de productos" execute selecpro()
    ENDMENU
    MENU "&Clientes"
        MENUITEM "&Nuevo cliente" message "Da de alta un nuevo cliente y lo mete dentro del ordenador" EXECUTE ALTcli()
        MENUITEM "&Borrar cliente" message "Borra el cliente elegido del ordenador" EXECUTE BORcli()
        MENUITEM "&Consultar cliente" message "Consulta un cliente" execute concli()
        MENUITEM "&Modificar cliente" message "Modifica el cliente elegido por si tiene algun dato mal" execute modcli()
        MENUITEM "Listar por &pantalla" message "Te salen todos los clientes por pantalla";
                execute listpan()
        MENUITEM "Listar por &impresora" message "Te sale un listado por impresora de todos los clientes";
                execute listimp(,,{'ruta','codcli','nombre','apellido1','observa'},,,)
    ENDMENU
    MENU "&Productos"
        MENUITEM "&Nuevo producto" message "Da de alta un nuevo producto y lo mete dentro del ordenador" execute altpro()
        MENUITEM "&Borrar producto" message "Borra el producto elegido del ordenador" execute borpro()
        MENUITEM "&Consultar producto" message "Consulta un producto" execute conpro()
        MENUITEM "&Modificar producto" message "Modifica el producto elegido por si tiene algun dato mal" execute modpro()
        MENUITEM "&Listar por pantalla" message "Te sale un listado por pantalla de todos los productos";
                execute listpanpro()
        MENUITEM "&Listar por impresora" execute listimppro()
    ENDMENU
    MENU "&Listados por rutas"
        menuitem "&Lunes" execute listruta("L","Listado de clientes de la ruta del Lunes")
        menuitem "&Martes" execute listruta("M","Listado de clientes de la ruta del Martes")
        menuitem "&Miercoles" execute listruta("X","Listado de clientes de la ruta del Miercoles")
        menuitem "&Jueves" execute listruta("J","Listado de clientes de la ruta del Jueves")
        menuitem "&Viernes" execute listruta("V","Listado de clientes de la ruta del Viernes")
    endmenu
    MENU "&Salir"
        MENUITEM "&Acerca de..." execute acerca()
        MENUITEM "&Salir  Alt-X" message "Salir del programa" SHORTKEY K_ALT_X;
                EXECUTE OMENU:lend:=.T.
    ENDMENU
ENDPULLDOWN
set procedure to "clien"
set procedure to "producto"
set procedure to "Tipo"
set procedure to "listado"
IF !FILE('CLIENTES.DBF')
        DBCREATE("CLIENTES",{;
                {'RUTA     ','C',01,00},;
                {'CODCLI   ','C',04,00},;
                {'DNI      ','C',15,00},;
                {'NOMBRE   ','C',40,00},;
                {'DOMICILIO','C',30,00},;
                {'OBSERVA  ','C',30,00},;
                {'TELEFONO ','C',10,00}})
endif
IF !FILE('PRODUCTO.DBF')
        DBCREATE("PRODUCTO",{;
                {'CODPRO      ','C',04,00},;
                {'NOMPRO      ','C',40,00}})
endif
RUNMENU OMENU
CLS
QUIT
**********************************************************************
func acerca()
**********************************************************************
local pan
save screen to pan
@ 6,16,13,64 box "∞∞∞∞∞∞∞∞∞" color ("N+")
@ 6,15,12,63 box "€€€€€€€€€" color ("B")
@ 5,15 say "                  Acerca de...                   " color ("GR+/B")
@ 7,16 say "Programa de facturaci¢n y mantenimiento V.1.0." color ("G+/B")
@ 8,30 say "Realizado por:" color ("G+/B")
@ 9,25 say "Manuel Rodr°guez S†nchez" color ("G+/B")
@ 10,25 say "Aplicaciones inform†ticas" color ("G+/B")
@ 11,17 say "Tlf:(958)16-30-67/E-Mail:lito@mx3.redestb.es" color ("G+/B")
inkey(0)
RESTORE SCREEN FROM PAN
return
********************************************************************
func selecpro()
********************************************************************
local opc
opc:=alert('®Factura?',{'Nueva','Modificar'})
do case
        case opc=1
                facnueva()
        case opc=2
                facmod()
endcase
return
*********************************************************************
func facnueva()
*********************************************************************
local oldarea,cod:=space(4),pro:=space(40),contador:=0,pan,fexiste
fexiste:=file('copia.dbf')
if fexiste
        ferase('copia.dbf')
        ferase('copia.ntx')
        msgbox('Factura anterior borrada')
endif
IF !FILE('copia.DBF')
        DBCREATE("copia",{;
                {'CODcopia    ','C',04,00},;
                {'NOMcopia    ','C',40,00}})
else
        msgbox('El fichero todav°a existe')
endif
oldarea:=select()
use producto new
index on codpro to producto unique
set index to producto
do while contador!=48 .or. .t.
        save screen to pan
        @ 4,20 SAY "      Introducir Producto en Factura              " color ("W+/R")
        @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
        @ 7,22 SAY "C¢digo del producto:" color ("W+/B")
        @ 9,22 say "Nombre:" COLOR ("W+/B")
        @ 7,43 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
                @ 9,31 say nompro COLOR ("W+/G")
                inkey(0)
                restore screen from pan
                OPC:=ALERT("®Desea introducir este producto en factura?",{'Si','No'})
                if opc=1
                        PRO:=NOMPRO
                        OLDAREA:=SELECT()
                        USE COPIA NEW
                        index on codcopia to copia unique
                        set index to copia
                        seek cod
                        if found()
                                alert('Producto introducido anteriormente')
                        else
                                append blank
                                replace codcopia with cod,nomcopia with pro
                                contador ++
                                if contador==48
                                        msgbox('48 Productos metidos en factura.Imposible meter mas')
                                        exit
                                endif
                        endif
                        CLOSE COPIA
                        SELECT (OLDAREA)
                else
                        msgbox('Producto no introducido en factura')
                endif
        else
                alert('No existe el codigo')
                restore screen from pan
        endif
        opc:=alert('Meter otro producto',{'Si','No'})
        if opc==2
                exit
        endif
        if contador==48
                exit
        endif
enddo
return
*********************************************************************
func facmod()
*********************************************************************
local opc
opc:=alert('Que quiere hacer con el fichero productos',{'Borrar','Introducir nuevo'})
do case
        case opc=1
                borrarproducto()
        case opc=2
                inpro()
endcase
return
//////////////////////////////////////////////////////////////
func borrarproducto()
/////////////////////////////////////////////////////////////
local oldarea,cod:=space(4),nom:=space(40),bandera:=0,opc,pan
oldarea:=select()
use copia new
index on codcopia to copia unique
set index to copia
do while .t.
        save screen to pan
        @ 4,20 SAY "      Introducir Producto en Factura              " color ("W+/R")
        @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
        @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
        @ 7,22 SAY "C¢digo del producto:" color ("W+/B")
        @ 9,22 say "Nombre:" COLOR ("W+/B")
        @ 7,43 get cod color ("W+/G")
        set cursor on
        read
        set cursor off
        seek cod
        if found()
               @ 9,31 say nomcopia COLOR ("W+/G")
               inkey(0)
               restore screen from pan
               opc:=alert('®Quieres borrar la ficha?',{'Si','No'})
               do case
                        case opc = 1
                                bandera:=1
                                delete
                        case opc = 2
                                bandera:=0
                                msgbox('Ficha no borrada')
               endcase
        else
                msgbox('No se ha encontrado el producto')
        endif
        if bandera=1
                msgbox('Se va a proceder a compactar el fichero')
                pack
                msgbox('Fichero compactado')
        endif
        restore screen from pan
        opc:=alert('®Continuar?',{'Si','No'})
        if opc=2
                exit
        endif

enddo
close copia
select(oldarea)
return
///////////////////////////////////////////////////////////////////
func inpro()
//////////////////////////////////////////////////////////////////
local opc,oldarea,contador:=0,cod:=space(4),pro:=space(40)
do while .t.
        oldarea:=select()
        use copia new
        index on codcopia to copia unique
        set index to copia
        dbgotop()
        do while !eof()
                contador++
                dbskip()
        enddo
        close copia
        select(oldarea)
        if contador == 48
                msgbox('Hay 48 productos metidos en factura.Imposible meter mas')
                exit
        else
                oldarea:=select()
                use producto new
                index on codpro to producto unique
                set index to producto
                save screen to pan
                @ 4,20 SAY "       Introducir Producto en Factura              " color ("W+/R")
                @ 5,21,13,71 box ('∞∞∞∞∞∞∞∞∞') color ("N")
                @ 5,20,12,70 box ('€€€€€€€€€') color ("B")
                @ 7,22 SAY "C¢digo del producto:" color ("W+/B")
                @ 9,22 say "Nombre:" COLOR ("W+/B")
                @ 7,43 get cod color ("W+/G")
                set cursor on
                read
                set cursor off
                seek cod
                if found()
                        @ 9,31 say nompro COLOR ("W+/G")
                        inkey(0)
                        restore screen from pan
                        OPC:=ALERT("®Desea introducir este producto en factura?",{'Si','No'})
                        if opc=1
                                PRO:=NOMPRO
                                oldarea:=select()
                                use copia new
                                set index to copia
                                seek cod
                                if found()
                                        alert('Producto introducido anteriormente')
                                else
                                        append blank
                                        replace codcopia with cod,nomcopia with pro
                                        contador++
                                        if contador==48
                                                msgbox('Hay 48 productos en factura')
                                                exit
                                        endif
                                endif
                                close copia
                                select(oldarea)
                        else
                                msgbox('Producto no introducido en factura')
                        endif
                else
                        alert('No existe el codigo')
                        restore screen from pan
                endif
                opc:=alert('Meter otro producto',{'Si','No'})
                if opc==2
                        close producto
                        select(oldarea)
                        exit
                endif
        endif
        if contador==48
                close producto
                select(oldarea)
                exit
        endif
enddo
return






















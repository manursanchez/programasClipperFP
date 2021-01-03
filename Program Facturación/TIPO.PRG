*********************************************************************
func fact1()
*********************************************************************
local COD:=SPACE(4),l,c,opc
LOCAL OLDAREA,pan
set scoreboard off
set printer on
OLDAREA:=SELECT()
USE clientes NEW
index on codcli to clientes unique
set index to clientes
do while .t.
        save screen to pan
        cod:=space(4)
        @ 10,26,14,49 box ('°°°°°°°°°') color ("N+")
        @ 10,25,13,48 box ('ÛÛÛÛÛÛÛÛÛ') color ("B")
        @ 10,25 say "Cliente a sacar factura" color ("W+/B")
        @ 11,25 SAY "  Codigo Cliente" color ("W+/B")
        @ 13,25 say 'Codigo:' color ("W+/B")
        @ 13,33 get cod color ("W+/G")
        read
        seek cod
        restore screen from pan
        if found()
                set device to print
                do while isprinter()=.f.
                        if !isprinter()
                                Alert ('La impresora no funciona')
                                msgbox('Aseg£rese de que est  encendida y hay papel')
                        endif
                enddo
                @ 1,3 say "Antonio Jesus Valverde Garc¡a"
                @ 1,40 say nombre
                @ 2,8 say "N.I.F.24.233.357-M"
                @ 2,40 say "D.N.I.:"
                @ 2,49 say dni
                @ 3,1 say "C/Arzobispo Pedro de Castro,19-P2-3§D"
                @ 3,40 say domicilio
                @ 4,3 say "Telefono:(958)46-74-12-GRANADA"
                @ 4,40 say "Obs:"
                @ 4,45 say observa
                @ 6,1 say "N§ Factura:"
                @ 6,30 say "Fecha:"
                @ 6,55 say "C¢digo cliente:"
                @ 6,71 say codcli
                @ 7,1 say "Ú"
                for c=2 to 78
                        @ 7,c say "Ä"
                next
                @ 7,79 say "¿"
                @ 8,1 say "³"
                @ 8,2 SAY "C¢digo"
                @ 8,9 say "Cant."
                @ 8,30 say "Producto"
                @ 8,60 say "Precio"
                @ 8,70 say "Importe"
                @ 8,79 say "³"
                @ 9,1 say "Ã"
                for c=2 to 7
                        @ 9,c say "Ä"
                next
                @ 9,8 say "Â"
                for c=9 to 13
                        @ 9,c say "Ä"
                next
                @ 9,14 say "Â"
                for c=15 to 56
                        @ 9,c say "Ä"
                next
                @ 9,57 say "Â"
                for c=58 to 67
                        @ 9,c say "Ä"
                next
                @ 9,68 say "Â"
                for c=69 to 78
                        @ 9,c say "Ä"
                next
                @ 9,79 say "´"
                oldarea:=select()
                use copia new
                index on codcopia to copia unique ascending
                SET INDEX TO COPIA
                dbgotop()
                do while !eof()
                        for l=10 to 57
                                @ l,1 say "³"
                                @ l,3 say codcopia
                                @ l,8 say "³"
                                @ l,9 say "....."
                                @ l,14 say "³"
                                @ l,15 say nomcopia
                                @ l,57 say "³"
                                @ l,58 say ".........."
                                @ l,68 say "³"
                                @ l,69 say ".........."
                                @ l,79 say "³"
                                dbskip()
                        next
                enddo
                close copia
                select(oldarea)
                @ 58,1 say "À"
                for c=2 to 7
                        @ 58,c say "Ä"
                next
                @ 58,8 say "Á"
                for c=9 to 13
                        @ 58,c say "Ä"
                next
                @ 58,14 say "Á"
                for c=15 to 46
                        @ 58,c say "Ä"
                next
                @ 58,47 say "Â"
                for c=48 to 56
                        @ 58,c say "Ä"
                next
                @ 58,57 say "Å"
                for c=58 to 67
                        @ 58,c say "Ä"
                next
                @ 58,68 say "Á"
                for c=69 to 78
                        @ 58,c say "Ä"
                next
                @ 58,79 say "´"
                @ 59,47 say "³"
                @ 59,48 say "Cantidad:"
                @ 59,57 say "³"
                @ 59,58 say "....................."
                @ 59,79 say "³"
                @ 60,47 say "³"
                @ 60,48 say "IVA:"
                @ 60,57 say "³"
                @ 60,58 say "....................."
                @ 60,79 say "³"
                @ 61,47 say "³"
                @ 61,48 SAY "Total:"
                @ 61,57 say "³"
                @ 61,58 say "....................."
                @ 61,79 say "³"
                @ 62,47 say "À"
                for c=48 to 57
                        @ 62,c say "Ä"
                next
                @ 62,57 say "Á"
                for c=58 to 78
                        @ 62,c say "Ä"
                next
                @ 62,79 say "Ù"
                set device to screen
        else
                alert ('no existe el cliente')
        endif
        opc:=alert('Sacar otro cliente por factura',{'Si','No'})
        if opc=2
                exit
        endif
enddo
close clientes
select(oldarea)
return
/////////////////////////////////////////////////////////////////////////
func fact2()
////////////////////////////////////////////////////////////////////////
local COD:=SPACE(4),l,c,opc
LOCAL OLDAREA,pan
set printer on
set scoreboard off
do while .t.
                msgbox('Se va a proceder a sacar una factura sin cliente')
                set device to print
                do while isprinter()=.f.
                        if !isprinter()
                                Alert ('La impresora no funciona')
                                msgbox('Aseg£rese de que est  bien conectada al puerto LPT1,encendida y hay papel')
                        endif
                enddo
                @ 1,3 say "Antonio Jesus Valverde Garc¡a"
                @ 1,43 say "Nombre:"
                @ 2,8 say "N.I.F.24.233.357-M"
                @ 2,43 say "D.N.I.:"
                @ 3,1 say "C/Arzobispo Pedro de Castro,19-P2-3§D"
                @ 3,43 SAY "Domicilio:"
                @ 4,3 say "Telefono:(958)46-74-12-GRANADA"
                @ 4,43 say "Observaciones:"
                @ 8,1 say "N§ Factura:"
                @ 8,30 say "Fecha:"
                @ 8,55 say "C¢digo cliente:"
                @ 9,1 say "Ú"
                for c=2 to 78
                        @ 9,c say "Ä"
                next
                @ 9,79 say "¿"
                @ 10,1 say "³"
                @ 10,2 SAY "C¢digo"
                @ 10,9 say "Cant."
                @ 10,30 say "Producto"
                @ 10,60 say "Precio"
                @ 10,70 say "Importe"
                @ 10,79 say "³"
                @ 11,1 say "Ã"
                for c=2 to 7
                        @ 11,c say "Ä"
                next
                @ 11,8 say "Â"
                for c=9 to 13
                        @ 11,c say "Ä"
                next
                @ 11,14 say "Â"
                for c=15 to 56
                        @ 11,c say "Ä"
                next
                @ 11,57 say "Â"
                for c=58 to 67
                        @ 11,c say "Ä"
                next
                @ 11,68 say "Â"
                for c=69 to 78
                        @ 11,c say "Ä"
                next
                @ 11,79 say "´"
                oldarea:=select()
                use copia new
                set index to copia
                dbgotop()
                do while !eof()
                        for l=12 to 57
                                @ l,1 say "³"
                                @ l,3 say codcopia
                                @ l,8 say "³"
                                @ l,9 say "....."
                                @ l,14 say "³"
                                @ l,15 say nomcopia
                                @ l,57 say "³"
                                @ l,58 say ".........."
                                @ l,68 say "³"
                                @ l,69 say ".........."
                                @ l,79 say "³"
                                dbskip()
                        next
                enddo
                close copia
                select(oldarea)
                @ 58,1 say "À"
                for c=2 to 7
                        @ 58,c say "Ä"
                next
                @ 58,8 say "Á"
                for c=9 to 13
                        @ 58,c say "Ä"
                next
                @ 58,14 say "Á"
                for c=15 to 46
                        @ 58,c say "Ä"
                next
                @ 58,47 say "Â"
                for c=48 to 56
                        @ 58,c say "Ä"
                next
                @ 58,57 say "Å"
                for c=58 to 67
                        @ 58,c say "Ä"
                next
                @ 58,68 say "Á"
                for c=69 to 78
                        @ 58,c say "Ä"
                next
                @ 58,79 say "´"
                @ 59,47 say "³"
                @ 59,48 say "Cantidad:"
                @ 59,57 say "³"
                @ 59,58 say "....................."
                @ 59,79 say "³"
                @ 60,47 say "³"
                @ 60,48 say "IVA:"
                @ 60,57 say "³"
                @ 60,58 say "....................."
                @ 60,79 say "³"
                @ 61,47 say "³"
                @ 61,48 SAY "Total:"
                @ 61,57 say "³"
                @ 61,58 say "....................."
                @ 61,79 say "³"
                @ 62,47 say "À"
                for c=48 to 57
                        @ 62,c say "Ä"
                next
                @ 62,57 say "Á"
                for c=58 to 78
                        @ 62,c say "Ä"
                next
                @ 62,79 say "Ù"
                set device to screen
        opc:=alert('Sacar otra factura en blanco',{'Si','No'})
        if opc=2
                exit
        endif
enddo
return

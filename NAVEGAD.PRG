
      ***********************************************
      *            Miembros del Grupo:              *
      *---------------------------------------------*
      *          Ces reo Jim‚nez Romero             *
      *         Manuel Rodr¡guez S nchez            *
      *          Vicente Dorado Maga¤a              *
      ***********************************************
      ***********************************************
      *            Programa: SELEARCHIVOS           *
      *---------------------------------------------*
      * Programa que pone una pantalla de selecci¢n *
      *   de datos con dos ventanas copi ndolos de  *
      *                 una a otra.                 *
      ***********************************************

# include 'inkey.ch'
# include 'achoice.ch'
# include 'directry.ch'


local aFicheros:=directory("*.*"),nTotal:=0
aeval(aFicheros,;
        { | aFichero | ;
        Qout (PADR (afichero[F_NAME],10) , aFichero[F_SIZE],;
                   nTotal+=aFichero[F_SIZE]);
        })
? "Bytes Totales: ",nTotal

quit



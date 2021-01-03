/******
** Cabecera para la librer¡a Object ClipperVision.
** Puede, si lo desea, almacenar cada secci¢n
** en un fichero de cabecera distinto.
**
** (c) Gabriel Mu¤oz M rquez, 1993-94
*****/

#ifndef _CLVISION_CH
#define _CLVISION_CH

// Modos gr ficos soportados

#define CGA      4   /*  320x200 4 colores   */
#define EGALO    14  /*  640x200 16 colores  */
#define EGAHI    16  /*  640x350 16 colores  */
#define EGAMONO  15  /*  640x350 monocromo   */
#define VGALO    19  /*  320x200 256 colores */
#define VGAHI    18  /*  640x480 16 colores  */
#define SVGA0    93  /*  640x480 256 colores */
#define SVGA1    91  /*  800x600 16 colores  */
#define SVGA2    94  /*  800x600 256 colores */
#define SVGA3    95  /* 1024x768 16 colores  */
#define SVGA4    98  /* 1024x768 256 colores */

// Modos texto soportados

#define T40X25   0
#define T80X25   3
#define TMONO    7
#define T4350   64
#define T80X30  80
#define T80X43  81
#define T80X60  82
#define T132X25 83
#define T132X30 84
#define T132X43 85
#define T132X60 86                                                           

// Colores en ingl‚s

#define BLACK         0
#define BLUE          1
#define GREEN         2
#define CYAN          3
#define RED           4
#define MAGENTA       5
#define BROWN         6
#define LIGHTGRAY     7
#define DARKGRAY      8
#define LIGHTBLUE     9
#define LIGHTGREEN   10
#define LIGHTCYAN    11
#define LIGHTRED     12
#define LIGHTMAGENTA 13
#define YELLOW       14
#define WHITE        15

// Colores en espa¤ol

#define NEGRO          0
#define AZUL           1
#define VERDE          2
#define ROJO           4
#define MARRON         6
#define GRISBRILLO     7
#define GRIS           8
#define AZULBRILLO     9
#define VERDEBRILLO   10
#define CYANBRILLO    11
#define ROJOBRILLO    12
#define MAGENTABRILLO 13
#define AMARILLO      14
#define BLANCO        15

// Tipos de rellenados

#define F_VERTICAL   1
#define F_HORIZONTAL 2

// Atributos de ficheros

#define FA_READONLY   1
#define FA_HIDDEN     2
#define FA_SYSTEM     4
#define FA_LABEL      8
#define FA_DIRECTORY 16
#define FA_ARCHIVE   32

// Valores de retorno de la funci¢n GetDrive

#define D_PREPARADA   0
#define D_NOPREPARADA 1
#define D_PROTEGIDO   2
#define D_DESCONOCIDO 3

// Valores de retorno de la funci¢n PrnGet

#define P_PREPARADA   0
#define P_SINPAPEL    1
#define P_NOPREPARADA 2
#define P_DESCONOCIDO 3

// Valores de retorno de la funci¢n TipoPC

#define PC_AT          0
#define PC_PS280       1
#define PC_NORMAL      2
#define PC_XT          3
#define PC_PCJR        4
#define PC_XT2         5
#define PC_CONVERTIBLE 6
#define PC_PS230       7
#define PC_COMPAQP     8
#define PC_COMPAQPP    9

// Efectos de aparici¢n de ventanas

#define W_NORMAL  0
#define W_CORNER  1
#define W_CURTAIN 2
#define W_IN      3
#define W_OUT     4
#define W_SPIRAL  5
#define W_CROSS   6
#define W_DOWN    7
#define W_LEFT    8
#define W_RIGHT   9
#define W_UP     10

// Sintaxis OOP

#xcommand CLASS <NomClase> ;
   [ <Here:PUBLIC,FROM> <Hereda1> [,<HeredaN>] ] => ;
   function <NomClase>(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,lLogic) ;;
      static oObjeto, bNew ;;
      if oObjeto == NIL .or. (ValType( lLogic ) == "L" .and. lLogic) ;;
         AddClase(<"NomClase">, lLogic) ;
         [; Eval({|| <Hereda1>(,,,,,,,,,,,,,,,,,,,,,,,,,.T.)}) ] ;
         [; Eval({|| <HeredaN>(,,,,,,,,,,,,,,,,,,,,,,,,,.T.)}) ] ;
         [; #define CLASEPADRE <"Hereda1"> ]

#ifndef USEDATA
   #xcommand PUBLIC <Var1> [, <VarN> ] => AddDato(<"Var1">,"N") [; AddDato(<"VarN">,"N")]

   #xcommand PRIVATE <Var1> [, <VarN> ] => AddDato(<"Var1">,"P") [; AddDato(<"VarN">,"P")]
#else
   #xcommand DATA <Var1> [, <VarN> ] => AddDato(<"Var1">,"N") [; AddDato(<"VarN">,"N")]

   #xcommand DATA <Var1> [, <VarN> ] READONLY => AddDato(<"Var1">,"P") [; AddDato(<"VarN">,"P")]
#endif

#xcommand HIDDEN <Var1> [, <VarN> ] => AddDato(<"Var1">,"H") [; AddDato(<"VarN">,"H")]

#xcommand METHOD <xMetodo>([ <Params,...> ]) CONSTRUCTOR => ;
   AddMetodo(<"xMetodo">, {|Self [,<Params>]| <xMetodo>(Self [,<Params>]), Self }, lLogic)

#xcommand CONSTRUCTOR <xMetodo>([ <Params,...> ]) => ;
   bNew := { |Self [,<Params>]| <xMetodo>(Self [,<Params>]) } ;;
   AddMetodo(<"xMetodo">, bNew, lLogic )

#xcommand CONSTRUCTOR <xMetodo>([ <Params,...> ]) INLINE <Accion> [,<AccionN>] => ;
   bNew := { |Self [,<Params>]| <Accion> [,<AccionN>]} ;;
   AddMetodo(<"xMetodo">, bNew, lLogic )

#xcommand CONSTRUCTOR <xMetodo>([ <Params,...> ]) BLOCK <bBlock> => ;
   bNew := <bBlock> ;;
   AddMetodo(<"xMetodo">, bNew, lLogic )

#xcommand METHOD <xMetodo>([ <Params,...> ]) => AddMetodo(<"xMetodo">, ;
   {|Self [,<Params>]| <xMetodo>(Self [,<Params>])}, lLogic )

#xcommand METHOD <xMetodo>([ <Params,...> ]) INLINE <Accion> [,<AccionN>] => ;
   AddMetodo(<"xMetodo">,{|Self [,<Params>]| <Accion> [,<AccionN>]}, lLogic )

#xcommand METHOD <xMetodo>([ <Params,...> ]) BLOCK <bBlock> => ;
   AddMetodo(<"xMetodo">,<bBlock>, lLogic )

#xcommand METHOD <xMetodo>([ <Params,...> ]) VIRTUAL => ;
   AddMetodo(<"xMetodo">,{|| NIL }, lLogic )

#xcommand Friend:<NomClase>:<xMetodo>([<Params,...>]) =>;
   EVal(RunMetodo(<"NomClase">,<"xMetodo">),Self [,<Params>])

#xtranslate Self:Parent(<NomClase>):<xMetodo>([<Params,...>]) =>;
   EVal(RunMetodo(<"NomClase">,<"xMetodo">),Self [,<Params>])

#xtranslate Self:Parent:<xMetodo>([<Params,...>]) => ;
   Eval(RunMetodo( CLASEPADRE, <"xMetodo">),Self [,<Params>])

#xtranslate METHOD <NomClase>::<xMetodo>([ <Params,...>]) => ;
   static function <xMetodo>(Self [,<Params>])

#xcommand METHOD CONSTRUCTOR <xMetodo>([<Params,...>]) => ;
   static function <xMetodo>(Self [,<Params>])

#xcommand ENDCLASS => ;
      if lLogic == NIL ;;
         oObjeto := CreaObjeto() ;;
      end ;;
   else ;;
      oObjeto := __ClassIns( oObjeto:ClassH() ) ;;
   end ;;
   if bNew != NIL .and. oObjeto != NIL .and. lLogic == NIL;;
      oObjeto := Eval( bNew, oObjeto,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25 ) ;;
   end ;;
   return(oObjeto)

#xcommand DEFAULT <Var1> := <Dato1> [, <VarN> := <DatoN> ] => ;
   <Var1> := iif(<Var1> == NIL, <Dato1>, <Var1>) ;;
 [ <VarN> := iif(<VarN> == NIL, <DatoN>, <VarN>); ]

#xtranslate Self:<var>@   => Oculto(Self,<"var">)
#xtranslate Self:(<var>@) => Oculto(Self,<"var">)

#xtranslate Self:<var>@ := <valor> => Oculto(Self,<"var">,<valor>)

#xtranslate Self:<var>@ ++ => Oculto(Self,<"var">,"++",1)
#xtranslate Self:<var>@ -- => Oculto(Self,<"var">,"--",1)

#xtranslate Self:<var>@ += <valor> => Oculto(Self,<"var">,"+=",<valor>)
#xtranslate Self:<var>@ -= <valor> => Oculto(Self,<"var">,"-=",<valor>)
#xtranslate Self:<var>@ *= <valor> => Oculto(Self,<"var">,"*=",<valor>)
#xtranslate Self:<var>@ /= <valor> => Oculto(Self,<"var">,"/=",<valor>)
#xtranslate Self:<var>@ %= <valor> => Oculto(Self,<"var">,"%=",<valor>)
#xtranslate Self:<var>@ **= <valor> => Oculto(Self,<"var">,"**=",<valor>)

#xtranslate :: => Self:

#xtranslate This => Self

// Sintaxis de men£s PullDown

#xcommand PULLDOWN <oObjeto> [<lT:COLOR,COLORS> <cColors,...>] => ;
     local nPos := 1, oGm, cPant := SaveScreen(0,0,24,79), <oObjeto> ;;
       <oObjeto> := TMenu():New() ;;
       oGm := <oObjeto> ;;
       ColorsAdd(oGm,<cColors>)

#xcommand MENU <cItem> [MESSAGE <cMensaje>] => ;
        Aadd(oGm:aMenus,TMenuBox():New(<cItem>, <cMensaje>))

#xcommand MENUITEM <cItem> ;
          [ MESSAGE <cMensaje> ];
          [ SHORTKEY <nKey> ];
          [ EXECUTE <bAccion> [,<bAccionN>]];  
          [ <lEs:DISABLED> ] => ;
     ItemAdd(oGm,TMenuItem():New(<cItem>,<cMensaje>,;
        <nKey>,{|| .T. [,<bAccion>][,<bAccionN>] },<.lEs.>),nPos)

#xtranslate SEPARATOR => ""

#xcommand ENDMENU => nPos++

#xcommand ENDPULLDOWN => oGm:Configura(cPant)

#xcommand RUNMENU <oObjeto> => <oObjeto>:Run()

// Sintaxis de cajas de di logo

#xcommand DIALOG <oObjeto> AT <nTop>,<nLeft>,<nBottom>,<nRight> ;
                  [ TITLE <cTitulo> ] ;
                  [ <lGraph:GRAPHIC> ] ;
                  [ <lT:COLOR,COLORS> <cColors,...> ] => ;
   local <oObjeto>, oDm ;;
      <oObjeto> := TDialog():New(<nTop>,<nLeft>,<nBottom>,<nRight>,<cTitulo>) ;;
      oDm := <oObjeto> ;;
      oDm:lGraph := <.lGraph.> ;;
      AColors(oDm, <cColors>)

#xcommand @<nFila>,<nCol> BUTTON <cMensaje> [ EXECUTE <bAccion> ] ;
                  [ <lOk:BTN_OK> ] ;
                  [ <lCancel:BTN_CANCEL> ] ;
                  [ COLOR <cColor> ] => ;
   Aadd(oDm:aObjetos,TButton(<nFila>,<nCol>,<cMensaje>,<{bAccion}>,;
      <.lOk.>, <.lCancel.>,<cColor>))

#xcommand @<nFila>,<nCol> RADIOBOX <aOpciones> [ TITLE <cTitle> ] ;
                  [ DEFAULT <nDefault> ] ;
                  [ COLOR <cColor> ] => ;
   Aadd(oDm:aObjetos,TRadioBox(<nFila>,<nCol>,<aOpciones>,<cTitle>, ;
      <nDefault>,<cColor>))

#xcommand @<nFila>,<nCol> CHECKBOX <aOpciones> [ TITLE <cTitle> ] ;
                  [ DEFAULT <aDefault> ] ;
                  [ COLOR <cColor> ] => ;
   Aadd(oDm:aObjetos,TCheckBox(<nFila>,<nCol>,<aOpciones>,<cTitle>, ;
      <aDefault>,<cColor>))

#xcommand @<nFila>,<nCol> GETVAR <cDefecto> [ TITLE <cTitle> ] ;
                  [ <lTop:TOPTITLE> ] ;
                  [ WIDE <nAncho> ] ;
                  [ LENGTH <nLongitud> ] ;
                  [ <lNum:NUMERIC> ] ;
                  [ <lDate:DATE> ] ;
                  [ <lPassW:PASSWORD> ] ;
                  [ FUNCTION <cFunc> ] ;
                  [ COLOR <cColor> ] => ;
   Aadd(oDm:aObjetos,TGetVar(<nFila>,<nCol>,<cDefecto>,<cTitle>,<.lTop.>,;
      <nAncho>,<nLongitud>,<.lNum.>,<.lDate.>,<.lPassW.>,<cFunc>,<cColor>))

#xcommand @<nFila>,<nCol> COMBOBOX <aOpciones> [ TITLE <cTitle> ] ;
                  [ <lTop:TOPTITLE> ] ;
                  [ DEFAULT <nDefault> ] ;
                  [ FUNCTION <cFunc> ] ;
                  [ COLOR <cColor> ] ;
                  [ COLORBUTTON <cClrBut> ] ;
                  [ COLORBAR <cClrBar> ] => ;
   Aadd(oDm:aObjetos,TComboBox(<nFila>,<nCol>,<aOpciones>,<cTitle>,<.lTop.>,;
      <nDefault>,<cFunc>,<cColor>,<cClrBut>,<cClrBar>))

#xcommand @<nTop>,<nLeft>,<nBottom>,<nRight> LISTBOX <aOpciones> ;
                  [ TITLE <cTitle> ] ;
                  [ FUNCTION <cFunc> [ <lWatch:ON WATCH> ] ] ;
                  [ <lExit:WITH EXIT> ] ;
                  [ <lHelp:HELP> ] ;
                  [ COLOR <cColor> ] ;
                  [ COLORBAR <cClrBar> ] => ;
   Aadd(oDm:aObjetos,TListBox(<nTop>,<nLeft>,<nBottom>,<nRight>,<aOpciones>,;
      <cTitle>,<cFunc>,<.lWatch.>,<.lExit.>,<cColor>,<cClrBar>,<.lHelp.>))

#xcommand WINDOW FROM <nTop>,<nLeft> TO <nBottom>,<nRight> ; 
                  [ COLOR <cColor> ] => ;
   Aadd(oDm:aObjetos,TWindow(<nTop>,<nLeft>,<nBottom>,<nRight>,<cColor>))

#xcommand TEXT <cTexto> AT <nFila>,<nCol> [ COLOR <cColor> ] =>;
   Aadd(oDm:aObjetos,TSay(<nFila>,<nCol>,<cTexto>,<cColor>))

#xcommand ENDDIALOG => oDm:Refresh()

#xtranslate RUNDIALOG <oObjeto> => <oObjeto>:Run()

#endif

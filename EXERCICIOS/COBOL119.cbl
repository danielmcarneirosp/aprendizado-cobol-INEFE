 *****************************************************************
      * DATA     : 06/09/2024
      * AUTOR    : VAGNER RENATO BELLACOSA
      * OBJETIVO : PROGRAMA RECEBE NUMERICO DE 4 BYTES COM SINAL
      *  EFETUA CALCULO COM DATA DO SISTEMA E USA
      * FUNCAO INTRINSECA
      * CPD      : INEFE
      *****************************************************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. COBOL119.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 06/09/24 @ 21:18:00.
       DATE-COMPILED. 2024-09-06.
       SECURITY. TESTE INEFE
       INSTALLATION. INEFE MARIST
      *
      **********************
       ENVIRONMENT DIVISION.
      **********************
      *
       CONFIGURATION SECTION.
      *
       SOURCE-COMPUTER. IBM-I.
       OBJECT-COMPUTER. IBM-I.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
      *

      ***************
       DATA DIVISION.
      ***************
      *
       WORKING-STORAGE  SECTION.
      *
       01 WSS-TODAY.
          05 WSS-YYYYMMDD   PIC 9(8).
      *
       77 WSS-OTHER-DAY1    PIC S9(9) BINARY.
       77 WSS-OTHER-DAY2    PIC 9(8).
       77 WSS-DAYS          PIC S9(4) BINARY.
       77 WSS-MENSAGEM      PIC A(30).
      *
       LINKAGE SECTION.
      *
       01  LKS-PARAM-IBM.
           05  LKS-PARAM-TAM           PIC S9(4) COMP.
           05  LKS-PARAM-SIGN          PIC A(1).
           05  LKS-PARAM-DAYS          PIC 9(4).
      *
      *****************************************
       PROCEDURE DIVISION USING LKS-PARAM-IBM.                          00210000
      *****************************************

           MOVE FUNCTION CURRENT-DATE TO WSS-TODAY.

           DISPLAY ' '
           DISPLAY ' '
           DISPLAY ' COBOL119'
           DISPLAY "WSS-TODAY IS " WSS-TODAY ".".
           DISPLAY "OBTAIN THE DATE AFTER HOW MANY WSS-DAYS? >> "
                    WITH NO ADVANCING.

           PERFORM ROT-VALIDA-PARAM.


      *-----------------------------------------------------------------
      * THE DATE AFTER THE SPECIFIED NUMBER OF WSS-DAYS HAS ELAPSED IS
      * OBTAINED BY CALCULATING THE NUMBER OF WSS-DAYS FROM
      * JANUARY 1, 1601 AND ADDIN THE WSS-DAYS ENTERED BY THE USER.
      *-----------------------------------------------------------------
           COMPUTE WSS-OTHER-DAY1 = FUNCTION INTEGER-OF-DATE
                       (WSS-YYYYMMDD) + WSS-DAYS

      *-----------------------------------------------------------------
      * TO DISPLAY THE DATE, THE NEWLY COMPUTED NUMBER OF WSS-DAYS IS
      * CONVERTED TO STANDARD FORMAT (YYYYMMDD).
      *-----------------------------------------------------------------
           COMPUTE WSS-OTHER-DAY2 =
                       FUNCTION DATE-OF-INTEGER (WSS-OTHER-DAY1).

      *-----------------------------------------------------------------
      * OUTPUT
      *-----------------------------------------------------------------
           DISPLAY " ".
           DISPLAY " ".
           DISPLAY "THE DATE AFTER " WSS-DAYS " WSS-DAYS FROM "
                       WSS-TODAY " IS "   WSS-OTHER-DAY2 ".".

      *-----------------------------------------------------------------
      * END
      *-----------------------------------------------------------------
           STOP RUN.

      *-----------------------------------------------------------------
      * ROTINAS AUXILIARES
      *-----------------------------------------------------------------
       SECTION-CODES       SECTION.

      *-----------------------------------------------------------------
      * VALIDA PARAMETER
      *-----------------------------------------------------------------
       ROT-VALIDA-PARAM.

           DISPLAY ' '
           DISPLAY ' PARAMETRO RECEBIDO NESTE PROCESSAMENTO '
           DISPLAY ' LKS-PARAM-DAYS = ' LKS-PARAM-SIGN LKS-PARAM-DAYS
                   ' ' LKS-PARAM-TAM ' BYTES'
           DISPLAY ' '

           IF LKS-PARAM-TAM EQUAL ZEROES
              MOVE ' PARAMETRO NAO INFORMADO' TO WSS-MENSAGEM
              MOVE 110                        TO RETURN-CODE
              PERFORM ROT-ABEND
           END-IF.

           IF LKS-PARAM-TAM > 5
              MOVE ' PARAMETRO INFORMADO MAIOR QUE O ESPERADO'
                     TO WSS-MENSAGEM
              MOVE 120                        TO RETURN-CODE
              PERFORM ROT-ABEND
           END-IF.

           IF NOT LKS-PARAM-DAYS IS NUMERIC
              MOVE ' PARAMETRO NAO NUMERICO'
                     TO WSS-MENSAGEM
              MOVE 130                        TO RETURN-CODE
              PERFORM ROT-ABEND
           END-IF.

           IF LKS-PARAM-SIGN NOT EQUAL '+' AND
              LKS-PARAM-SIGN NOT EQUAL '-'
              MOVE ' SINAL DIFERENTE DE [+] OU [-]'
                     TO WSS-MENSAGEM
              MOVE 140                        TO RETURN-CODE
              PERFORM ROT-ABEND
           END-IF.

           IF LKS-PARAM-SIGN EQUAL '-'
             SUBTRACT LKS-PARAM-DAYS   FROM WSS-DAYS
           ELSE
             ADD  LKS-PARAM-DAYS         TO WSS-DAYS
           END-IF.

      *-----------------------------------------------------------------
      * ABEND
      *-----------------------------------------------------------------
       ROT-ABEND.

           DISPLAY ' '
           DISPLAY '***********************************************'
           DISPLAY '***               ABEND                     ***'
           DISPLAY '***********************************************'
           DISPLAY '* ERRO NO PROGRAMA                          ***'
           DISPLAY '* FAVOR AVISAR ANALISTA RESPONSAVEL         ***'
           DISPLAY '***********************************************'
           DISPLAY '* ' WSS-MENSAGEM '         ***'
           DISPLAY '* RETURN-CODE  :' RETURN-CODE
                                        '                       ***'
           DISPLAY '***********************************************'.

           STOP RUN.

       END PROGRAM COBOL119.
      ********************** FIM PROGRAMA   ****************************

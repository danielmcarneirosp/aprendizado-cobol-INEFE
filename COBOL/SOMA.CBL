999999*AAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
      *****************************************************************
      * DATA     : 09/11/205
      * AUTOR    : DANIEL CARNEIRO
      * OBJETIVO : APRENDENDO COBOL
      * CPD      : INEFE
      *****************************************************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. SOMA.
       AUTHOR. DANIEL CARNEIRO
       DATE-WRITTEN. 09/11/2025
       DATE-COMPILED. 09/11/2025
       INSTALLATION. INEFE.
       SECURITY. NORMAL.
      *
      **********************
       ENVIRONMENT DIVISION.
      **********************
      *
      ***************
       DATA DIVISION.
      ***************
      *
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
       77 WS-N1     PIC 9(02) VALUE ZEROS.
       77 WS-N2     PIC 9(02) VALUE ZEROS.
       77 WS-TOTAL  PIC 9(03) VALUE ZEROS.
       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.
      *
      ********************
       PROCEDURE DIVISION.
      ********************

           DISPLAY "*** SOMA DE 2 NUMEROS ***"
           MOVE 5 TO WS-N1
           MOVE 3 TO WS-N2
           COMPUTE WS-TOTAL = WS-N1 + WS-N2
           DISPLAY "RESULTADO DA SOMA: " WS-TOTAL

           STOP RUN.

       END PROGRAM SOMA.
      ********************* FIM DO PROGRAMA ****************************

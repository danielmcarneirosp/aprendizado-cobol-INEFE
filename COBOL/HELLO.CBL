999999*AAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
      *****************************************************************
      * DATA     : 07/11/205
      * AUTOR    : DANIEL CARNEIRO
      * OBJETIVO : APRENDENDO COBOL
      * CPD      : INEFE
      *****************************************************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. HELLO.
       AUTHOR. DANIEL CARNEIRO
       DATE-WRITTEN. 07/11/2025
       DATE-COMPILED. 07/11/2025
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
      *
       LOCAL-STORAGE SECTION.
      *
       LINKAGE SECTION.
      *
      ********************
       PROCEDURE DIVISION.
      ********************

           DISPLAY 'HELLO WORLD'
           DISPLAY 'APRENDENDO COBOL COM O INEFE'
           MOVE    13     TO  RETURN-CODE.

           STOP RUN.

       END PROGRAM HELLO.
      ********************* FIM DO PROGRAMA ****************************

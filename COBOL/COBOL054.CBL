      *****************************************************************
      * DATA     :  10/06/2023
      * AUTOR    : VAGNER RENATO BELLACOSA
      * OBJETIVO : PROGRAMA TABELA COM PESQUISA BINARIA
      *            TABELA UNIDIMENSIONAL COM 90 OCORRENCIAS
      * CPD      : INEFE
      *****************************************************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. COBOL054.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 11/06/23 @ 14:10:00.
       DATE-COMPILED. 2023-06-11.
       INSTALLATION. INEFE.
       SECURITY. NORMAL.

      **********************
       ENVIRONMENT DIVISION.
      **********************

      ***************
       DATA DIVISION.
      ***************
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       01  TABLE-A.
         05 TABLE-ENTRY OCCURS 90 TIMES
                  ASCENDING KEY-1, KEY-2
                  DESCENDING KEY-3
                  INDEXED BY INDX-1.
           10 PART-1       PIC 99.
           10 KEY-1        PIC 9(5).
           10 PART-2       PIC 9(6).
           10 KEY-2        PIC 9(4).
           10 PART-3       PIC 9(18).
           10 KEY-3        PIC 9(5).
      *
       01 VALUE-1          PIC 9(05).
       01 VALUE-2          PIC 9(04).
       01 VALUE-3          PIC 9(05).
      *
       01 OUTPUT-AREA      PIC 999.
      *
      ********************
       PROCEDURE DIVISION.
      ********************

           DISPLAY 'COBOL054'.
           DISPLAY 'EXEMPLO DE BUSCA EM TABELA UNIDIMENSIONAL'.
           DISPLAY ' '.

      *****************************************************************
           DISPLAY ' '.
           DISPLAY 'PROGRAMA TABELA COM PESQUISA BINARIA'
           DISPLAY 'TABELA UNIDIMENSIONAL COM 90 OCORRENCIAS'
           DISPLAY ' '.

           MOVE 1 TO VALUE-1.

           SEARCH ALL TABLE-ENTRY
             AT END
               PERFORM NOENTRY
             WHEN KEY-1 (INDX-1) = VALUE-1 AND
                  KEY-2 (INDX-1) = VALUE-2 AND
                  KEY-3 (INDX-1) = VALUE-3
               MOVE PART-1 (INDX-1) TO OUTPUT-AREA
           END-SEARCH

           DISPLAY 'OUTPUT-AREA = '  OUTPUT-AREA.

           STOP RUN.

      *** TRATAR ERRO
       NOENTRY.

           MOVE 199 TO RETURN-CODE
           DISPLAY ' ERRO NA BUSCA DO SEARCH ALL'.

       END PROGRAM COBOL054.
      ********************** FIM DO PROGRAMA **************************

*****************************************************************
      * DATA     : 06/09/2024
      * AUTOR    : VAGNER RENATO BELLACOSA
      * OBJETIVO : PROGRAMA EXEMPLO ARQUIVO QSAM LOOP
      * USO DE ENDERECO DE MEMORIA E TABELA INTERNA
      * USO DE ALOCACAO DINAMICA
      * CPD      : INEFE
      *****************************************************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. COBOL120.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 06/09/24 @ 21:18:00.
       DATE-COMPILED. 2024-09-06.
       SECURITY. TESTE INEFE
       INSTALLATION. INEFE MARIST

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
       01 WORK-AREA.
        05 WSS-DATA1           PIC X(4) VALUE 'AAAA'.
        05 WSS-DATA2           PIC X(4) VALUE 'BBBB'.
        05 WSS-DATA3           PIC X(4) VALUE 'CCCC'.
        05 WSS-DATA4           PIC X(4) VALUE 'ZZZZ'.
      *
       77 WSS-PTR POINTER.
       77 WSS-IDX              PIC 9.
      *
       LINKAGE SECTION.
      *
       01 TBL-DATA.
        05 TBL-DATA-ALPHA      PIC X(4) OCCURS 4 TIMES.
      *
      ********************
       PROCEDURE DIVISION.                                              00210000
      ********************

           DISPLAY ' '
           DISPLAY ' '
           DISPLAY ' COBOL120'
           DISPLAY ' USO DE TABELA INTERNA E MOVIMENTACAO POR PONTEIRO'
           DISPLAY ' DE MEMORIA.'
           DISPLAY ' '

      *
           DISPLAY ' TABELA INICIAL - VAZIA'.
           DISPLAY ' '.

           PERFORM VARYING WSS-IDX FROM 1 BY 1
                                 UNTIL WSS-IDX > 4
             DISPLAY ' TBL-DATA-ALPHA [' WSS-IDX '] = '
                       TBL-DATA-ALPHA(WSS-IDX)
           END-PERFORM.

           DISPLAY ' '.

      *
           SET WSS-PTR TO ADDRESS OF WORK-AREA.
           SET ADDRESS OF TBL-DATA TO WSS-PTR.
      *
           DISPLAY ' RECEBI O MESMO ENDERECO DA WORKING'
           DISPLAY ' TABELA INTERNA INICIALIZADA PELO ADDRESS E SET'
           DISPLAY ' '.

           PERFORM VARYING WSS-IDX FROM 1 BY 1
                                 UNTIL WSS-IDX > 4
             DISPLAY ' TBL-DATA-ALPHA [' WSS-IDX '] = '
                       TBL-DATA-ALPHA(WSS-IDX)
           END-PERFORM.

           DISPLAY ' '.

           STOP RUN.

       END PROGRAM COBOL120.
      ********************** FIM PROGRAMA   ****************************

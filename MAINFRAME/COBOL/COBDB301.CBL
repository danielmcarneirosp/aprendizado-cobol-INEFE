000100*****************************************************************
000200* DATA     :  16/02/2024
000300* AUTOR    : VAGNER RENATO BELLACOSA
000400* OBJETIVO : PROGRAMA db2
000500*            LE O ARQUIVO ALUNOS E GRAVA TABELA DB2.
000600* CPD      : INEFE
000700*****************************************************************
000800
000900*************************
001000*PRIMEIRA DIVSAO*********
001100*************************
      *------------------------
       IDENTIFICATION DIVISION.
      *------------------------
       PROGRAM-ID. COBDB301.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 16/02/24 @ 22:20:00.
       DATE-COMPILED. 2024-02-16.
       INSTALLATION. INEFE.
       SECURITY. NORMAL.
      *---------------------
       ENVIRONMENT DIVISION.
      *---------------------
        CONFIGURATION SECTION.
      *
         SPECIAL-NAMES.  DECIMAL-POINT IS COMMA.
      *
        INPUT-OUTPUT SECTION.

        FILE-CONTROL.

      *--------------
       DATA DIVISION.
      *--------------
       FILE SECTION.
      *
      *------------------------
       WORKING-STORAGE SECTION.
      *------------------------
       77 ST-ALUNO                     PIC 9(002) VALUE 0.
       77 wss-sqlcode                  PIC -ZZZZZZZZ9.
       77 WSS-DATA-COMPIL              PIC X(16).
       77 WSS-MSG-ERROR                PIC X(40).
      *----------------------
       LOCAL-STORAGE SECTION.
      *----------------------
      *
      * DCLGEN DA TABELA TBCURSO
      *
      **  COPY TBCURSO.
      ******************************************************************
      * DCLGEN TABLE(TBCURSO)                                          *
      *        LIBRARY(USER.INEFE.EDISON(TBCURS1))                     *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE TBCURSO TABLE
           ( MATRI                          INTEGER NOT NULL,
             CURSO                          VARCHAR(20) NOT NULL,
             VALOR                          DECIMAL(8, 2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE TBCURSO                            *
      ******************************************************************
       01  DCLTBCURSO.
           10 MATRI                PIC S9(9) USAGE COMP.
           10 CURSO.
              49 CURSO-LEN         PIC S9(4) USAGE COMP.
              49 CURSO-TEXT        PIC X(20).
           10 VALOR                PIC S9(6)V9(2) USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

      *-------------------
       PROCEDURE DIVISION.
      *-------------------

           DISPLAY 'COBDB301'.
           DISPLAY 'PROGRAMA COBOL + DB2'
           DISPLAY 'LE SEQUENCIA E INSERI REGISTROS '

           DISPLAY ' '

           MoVE FUNCTION WHEN-COMPILED  TO WSS-DATA-COMPIL

           DISPLAY ' WSS-DATA-COMPIL = ' WSS-DATA-COMPIL
           DISPLAY ' '

           MOVE 12345         TO MATRI
           MOVE 'JOSE NUNES'  TO CURSO
           MOVE 98,10         TO VALOR

           PERFORM 0010-VALIDA-CAMPO.

           PERFORM 0020-INCLUI-TABELA.

           PERFORM 0030-EFETIVA-DADOS.

           STOP RUN.

      ******************************************************************
      * CODIGOS AUXILIARES
      ******************************************************************
       CODE-AUX               SECTION.

       0010-VALIDA-CAMPO.

            IF MATRI EQUAL ZEROES
              MOVE 101                      TO RETURN-CODE
              MOVE 'MATRICULA ZERADA      ' TO WSS-MSG-ERROR
              PERFORM ROT-ABEND
            END-IF

      * NUMERO COMPUTACIONAL NAO COMPARAVEL COM HIGH-VALUES
      * E TAMPOUCO COM IS NUMERIC
      *     IF MATRI EQUAL HIGH-VALUES
      *       MOVE 102                      TO RETURN-CODE
      *       MOVE 'MATRICULA NAO VALIDA'   TO WSS-MSG-ERROR
      *       PERFORM ROT-ABEND
      *     END-IF.

            IF CURSO-LEN EQUAL ZEROES
              MOVE 103                      TO RETURN-CODE
              MOVE 'CURSO COM ERRO NO TAMANHO' TO WSS-MSG-ERROR
              PERFORM ROT-ABEND
            END-IF.

            IF CURSO-TEXT EQUAL SPACES OR
               CURSO-TEXT EQUAL LOW-VALUES
              MOVE 104                      TO RETURN-CODE
              MOVE 'DESCRITO CURSO INVALIDO' TO WSS-MSG-ERROR
              PERFORM ROT-ABEND
            END-IF.

            IF VALOR IS NUMERIC
              IF VALOR EQUAL ZEROES
                MOVE 105                      TO RETURN-CODE
                MOVE 'NOTA ZERADA           ' TO WSS-MSG-ERROR
                PERFORM ROT-ABEND
              END-IF
            ELSE
              MOVE 106                      TO RETURN-CODE
              MOVE 'NOTA NAO NUMERICA' TO WSS-MSG-ERROR
              PERFORM ROT-ABEND
            END-IF.

      * ABEND PLANEJADO
       ROT-ABEND.

            DISPLAY ' '
            DISPLAY '*********************************************'
            DISPLAY '*** ABEND ABEND ABEND - PROGRAMADO        ***'
            DISPLAY '*********************************************'
            DISPLAY '*** RETURN-CODE : ' RETURN-CODE
                                            '                  ***'
            DISPLAY '*** MENSAGE : ' WSS-MSG-ERROR           ' ***'
            DISPLAY '*********************************************'

            STOP RUN.

      *
      ******************************************************************
      * ACESSO AO BANCO DE DADOS
      ******************************************************************
       CURSO-DATABASE         SECTION.

      ******************************************************************
      * INCLUIR REGISTRO NA TABELA
      ******************************************************************
       0020-INCLUI-TABELA.

           EXEC SQL
             INSERT INTO IBMUSER.tbcurso (
                           MATRI,
                           CURSO,
                           VALOR
                                      )
                  VALUES ( :MATRI,
                           :CURSO,
                           :VALOR
                                       )
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             move sqlcode   to wss-sqlcode
             DISPLAY "SQLCODE NAO FOI IGUAL A ZERO!"
             display 'wss-sqlcode   = ' wss-sqlcode
             display 'matri         = ' matri
             display 'CURSO         = ' CURSO
             display 'VALOR         = ' VALOR
             MOVE SQLCODE   TO RETURN-CODE
             MOVE ' ERRO NA INSERCAO DE DADOS DO CURSO'
                                   TO WSS-MSG-ERROR
             PERFORM ROT-ABEND
           END-IF.
      *
       0030-EFETIVA-DADOS.

           EXEC SQL
             COMMIT
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             move sqlcode   to wss-sqlcode
             DISPLAY "SQLCODE NAO FOI IGUAL A ZERO!"
             display 'wss-sqlcode   = ' wss-sqlcode
             display 'matri         = ' matri
             display 'CURSO         = ' CURSO
             display 'VALOR         = ' VALOR
             MOVE SQLCODE   TO RETURN-CODE
             MOVE ' ERRO NA EFETIVACAO DA INSERCAO'
                                   TO WSS-MSG-ERROR
             PERFORM ROT-ABEND
           END-IF.
      *
       END PROGRAM COBDB301.
      ********************** FIM DO PROGRAMA ***************************

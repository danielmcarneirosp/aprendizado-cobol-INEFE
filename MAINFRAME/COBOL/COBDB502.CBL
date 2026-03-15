      *****************************************************************
      * DATA     :  18/06/2025
      * AUTOR    : VAGNER RENATO BELLACOSA
      * OBJETIVO : PROGRAMA db2
      *            SELECT SIMPLES NA TABELA DB2 PAIS SEDE.
      * CPD      : INEFE
      *****************************************************************
111111*AAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
      *-----------------------*
       IDENTIFICATION DIVISION.
      *-----------------------*
       PROGRAM-ID. COBDB502.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 18/06/25 @ 22:20:00.
       DATE-COMPILED. 2025-06-18.
       INSTALLATION. INEFE.
       SECURITY. ACESSO DB2 - select

      *--------------------*
       ENVIRONMENT DIVISION.
      *--------------------*

        CONFIGURATION SECTION.
         SPECIAL-NAMES.  DECIMAL-POINT IS COMMA.
      *
        INPUT-OUTPUT SECTION.
      *
      *-------------*
       DATA DIVISION.
      *-------------*
       FILE SECTION.
      *
      *-----------------------*
       WORKING-STORAGE SECTION.
      *-----------------------*
       77 FS-LSTCOPAC                  PIC 9(002) VALUE 0.
       77 WSS-SQLCODE                  PIC -ZZZZZZZZ9.
       77 WSS-LIDOS                    PIC 9(04).
       77 WSS-TAMANHO                  PIC 9(04).
       77 WSS-SELECT                   PIC 9(04).
       77 WSS-SELECT-SEDE              PIC 9(04).
       77 WSS-SELECT-JOGO              PIC 9(04).
       77 WSS-DATA-COMPIL              PIC X(16).
       77 WSS-MESSAGE                  PIC X(50).

      *-----------------------*
       LOCAL-STORAGE SECTION.
      *-----------------------*

      *** --> TABELA PAIS SEDE E ANO DA COPA DO MUNDO
      *COPY TBCOPA.
      ******************************************************************
      * DCLGEN TABLE(IBMUSER.COPA_MUNDO)                               *
      *        LIBRARY(IBMUSER.WORKBOOK.COBOL(TBCOPA))                 *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE IBMUSER.COPA_MUNDO TABLE
           ( COPA_ANO                       SMALLINT NOT NULL,
             COPA_DETALHE                   VARCHAR(100),
             COPA_PAIS_SEDE                 CHAR(30),
             COPA_COMENTARIOS               VARCHAR(500)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE IBMUSER.COPA_MUNDO                 *
      ******************************************************************
       01  DCLCOPA-MUNDO.
           10 COPA-ANO             PIC S9(4) USAGE COMP.
           10 COPA-DETALHE.
              49 COPA-DETALHE-LEN
                 PIC S9(4) USAGE COMP.
              49 COPA-DETALHE-TEXT
                 PIC X(100).
           10 COPA-PAIS-SEDE       PIC X(30).
           10 COPA-COMENTARIOS.
              49 COPA-COMENTARIOS-LEN
                 PIC S9(4) USAGE COMP.
              49 COPA-COMENTARIOS-TEXT
                 PIC X(500).
      *
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 4       *
      ******************************************************************
      *
      *** --> TABELA JOGOS DA COPA DO MUNDO COM RESULTADO
      *COPY TBJOGOS.
      ******************************************************************
      * DCLGEN TABLE(IBMUSER.COPA_JOGOS)                               *
      *        LIBRARY(IBMUSER.WORKBOOK.COPY(TBJOGOS))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE IBMUSER.COPA_JOGOS TABLE
           ( JOGO_COD_TIPO                  SMALLINT NOT NULL,
             JOGO_ANO                       SMALLINT NOT NULL,
             JOGO_TIPO_JOGO                 CHAR(20),
             JOGO_SELECAO_WIN               CHAR(26) NOT NULL,
             JOGO_SELECAO_LOSER             CHAR(26) NOT NULL,
             JOGO_GOL_WIN                   DECIMAL(2, 0),
             JOGO_GOL_LOSER                 DECIMAL(2, 0),
             JOGO_TIPO_TEMPO                CHAR(20),
             JOGO_PENALTY_WIN               DECIMAL(2, 0),
             JOGO_PENALTY_LOSER             DECIMAL(2, 0),
             JOGO_OBSERV                    CHAR(20),
             JOGO_COMENT                    VARCHAR(500)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE IBMUSER.COPA_JOGOS                 *
      ******************************************************************
       01  DCLCOPA-JOGOS.
           10 JOGO-COD-TIPO        PIC S9(4) USAGE COMP.
           10 JOGO-ANO             PIC S9(4) USAGE COMP.
           10 JOGO-TIPO-JOGO       PIC X(20).
           10 JOGO-SELECAO-WIN     PIC X(26).
           10 JOGO-SELECAO-LOSER   PIC X(26).
           10 JOGO-GOL-WIN         PIC S9(2)V USAGE COMP-3.
           10 JOGO-GOL-LOSER       PIC S9(2)V USAGE COMP-3.
           10 JOGO-TIPO-TEMPO      PIC X(20).
           10 JOGO-PENALTY-WIN     PIC S9(2)V USAGE COMP-3.
           10 JOGO-PENALTY-LOSER   PIC S9(2)V USAGE COMP-3.
           10 JOGO-OBSERV          PIC X(20).
           10 JOGO-COMENT.
              49 JOGO-COMENT-LEN   PIC S9(4) USAGE COMP.
              49 JOGO-COMENT-TEXT
                 PIC X(500).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 12      *
      ******************************************************************
      *
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 12      *
      ******************************************************************
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

       LINKAGE SECTION.
      *
       01  JCLPARM.
         02  JCLPARM-LENGTH     PIC S9(4) BINARY.
         02  JCLPARM-TIPO-PESQ  PIC 9.
           88 FLG-SEDE          VALUE 1.
           88 FLG-ANO           VALUE 2.
         02  JCLPARM-PAIS-ANO   PIC 9(04).
         02  JCLPARM-PAIS-SEDE  PIC X(30).
      *
      *********************************
       PROCEDURE DIVISION USING JCLPARM.
      ***********************************
       MAIN-SECTION                       SECTION.

           PERFORM ROT-DISPLAY.

           PERFORM ROT-VALIDA-PARAM.

           PERFORM ROT-PESQUISA

           PERFORM ROT-ESTATISTICA.
      *
           STOP RUN.
      *
      *--------------------------------*
      * ARQUITETURA DO SISTEMA                                         *
      *--------------------------------*
       ARQUITETURA-SECTION                SECTION.

       ROT-DISPLAY.

           DISPLAY 'COBDB502'.

           DISPLAY 'PROGRAMA COBOL + QSAM + DB2'
           DISPLAY 'LE ARQUIVO SEQUENCIAL E INSERE REGISTROS '
           DISPLAY 'NA TABELA PAIS SEDE E RESULTADO JOGOS'

           DISPLAY ' '

           DISPLAY ' '
           MOVE FUNCTION WHEN-COMPILED  TO WSS-DATA-COMPIL
           DISPLAY ' WSS-DATA-COMPIL = ' WSS-DATA-COMPIL
           DISPLAY ' '.

           PERFORM ROT-INITIALIZE.

       ROT-DISPLAY-EXIT.
           EXIT.

       ROT-INITIALIZE.

           INITIALIZE WSS-LIDOS   REPLACING NUMERIC DATA BY ZERO
           INITIALIZE WSS-SELECT  REPLACING NUMERIC DATA BY ZEROES
           INITIALIZE WSS-DATA-COMPIL
                                  REPLACING ALPHANUMERIC DATA BY " "
           INITIALIZE WSS-MESSAGE REPLACING ALPHANUMERIC DATA BY SPACE.

           MOVE ZEROES            TO WSS-SQLCODE.

       ROT-INITIALIZE-EXIT.
           EXIT.


       ROT-LIMPA-SEDE.

           INITIALIZE DCLCOPA-MUNDO
                      REPLACING NUMERIC DATA BY ZEROES
                                ALPHANUMERIC DATA BY SPACES.

       ROT-LIMPA-SEDE-EXIT.
           EXIT.

       ROT-LIMPA-JOGOS.

           INITIALIZE DCLCOPA-JOGOS
                      REPLACING NUMERIC DATA BY ZEROES
                                ALPHANUMERIC DATA BY SPACES.

       ROT-LIMPA-JOGOS-EXIT.
           EXIT.

       ROT-VALIDA-PARAM.

           IF JCLPARM-LENGTH = 0
              MOVE 'PARAMETRO INVALIDO '
                   TO WSS-MESSAGE
              MOVE 113          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF JCLPARM-LENGTH < 35
              MOVE  JCLPARM-LENGTH      TO WSS-TAMANHO
              STRING 'PARAMETRO MENOR DO QUE O ESPERADO '
                                    DELIMITED BY SIZE
                     WSS-TAMANHO    DELIMITED BY SIZE
                     ' BYTES. '     DELIMITED BY SIZE
                 INTO WSS-MESSAGE
              END-STRING
              MOVE 123          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF JCLPARM-TIPO-PESQ EQUAL ZEROES
              MOVE 'TIPO DE PESQUISA INVALIDO' TO WSS-MESSAGE
              MOVE 133          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF JCLPARM-TIPO-PESQ > 2
              MOVE 'TIPO DE PESQUISA INVALIDO' TO WSS-MESSAGE
              MOVE 143          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF FLG-SEDE AND JCLPARM-PAIS-SEDE EQUAL SPACES
              MOVE 'PAIS SEDE NAO INFORMADO  ' TO WSS-MESSAGE
              MOVE 153          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF FLG-ANO  AND JCLPARM-PAIS-ANO EQUAL ZEROES
              MOVE 'ANO DA COPA NAO INFORMADO  ' TO WSS-MESSAGE
              MOVE 163          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF JCLPARM-PAIS-SEDE EQUAL SPACES AND
              JCLPARM-PAIS-ANO EQUAL ZEROES
              STRING 'PARAMETRO INVALIDO NESTE PROCESSAMENTO'
                                    DELIMITED BY SIZE
                  JCLPARM-PAIS-SEDE DELIMITED BY SIZE
                     ' '            DELIMITED BY SIZE
                        JCLPARM-PAIS-ANO DELIMITED BY SIZE
                 INTO WSS-MESSAGE
              END-STRING
              MOVE 173          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF JCLPARM-LENGTH > 35
              MOVE  JCLPARM-LENGTH      TO WSS-TAMANHO
              STRING 'PARAMETRO MAIOR DO QUE O ESPERADO '
                                    DELIMITED BY SIZE
                     WSS-TAMANHO    DELIMITED BY SIZE
                     ' BYTES. '     DELIMITED BY SIZE
                 INTO WSS-MESSAGE
              END-STRING
              MOVE 183          TO  RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           ELSE
              DISPLAY 'TIPO DE PESQUISA = '
              JCLPARM-TIPO-PESQ
              DISPLAY 'PAIS NESTE PROCESSAMENTO = '
              JCLPARM-PAIS-SEDE
              DISPLAY 'ANO DA COPA NESTE PROCESSAMENTO = '
              JCLPARM-PAIS-ANO
              DISPLAY ' '
           END-IF.

       ROT-VALIDA-PARAM-EXIT.
           EXIT.

       ROT-PESQUISA.

           IF FLG-ANO
             MOVE JCLPARM-PAIS-ANO   TO COPA-ANO
             PERFORM DB-SELECT-ANO
           END-IF.

           IF FLG-SEDE
             MOVE JCLPARM-PAIS-SEDE  TO COPA-PAIS-SEDE
             PERFORM DB-SELECT-SEDE
           END-IF.

       ROT-PESQUISA-EXIT.
           EXIT.

       ROT-ESTATISTICA.

           DISPLAY ' '.
           DISPLAY '**********************************'.
           DISPLAY '*** COBDB502 - TERMINO NORMAL  ***'.
           DISPLAY '**********************************'.
           DISPLAY ' DB2  - select PAIS SEDE = ' WSS-SELECT-SEDE.

       ROT-TRATA-ERRO-EXIT.
           EXIT.

       ROT-TRATA-ERRO.

           DISPLAY ' '.
           DISPLAY '**********************************'.
           DISPLAY '*** ABEND PROGRAMADO  ************'.
           DISPLAY '**********************************'.
           DISPLAY ' DB2  - select PAIS SEDE = ' WSS-SELECT-SEDE.
           DISPLAY '**********************************'.
           DISPLAY ' WSS-MESSAGE   = ' WSS-MESSAGE.

           IF SQLCODE NOT EQUAL ZEROES
             MOVE SQLCODE               TO WSS-SQLCODE
             MOVE 1234                  TO RETURN-CODE
             DISPLAY ' ERRO NO DB2 '
             DISPLAY ' WSS-SQLCODE   = ' WSS-SQLCODE
             DISPLAY ' RETURN-CODE   = ' RETURN-CODE
           END-IF.

           STOP RUN.

       ROT-TRATA-ERRO-EXIT.
           EXIT.
      *
      ******************************************************************
      * SERVICOS DE DADOS NO DB2
      ******************************************************************
       DATABASE-SECTION                   SECTION.

       DB-SELECT-ANO.

           display 'pesquisa ano : ' COPA-ANO

           EXEC SQL
                SELECT COPA_ANO
                     , COPA_DETALHE
                     , COPA_PAIS_SEDE
                  INTO :COPA-ANO
                     , :COPA-DETALHE
                     , :COPA-PAIS-SEDE
                FROM IBMUSER.COPA_MUNDO
                WHERE COPA_ANO = :COPA-ANO
                FETCH FIRST 1 ROW ONLY
           END-EXEC.

           IF SQLCODE NOT EQUAL 0 THEN
             MOVE SQLCODE         TO WSS-SQLCODE
             MOVE "ERRO NO SELECT NA TABELA PAIS SEDE"
                                  TO WSS-MESSAGE
             PERFORM ROT-TRATA-ERRO
           ELSE
             DISPLAY 'COPA-ANO       = '
                   COPA-ANO       OF DCLCOPA-MUNDO
             DISPLAY 'COPA-PAIS-SEDE = '
                   COPA-PAIS-SEDE OF DCLCOPA-MUNDO
             ADD 01               TO WSS-SELECT-SEDE
           END-IF.

       DB-SELECT-ANO-EXIT.
           EXIT.
      *
       DB-SELECT-SEDE.

           display 'pesquisa pais : ' COPA-PAIS-SEDE

           EXEC SQL
                SELECT COPA_ANO
                     , COPA_DETALHE
                     , COPA_PAIS_SEDE
                  INTO :COPA-ANO
                     , :COPA-DETALHE
                     , :COPA-PAIS-SEDE
                FROM IBMUSER.COPA_MUNDO
                WHERE COPA_PAIS_SEDE >= :COPA-PAIS-SEDE
                FETCH FIRST 1 ROW ONLY
           END-EXEC.

           IF SQLCODE NOT EQUAL 0 THEN
             MOVE SQLCODE         TO WSS-SQLCODE
             MOVE "ERRO NO SELECT NA TABELA PAIS SEDE"
                                  TO WSS-MESSAGE
             PERFORM ROT-TRATA-ERRO
           ELSE
             DISPLAY 'COPA-ANO      = '
                   COPA-ANO       OF DCLCOPA-MUNDO
             DISPLAY 'COPA-PAIS-SEDE= '
                   COPA-PAIS-SEDE OF DCLCOPA-MUNDO
             ADD 01               TO WSS-SELECT-SEDE
           END-IF.

       DB-SELECT-SEDE-EXIT.
           EXIT.
      *
       END PROGRAM COBDB502.
      ********************** FIM DO PROGRAMA ***************************

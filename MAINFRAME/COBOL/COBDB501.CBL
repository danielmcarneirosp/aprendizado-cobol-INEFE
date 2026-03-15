      *****************************************************************
      * DATA     :  12/06/2025
      * AUTOR    : VAGNER RENATO BELLACOSA
      * OBJETIVO : PROGRAMA db2
      *            LE O ARQUIVO copa do mundo E insere TABELA DB2.
      * CPD      : INEFE
      *****************************************************************
      *area                    areab
111111*AAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
      *-----------------------*
       IDENTIFICATION DIVISION.
      *-----------------------*
       PROGRAM-ID. COBDB501.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 12/06/25 @ 22:20:00.
       DATE-COMPILED. 2025-06-12.
       INSTALLATION. INEFE.
       SECURITY. ACESSO DB2 COM INCLUSAO REG QSAM

      *--------------------*
       ENVIRONMENT DIVISION.
      *--------------------*

        CONFIGURATION SECTION.
         SPECIAL-NAMES.  DECIMAL-POINT IS COMMA.
      *
        INPUT-OUTPUT SECTION.

        FILE-CONTROL.
               SELECT LSTCOPAC ASSIGN TO LSTCOPAC
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE  IS SEQUENTIAL
               FILE STATUS  IS FS-LSTCOPAC.
      *
      *-------------*
       DATA DIVISION.
      *-------------*
       FILE SECTION.

       FD   LSTCOPAC
            RECORDING MODE IS F
            RECORD CONTAINS 250 CHARACTERS.

      *--- REGISTRO DO ARQUIVO QSAM

       01 REG-LSTCOPAC.
          05 REG-ANO-COPA                  PIC 9(04).
          05 FILLER                        PIC X(01).
          05 REG-SUPER-COMENT              PIC X(68).
          05 REDEFINES REG-SUPER-COMENT.
            10 REG-COMENT-COPA             PIC X(08).
            10 FILLER                      PIC X(08).
            10 REG-PAIS-SEDE-COPA          PIC X(25).
            10 FILLER                      PIC X(06).
            10 REG-CAMPEAO-COPA            PIC X(19).
            10 REG-FINAL-GOL-CAMPEAO       PIC 9.
          05 FILLER                        PIC X(03).
          05 REG-FINAL-GOL-VICE            PIC 9.
          05 REG-FINAL-OBSERV              PIC X(07).
          05 REG-PENALT-FIN-CAMPEAO        PIC 9.
          05 FILLER                        PIC X(06).
          05 REG-PENALT-FIN-VICE           PIC 9.
          05 FILLER                        PIC X(04).
          05 REG-VICE-COPA                 PIC X(16).
          05 FILLER                        PIC X(05).
          05 REG-TERCEIRO-COPA             PIC X(20).
          05 REG-TERCEIRO-GOL              PIC 9.
          05 FILLER                        PIC X(03).
          05 REG-QUARTO-COL                PIC 9.
          05 REG-SEMI-OBSERV               PIC X(07).
          05 REG-QUARTO-COPA               PIC X(21).
      *
      *-----------------------*
       WORKING-STORAGE SECTION.
      *-----------------------*
       77 FS-LSTCOPAC                  PIC 9(002) VALUE 0.
       77 WSS-SQLCODE                  PIC -ZZZZZZZZ9.
       77 WSS-LIDOS                    PIC 9(04).
       77 WSS-INSERT                   PIC 9(04).
       77 WSS-INSERT-SEDE              PIC 9(04).
       77 WSS-INSERT-JOGO              PIC 9(04).
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
           EXEC SQL DECLARE INEFE18.COPA_MUNDO TABLE
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
           EXEC SQL DECLARE INEFE18.COPA_JOGOS TABLE
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

      *------------------*
       PROCEDURE DIVISION.
      *------------------*
       MAIN-SECTION                       SECTION.

           PERFORM ROT-DISPLAY.

           PERFORM ROT-OPEN-FILE.

           PERFORM ROT-LER-LSTCOPAC UNTIL FS-LSTCOPAC = 10

           PERFORM ROT-CLOSE-FILE.

           PERFORM ROT-COMMIT.

           PERFORM ROT-ESTATISTICA.
      *
           STOP RUN.
      *
      *--------------------------------*
      * QSAM FILES                                                     *
      *--------------------------------*
       ARQUIVO-SEQUENCIAL                 SECTION.

       ROT-OPEN-FILE.

           OPEN INPUT LSTCOPAC.

           IF FS-LSTCOPAC NOT EQUAL 0 THEN
              DISPLAY ' '
              DISPLAY 'cobdb501 - ERRO OPEN LSTCOPAC FS = ' FS-LSTCOPAC
              DISPLAY ' '
              MOVE FS-LSTCOPAC     TO RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.
      *
       ROT-OPEN-FILE-EXIT.
           EXIT.
      *
       ROT-LER-LSTCOPAC.

           DISPLAY 'ROT-LER-LSTCOPAC'.

           READ LSTCOPAC.

           IF FS-LSTCOPAC NOT EQUAL 0 AND
              FS-LSTCOPAC NOT EQUAL 10
              DISPLAY ' '
              DISPLAY 'COBDB501 - ERRO READ LSTCOPAC FS = ' FS-LSTCOPAC
              DISPLAY ' '
              MOVE FS-LSTCOPAC     TO RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF FS-LSTCOPAC EQUAL 0
             ADD 01        TO WSS-LIDOS
             PERFORM ROT-EXIBE-REC
             PERFORM ROT-INS-PAIS-SEDE
             IF REG-COMENT-COPA       EQUAL 'Detalhes'
               PERFORM ROT-INS-RESUL-FINAL
               PERFORM ROT-INS-RESUL-SEMI
             ELSE
               DISPLAY 'REG-COMENT-COPA = ' REG-COMENT-COPA
             END-IF
           ELSE
             IF FS-LSTCOPAC EQUAL 10 AND WSS-LIDOS EQUAL ZEROES
               DISPLAY ' '
               DISPLAY 'COBDB501 - ARQUIVO LSTCOPAC VAZIO ' FS-LSTCOPAC
               DISPLAY ' '
               MOVE FS-LSTCOPAC   TO RETURN-CODE
               PERFORM ROT-TRATA-ERRO
             END-IF
           END-IF.
      *
       ROT-LER-LSTCOPAC-EXIT.
           EXIT.
      *
       ROT-CLOSE-FILE.

           CLOSE LSTCOPAC.

           IF FS-LSTCOPAC NOT EQUAL 0 THEN
              DISPLAY ' '
              DISPLAY 'COBDB501 - ERRO CLOSE ALUNOS FS = ' FS-LSTCOPAC
              DISPLAY ' '
              MOVE FS-LSTCOPAC     TO RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

       ROT-CLOSE-FILE-EXIT.
           EXIT.

      *--------------------------------*
      * ARQUITETURA DO SISTEMA                                         *
      *--------------------------------*

       ARQUITETURA-SECTION                SECTION.

       ROT-DISPLAY.

           DISPLAY 'COBDB501'.

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
           INITIALIZE WSS-INSERT  REPLACING NUMERIC DATA BY ZEROES
           INITIALIZE WSS-DATA-COMPIL
                                  REPLACING ALPHANUMERIC DATA BY " "
           INITIALIZE WSS-MESSAGE REPLACING ALPHANUMERIC DATA BY SPACE.

           MOVE ZEROES            TO WSS-SQLCODE.

       ROT-INITIALIZE-EXIT.
           EXIT.

       ROT-EXIBE-REC.

           DISPLAY ' '
           DISPLAY 'REGISTRO LIDO NO QSAM -> ' WSS-LIDOS
           DISPLAY ' PAIS SEDE E ANO DA COPA'.
           DISPLAY ' REG-ANO-COPA = ' REG-ANO-COPA
                   ' REG-PAIS-SEDE-COPA = ' REG-PAIS-SEDE-COPA

           IF REG-SUPER-COMENT(1:6) not equal 'Edicoes'
             display ' Resultado '
                     ' Campeao = ' REG-CAMPEAO-COPA
                     ' vice    = ' rEG-VICE-COPA
                     ' ' REG-FINAL-GOL-CAMPEAO ' X '
                     REG-FINAL-GOL-VICE
             if REG-FINAL-OBSERV  not equal spaces
                display REG-FINAL-OBSERV
                       ' '  REG-PENALT-FIN-CAMPEAO ' X '
                       REG-PENALT-FIN-VICE
             end-if
             DISPLAY ' TERCEIRO LUGAR = ' REG-TERCEIRO-COPA
             display ' QUARTO lugar = ' REG-QUARTO-COPA
                     ' RESULTADO ' REG-TERCEIRO-GOL   ' X '
                      REG-QUARTO-COL
             DISPLAY REG-SEMI-OBSERV
           else
              display REG-SUPER-COMENT
           end-if.

       ROT-EXIBE-REC-EXIT.
           EXIT.

       ROT-INS-PAIS-SEDE.

           PERFORM ROT-LIMPA-SEDE.

           MOVE  REG-ANO-COPA         TO COPA-ANO
           MOVE  REG-PAIS-SEDE-COPA   TO COPA-PAIS-SEDE
           MOVE  SPACES               TO COPA-COMENTARIOS-TEXT
           MOVE  1                    TO COPA-COMENTARIOS-LEN

           IF REG-SUPER-COMENT(1:7) not equal 'Edicoes'
              MOVE REG-SUPER-COMENT(1:16)  TO COPA-DETALHE-TEXT
              MOVE 16                      TO COPA-DETALHE-LEN
           ELSE
              MOVE REG-SUPER-COMENT        TO COPA-DETALHE-TEXT
              MOVE 68                      TO COPA-DETALHE-LEN
           END-IF.

           PERFORM DB-INSERE-SEDE.

       ROT-INS-PAIS-SEDE-EXIT.
           EXIT.

       ROT-INS-RESUL-FINAL.

           PERFORM ROT-LIMPA-JOGOS.

           MOVE 001                    TO
                                 JOGO-COD-TIPO      OF DCLCOPA-JOGOS
           MOVE 'FINAL'                TO
                                 JOGO-TIPO-JOGO     OF DCLCOPA-JOGOS
           MOVE REG-ANO-COPA           TO
                                 JOGO-ANO           OF DCLCOPA-JOGOS
           MOVE REG-CAMPEAO-COPA       TO
                                 JOGO-SELECAO-WIN   OF DCLCOPA-JOGOS
           MOVE REG-VICE-COPA          TO
                                 JOGO-SELECAO-LOSER OF DCLCOPA-JOGOS
           MOVE REG-FINAL-GOL-CAMPEAO  TO
                                 JOGO-GOL-WIN       OF DCLCOPA-JOGOS
           MOVE REG-FINAL-GOL-VICE     TO
                                 JOGO-GOL-LOSER     OF DCLCOPA-JOGOS
           MOVE REG-FINAL-OBSERV       TO
                                 JOGO-TIPO-TEMPO    OF DCLCOPA-JOGOS
           MOVE REG-PENALT-FIN-CAMPEAO TO
                                 JOGO-PENALTY-WIN   OF DCLCOPA-JOGOS
           MOVE REG-PENALT-FIN-VICE    TO
                                 JOGO-PENALTY-LOSER OF DCLCOPA-JOGOS
           MOVE REG-FINAL-OBSERV       TO
                                 JOGO-COMENT-TEXT   OF DCLCOPA-JOGOS
           MOVE 40                     TO
                                 JOGO-COMENT-LEN    OF DCLCOPA-JOGOS

           PERFORM DB-INSERE-JOGOS.

             DISPLAY ' TERCEIRO LUGAR = ' REG-TERCEIRO-COPA
             display ' QUARTO lugar = ' REG-QUARTO-COPA
                     ' RESULTADO ' REG-TERCEIRO-GOL   ' X '
                      REG-QUARTO-COL.

       ROT-INS-RESUL-FINAL-EXIT.
           EXIT.

       ROT-INS-RESUL-SEMI.

           PERFORM ROT-LIMPA-JOGOS.

           MOVE 002                    TO
                                 JOGO-COD-TIPO      OF DCLCOPA-JOGOS
           MOVE 'SEMIFINAL'            TO
                                 JOGO-TIPO-JOGO     OF DCLCOPA-JOGOS
           MOVE REG-ANO-COPA           TO
                                 JOGO-ANO           OF DCLCOPA-JOGOS
           MOVE REG-TERCEIRO-COPA      TO
                                 JOGO-SELECAO-WIN   OF DCLCOPA-JOGOS
           MOVE REG-QUARTO-COPA        TO
                                 JOGO-SELECAO-LOSER OF DCLCOPA-JOGOS
           MOVE REG-TERCEIRO-GOL       TO
                                 JOGO-GOL-WIN       OF DCLCOPA-JOGOS
           MOVE REG-QUARTO-COL         TO
                                 JOGO-GOL-LOSER     OF DCLCOPA-JOGOS
           MOVE REG-FINAL-OBSERV       TO
                                 JOGO-TIPO-TEMPO    OF DCLCOPA-JOGOS
           MOVE REG-PENALT-FIN-CAMPEAO TO
                                 JOGO-PENALTY-WIN   OF DCLCOPA-JOGOS
           MOVE REG-PENALT-FIN-VICE    TO
                                 JOGO-PENALTY-LOSER OF DCLCOPA-JOGOS
           MOVE REG-SEMI-OBSERV        TO
                                 JOGO-COMENT-TEXT   OF DCLCOPA-JOGOS
           MOVE 40                     TO
                                 JOGO-COMENT-LEN    OF DCLCOPA-JOGOS

           PERFORM DB-INSERE-JOGOS.

       ROT-INS-RESUL-SEMI-EXIT.
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

       ROT-ESTATISTICA.

           DISPLAY ' '.
           DISPLAY '**********************************'.
           DISPLAY '*** COBDB501 - TERMINO NORMAL  ***'.
           DISPLAY '**********************************'.
           DISPLAY ' QSAM - LIDOS            = ' WSS-LIDOS.
           DISPLAY ' DB2  - INSERT PAIS SEDE = ' WSS-INSERT-SEDE.
           DISPLAY ' DB2  - INSERT JOGOS     = ' WSS-INSERT-JOGO.

       ROT-TRATA-ERRO-EXIT.
           EXIT.

       ROT-TRATA-ERRO.

           DISPLAY ' '.
           DISPLAY '**********************************'.
           DISPLAY '*** ABEND PROGRAMADO  ************'.
           DISPLAY '**********************************'.
           DISPLAY ' QSAM - LIDOS   = ' WSS-LIDOS.
           DISPLAY ' DB2  - INSERT PAIS SEDE = ' WSS-INSERT-SEDE.
           DISPLAY ' DB2  - INSERT JOGOS     = ' WSS-INSERT-JOGO.
           DISPLAY '**********************************'.
           DISPLAY ' WSS-MESSAGE   = ' WSS-MESSAGE.

           IF SQLCODE NOT EQUAL ZEROES
             MOVE SQLCODE               TO WSS-SQLCODE
             MOVE 1234                  TO RETURN-CODE
             DISPLAY ' ERRO NO DB2 '
             DISPLAY ' WSS-SQLCODE   = ' WSS-SQLCODE
             DISPLAY ' RETURN-CODE   = ' RETURN-CODE
             PERFORM ROT-ROLLBACK
           END-IF.


           STOP RUN.

       ROT-TRATA-ERRO-EXIT.
           EXIT.
      *
      ******************************************************************
      * SERVICOS DE DADOS NO DB2
      ******************************************************************
       DATABASE-SECTION                   SECTION.

       DB-INSERE-SEDE.

           DISPLAY ' '
           DISPLAY ' COPA-ANO         = ' COPA-ANO
           DISPLAY ' COPA-DETALHE     = ' COPA-DETALHE
           DISPLAY ' COPA-PAIS-SEDE   = ' COPA-PAIS-SEDE
           DISPLAY ' COPA-COMENTARIOS = ' COPA-COMENTARIOS

           EXEC SQL
             INSERT INTO INEFE18.COPA_MUNDO (
                           COPA_ANO
                         , COPA_DETALHE
                         , COPA_PAIS_SEDE
                         , COPA_COMENTARIOS
                                      )
                  VALUES (
                           :DCLCOPA-MUNDO.COPA-ANO
                         , :DCLCOPA-MUNDO.COPA-DETALHE
                         , :DCLCOPA-MUNDO.COPA-PAIS-SEDE
                         , :DCLCOPA-MUNDO.COPA-COMENTARIOS
                                       )
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             MOVE SQLCODE                          TO WSS-SQLCODE
             MOVE "ERRO NO INSERT NA TABELA PAIS SEDE" TO WSS-MESSAGE
             DISPLAY 'COPA-ANO      = '
                   COPA-ANO            OF DCLCOPA-MUNDO
             DISPLAY 'COPA-PAIS-SEDE= '
                   COPA-PAIS-SEDE      OF DCLCOPA-MUNDO
             PERFORM ROT-TRATA-ERRO
           ELSE
             ADD 01               TO WSS-INSERT-SEDE
           END-IF.

       DB-INSERE-SEDE-EXIT.
           EXIT.
      *
       DB-INSERE-JOGOS.

           DISPLAY ' '
           DISPLAY ' JOGO-COD-TIPO       = ' JOGO-COD-TIPO
           DISPLAY ' JOGO-ANO            = ' JOGO-ANO
           DISPLAY ' JOGO-TIPO-JOGO      = ' JOGO-TIPO-JOGO
           DISPLAY ' JOGO-SELECAO-WIN    = ' JOGO-SELECAO-WIN
           DISPLAY ' JOGO-SELECAO-LOSER  = ' JOGO-SELECAO-LOSER
           DISPLAY ' JOGO-GOL-WIN        = ' JOGO-GOL-WIN
           DISPLAY ' JOGO-GOL-LOSER      = ' JOGO-GOL-LOSER
           DISPLAY ' JOGO-TIPO-TEMPO     = ' JOGO-TIPO-TEMPO
           DISPLAY ' JOGO-PENALTY-WIN    = ' JOGO-PENALTY-WIN
           DISPLAY ' JOGO-PENALTY-LOSER  = ' JOGO-PENALTY-LOSER
           DISPLAY ' JOGO-OBSERV         = ' JOGO-OBSERV
           DISPLAY ' JOGO-COMENT         = ' JOGO-COMENT

           EXEC SQL
             INSERT INTO INEFE18.COPA_JOGOS (
                           JOGO_COD_TIPO
                         , JOGO_ANO
                         , JOGO_TIPO_JOGO
                         , JOGO_SELECAO_WIN
                         , JOGO_SELECAO_LOSER
                         , JOGO_GOL_WIN
                         , JOGO_GOL_LOSER
                         , JOGO_TIPO_TEMPO
                         , JOGO_PENALTY_WIN
                         , JOGO_PENALTY_LOSER
                         , JOGO_OBSERV
                         , JOGO_COMENT
                                      )
                  VALUES (
                           :DCLCOPA-JOGOS.JOGO-COD-TIPO
                         , :DCLCOPA-JOGOS.JOGO-ANO
                         , :DCLCOPA-JOGOS.JOGO-TIPO-JOGO
                         , :DCLCOPA-JOGOS.JOGO-SELECAO-WIN
                         , :DCLCOPA-JOGOS.JOGO-SELECAO-LOSER
                         , :DCLCOPA-JOGOS.JOGO-GOL-WIN
                         , :DCLCOPA-JOGOS.JOGO-GOL-LOSER
                         , :DCLCOPA-JOGOS.JOGO-TIPO-TEMPO
                         , :DCLCOPA-JOGOS.JOGO-PENALTY-WIN
                         , :DCLCOPA-JOGOS.JOGO-PENALTY-LOSER
                         , :DCLCOPA-JOGOS.JOGO-OBSERV
                         , :DCLCOPA-JOGOS.JOGO-COMENT
                                       )
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             MOVE SQLCODE                          TO WSS-SQLCODE
             MOVE "ERRO NO INSERT NA TABELA PAIS SEDE" TO WSS-MESSAGE
             DISPLAY 'JOGO-ANO           = '
                   JOGO-ANO            OF DCLCOPA-JOGOS
             DISPLAY 'JOGO-SELECAO-WIN   = '
                   JOGO-SELECAO-WIN    OF DCLCOPA-JOGOS
             DISPLAY 'JOGO-SELECAO-LOSER = '
                   JOGO-SELECAO-LOSER  OF DCLCOPA-JOGOS
             PERFORM ROT-TRATA-ERRO
           ELSE
             ADD 01               TO WSS-INSERT-JOGO
           END-IF.

       DB-INSERE-JOGOS-EXIT.
           EXIT.
      *
       ROT-COMMIT.

           EXEC SQL
             COMMIT
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             MOVE SQLCODE   TO WSS-SQLCODE
             MOVE "ERRO NO COMMIT"      TO WSS-MESSAGE
              PERFORM ROT-TRATA-ERRO
           END-IF.
      *
       ROT-COMMIT-EXIT.
           EXIT.

      *
       ROT-ROLLBACK.

           EXEC SQL
             ROLLBACK
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             MOVE "ERRO NO ROLLBACK"    TO WSS-MESSAGE
           END-IF.
      *
       ROT-ROLLBACK-EXIT.
           EXIT.

       END PROGRAM COBDB501.
      ********************** FIM DO PROGRAMA ***************************

000100*****************************************************************
000200* DATA     :  16/02/2024
000300* AUTOR    : VAGNER RENATO BELLACOSA
000400* OBJETIVO : PROGRAMA db2
000500*            LE O ARQUIVO CURSO  E GRAVA TABELA DB2.
000600* CPD      : INEFE
000700*****************************************************************
000800
000900*************************
001000*PRIMEIRA DIVSAO*********
001100*************************
      *-----------------------*
       IDENTIFICATION DIVISION.
      *-----------------------*
       PROGRAM-ID. COBDB201.
       DATE-WRITTEN. 16/02/24 @ 22:20:00.
       DATE-COMPILED. 2024-02-16.
       INSTALLATION. INEFE.
       SECURITY. NORMAL.

      *--------------------*
       ENVIRONMENT DIVISION.
      *--------------------*
        CONFIGURATION SECTION.
         SPECIAL-NAMES.  DECIMAL-POINT IS COMMA.
      *
        INPUT-OUTPUT SECTION.

        FILE-CONTROL.
           SELECT CURSOS ASSIGN TO CURSOS
                  ORGANIZATION IS SEQUENTIAL
                  ACCESS MODE  IS SEQUENTIAL
                  FILE STATUS  IS FS-CURSOS.
      *
      *-------------*
       DATA DIVISION.
      *-------------*
       FILE SECTION.

       FD   CURSOS
            RECORDING MODE IS F
            RECORD CONTAINS 80 CHARACTERS.
      *--- record?
       01   REG-CURSOS.
            03 COD-CURSO                   PIC 9(006).
            03 NOME-CURSO                  PIC X(040).
            03 ALUNO-CURSO                 PIC 9(006).
            03 CARGA-AULA-CURSO            PIC 9(006).
            03 COMENTARIO-CURSO            PIC X(022).
      *-----------------------*
       WORKING-STORAGE SECTION.
      *-----------------------*
       77 FS-CURSOS                    PIC 9(002) VALUE 0.
       77 WSS-SQLCODE                  PIC -ZZZZZZZZ9.
       77 WSS-LIDOS                    PIC 9(04).
       77 WSS-INSERT                   PIC 9(04).
       77 WSS-DATA-COMPIL              PIC X(16).
       77 WSS-MESSAGE                  PIC X(50).
      *-----------------------*
       LOCAL-STORAGE SECTION.
      *-----------------------*
      *
      ******************************************************************
      * DCLGEN TABLE(INEFE00.CURSO)                                    *
      *        LIBRARY(IBMUSER.WORKBOOK.COPY(TBCURSO))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE INEFE00.CURSO TABLE
           ( COD_CURSO                      INTEGER NOT NULL,
             MATRICULA_ALU                  INTEGER NOT NULL,
             NOME_CURSO                     CHAR(40) NOT NULL,
             CARGA_HORARIA_CURSO            DECIMAL(3, 0),
             COMENTARIOS_CURSO              VARCHAR(200),
             DATA_CAD                       DATE,
             HORA_CAD                       TIME,
             LOG_CAD                        TIMESTAMP
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE INEFE00.CURSO                      *
      ******************************************************************
       01  DCLCURSO.
           10 COD-CURSO            PIC S9(9) USAGE COMP.
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.
           10 NOME-CURSO           PIC X(40).
           10 CARGA-HORARIA-CURSO  PIC S9(3)V USAGE COMP-3.
           10 COMENTARIOS-CURSO.
              49 COMENTARIOS-CURSO-LEN
                 PIC S9(4) USAGE COMP.
              49 COMENTARIOS-CURSO-TEXT
                 PIC X(200).
           10 DATA-CAD             PIC X(10).
           10 HORA-CAD             PIC X(8).
           10 LOG-CAD              PIC X(26).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 8       *
      ******************************************************************
      *
      *   COPY TBALUNOS.
      *
      ******************************************************************
      * DCLGEN TABLE(INEFE18.ALUNOS)                                   *
      *        LIBRARY(IBMUSER.WORKBOOK.COPY(TBALUNOS))                *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE INEFE00.ALUNOS TABLE
           ( MATRICULA_ALU                  INTEGER NOT NULL,
             NOME_ALU                       CHAR(40),
             SEXO_ALU                       CHAR(1),
             NOTA01_ALU                     DECIMAL(4, 2),
             NOTA02_ALU                     DECIMAL(4, 2),
             NOTA03_ALU                     DECIMAL(4, 2),
             NOTA04_ALU                     DECIMAL(4, 2),
             NOTA05_ALU                     DECIMAL(4, 2),
             MEDIA_ALU                      DECIMAL(4, 2),
             DATA_CAD                       DATE,
             HORA_CAD                       TIME,
             LOG_CAD                        TIMESTAMP
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE INEFE00.ALUNOS                     *
      ******************************************************************
       01  DCLALUNOS.
      *    *************************************************************
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.
           10 NOME-ALU             PIC X(40).
           10 SEXO-ALU             PIC X(1).
           10 NOTA01-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA02-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA03-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA04-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA05-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 MEDIA-ALU            PIC S9(2)V9(2) USAGE COMP-3.
           10 DATA-CAD             PIC X(10).
           10 HORA-CAD             PIC X(8).
           10 LOG-CAD              PIC X(26).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 12      *
      ******************************************************************
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

      *----------
       PROCEDURE DIVISION.
      *----------
       MAIN-SECTION                       SECTION.

           PERFORM ROT-DISPLAY.

           PERFORM ROT-OPEN-FILE.

           PERFORM ROT-LER-CURSOS UNTIL FS-CURSOS = 10

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

           OPEN INPUT CURSOS.

           IF FS-CURSOS NOT EQUAL 0 THEN
              DISPLAY ' '
              DISPLAY 'COBDB201 - ERRO OPEN CURSOS FS = ' FS-CURSOS
              DISPLAY ' '
              MOVE FS-CURSOS       TO RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.
      *
       ROT-OPEN-FILE-EXIT.
           EXIT.
      *
       ROT-LER-CURSOS.

           DISPLAY 'ROT-LER-CURSOS'.

           READ CURSOS.

           IF FS-CURSOS NOT EQUAL 0 AND
              FS-CURSOS NOT EQUAL 10
              DISPLAY ' '
              DISPLAY 'COBDB201 - ERRO READ CURSOS FS = ' FS-CURSOS
              DISPLAY ' '
              MOVE FS-CURSOS       TO RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

           IF FS-CURSOS EQUAL 0
             PERFORM ROT-PREPARA-INSERT
           ELSE
             IF FS-CURSOS EQUAL 10 AND WSS-LIDOS EQUAL ZEROES
               DISPLAY ' '
               DISPLAY 'COBDB201 - ARQUIVO CURSOS VAZIO ' FS-CURSOS
               DISPLAY ' '
               MOVE FS-CURSOS     TO RETURN-CODE
               PERFORM ROT-TRATA-ERRO
             END-IF
           END-IF.
      *
       ROT-LER-CURSOS-EXIT.
           EXIT.
      *
       ROT-CLOSE-FILE.

           CLOSE CURSOS.

           IF FS-CURSOS NOT EQUAL 0 THEN
              DISPLAY ' '
              DISPLAY 'COBDB201 - ERRO CLOSE ALUNOS FS = ' FS-CURSOS
              DISPLAY ' '
              MOVE FS-CURSOS       TO RETURN-CODE
              PERFORM ROT-TRATA-ERRO
           END-IF.

       ROT-CLOSE-FILE-EXIT.
           EXIT.

      ******************************************************************
      * INCLUIR REGISTRO NA TABELA
      ******************************************************************
       DATABASE-SECTION                   SECTION.

       ROT-DB-INCLUI-CURSO.

           EXEC SQL
             INSERT INTO INEFE00.CURSO (
                           COD_CURSO
                         , MATRICULA_ALU
                         , NOME_CURSO
                         , CARGA_HORARIA_CURSO
                         , COMENTARIOS_CURSO
                         , DATA_CAD
                         , HORA_CAD
                         , LOG_CAD
                                      )
                  VALUES (
                           :DCLCURSO.COD-CURSO
                         , :DCLCURSO.MATRICULA-ALU
                         , :DCLCURSO.NOME-CURSO
                         , :DCLCURSO.CARGA-HORARIA-CURSO
                         , :DCLCURSO.COMENTARIOS-CURSO
                         , CURRENT DATE
                         , CURRENT TIME
                         , CURRENT TIMESTAMP
                                       )
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             MOVE SQLCODE                          TO WSS-SQLCODE
             MOVE "ERRO NO INSERT NA TABELA CURSO" TO WSS-MESSAGE
             DISPLAY 'COD-CURSO     = '
                   COD-CURSO           OF DCLCURSO
             DISPLAY 'MATRICULA-ALU = '
                   MATRICULA-ALU       OF DCLCURSO
             DISPLAY 'NOME-CURSO    = '
                   NOME-CURSO          OF DCLCURSO
             PERFORM ROT-TRATA-ERRO
           ELSE
             ADD 01               TO WSS-INSERT
           END-IF.

       ROT-DB-INCLUI-CURSO-EXIT.
           EXIT.
      *
       ROT-COMMIT.

           EXEC SQL
             COMMIT
           END-EXEC.
      *
           IF SQLCODE NOT EQUAL 0 THEN
             move sqlcode   to wss-sqlcode
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

      *--------------------------------*
      * ARQUITETURA DO SISTEMA                                         *
      *--------------------------------*

       ARQUITETURA-SECTION                SECTION.

       ROT-DISPLAY.

           DISPLAY 'COBDB201'.

           DISPLAY 'PROGRAMA COBOL + QSAM + DB2'
           DISPLAY 'LE ARQUIVO SEQUENCIAL E INSERE REGISTROS '
           DISPLAY 'NA TABELA CURSO'

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

       ROT-PREPARA-INSERT.

           ADD 01                TO WSS-LIDOS

           MOVE COD-CURSO OF REG-CURSOS
                                 TO COD-CURSO           OF DCLCURSO
           MOVE ALUNO-CURSO      TO MATRICULA-ALU       OF DCLCURSO
           MOVE NOME-CURSO OF REG-CURSOS
                                 TO NOME-CURSO          OF DCLCURSO
           MOVE CARGA-AULA-CURSO TO CARGA-HORARIA-CURSO OF DCLCURSO
           MOVE 40               TO COMENTARIOS-CURSO-LEN
                                                        OF DCLCURSO
           MOVE COMENTARIO-CURSO TO COMENTARIOS-CURSO-TEXT
                                                        OF DCLCURSO
           DISPLAY ' '
           DISPLAY 'REGISTRO LIDO NO QSAM -> ' WSS-LIDOS
           DISPLAY 'COD-CURSO        = ' COD-CURSO OF REG-CURSOS
           DISPLAY 'NOME-CURSO       = ' NOME-CURSO OF REG-CURSOS
           DISPLAY 'ALUNO-CURSO      = ' ALUNO-CURSO OF REG-CURSOS
           DISPLAY 'CARGA-AULA-CURSO = ' CARGA-AULA-CURSO OF REG-CURSOS
           DISPLAY 'COMENTARIO-CURSO = ' COMENTARIO-CURSO OF REG-CURSOS

           PERFORM ROT-DB-INCLUI-CURSO.

       ROT-PREPARA-INSERT-EXIT.
           EXIT.

       ROT-ESTATISTICA.

           DISPLAY '**********************************'.
           DISPLAY '*** COBDB201 - TERMINO NORMAL  ***'.
           DISPLAY '**********************************'.
           DISPLAY ' QSAM - LIDOS   = ' WSS-LIDOS.
           DISPLAY ' DB2  - INSERT  = ' WSS-INSERT.

       ROT-TRATA-ERRO-EXIT.
           EXIT.

       ROT-TRATA-ERRO.

           DISPLAY '**********************************'.
           DISPLAY '*** ABEND PROGRAMADO  ************'.
           DISPLAY '**********************************'.
           DISPLAY ' QSAM - LIDOS   = ' WSS-LIDOS.
           DISPLAY ' DB2  - INSERT  = ' WSS-INSERT.
           DISPLAY '**********************************'.
           DISPLAY ' WSS-MESSAGE   = ' WSS-MESSAGE.

           IF SQLCODE NOT EQUAL ZEROES
             MOVE SQLCODE               TO WSS-SQLCODE
             MOVE 9999                  TO RETURN-CODE
             DISPLAY ' ERRO NO DB2 '
             DISPLAY ' WSS-SQLCODE   = ' WSS-SQLCODE
             PERFORM ROT-ROLLBACK
           END-IF.

           DISPLAY ' RETURN-CODE   = ' RETURN-CODE.

           STOP RUN.

       ROT-TRATA-ERRO-EXIT.
           EXIT.
      *
       END PROGRAM COBDB201.
      ********************** FIM DO PROGRAMA ***************************

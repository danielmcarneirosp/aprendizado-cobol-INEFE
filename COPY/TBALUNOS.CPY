      ******************************************************************
      * DCLGEN TABLE(INEFE00.ALUNOS)                                   *
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

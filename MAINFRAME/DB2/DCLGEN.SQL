      ******************************************************************00010000
      * DCLGEN TABLE(CAZE.ALUNOS)                                      *00020000
      *        LIBRARY(USER.INEFEXX.COBOL(DCLGEN))                     *00030000
      *        ACTION(REPLACE)                                         *00040000
      *        LANGUAGE(COBOL)                                         *00050000
      *        QUOTE                                                   *00060000
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *00070000
      ******************************************************************00080000
           EXEC SQL DECLARE CAZE.ALUNOS TABLE                           00090000
           ( MATRICULA_ALU                  INTEGER NOT NULL,           00100000
             NOME_ALU                       CHAR(40),                   00110000
             SEXO_ALU                       CHAR(1),                    00120000
             NOTA01_ALU                     DECIMAL(4, 2),              00130000
             NOTA02_ALU                     DECIMAL(4, 2),              00140000
             NOTA03_ALU                     DECIMAL(4, 2),              00150000
             NOTA04_ALU                     DECIMAL(4, 2),              00160000
             NOTA05_ALU                     DECIMAL(4, 2),              00170000
             MEDIA_ALU                      DECIMAL(4, 2)               00180000
           ) END-EXEC.                                                  00190000
      ******************************************************************00200000
      * COBOL DECLARATION FOR TABLE CAZE.ALUNOS                        *00210000
      ******************************************************************00220000
       01  DCLALUNOS.                                                   00230000
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.                00240000
           10 NOME-ALU             PIC X(40).                           00250000
           10 SEXO-ALU             PIC X(1).                            00260000
           10 NOTA01-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00270000
           10 NOTA02-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00280000
           10 NOTA03-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00290000
           10 NOTA04-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00300000
           10 NOTA05-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00310000
           10 MEDIA-ALU            PIC S9(2)V9(2) USAGE COMP-3.         00320000
      ******************************************************************00330000
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 9       *00340000
      ******************************************************************00350000

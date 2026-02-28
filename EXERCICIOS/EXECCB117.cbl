      ******************************************************************
      * Author:DANIEL CARNEIRO
      * Date: 08/12/2025
      * Purpose: APRENDER AQUIVO QSAM E LOOP
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. EXECCB117.
       AUTHOR. DANIEL CARNEIRO.
       DATE-WRITTEN. 08/12/2025

       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-Z.
       OBJECT-COMPUTER. IBM-Z.

       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

      *-----------------------
       INPUT-OUTPUT SECTION.
       FILE CONTROL.
           SELECT OUTPTFL   ASSIGN TO OUTPTFL
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FS-STATUS.

      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
       FD OUTPTFL
           RECORD CONTAINS 145 CHARACTERS
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F
           DATA RECORD IS REG-DADOS.

       COPY COPY117A.

      *-----------------------
       WORKING-STORAGE SECTION.
       01 WSS-VARIAVEL-AUX.
           05 WSS-EOF          PIC A(01).
           05 FS-STATUS        PIC 99.

       77 WSS-RANDOM-NUMBER1       PIC 999 VALUE ZEROES.
       77 WSS-RANDOM-NUMBER2       PIC 999 VALUE ZEROES.
       77 WSS-REG-GRAVADOS         PIC 999 VALUE ZEROES.
       77 WSS-CICLO                PIC 99 VALUE 15.
       77 WSS-DATA-COMPIL          PIC X(16).

      *****************************************************************
      **    DECLARIONS FOR THE LOCAL DATE/TIME FOR DISPLAY            *
      *****************************************************************
       01 WSS-CAMPOS-AUXILIARES.
           05 WSS-YYYYMMDD             PIC 9(008).
           05 WSS-YYMMDD               PIC 9(006).
           05 WSS-HHMMSS               PIC 9(006).
           05 WSS-HHMMSSCC             PIC 9(008).
           05 WSS-ANODIA               PIC 9(005).
           05 WSS-DAY-YYYYDDD          PIC 9(007).
           05 WSS-DAY-001              PIC S9(009).
           05 WSS-INTEGER-FORM         PIC S9(9) SIGN LEADIN SEPARATE.
           05 WSS-INT-DATE             PIC 9(8) VALUE ZEROES.
           05 WSS-DATE-TODAY           PIC 9(7) VALUE ZERO.
           05 WSS-DUE-DATE             PIC 9(7) VALUE ZERO.




      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.

       001-INICIALIZAR             SECTION.

           PERFORM ROOT-LISTA-INFO
              THRU ROOT-LISTA-EXIT.

           PERFORM ROOT-OPEN-FILE
              THRU ROOT-OPEN-FILE-EXIT.

           PERFORM ROOT-INITIALIZE-VAR
              THRU ROOT-INITIALIZE-VAR-EXIT.


       002-WORKFILE            SECTION.
           PERFORM ROOT-FORMATA-OUTPUT
              THRU ROOT-FORMATA-OUTPUT-EXIT WSS-CICLO TIMES.

       003-PROCEDIMENTOS-FINAIS        SECTION.
           PERFORM ROOT-CLOSE-FILE
              THRU ROOT-CLOSE-FILE-EXIT.

           PERFORM ROOT-ESTATISTICA
              THRU ROOT-ESTATISTICA-EXIT.

           STOP RUN.

       END PROGRAM EXECCB117.

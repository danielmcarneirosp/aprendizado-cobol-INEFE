      ******************************************************************00010000
      * RECEBE MATRICULA NO SYSIN E LE A TABELA DB2. CALCULA MÉDIA E    00020000
      * IMPRIME REGISTRO COM NOME, MÉDIA E SITUAÇÃO                     00030000
      ******************************************************************00040000
      *------------------------                                         00050000
       IDENTIFICATION DIVISION.                                         00060000
      *------------------------                                         00070000
       PROGRAM-ID. COBXXX5Z.                                            00080000
                                                                        00081003
      *---------------------                                            00090000
       ENVIRONMENT DIVISION.                                            00100000
      *---------------------                                            00110000
        CONFIGURATION SECTION.                                          00120000
         SPECIAL-NAMES.  DECIMAL-POINT IS COMMA.                        00130000
                                                                        00131003
      *--------------                                                   00140000
       DATA DIVISION.                                                   00150000
      *--------------                                                   00160000
                                                                        00161003
      *------------------------                                         00170000
       WORKING-STORAGE SECTION.                                         00180000
      *------------------------                                         00190000
       77 MASCARA                         PIC Z9,99.                    00200000
       77 MEDIA                           PIC 9(002)V99.                00210000
       77 MAT                             PIC 9(009).                   00220003
      *                                                                 00230000
       01 REG-SAIDA.                                                    00240000
          03 NOME-SAI                     PIC X(040) VALUE SPACES.      00250000
          03 FILLER                       PIC X(003) VALUE ' - '.       00260000
          03 MEDIA-SAI                    PIC X(005) VALUE SPACES.      00270000
          03 FILLER                       PIC X(003) VALUE ' - '.       00280000
          03 SITUACAO-SAI                 PIC X(009) VALUE SPACES.      00290000
                                                                        00291003
      *----------------------                                           00300000
       LOCAL-STORAGE SECTION.                                           00310000
      *----------------------                                           00320000
       01  DCLALUNOS.                                                   00330002
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.                00340002
           10 NOME-ALU             PIC X(40).                           00350002
           10 SEXO-ALU             PIC X(1).                            00360002
           10 NOTA01-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00370002
           10 NOTA02-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00380002
           10 NOTA03-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00390002
           10 NOTA04-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00400002
           10 NOTA05-ALU           PIC S9(2)V9(2) USAGE COMP-3.         00410002
           10 MEDIA-ALU            PIC S9(2)V9(2) USAGE COMP-3.         00420002
      *                                                                 00430000
           EXEC SQL                                                     00440000
               INCLUDE SQLCA                                            00450000
           END-EXEC.                                                    00460000
      *-------------------                                              00470000
       PROCEDURE DIVISION.                                              00480000
      *-------------------                                              00490000
           ACCEPT MAT.                                                  00500000
                                                                        00500103
           DISPLAY ' MAT = ' MAT                                        00501003
                                                                        00502003
           MOVE MAT TO MATRICULA-ALU.                                   00510000
                                                                        00511003
           EXEC SQL                                                     00520000
                SELECT                                                  00530000
                       NOME_ALU,                                        00540000
                       NOTA01_ALU,                                      00550000
                       NOTA02_ALU,                                      00560000
                       NOTA03_ALU,                                      00570000
                       NOTA04_ALU,                                      00580000
                       NOTA05_ALU                                       00590000
                INTO   :NOME-ALU,                                       00600000
                       :NOTA01-ALU,                                     00610000
                       :NOTA02-ALU,                                     00620000
                       :NOTA03-ALU,                                     00630000
                       :NOTA04-ALU,                                     00640000
                       :NOTA05-ALU                                      00650000
                FROM   CAZE.ALUNOS                                      00660000
                WHERE  MATRICULA_ALU = :MATRICULA-ALU                   00670000
                FETCH FIRST 1 ROWS ONLY                                 00671003
           END-EXEC                                                     00680000
      *                                                                 00690000
           IF SQLCODE NOT EQUAL ZEROES                                  00690103
              DISPLAY ' ALUNO NAO ENCONTRADO '                          00690203
              STOP RUN                                                  00690303
           END-IF.                                                      00690403
      *                                                                 00691003
           COMPUTE MEDIA = (NOTA01-ALU + NOTA02-ALU +                   00700000
                            NOTA03-ALU + NOTA04-ALU +                   00710000
                            NOTA05-ALU) / 5                             00720000
      *                                                                 00721003
           IF MEDIA < 7 THEN                                            00730000
              MOVE 'REPROVADO' TO SITUACAO-SAI                          00740000
           ELSE                                                         00750000
              MOVE 'APROVADO ' TO SITUACAO-SAI                          00760000
           END-IF                                                       00770000
                                                                        00771003
           MOVE MEDIA       TO MASCARA                                  00780000
           MOVE MASCARA     TO MEDIA-SAI                                00790000
           MOVE NOME-ALU    TO NOME-SAI                                 00800000
                                                                        00801003
           DISPLAY REG-SAIDA                                            00810000
      *                                                                 00811000
           MOVE MEDIA TO MEDIA-ALU                                      00811100
      *                                                                 00811203
           DISPLAY ' ANTES MATRICULA =  ' MATRICULA-ALU.                00811303
                                                                        00811403
           MOVE MAT TO MATRICULA-ALU.                                   00811503
      *                                                                 00811603
           DISPLAY ' DEPOIS MATRICULA =  ' MATRICULA-ALU.               00811703
                                                                        00811803
           EXEC SQL                                                     00811900
                   UPDATE CAZE.ALUNOS                                   00812003
                   SET MEDIA_ALU = :MEDIA-ALU                           00812103
                          WHERE MATRICULA_ALU = :MATRICULA-ALU          00812203
           END-EXEC.                                                    00812300
      *                                                                 00812400
           IF SQLCODE NOT EQUAL ZEROES                                  00813003
              DISPLAY ' ERRO NA ATUALIZACAO DO ALUNO'                   00814003
              STOP RUN                                                  00815003
           END-IF.                                                      00816003
      *                                                                 00817003
           GOBACK.                                                      00820000

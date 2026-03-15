      ******************************************************************
      * PROGRAMA    : COBDB202
      * VERSÃO      : 001
      * CRIAÇÃO     : 23/09/2020
      * PROGRAMADOR : CAZÉ
      * SISTEMA     : CIC - CICS
      * TIPO OBJETO : PROGRAMA COBOL/CICS
      * LINGUAGEM   : COBOL II
      * AMBIENTE    : ONLINE
      * FINALIDADE  : ALTERA REGISTRO DA TABELA DB2 INEFEXX.ALUNOS
      ******************************************************************
      *------------------------                                               00
       IDENTIFICATION DIVISION.                                               00
      *------------------------                                               00
       PROGRAM-ID. COBDB202.                                                  00
      *---------------------                                                  00
       ENVIRONMENT DIVISION.                                                  00
      *---------------------                                                  00
        CONFIGURATION SECTION.
         SPECIAL-NAMES.  DECIMAL-POINT IS COMMA.
      *--------------                                                         00
       DATA DIVISION.                                                         00
      *--------------                                                         00
      *------------------------                                               00
       WORKING-STORAGE SECTION.                                               00
      *------------------------                                               00
       77  W-ABS                     PIC S9(015) COMP-3.                      00
       77  MATRIC                    PIC  9(006) VALUE 0.                     00
       77  N01                       PIC  9(002).
       77  N02                       PIC  9(002).
       77  N03                       PIC  9(002).
       77  N04                       PIC  9(002).
       77  N05                       PIC  9(002).
      *                                                                       00
       01  DCLALUNOS.                                                         00
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.                      00
           10 NOME-ALU             PIC X(40).                                 00
           10 SEXO-ALU             PIC X(1).                                  00
           10 NOTA1-ALU            PIC S9(2)V USAGE COMP-3.                   00
           10 NOTA2-ALU            PIC S9(2)V USAGE COMP-3.                   00
           10 NOTA3-ALU            PIC S9(2)V USAGE COMP-3.                   00
           10 NOTA4-ALU            PIC S9(2)V USAGE COMP-3.                   00
           10 NOTA5-ALU            PIC S9(2)V USAGE COMP-3.                   00
           10 MEDIA-ALU            PIC S9(2)V9(2) USAGE COMP-3.               00
      *                                                                       00
       01  MSG-ERRO.                                                          00
           03  FILLER                PIC  X(05) VALUE 'CMD= '.                00
           03  COMANDO               PIC  X(08) VALUE SPACES.                 00
           03  FILLER                PIC  X(08) VALUE ', RESP= '.             00
           03  RESP1                 PIC  9(05).                              00
           03  FILLER                PIC  X(09) VALUE ', RESP2= '.            00
           03  RESP2                 PIC  9(05).                              00
      *                                                                       00
       01  MAPA                      PIC X(008) VALUE 'COBM002 '.             00
       01  CONT-CHAVE                PIC X(016) VALUE 'CONTCHAVE'.            00
       01  CONT-NAME                 PIC X(016) VALUE 'CONTKAZ'.              00
       01  CONT-PFS                  PIC X(016) VALUE 'CONTPFS'.              00
       01  CHANNEL-NAME              PIC X(016) VALUE 'CHANNKAZ'.             00
      *                                                                       00
           COPY COBS002.                                                      00
           COPY DFHAID.                                                       00
      *----------------------                                                 00
       LOCAL-STORAGE SECTION.                                                 00
      *----------------------                                                 00
           EXEC SQL
                INCLUDE SQLCA
           END-EXEC.
      *-------------------                                                    00
       PROCEDURE DIVISION.                                                    00
      *-------------------                                                    00
      ******************************************************************      00
      * ROTINA VERIFICA SE É A PRIMEIRA VEZ QUE O PROGRAMA EXECUTA            00
      ******************************************************************      00
           EXEC CICS GET CONTAINER(CONT-NAME)                                 00
                               CHANNEL(CHANNEL-NAME)                          00
                               INTO(MAPA)                                     00
                               FLENGTH(LENGTH OF MAPA)                        00
                               RESP(RESP1)                                    00
                               RESP2(RESP2)                                   00
           END-EXEC.                                                          00
           IF RESP1 NOT EQUAL DFHRESP(NORMAL)                                 00
              GO TO 0000-PRIMEIRA-VEZ                                         00
           ELSE                                                               00
              GO TO 0100-SEGUNDA-VEZ                                          00
           END-IF.                                                            00
      ******************************************************************      00
      * ROTINA EXECUTADA SE O PROGRAMA É CARREGADO PELA PRIMEIRA VEZ          00
      ******************************************************************      00
       0000-PRIMEIRA-VEZ.                                                     00
           EXEC CICS PUT CONTAINER(CONT-NAME)                                 00
                               CHANNEL(CHANNEL-NAME)                          00
                               FROM(MAPA)                                     00
                               FLENGTH(LENGTH OF MAPA)                        00
                               RESP(RESP1)                                    00
                               RESP2(RESP2)                                   00
           END-EXEC.                                                          00
      *                                                                       00
           PERFORM 0001-LIMPA-CAMPOS.                                         00
           PERFORM 0200-ROTINA-SEND.                                          00
           GO TO 1000-FIM.                                                    00
      ******************************************************************      00
      * ROTINA EXECUTADA SE O PROGRAMA É CARREGADO PELA SEGUNDA VEZ           00
      ******************************************************************      00
       0100-SEGUNDA-VEZ.                                                      00
           PERFORM 0300-ROTINA-RECE                                           00
      *                                                                       00
           EVALUATE EIBAID                                                    00
               WHEN  DFHENTER                                                 00
                     GO TO 1000-LER-TABELA                                    00
               WHEN  DFHPF3                                                   00
                     EXEC CICS START
                          TRANSID('KDB0')
                          TERMID(EIBTRMID)
                     END-EXEC                                                 00
                     GO TO 2000-ENCERRA
               WHEN  DFHPF2                                                   00
                     PERFORM 0001-ALTERA-CAMPOS                               00
                     PERFORM 0200-ROTINA-SEND                                 00
                     GO TO 1000-FIM                                           00
               WHEN  OTHER                                                    00
                     MOVE 'TECLA INVÁLIDA.' TO MSGO                           00
                     PERFORM 0200-ROTINA-SEND                                 00
                     GO TO 1000-FIM                                           00
           END-EVALUATE.                                                      00
      ******************************************************************      00
      * ROTINA PARA LIMPAR OS CAMPOS DA TELA                                  00
      ******************************************************************      00
       0001-LIMPA-CAMPOS.                                                     00
           EXEC CICS ASSIGN USERID(USUARIOO) END-EXEC                         00
           EXEC CICS ASSIGN APPLID(CICSIDO) END-EXEC                          00
           MOVE SPACES TO MATRICO                                             00
           MOVE SPACES TO NOMEO                                               00
           MOVE SPACES TO SEXOO                                               00
           MOVE 0      TO NOTA01O                                             00
           MOVE 0      TO NOTA02O                                             00
           MOVE 0      TO NOTA03O                                             00
           MOVE 0      TO NOTA04O                                             00
           MOVE 0      TO NOTA05O                                             00
           MOVE SPACES TO MSGO                                                00
      *                                                                       00
           EXEC CICS ASKTIME ABSTIME (W-ABS) END-EXEC                         00
      *                                                                       00
           EXEC CICS FORMATTIME ABSTIME (W-ABS)                               00
                                DATESEP                                       00
                                DDMMYYYY (DATAO)                              00
                                TIME (HORAO)                                  00
                                TIMESEP                                       00
           END-EXEC.                                                          00
      ******************************************************************      00
      * ROTINA SEND MAP                                                       00
      ******************************************************************      00
       0200-ROTINA-SEND.                                                      00
           EXEC CICS SEND MAP(MAPA)                                           00
                          MAPSET('COBS002')                                   00
                          FROM(COBM002O)                                      00
                          LENGTH(LENGTH OF COBM002O)
                          FRSET
                          NOHANDLE                                            00
           END-EXEC.                                                          00
      ******************************************************************      00
      * ROTINA RECEIVE MAP                                                    00
      ******************************************************************      00
       0300-ROTINA-RECE.                                                      00
           EXEC CICS RECEIVE MAP(MAPA)                                        00
                             MAPSET('COBS002')                                00
                             INTO(COBM002I)                                   00
                             NOHANDLE                                         00
           END-EXEC.                                                          00
      ******************************************************************      00
      * ROTINA PARA LER O ARQUIVO VSAM                                        00
      ******************************************************************      00
       1000-LER-TABELA.                                                       00
           UNSTRING
              MATRICI   DELIMITED BY SPACES INTO MATRIC
           END-UNSTRING
      *----
           MOVE MATRIC TO MATRICULA-ALU
      *----
           EXEC SQL                                                           00
                SELECT NOME_ALU,
                       SEXO_ALU,
                       NOTA1_ALU,
                       NOTA2_ALU,
                       NOTA3_ALU,
                       NOTA4_ALU,
                       NOTA5_ALU
                INTO   :NOME-ALU,                                             00
                       :SEXO-ALU,                                             00
                       :NOTA1-ALU,                                            00
                       :NOTA2-ALU,
                       :NOTA3-ALU,
                       :NOTA4-ALU,
                       :NOTA5-ALU
                FROM   INEFE00.ALUNOS
                WHERE  MATRICULA_ALU = :MATRICULA-ALU
           END-EXEC                                                           00
      *----
           IF SQLCODE NOT EQUAL 0                                             00
              MOVE 'MATRICULA NÃO ENCONTRADA.' TO MSGO                        00
           ELSE                                                               00
              MOVE NOME-ALU  TO NOMEO
              MOVE SEXO-ALU  TO SEXOO
              MOVE NOTA1-ALU TO N01
              MOVE N01       TO NOTA01O
              MOVE NOTA2-ALU TO N02
              MOVE N02       TO NOTA02O
              MOVE NOTA3-ALU TO N03
              MOVE N03       TO NOTA03O
              MOVE NOTA4-ALU TO N04
              MOVE N04       TO NOTA04O
              MOVE NOTA5-ALU TO N05
              MOVE N05       TO NOTA05O
           END-IF                                                             00
      *----
           PERFORM 0200-ROTINA-SEND                                           00
           GO TO 1000-FIM.                                                    00
      ******************************************************************      00
      * ROTINA ALTERA OS CAMPOS DA TABELA.                                    00
      ******************************************************************      00
       0001-ALTERA-CAMPOS.
           IF NOMEL > 0 THEN
              MOVE NOMEI TO NOME-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET NOME_ALU = :NOME-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
           IF SEXOL > 0 THEN
              MOVE SEXOI TO SEXO-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET SEXO_ALU = :SEXO-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
           IF NOTA01L > 0 THEN
              MOVE NOTA01I TO NOTA1-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET NOTA1_ALU = :NOTA1-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
           IF NOTA02L > 0 THEN
              MOVE NOTA02I TO NOTA2-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET NOTA2_ALU = :NOTA2-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
           IF NOTA03L > 0 THEN
              MOVE NOTA03I TO NOTA3-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET NOTA3_ALU = :NOTA3-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
           IF NOTA04L > 0 THEN
              MOVE NOTA04I TO NOTA4-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET NOTA4_ALU = :NOTA4-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
           IF NOTA05L > 0 THEN
              MOVE NOTA05I TO NOTA5-ALU
              EXEC SQL
                 UPDATE INEFE00.ALUNOS
                    SET NOTA5_ALU = :NOTA5-ALU
                    WHERE MATRICULA_ALU = :MATRICULA-ALU
              END-EXEC
           END-IF
      *----
           MOVE 'REGISTRO ALTERADO COM SUCESSO.' TO MSGO                      00
           PERFORM 0200-ROTINA-SEND
           GO TO 1000-FIM.                                                    00
      ******************************************************************      00
      * ROTINA FIM DA PSEUDO-CONVERSACAO                                      00
      ******************************************************************      00
       1000-FIM.                                                              00
           EXEC CICS SEND CONTROL FREEKB END-EXEC                             00
           EXEC CICS RETURN TRANSID(EIBTRNID) CHANNEL(CHANNEL-NAME)           00
           END-EXEC.                                                          00
      ******************************************************************      00
      * ROTINA ENCERRA O PROGRAMA                                             00
      ******************************************************************      00
       2000-ENCERRA.                                                          00
           EXEC CICS SEND CONTROL FREEKB ERASE END-EXEC                       00
           EXEC CICS RETURN                                                   00
           END-EXEC.                                                          00

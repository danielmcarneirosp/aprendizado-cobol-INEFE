      ******************************************************************
      * PROGRAMA    : COBDB204
      * VERSÃO      : 001
      * CRIAÇÃO     : 23/09/2020
      * PROGRAMADOR : CAZÉ
      * SISTEMA     : CIC - CICS
      * TIPO OBJETO : PROGRAMA COBOL/CICS
      * LINGUAGEM   : COBOL II
      * AMBIENTE    : ONLINE
      * FINALIDADE  : LISTA REGISTROS DA TABELA DB2 INEFEXX.ALUNOS
      ******************************************************************
      *------------------------
       IDENTIFICATION DIVISION.
      *------------------------
       PROGRAM-ID. COBDB204.
      *---------------------
       ENVIRONMENT DIVISION.
      *---------------------
      *--------------
       DATA DIVISION.
      *--------------
      *------------------------
       WORKING-STORAGE SECTION.
      *------------------------
       77  CTE-INICIO                     PIC  X(024) VALUE
           'COBDB204 WSS COMECA AQUI'                                  .
       77  CTE-VERS                       PIC  X(006) VALUE 'VRS001'   .
       77  W-ABS                          PIC S9(015) COMP-3           .
       77  MAPA                           PIC  X(008) VALUE 'COBM004 ' .
       77  MAPAG                          PIC  X(008) VALUE 'COBS004 ' .
       77  CONTNAME                       PIC  X(016) VALUE '0001     '.
       77  CHANNAME                       PIC  X(016) VALUE 'CANAL01'  .
       77  RESP1                          PIC  9(005) VALUE 0          .
       77  RESP2                          PIC  9(005) VALUE 0          .
       77  I                              PIC  9(002) VALUE 0          .
       77  J                              PIC  9(002) VALUE 0          .
       77  K                              PIC  9(002) VALUE 0          .
       77  ACAO                           PIC  X(001) VALUE SPACES     .
       77  CHAVE-FUNCI                    PIC  X(008) VALUE SPACES     .
       77  MSGERRO                        PIC  X(080) VALUE SPACES     .
       77  TRANSACAO                      PIC  X(016) VALUE 'TRANSACAO'.
       77  CONTERRO                       PIC  X(016) VALUE 'CONTERRO' .
       77  RETORNO                        PIC  X(016) VALUE 'RETORNO'  .
       77  NUM-ITENS                      PIC S9(04) COMP VALUE 0      .
       77  NUM-TELAS                      PIC S9(04) COMP VALUE 0      .
       77  ITEM                           PIC S9(04) COMP VALUE 0      .
       77  TELA-ATUAL                     PIC S9(04) COMP VALUE 1      .
       77  RESTO                          PIC S9(04) COMP VALUE 0      .
       77  INICIO                         PIC S9(08) COMP VALUE ZEROS  .
       77  RBA-CHAVE                      PIC S9(04) COMP VALUE 0      .
      *----
       01  DCLALUNOS.
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.
           10 NOME-ALU             PIC X(40).
           10 SEXO-ALU             PIC X(1).
           10 NOTA1-ALU            PIC S9(2)V USAGE COMP-3.
           10 NOTA2-ALU            PIC S9(2)V USAGE COMP-3.
           10 NOTA3-ALU            PIC S9(2)V USAGE COMP-3.
           10 NOTA4-ALU            PIC S9(2)V USAGE COMP-3.
           10 NOTA5-ALU            PIC S9(2)V USAGE COMP-3.
           10 MEDIA-ALU            PIC S9(2)V9(2) USAGE COMP-3.
      *----
       01  REGISTRO.
           10 MATRICULA            PIC 9(006).
           10 NOME                 PIC X(040).
      *----
       01  REGISTRO-TS.
           03  R-TS OCCURS 1 TO 9999 DEPENDING NUM-ITENS               .
               05  R-MATRICULA            PIC  9(006)                  .
               05  R-NOME                 PIC  X(040)                  .
      *----
       COPY COBS004.
       COPY DFHBMSCA.
       COPY DFHAID.
      *----------------------
       LOCAL-STORAGE SECTION.
      *----------------------
           EXEC SQL
                INCLUDE SQLCA
           END-EXEC.
      *
            EXEC SQL DECLARE CURS-01 CURSOR FOR
                 SELECT MATRICULA_ALU, NOME_ALU FROM INEFE00.ALUNOS
                        ORDER BY MATRICULA_ALU
            END-EXEC.
      *-------------------
       PROCEDURE DIVISION.
      *-------------------
      ******************************************************************
      * ROTINA VERIFICA SE É A PRIMEIRA VEZ QUE O PROGRAMA EXECUTA
      ******************************************************************
           EXEC CICS
                     GET CONTAINER(CONTNAME      )
                         CHANNEL  (CHANNAME      )
                         INTO     (MAPA          )
                         FLENGTH  (LENGTH OF MAPA)
                         RESP     (RESP1         )
                         RESP2    (RESP2         )
           END-EXEC
      *----
           IF RESP1 NOT EQUAL DFHRESP(NORMAL)
              GO TO 0000-PRIMEIRA-VEZ
           ELSE
              GO TO 0000-SEGUNDA-VEZ
           END-IF
           .
      ******************************************************************
      * ROTINA EXECUTADA SE O PROGRAMA É CARREGADO PELA PRIMEIRA VEZ
      ******************************************************************
       0000-PRIMEIRA-VEZ.
           EXEC CICS
                     DELETEQ TS QNAME('COBDB204')
                                NOHANDLE
           END-EXEC
      *----
           EXEC CICS
                     DELETE CONTAINER(CONTERRO)
                            CHANNEL  (CHANNAME)
                            NOHANDLE
           END-EXEC
      *----
           EXEC CICS
                     SEND CONTROL FREEKB ERASE
           END-EXEC
      *----
           EXEC CICS
                     PUT CONTAINER(CONTNAME      )
                         CHANNEL  (CHANNAME      )
                         FROM     (MAPA          )
                         FLENGTH  (LENGTH OF MAPA)
           END-EXEC
      *----
      *    PERFORM 0000-LIMPA-GERAL
           PERFORM 0000-MONTAR-REGISTRO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      ******************************************************************
      * ROTINA EXECUTADA SE O PROGRAMA É CARREGADO PELA SEGUNDA VEZ
      ******************************************************************
       0000-SEGUNDA-VEZ.
           EXEC CICS
                     GET CONTAINER('QTD-ITENS'        )
                         CHANNEL  (CHANNAME           )
                         INTO     (NUM-ITENS          )
                         FLENGTH  (LENGTH OF NUM-ITENS)
                         NOHANDLE
           END-EXEC
      *----
           EXEC CICS
                     GET CONTAINER('QTD-TELAS'        )
                         CHANNEL  (CHANNAME           )
                         INTO     (NUM-TELAS          )
                         FLENGTH  (LENGTH OF NUM-TELAS)
                         NOHANDLE
           END-EXEC
      *----
           EXEC CICS
                     GET CONTAINER('TELA-ATUAL'        )
                         CHANNEL  (CHANNAME            )
                         INTO     (TELA-ATUAL          )
                         FLENGTH  (LENGTH OF TELA-ATUAL)
                         NOHANDLE
           END-EXEC
      *----
           PERFORM   0000-ROTINA-RECE
           EVALUATE  EIBAID
               WHEN  DFHENTER
                     GO      TO 0000-SEL-REGISTRO
               WHEN  DFHPF3
                     EXEC CICS START
                          TRANSID('KDB0')
                          TERMID(EIBTRMID)
                     END-EXEC                                                 00
                     GO      TO 0000-ENCERRA
               WHEN  DFHPF7
                     SUBTRACT 1 FROM TELA-ATUAL
                     GO      TO 0000-RETORNA
               WHEN  DFHPF8
                     ADD 1   TO TELA-ATUAL
                     GO      TO 0000-AVANCA
               WHEN  OTHER
                     PERFORM 0000-LIMPA-GERAL
                     MOVE    'Tecla de função não disponível.'
                             TO 0004-MSGO
                     PERFORM 0000-ROTINA-SEND
                     GO TO   0000-FIM
           END-EVALUATE
           .
      ******************************************************************
      * ROTINA RETORNA TELA PF7
      ******************************************************************
       0000-RETORNA.
           IF TELA-ATUAL = 0 THEN
              PERFORM 0000-LIMPA
              MOVE    'Primeira tela.' TO 0004-MSGO
              MOVE    1                TO TELA-ATUAL
           ELSE
              PERFORM 0000-LIMPA-CAMPOS
              COMPUTE I = (TELA-ATUAL - 1) * 10 + 1
              COMPUTE J = TELA-ATUAL * 10
              PERFORM 0000-LER-TS
      *----
              EXEC CICS
                        PUT CONTAINER('TELA-ATUAL'        )
                            CHANNEL  (CHANNAME            )
                            FROM     (TELA-ATUAL          )
                            FLENGTH  (LENGTH OF TELA-ATUAL)
              END-EXEC
      *----
           END-IF
           MOVE    TELA-ATUAL TO 0004-PAGINAO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      ******************************************************************
      * ROTINA AVANCA TELA PF8
      ******************************************************************
       0000-AVANCA.
           IF TELA-ATUAL > NUM-TELAS THEN
              PERFORM 0000-LIMPA
              MOVE    'Última tela.' TO 0004-MSGO
              MOVE    NUM-TELAS      TO TELA-ATUAL
           ELSE
              PERFORM 0000-LIMPA-CAMPOS
              COMPUTE I = (TELA-ATUAL - 1) * 10 + 1
              COMPUTE J = TELA-ATUAL * 10
              PERFORM 0000-LER-TS
      *----
              EXEC CICS
                        PUT CONTAINER('TELA-ATUAL'        )
                            CHANNEL  (CHANNAME            )
                            FROM     (TELA-ATUAL          )
                            FLENGTH  (LENGTH OF TELA-ATUAL)
              END-EXEC
      *----
           END-IF
           MOVE    TELA-ATUAL TO 0004-PAGINAO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      ******************************************************************
      * ROTINA LE REGISTROS E GRAVA TS
      ******************************************************************
       0000-MONTAR-REGISTRO.
           EXEC SQL OPEN CURS-01 END-EXEC.
           PERFORM UNTIL SQLCODE = 100
               EXEC SQL
                  FETCH CURS-01
                  INTO  :MATRICULA-ALU,
                        :NOME-ALU
              END-EXEC
      *----
              MOVE MATRICULA-ALU TO MATRICULA
              MOVE NOME-ALU      TO NOME
      *----
              IF SQLCODE NOT EQUAL 100 THEN
                 EXEC CICS
                           WRITEQ TS QUEUE ('COBDB204'        )
                                     FROM  (REGISTRO          )
                                     LENGTH(LENGTH OF REGISTRO)
                 END-EXEC
      *----
                 ADD 1 TO NUM-ITENS
              END-IF
           END-PERFORM
      *----
           EXEC CICS
                     PUT CONTAINER('QTD-ITENS'        )
                         CHANNEL  (CHANNAME           )
                         FROM     (NUM-ITENS          )
                         FLENGTH  (LENGTH OF NUM-ITENS)
           END-EXEC
      *-----------------------------------------------------------------
      *---- Calcula a quantidade total de telas ------------------------
      *-----------------------------------------------------------------
           DIVIDE NUM-ITENS BY 10 GIVING NUM-TELAS REMAINDER RESTO
           IF RESTO > 0 THEN
              ADD 1 TO NUM-TELAS
           END-IF
      *----
           EXEC CICS
                     PUT CONTAINER('QTD-TELAS'        )
                         CHANNEL  (CHANNAME           )
                         FROM     (NUM-TELAS          )
                         FLENGTH  (LENGTH OF NUM-TELAS)
           END-EXEC
      *----
           EXEC CICS
                     PUT CONTAINER('TELA-ATUAL'        )
                         CHANNEL  (CHANNAME            )
                         FROM     (TELA-ATUAL          )
                         FLENGTH  (LENGTH OF TELA-ATUAL)
           END-EXEC
      *----
           PERFORM 0000-LIMPA-CAMPOS
           MOVE    NUM-ITENS  TO 0004-NUMITENSO
           MOVE    NUM-TELAS  TO 0004-PAGINATO
           MOVE    TELA-ATUAL TO 0004-PAGINAO
      *----
           MOVE    1          TO I
           MOVE    10         TO J
           PERFORM 0000-LER-TS
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      ******************************************************************
      * ROTINA PARA TRATAR REGISTRO SELECIONADO
      ******************************************************************
       0000-SEL-REGISTRO.
           COMPUTE I = (TELA-ATUAL - 1) * 10 + 1
           COMPUTE J = TELA-ATUAL * 10
           MOVE    1 TO K
           PERFORM VARYING I FROM I BY 1 UNTIL I > J
              IF 0004-SL(K) >  0   AND
                 0004-SI(K) = 'S'  THEN
                 MOVE I            TO ITEM
      *----
                 EXEC CICS
                           READQ TS QUEUE ('COBDB204'           )
                                    INTO  (R-TS(I)              )
                                    LENGTH(LENGTH OF REGISTRO-TS)
                                    ITEM  (ITEM                 )
                                    NOHANDLE
                 END-EXEC
      *----
                 EXEC CICS
                           PUT CONTAINER('MATRICULA'        )
                               FROM     (R-MATRICULA(I)     )
                               CHANNEL  (CHANNAME           )
                               FLENGTH  (LENGTH OF MATRICULA)
                 END-EXEC
      *----
                 EXEC CICS
                           START TRANSID('KDB5'  )
                                 TERMID (EIBTRMID)
                                 CHANNEL(CHANNAME)
                 END-EXEC
      *----
                 EXEC CICS
                           RETURN
                 END-EXEC
      *----
              END-IF
              ADD 1 TO K
           END-PERFORM
           MOVE    'SELECIONE UM REGISTRO.' TO 0004-MSGO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      ******************************************************************
      * ROTINA PARA LIMPAR OS CAMPOS DA TELA
      ******************************************************************
       0000-LIMPA-CAMPOS.
           EXEC CICS
                     ASSIGN USERID(0004-USUARIOO)
           END-EXEC
      *----
           EXEC CICS
                     ASKTIME ABSTIME    (W-ABS)
           END-EXEC
      *----
           EXEC CICS
                     FORMATTIME ABSTIME (W-ABS     )
                                DATESEP
                                DDMMYYYY(0004-DATAO)
                                TIME    (0004-HORAO)
                                TIMESEP
           END-EXEC
      *----
           MOVE 'COBDB204'   TO 0004-PROGRAMAO
           MOVE SPACES       TO 0004-MSGO
           IF TELA-ATUAL < NUM-TELAS THEN
              MOVE '(  +)'   TO 0004-PF7PF8O
           END-IF
           IF TELA-ATUAL < NUM-TELAS AND > 1 THEN
              MOVE '(-/+)'   TO 0004-PF7PF8O
           END-IF
           IF TELA-ATUAL = NUM-TELAS AND > 1 THEN
              MOVE '(-  )'   TO 0004-PF7PF8O
           END-IF
           IF NUM-ITENS < 10 THEN
              COMPUTE I = NUM-ITENS + 1
              PERFORM VARYING I FROM I BY 1 UNTIL I > 10
                 MOVE SPACES TO 0004-SO(I)
                 MOVE SPACES TO 0004-MATRICULAO(I)
                 MOVE SPACES TO 0004-NOMEO(I)
              END-PERFORM
              COMPUTE J = NUM-ITENS + 1
              PERFORM VARYING J FROM J BY 1 UNTIL J > 10
                 MOVE DFHBMPRO  TO 0004-SA(J)
                 MOVE DFHBMPRO  TO 0004-MATRICULAA(J)
                 MOVE DFHBMPRO  TO 0004-NOMEA(J)
              END-PERFORM
           END-IF
           .
      ******************************************************************
      * ROTINA LIMPA CAMPOS NÃO USADOS
      ******************************************************************
       0000-LIMPA-GERAL.
           EXEC CICS
                     ASSIGN USERID(0004-USUARIOO)
           END-EXEC
      *----
           EXEC CICS
                     ASKTIME ABSTIME(W-ABS)
           END-EXEC
      *----
           EXEC CICS
                     FORMATTIME ABSTIME (W-ABS     )
                                DATESEP
                                DDMMYYYY(0004-DATAO)
                                TIME    (0004-HORAO)
                                TIMESEP
           END-EXEC
      *----
           EXEC CICS
                     DELETE CONTAINER(CONTNAME)
                            CHANNEL  (CHANNAME)
                            NOHANDLE
           END-EXEC
      *----
           MOVE CHAVE-FUNCI  TO 0004-USUARIOO
           MOVE 'COBDB204'   TO 0004-PROGRAMAO
           MOVE SPACES       TO 0004-MSGO
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
              MOVE SPACES    TO 0004-SO(I)
              MOVE SPACES    TO 0004-MATRICULAO(I)
              MOVE SPACES    TO 0004-NOMEO(I)
           END-PERFORM
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > 10
              MOVE DFHBMPRO  TO 0004-SA(J)
              MOVE DFHBMPRO  TO 0004-MATRICULAA(J)
              MOVE DFHBMPRO  TO 0004-NOMEA(J)
           END-PERFORM
           .
      ******************************************************************
      * ROTINA LIMPA CAMPOS NÃO USADOS
      ******************************************************************
       0000-LIMPA.
           EXEC CICS
                     GET CONTAINER('K'        )
                         CHANNEL  (CHANNAME   )
                         INTO     (K          )
                         FLENGTH  (LENGTH OF K)
                         NOHANDLE
           END-EXEC
      *----
           COMPUTE I = K
           PERFORM VARYING I FROM I BY 1 UNTIL I > 10
              MOVE SPACES    TO 0004-SO(I)
              MOVE SPACES    TO 0004-MATRICULAO(I)
              MOVE SPACES    TO 0004-NOMEO(I)
           END-PERFORM
           COMPUTE J = K
           PERFORM VARYING J FROM J BY 1 UNTIL J > 10
              MOVE DFHBMPRO  TO 0004-SA(J)
           END-PERFORM
           .
      ******************************************************************
      * ROTINA LÊ TS
      ******************************************************************
       0000-LER-TS.
           MOVE    1 TO K
           PERFORM VARYING I FROM I BY 1 UNTIL I > J
              IF I <= NUM-ITENS THEN
                 MOVE I TO ITEM
      *----
                 EXEC CICS
                           READQ TS QNAME ('COBDB204'           )
                                    INTO  (R-TS(I)              )
                                    LENGTH(LENGTH OF REGISTRO-TS)
                                    ITEM  (ITEM                 )
                                    NOHANDLE
                 END-EXEC
      *----
                 MOVE R-MATRICULA(I) TO 0004-MATRICULAO(K)
                                        0004-MATRICULAI(K)
                 MOVE R-NOME(I)      TO 0004-NOMEO(K)
                 ADD  1 TO K
              END-IF
           END-PERFORM
      *----
           EXEC CICS
                     PUT CONTAINER('K'        )
                         CHANNEL  (CHANNAME   )
                         FROM     (K          )
                         FLENGTH  (LENGTH OF K)
           END-EXEC
      *----
           IF K < 10 THEN
              COMPUTE I = K
              PERFORM VARYING I FROM I BY 1 UNTIL I > 10
                 MOVE SPACES    TO 0004-SO(I)
                 MOVE SPACES    TO 0004-MATRICULAO(I)
                 MOVE SPACES    TO 0004-NOMEO(I)
              END-PERFORM
              COMPUTE J = K
              PERFORM VARYING J FROM J BY 1 UNTIL J > 10
                 MOVE DFHBMPRO  TO 0004-SA(J)
              END-PERFORM
           END-IF
           .
      ******************************************************************
      * ROTINA SEND MAP
      ******************************************************************
       0000-ROTINA-SEND.
           EXEC CICS
                     SEND MAP   (MAPA             )
                          MAPSET(MAPAG            )
                          FROM  (COBM004O         )
                          LENGTH(LENGTH OF COBM004O)
                          FRSET
                          NOHANDLE
           END-EXEC
           .
      ******************************************************************
      * ROTINA RECEIVE MAP
      ******************************************************************
       0000-ROTINA-RECE.
           EXEC CICS
                     RECEIVE MAP   (MAPA   )
                             MAPSET(MAPAG  )
                             INTO  (COBM004I)
                             NOHANDLE
           END-EXEC
           .
      ******************************************************************
      * ROTINA RETORNA AO MENU PRINCIPAL
      ******************************************************************
       0000-FIM.
           EXEC CICS
                     SEND CONTROL FREEKB
           END-EXEC
      *----
           EXEC CICS
                     RETURN TRANSID(EIBTRNID) CHANNEL(CHANNAME)
           END-EXEC
           .
      ******************************************************************
      * ROTINA ENCERRA O PROGRAMA
      ******************************************************************
       0000-ENCERRA.
           EXEC CICS
                     SEND CONTROL FREEKB ERASE
           END-EXEC
           EXEC CICS
                     RETURN
           END-EXEC
           .

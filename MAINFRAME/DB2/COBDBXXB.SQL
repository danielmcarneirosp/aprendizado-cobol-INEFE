      ******************************************************************
      * PROGRAMA    : COBDBXXB
      * VERSÃO      : 001
      * CRIAÇÃO     : 10/06/2021
      * PROGRAMADOR : CAZÉ
      * SISTEMA     : CIC - CICS
      * TIPO OBJETO : PROGRAMA COBOL/CICS
      * LINGUAGEM   : COBOL II
      * AMBIENTE    : ONLINE
      * FINALIDADE  : LISTA A TABELA ALUNOS
      ******************************************************************
      *
      *------------------------
       IDENTIFICATION DIVISION.
      *------------------------
      *
       PROGRAM-ID. COBDBXXB.
      *
      *---------------------
       ENVIRONMENT DIVISION.
      *---------------------
      *
      *--------------
       DATA DIVISION.
      *--------------
      *
      *------------------------
       WORKING-STORAGE SECTION.
      *------------------------
      *
       77  CTE-INICIO                     PIC  X(024) VALUE
           'COBDBXXB WSS COMECA AQUI'                                  .
       77  CTE-VERS                       PIC  X(006) VALUE 'VRS001'   .
       77  W-ABS                          PIC S9(015) COMP-3           .
       77  MAPA                           PIC  X(008) VALUE 'MAPADBB ' .
       77  MAPAG                          PIC  X(008) VALUE 'MAPSDBB ' .
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
       77  NUM-ITENS                      PIC S9(004) COMP VALUE 0     .
       77  NUM-TELAS                      PIC S9(004) COMP VALUE 0     .
       77  ITEM                           PIC S9(004) COMP VALUE 0     .
       77  TELA-ATUAL                     PIC S9(004) COMP VALUE 1     .
       77  RESTO                          PIC S9(004) COMP VALUE 0     .
       77  INICIO                         PIC S9(008) COMP VALUE ZEROS .
       77  RBA-CHAVE                      PIC S9(004) COMP VALUE 0     .
      *
       01  REGISTRO.
           03 MATRICULA                   PIC  9(009) VALUE 0          .
           03 NOME                        PIC  X(040) VALUE SPACES     .
      *
       01  REGISTRO-TS.
           03  R-TS OCCURS 1 TO 9999 DEPENDING NUM-ITENS               .
               05  R-MATRICULA            PIC  9(009)                  .
               05  R-NOME                 PIC  X(040)                  .
      *
       COPY MAPSDBB.
       COPY DFHBMSCA.
       COPY DFHAID.
      *
      *----------------------
       LOCAL-STORAGE SECTION.
      *----------------------
      *
       01  DCLALUNOS.
           10 MATRICULA-ALU        PIC S9(9) USAGE COMP.
           10 NOME-ALU             PIC X(40).
           10 SEXO-ALU             PIC X(1).
           10 NOTA01-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA02-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA03-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA04-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 NOTA05-ALU           PIC S9(2)V9(2) USAGE COMP-3.
           10 MEDIA-ALU            PIC S9(2)V9(2) USAGE COMP-3.
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
      *
            EXEC SQL DECLARE CURS-01 CURSOR FOR
                 SELECT MATRICULA_ALU, NOME_ALU FROM CAZE.ALUNOS
                        ORDER BY MATRICULA_ALU
            END-EXEC.
      *
      *-------------------
       PROCEDURE DIVISION.
      *-------------------
      *
      ******************************************************************
      * ROTINA VERIFICA SE É A PRIMEIRA VEZ QUE O PROGRAMA EXECUTA
      ******************************************************************
      *
           EXEC CICS
                     GET CONTAINER(CONTNAME      )
                         CHANNEL  (CHANNAME      )
                         INTO     (MAPA          )
                         FLENGTH  (LENGTH OF MAPA)
                         RESP     (RESP1         )
                         RESP2    (RESP2         )
           END-EXEC
      *
           IF RESP1 NOT EQUAL DFHRESP(NORMAL)
              GO TO 0000-PRIMEIRA-VEZ
           ELSE
              GO TO 0000-SEGUNDA-VEZ
           END-IF
           .
      *
      ******************************************************************
      * ROTINA EXECUTADA SE O PROGRAMA É CARREGADO PELA PRIMEIRA VEZ
      ******************************************************************
      *
       0000-PRIMEIRA-VEZ.
           EXEC CICS
                     DELETEQ TS QNAME('COBDBXXB')
                                NOHANDLE
           END-EXEC
      *
           EXEC CICS
                     DELETE CONTAINER(CONTERRO)
                            CHANNEL  (CHANNAME)
                            NOHANDLE
           END-EXEC
      *
           EXEC CICS
                     SEND CONTROL FREEKB ERASE
           END-EXEC
      *
           EXEC CICS
                     PUT CONTAINER(CONTNAME      )
                         CHANNEL  (CHANNAME      )
                         FROM     (MAPA          )
                         FLENGTH  (LENGTH OF MAPA)
           END-EXEC
      *
           GO TO   0000-MONTAR-REGISTRO
           .
      *
      ******************************************************************
      * ROTINA EXECUTADA SE O PROGRAMA É CARREGADO PELA SEGUNDA VEZ
      ******************************************************************
      *
       0000-SEGUNDA-VEZ.
           EXEC CICS
                     GET CONTAINER('QTD-ITENS'        )
                         CHANNEL  (CHANNAME           )
                         INTO     (NUM-ITENS          )
                         FLENGTH  (LENGTH OF NUM-ITENS)
                         NOHANDLE
           END-EXEC
      *
           EXEC CICS
                     GET CONTAINER('QTD-TELAS'        )
                         CHANNEL  (CHANNAME           )
                         INTO     (NUM-TELAS          )
                         FLENGTH  (LENGTH OF NUM-TELAS)
                         NOHANDLE
           END-EXEC
      *
           EXEC CICS
                     GET CONTAINER('TELA-ATUAL'        )
                         CHANNEL  (CHANNAME            )
                         INTO     (TELA-ATUAL          )
                         FLENGTH  (LENGTH OF TELA-ATUAL)
                         NOHANDLE
           END-EXEC
      *
           PERFORM   0000-ROTINA-RECE
           EVALUATE  EIBAID
               WHEN  DFHENTER
                     GO         TO   0000-SEL-REGISTRO
               WHEN  DFHPF3
                     GO         TO   0000-ENCERRA
               WHEN  DFHPF7
                     SUBTRACT 1 FROM TELA-ATUAL
                     GO         TO   0000-RETORNA
               WHEN  DFHPF8
                     ADD 1      TO   TELA-ATUAL
                     GO         TO   0000-AVANCA
               WHEN  DFHPF10
                     EXEC CICS
                               START TRANSID('IDBA')
                                     TERMID (EIBTRMID)
                     END-EXEC
      *
                     EXEC CICS
                               RETURN
                     END-EXEC
               WHEN  OTHER
                     PERFORM 0000-LIMPA
                     MOVE    'Tecla de função não disponível.'
                             TO DBB-MSGO
                     PERFORM 0000-ROTINA-SEND
                     GO TO   0000-FIM
           END-EVALUATE
           .
      *
      ******************************************************************
      * ROTINA RETORNA TELA PF7
      ******************************************************************
      *
       0000-RETORNA.
           IF TELA-ATUAL = 0 THEN
              PERFORM 0000-LIMPA
              MOVE    'Primeira tela.' TO DBB-MSGO
              MOVE    1                TO TELA-ATUAL
           ELSE
              PERFORM 0000-LIMPA-CAMPOS
              COMPUTE I = (TELA-ATUAL - 1) * 10 + 1
              COMPUTE J = TELA-ATUAL * 10
              PERFORM 0000-LER-TS
      *
              EXEC CICS
                        PUT CONTAINER('TELA-ATUAL'        )
                            CHANNEL  (CHANNAME            )
                            FROM     (TELA-ATUAL          )
                            FLENGTH  (LENGTH OF TELA-ATUAL)
              END-EXEC
      *
           END-IF
           MOVE    TELA-ATUAL TO DBB-PAGINAO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      *
      ******************************************************************
      * ROTINA AVANCA TELA PF8
      ******************************************************************
      *
       0000-AVANCA.
           IF TELA-ATUAL > NUM-TELAS THEN
              PERFORM 0000-LIMPA
              MOVE    'Última tela.' TO DBB-MSGO
              MOVE    NUM-TELAS      TO TELA-ATUAL
           ELSE
              PERFORM 0000-LIMPA-CAMPOS
              COMPUTE I = (TELA-ATUAL - 1) * 10 + 1
              COMPUTE J = TELA-ATUAL * 10
              PERFORM 0000-LER-TS
      *
              EXEC CICS
                        PUT CONTAINER('TELA-ATUAL'        )
                            CHANNEL  (CHANNAME            )
                            FROM     (TELA-ATUAL          )
                            FLENGTH  (LENGTH OF TELA-ATUAL)
              END-EXEC
      *
           END-IF
           MOVE    TELA-ATUAL TO DBB-PAGINAO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      *
      ******************************************************************
      * ROTINA LE REGISTROS E GRAVA TS
      ******************************************************************
      *
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
      *
                 EXEC CICS
                           WRITEQ TS QUEUE ('COBDBXXB'        )
                                     FROM  (REGISTRO          )
                                     LENGTH(LENGTH OF REGISTRO)
                 END-EXEC
      *
                 ADD 1 TO NUM-ITENS
              END-IF
           END-PERFORM
      *
           EXEC CICS
                     PUT CONTAINER('QTD-ITENS'        )
                         CHANNEL  (CHANNAME           )
                         FROM     (NUM-ITENS          )
                         FLENGTH  (LENGTH OF NUM-ITENS)
           END-EXEC
      *
      *-----------------------------------------------------------------
      *     Calcula a quantidade total de telas
      *-----------------------------------------------------------------
      *
           DIVIDE NUM-ITENS BY 10 GIVING NUM-TELAS REMAINDER RESTO
           IF RESTO > 0 THEN
              ADD 1 TO NUM-TELAS
           END-IF
      *
           EXEC CICS
                     PUT CONTAINER('QTD-TELAS'        )
                         CHANNEL  (CHANNAME           )
                         FROM     (NUM-TELAS          )
                         FLENGTH  (LENGTH OF NUM-TELAS)
           END-EXEC
      *
           EXEC CICS
                     PUT CONTAINER('TELA-ATUAL'        )
                         CHANNEL  (CHANNAME            )
                         FROM     (TELA-ATUAL          )
                         FLENGTH  (LENGTH OF TELA-ATUAL)
           END-EXEC
      *
           PERFORM 0000-LIMPA-CAMPOS
           MOVE    NUM-ITENS  TO DBB-NUMITENSO
           MOVE    NUM-TELAS  TO DBB-PAGINATO
           MOVE    TELA-ATUAL TO DBB-PAGINAO
           MOVE    1          TO I
           MOVE    10         TO J
           PERFORM 0000-LER-TS
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      *
      ******************************************************************
      * ROTINA PARA TRATAR REGISTRO SELECIONADO
      ******************************************************************
      *
       0000-SEL-REGISTRO.
           COMPUTE I = (TELA-ATUAL - 1) * 10 + 1
           COMPUTE J = TELA-ATUAL * 10
           MOVE    1 TO K
           PERFORM VARYING I FROM I BY 1 UNTIL I > J
              IF DBB-SL(K) >   0   AND
                 DBB-SI(K) = 'S'   THEN
                 MOVE I            TO ITEM
      *
                 EXEC CICS
                           READQ TS QUEUE ('COBDBXXB'           )
                                    INTO  (R-TS(I)              )
                                    LENGTH(LENGTH OF REGISTRO-TS)
                                    ITEM  (ITEM                 )
                                    NOHANDLE
                 END-EXEC
      *
                 EXEC CICS
                           PUT CONTAINER('MATRICULA'             )
                               FROM     (R-MATRICULA(I)          )
                               CHANNEL  (CHANNAME                )
                               FLENGTH  (LENGTH OF R-MATRICULA(I))
                 END-EXEC
      *
                 EXEC CICS
                           START TRANSID('IDBC'  )
                                 TERMID (EIBTRMID)
                                 CHANNEL(CHANNAME)
                 END-EXEC
      *
                 EXEC CICS
                           RETURN
                 END-EXEC
      *
              END-IF
              ADD 1 TO K
           END-PERFORM
      *
           IF NUM-ITENS < 10 THEN
              COMPUTE I = NUM-ITENS + 1
              PERFORM VARYING I FROM I BY 1 UNTIL I > 10
                 MOVE SPACES TO DBB-SO(I)
                 MOVE SPACES TO DBB-MATRICULAO(I)
                 MOVE SPACES TO DBB-NOMEO(I)
              END-PERFORM
              COMPUTE J = NUM-ITENS + 1
              PERFORM VARYING J FROM J BY 1 UNTIL J > 10
                 MOVE DFHBMPRO  TO DBB-SA(J)
                 MOVE DFHBMPRO  TO DBB-MATRICULAA(J)
                 MOVE DFHBMPRO  TO DBB-NOMEA(J)
              END-PERFORM
           END-IF
      *
           MOVE    'SELECIONE UM REGISTRO.' TO DBB-MSGO
           PERFORM 0000-ROTINA-SEND
           GO TO   0000-FIM
           .
      *
      ******************************************************************
      * ROTINA PARA LIMPAR OS CAMPOS DA TELA
      ******************************************************************
      *
       0000-LIMPA-CAMPOS.
           EXEC CICS
                     ASSIGN USERID(DBB-USUARIOO)
           END-EXEC
      *
           EXEC CICS
                     ASKTIME ABSTIME    (W-ABS)
           END-EXEC
      *
           EXEC CICS
                     FORMATTIME ABSTIME (W-ABS     )
                                DATESEP
                                DDMMYYYY(DBB-DATAO)
                                TIME    (DBB-HORAO)
                                TIMESEP
           END-EXEC
      *
           MOVE 'COBDBXXB'   TO DBB-PROGRAMAO
           MOVE SPACES       TO DBB-MSGO
           IF TELA-ATUAL < NUM-TELAS THEN
              MOVE '(  +)'   TO DBB-PF7PF8O
           END-IF
           IF TELA-ATUAL < NUM-TELAS AND > 1 THEN
              MOVE '(-/+)'   TO DBB-PF7PF8O
           END-IF
           IF TELA-ATUAL = NUM-TELAS AND > 1 THEN
              MOVE '(-  )'   TO DBB-PF7PF8O
           END-IF
           IF NUM-ITENS < 10 THEN
              COMPUTE I = NUM-ITENS + 1
              PERFORM VARYING I FROM I BY 1 UNTIL I > 10
                 MOVE SPACES TO DBB-SO(I)
                 MOVE SPACES TO DBB-MATRICULAO(I)
                 MOVE SPACES TO DBB-NOMEO(I)
              END-PERFORM
              COMPUTE J = NUM-ITENS + 1
              PERFORM VARYING J FROM J BY 1 UNTIL J > 10
                 MOVE DFHBMPRO  TO DBB-SA(J)
                 MOVE DFHBMPRO  TO DBB-MATRICULAA(J)
                 MOVE DFHBMPRO  TO DBB-NOMEA(J)
              END-PERFORM
           END-IF
           .
      *
      ******************************************************************
      * ROTINA LIMPA CAMPOS NÃO USADOS
      ******************************************************************
      *
       0000-LIMPA.
           EXEC CICS
                     GET CONTAINER('K'        )
                         CHANNEL  (CHANNAME   )
                         INTO     (K          )
                         FLENGTH  (LENGTH OF K)
                         NOHANDLE
           END-EXEC
      *
           PERFORM VARYING I FROM K BY 1 UNTIL I > 10
              MOVE SPACES    TO DBB-SO(I)
              MOVE SPACES    TO DBB-MATRICULAO(I)
              MOVE SPACES    TO DBB-NOMEO(I)
           END-PERFORM
           PERFORM VARYING J FROM K BY 1 UNTIL J > 10
              MOVE DFHBMPRO  TO DBB-SA(J)
           END-PERFORM
           .
      *
      ******************************************************************
      * ROTINA LÊ TS
      ******************************************************************
      *
       0000-LER-TS.
           MOVE    1 TO K
           PERFORM VARYING I FROM I BY 1 UNTIL I > J
              IF I <= NUM-ITENS THEN
                 MOVE I TO ITEM
      *
                 EXEC CICS
                           READQ TS QNAME ('COBDBXXB'           )
                                    INTO  (R-TS(I)              )
                                    LENGTH(LENGTH OF REGISTRO-TS)
                                    ITEM  (ITEM                 )
                                    NOHANDLE
                 END-EXEC
      *
                 MOVE R-MATRICULA(I) TO DBB-MATRICULAO(K)
                                        DBB-MATRICULAI(K)
                 MOVE R-NOME(I)      TO DBB-NOMEO(K)
                 ADD  1 TO K
              END-IF
           END-PERFORM
      *
           EXEC CICS
                     PUT CONTAINER('K'        )
                         CHANNEL  (CHANNAME   )
                         FROM     (K          )
                         FLENGTH  (LENGTH OF K)
           END-EXEC
      *
           IF K < 10 THEN
              PERFORM VARYING I FROM K BY 1 UNTIL I > 10
                 MOVE SPACES    TO DBB-SO(I)
                 MOVE SPACES    TO DBB-MATRICULAO(I)
                 MOVE SPACES    TO DBB-NOMEO(I)
              END-PERFORM
              PERFORM VARYING J FROM K BY 1 UNTIL J > 10
                 MOVE DFHBMPRO  TO DBB-SA(J)
              END-PERFORM
           END-IF
           .
      *
      ******************************************************************
      * ROTINA SEND MAP
      ******************************************************************
      *
       0000-ROTINA-SEND.
           MOVE 1 TO I
           PERFORM UNTIL I > 10
              MOVE SPACES TO DBB-SO(I)
              ADD 1 TO I
           END-PERFORM
      *
           EXEC CICS
                     SEND MAP   (MAPA             )
                          MAPSET(MAPAG            )
                          FROM  (MAPADBBO         )
                          LENGTH(LENGTH OF MAPADBBO)
                          NOHANDLE
           END-EXEC
           .
      *
      ******************************************************************
      * ROTINA RECEIVE MAP
      ******************************************************************
      *
       0000-ROTINA-RECE.
           EXEC CICS
                     RECEIVE MAP   (MAPA   )
                             MAPSET(MAPAG  )
                             INTO  (MAPADBBI)
                             NOHANDLE
           END-EXEC
           .
      *
      ******************************************************************
      * ROTINA RETORNA AO MENU PRINCIPAL
      ******************************************************************
      *
       0000-FIM.
           EXEC CICS
                     SEND CONTROL FREEKB
           END-EXEC
      *
           EXEC CICS
                     RETURN TRANSID(EIBTRNID) CHANNEL(CHANNAME)
           END-EXEC
           .
      *
      ******************************************************************
      * ROTINA ENCERRA O PROGRAMA
      ******************************************************************
      *
       0000-ENCERRA.
           EXEC CICS
                     DELETEQ TS QUEUE('COBDBXXB')
           END-EXEC
      *
           EXEC CICS
                     SEND CONTROL FREEKB ERASE
           END-EXEC
      *
           EXEC CICS
                     RETURN
           END-EXEC
           .

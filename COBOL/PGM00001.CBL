       IDENTIFICATION DIVISION.
       PROGRAM-ID. PGM00001.
      *-----------------------------------------------
      * PROGRAMA: COBOL02
      ***
      * EXEMPLO DE VALIDACAO E MENSAGENS DE ERRO
      ***
      * FUNÁ„O : RECEBER DOIS N˙MEROS E UMA OPERAÁ„O
      *           (1=SOMA, 2=SUBTRAÁ„O, 3=MULTIPLICAÁ„O, 4=DIVIS„O)
      *           E APRESENTAR O RESULTADO.
      *-----------------------------------------------
      *
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 NUM1         PIC 9(5)V99 VALUE 0.
       77 NUM2         PIC 9(5)V99 VALUE 0.
       77 OPERACAO     PIC 9 VALUE 0.
       77 RESULTADO    PIC S9(7)V99 VALUE 0.
       77 WSS-OUTPUT   PIC ZBZZZBZZ9V,99+.
       77 MSG-OPCAO    PIC X(20) VALUE SPACES.
       77 WSS-ERRO     PIC A(30) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "======================================="
           DISPLAY "     COBOL02DORA COBOL                "
           DISPLAY "======================================="
      *
      *--- LEITURA DOS DADOS VIA SYSIN ---
           ACCEPT NUM1
           ACCEPT NUM2
           ACCEPT OPERACAO
      *
      ***  VALIDANDO PARAMETRO

           IF OPERACAO NOT NUMERIC
             MOVE  10       TO RETURN-CODE
             MOVE 'OPERACAO NAO PREVISTA'  TO WSS-ERRO
             PERFORM ROT-ABEND
           END-IF.

           IF NUM1 NOT NUMERIC
             MOVE  11       TO RETURN-CODE
             MOVE 'OPERANDO 1 INVALIDO  '  TO WSS-ERRO
             PERFORM ROT-ABEND
           END-IF.

           IF NUM2 NOT NUMERIC
             MOVE 'OPERANDO 2 INVALIDO  '  TO WSS-ERRO
             MOVE  12       TO RETURN-CODE
             PERFORM ROT-ABEND
           END-IF.

           IF OPERACAO < 1 OR OPERACAO > 4
             MOVE 'OPERACAO INVALIDA  '  TO WSS-ERRO
             MOVE  99       TO RETURN-CODE
             PERFORM ROT-ABEND
           END-IF.

           PERFORM ROT-PARAM.

      *
           EVALUATE OPERACAO
              WHEN 1
                 COMPUTE RESULTADO = NUM1 + NUM2
                 MOVE "SOMA" TO MSG-OPCAO
              WHEN 2
                 COMPUTE RESULTADO = NUM1 - NUM2
                 MOVE "SUBTRACAO" TO MSG-OPCAO
              WHEN 3
                 COMPUTE RESULTADO = NUM1 * NUM2
                 MOVE "MULTIPLICACAO" TO MSG-OPCAO
              WHEN 4
                 IF NUM2 = 0 THEN
                    DISPLAY "ERRO: DIVISAO POR ZERO NAO PERMITIDA."
                    STOP RUN
                 END-IF
                 COMPUTE RESULTADO = NUM1 / NUM2
                 MOVE "DIVISAO" TO MSG-OPCAO
              WHEN OTHER
                 DISPLAY "OPCAO INVALIDA."
                 STOP RUN
           END-EVALUATE
      *
           DISPLAY "---------------------------------------"
           DISPLAY "OPERACAO: " MSG-OPCAO
           MOVE RESULTADO TO  WSS-OUTPUT
           DISPLAY "RESULTADO: " WSS-OUTPUT
           DISPLAY "---------------------------------------"
           STOP RUN.

       ROT-PARAM.

           DISPLAY ' '.
           DISPLAY ' PARAMETROS RECEBIDOS NESTE PROCESSO '.
           DISPLAY ' OPERACAO : ' OPERACAO.
           DISPLAY ' NUM1     : ' NUM1.
           DISPLAY ' NUM2     : ' NUM2.
           DISPLAY ' '.
           DISPLAY ' '.

       ROT-ABEND.
           DISPLAY ' '
           DISPLAY '***************************************'
           DISPLAY '*** ERRO NOS PARAMETROS DE CALCULO  ***'
           DISPLAY '***************************************'
           PERFORM ROT-PARAM
           DISPLAY '*** ABEND CODE : ' RETURN-CODE.
           DISPLAY '*** MENSAGEM DE ERRO : ' WSS-ERRO.

           STOP RUN.

111111*AAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

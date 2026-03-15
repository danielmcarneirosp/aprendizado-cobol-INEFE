************************************************************************
*******  ESTE COPY BOOK CONTEM COMANDOS DA PROCEDURE DIVISION        ***
*******  ROTINA DE ABEND SAIDA CONTROLADA                            ***
************************************************************************
       ROT-ABEND.
           DISPLAY '*******************************************'.
           DISPLAY ' ABEND PROGRAMADO '.
           DISPLAY ' ERRO ENCONTRADO : '  RETURN-CODE.
           DISPLAY ' FAVOR AVISAR O ANALISTA RESPONSAVEL'.
           DISPLAY '*******************************************'.

           IF RETURN-CODE = 0
             MOVE 999 TO RETURN-CODE
           END-IF.

           STOP RUN.

       ROT-ABEND-EXIT.
           EXIT.
**************************** FIM DO COPYBOOK ***************************

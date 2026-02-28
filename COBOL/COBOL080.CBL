      *****************************************************************
      * DATA     :  17/06/2023
      * AUTOR    : VAGNER RENATO BELLACOSA
      * OBJETIVO : EXEMPLO CALL CPF
      * CPD      : INEFE
      *****************************************************************
       IDENTIFICATION DIVISION.
      *************************
       PROGRAM-ID. COBOL080.
       AUTHOR. VAGNER BELLACOSA.
       DATE-WRITTEN. 17/06/23 @ 21:05:00.
       DATE-COMPILED. 2023-06-17.
       INSTALLATION. INEFE.
       SECURITY. NORMAL.

      **********************
       ENVIRONMENT DIVISION.
      **********************
      ***************
       DATA DIVISION.
      ***************
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       01 WSS-NUMB        PIC 9(4) VALUE 10.
       01 WSS-FACT        PIC 9(8) VALUE 0.
       01 WSS-DATA-COMPIL PIC X(16).
      *
       01 WSS-SUBPROGRAMA PIC X(08) VALUE 'COBOL075'.
      *
       LOCAL-STORAGE SECTION.
      *
       01 WSS-NUM         PIC 9(4).
      *
       COPY COPY0651.
      *
       LINKAGE  SECTION.
      *
       01  LKS-PARAM-IBM.
           05  LKS-PARAM-TAM           PIC S9(4) COMP.
           05  LKS-PARAM-CPF           PIC 9(11).
      *
      ****************************************
       PROCEDURE DIVISION USING LKS-PARAM-IBM.
      *****************************************

       MAIN-SECTION          SECTION.

           PERFORM DISPLAY-INICIAL.

           PERFORM LIMPA-AREA.

           PERFORM ROT-VALIDA-PARM
              THRU ROT-VALIDA-PARM-EXIT.

           PERFORM VALIDAR-CPF.

           STOP RUN.

      *----------------------------------------------------------------*
      *--- PARAGRAFOS        ------------------------------------------*
      *----------------------------------------------------------------*
       AREA-TRABALHO               SECTION.

       DISPLAY-INICIAL.

           MOVE  FUNCTION WHEN-COMPILED  TO WSS-DATA-COMPIL.

           DISPLAY 'COBOL080'.
           DISPLAY 'EXEMPLO DE PROGRAMA INDO E VOLTANDO'.
           DISPLAY 'RECEBENDO PARAMETRO VIA JCL        '.
           DISPLAY ' WSS-DATA-COMPIL = ' WSS-DATA-COMPIL.
           DISPLAY ' '.

       LIMPA-AREA.

           DISPLAY WSS-CPF-LINKAGE.

           INITIALIZE  WSS-CPF-LINKAGE
             REPLACING ALPHABETIC DATA BY SPACES
           INITIALIZE  WSS-CPF-LINKAGE
             REPLACING NUMERIC    DATA BY ZEROES.
           INITIALIZE  WSS-RETURN-CODE
             REPLACING NUMERIC    DATA BY ZEROES.
           INITIALIZE  WSS-CPF-GERADO
             REPLACING NUMERIC    DATA BY ZEROES.
           INITIALIZE  WSS-CPF-OUTPUT
             REPLACING NUMERIC    DATA BY ZEROES.
           INITIALIZE  WSS-MENSAGEM
             REPLACING ALPHABETIC DATA BY SPACES

           DISPLAY WSS-CPF-LINKAGE.

       ROT-VALIDA-PARM.

           DISPLAY ' '.
           DISPLAY ' ROT-VALIDA-PARM'.
           DISPLAY ' '.

           IF LKS-PARAM-TAM < 11
            MOVE  110      TO RETURN-CODE
            INITIALIZE  LKS-PARAM-CPF
               REPLACING NUMERIC    DATA BY ZEROES
            DISPLAY ' LKS-PARAM-TAM = ' LKS-PARAM-TAM
            DISPLAY ' LKS-PARAM-CPF = ' LKS-PARAM-CPF
            DISPLAY ' CPF VALOR INVALIDO MENOR QUE 11 BYTES'
            PERFORM ROTINA-ABEND
           END-IF.

           IF LKS-PARAM-TAM > 11
            MOVE  120      TO RETURN-CODE
            DISPLAY ' LKS-PARAM-TAM = ' LKS-PARAM-TAM
            DISPLAY ' LKS-PARAM-CPF = ' LKS-PARAM-CPF
            DISPLAY ' CPF VALOR INVALIDO MAIOR QUE 11 BYTES'
            PERFORM ROTINA-ABEND
           END-IF.

           IF NOT LKS-PARAM-CPF IS NUMERIC
            MOVE  130      TO RETURN-CODE
            DISPLAY ' LKS-PARAM-TAM = ' LKS-PARAM-TAM
            DISPLAY ' LKS-PARAM-CPF = ' LKS-PARAM-CPF
            DISPLAY ' CPF NAO NUMERICO '
            PERFORM ROTINA-ABEND
           END-IF.

           IF LKS-PARAM-CPF EQUAL ZEROES OR
              LKS-PARAM-CPF EQUAL 99999999999
            MOVE  140      TO RETURN-CODE
            DISPLAY ' LKS-PARAM-TAM = ' LKS-PARAM-TAM
            DISPLAY ' LKS-PARAM-CPF = ' LKS-PARAM-CPF
            DISPLAY ' CPF INVALIDO'
            PERFORM ROTINA-ABEND
           END-IF.

       ROT-VALIDA-PARM-EXIT.
           EXIT.

       VALIDAR-CPF.

           MOVE LKS-PARAM-CPF         TO  WSS-CPF-REC.

           DISPLAY ' '.
           DISPLAY ' INDO     '.
           DISPLAY 'WSS-CPF-REC    = ' WSS-CPF-REC.
           DISPLAY 'WSS-CPF-GERADO = ' WSS-CPF-GERADO.
           DISPLAY ' '.

    ****
    ****   CHAMADA DINAMICA DO SUBPROGRAMA

           CALL WSS-SUBPROGRAMA  USING WSS-CPF-LINKAGE.

           IF WSS-RETURN-CODE NOT EQUAL ZEROES
              MOVE WSS-RETURN-CODE   TO RETURN-CODE
              DISPLAY 'CODIGO DO ERRO   : ' WSS-RETURN-CODE
              DISPLAY 'MENSAGEM DE ERRO : ' WSS-MENSAGEM
              DISPLAY 'WSS-CPF-GERADO   : ' WSS-CPF-GERADO
              PERFORM ROTINA-ABEND
           END-IF.

           DISPLAY ' '.
           DISPLAY ' VOLTANDO DO SUB-PROGRAMA'.
           DISPLAY ' '.
           DISPLAY 'WSS-CPF-REC    = ' WSS-CPF-REC.
           DISPLAY 'WSS-CPF-GERADO = ' WSS-CPF-GERADO.

       ROTINA-ABEND.
           DISPLAY ' '.
           DISPLAY '************************************************'.
           DISPLAY '** ABEND ABEND ABEND ABEND ABEND ABEND ABEND ***'.
           DISPLAY '************************************************'.
           DISPLAY 'CODIGO DO ERRO   : ' WSS-RETURN-CODE
           DISPLAY 'MENSAGEM DE ERRO : ' WSS-MENSAGEM
           DISPLAY 'WSS-CPF-GERADO   : ' WSS-CPF-GERADO
           DISPLAY ' '.

           STOP RUN.

       END PROGRAM COBOL080.
      ********************** FIM PROGRAMA   ****************************

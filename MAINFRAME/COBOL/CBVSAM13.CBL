000100************************************************************      00010008
000200* DATA     :  15/07/2025                                          00020008
000300* AUTOR    : VAGNER RENATO BELLACOSA                              00030008
000400* OBJETIVO : PROGRAMA EXEMPLO VSAM KSDS                           00040008
000500*            GRAVA REGISTRO POR CHAVE RECEBIDO VIA SYSIN          00050008
000600*            EM QUALQUER POSICAO                                  00060008
000700* CPD      : INEFE                                                00070008
000800************************************************************      00080008
000900 IDENTIFICATION DIVISION.                                         00090008
001000*************************                                         00100008
001100 PROGRAM-ID. CBVSAM13.                                            00110008
001200 AUTHOR. VAGNER BELLACOSA.                                        00120008
001300 DATE-WRITTEN. 15/07/25 @ 22:50:00.                               00130008
001400 DATE-COMPILED. 2025-07-15.                                       00140008
       INSTALLATION. INEFE.
       SECURITY. NORMAL.
001500                                                                  00150008
001600**********************                                            00160008
001700 ENVIRONMENT DIVISION.                                            00170008
001800**********************                                            00180008
001900 INPUT-OUTPUT SECTION.                                            00190008
002000*                                                                 00200008
002100 FILE-CONTROL.                                                    00210008
002200     SELECT ALUFILE ASSIGN TO ALUFILE                             00220008
002300     ORGANIZATION IS INDEXED                                      00230008
002500     ACCESS MODE  IS DYNAMIC                                      00250008
002600     FILE STATUS  IS FILE-STATUS  VSAM-CODE                       00260008
002700     RECORD KEY   IS FS-MATRICULA.                                00270009
002800*                                                                 00280008
002900***************                                                   00290008
003000 DATA DIVISION.                                                   00300008
003100***************                                                   00310008
003200*                                                                 00320008
003300 FILE SECTION.                                                    00330008
003400*                                                                 00340008
003500 FD ALUFILE                                                       00350008
003600     RECORD CONTAINS 80  CHARACTERS                               00360008
003700     BLOCK  CONTAINS 800 CHARACTERS                               00370008
003800     DATA RECORD     IS ALUFILE-RECORD.                           00380008
003900*                                                                 00390008
004000 01 ALUFILE-RECORD.                                               00400008
004100   05 FS-MATRICULA            PIC  9(11).                         00410009
004200   05 FS-NOME                 PIC  X(40).                         00420009
004300   05 FS-SEXO                 PIC  X(01).                         00430009
004400   05 FS-NOTA01               PIC  9(04).                         00440009
004500   05 FS-NOTA02               PIC  9(04).                         00450009
004510   05 FS-NOTA03               PIC  9(04).                         00451009
004520   05 FS-NOTA04               PIC  9(04).                         00452009
004530   05 FS-NOTA05               PIC  9(04).                         00453009
004540   05 FS-MEDIA                PIC  9(04).                         00454009
004600*                                                                 00460008
004700 WORKING-STORAGE SECTION.                                         00470008
004800*                                                                 00480008
004900 01 WS-VAR.                                                       00490008
005000    05 FILE-STATUS PIC 9(02).                                     00500008
005100    05 WSS-EOF-SW    PIC X(01).                                   00510008
005200       88 WSS-EOF              VALUE 'S'.                         00520008
005300       88 WS-NOT-EOF           VALUE 'N'.                         00530008
005400    05 VSAM-CODE.                                                 00540008
005500       10 VSAM-RETURN-CODE      PIC S9(2) USAGE BINARY.           00550008
005600       10 VSAM-COMPONENT-CODE   PIC S9(1) USAGE BINARY.           00560008
005700       10 VSAM-REASON-CODE      PIC S9(3) USAGE BINARY.           00570008
005800*                                                                 00580008
005900 77  WSS-MESSAGE               PIC X(99).                         00590008
006000 77  WSS-REG-GRAVADOS          PIC 9(10).                         00600008
006100 77  WSS-DATA-COMPIL           PIC X(16).                         00610008
006200*                                                                 00620008
006300********************                                              00630008
006400 PROCEDURE DIVISION.                                              00640008
006500********************                                              00650008
006600                                                                  00660008
006700     DISPLAY 'CBVSAM13'.                                          00670008
006800     DISPLAY 'GRAVA REGISTRO VSAM KSDS SEQUENCIAL'.               00680008
006900                                                                  00690008
007000     MOVE  FUNCTION WHEN-COMPILED  TO WSS-DATA-COMPIL.            00700008
007100                                                                  00710008
007200     DISPLAY ' WSS-DATA-COMPIL = ' WSS-DATA-COMPIL.               00720008
007300     DISPLAY ' '.                                                 00730008
007400                                                                  00740008
007500     PERFORM ROT-OPEN-FILE                                        00750008
007600        THRU ROT-OPEN-FILE-EXIT.                                  00760008
007700                                                                  00770008
007800     PERFORM ROT-RECEBE-SYSIN                                     00780008
007900        THRU ROT-RECEBE-SYSIN-EXIT.                               00790008
008000                                                                  00800008
008100     PERFORM ROT-CLOSE-FILE                                       00810008
008200        THRU ROT-CLOSE-FILE-EXIT.                                 00820008
008300                                                                  00830008
008400     PERFORM ROT-ESTATISTIC                                       00840008
008500        THRU ROT-ESTATISTIC-EXIT.                                 00850008
008600                                                                  00860008
008601     STOP RUN.                                                    00860109
008610                                                                  00861009
008700************************************************************      00870008
008800* SECAO TRATA ARQUIVOS *************************************      00880008
008900************************************************************      00890008
009000 ROT-OPEN-FILE.                                                   00900008
009100                                                                  00910008
009200     DISPLAY 'ROT-OPEN-FILE'.                                     00920008
009300                                                                  00930008
009400*    OPEN INPUT ALUFILE.                                          00940008
009500*    OPEN OUTPUT  ALUFILE.                                        00950008
009600     OPEN I-O     ALUFILE.                                        00960008
009700                                                                  00970008
009800     IF FILE-STATUS > 0                                           00980008
009900        MOVE 'ERRO NA ABERTURA DO ARQUIVO ALUFILE '               00990008
010000             TO WSS-MESSAGE                                       01000008
010100        MOVE FILE-STATUS  TO  RETURN-CODE                         01010008
010200        PERFORM ROT-ABEND                                         01020008
010300     END-IF.                                                      01030008
010400                                                                  01040008
010500 ROT-OPEN-FILE-EXIT.                                              01050008
010600     EXIT.                                                        01060008
010700                                                                  01070008
010800 ROT-RECEBE-SYSIN.                                                01080008
010900                                                                  01090008
011000     DISPLAY 'ROT-RECEBE-SYSIN'.                                  01100008
011100                                                                  01110008
011200     INITIALIZE ALUFILE-RECORD                                    01120008
011300                                                                  01130008
011400* RECEBER TODOS OS PARAMETROS DA SYSIN                            01140008
011500     ACCEPT FS-MATRICULA                                          01150009
011700     ACCEPT FS-NOME                                               01170009
011810     ACCEPT FS-SEXO                                               01181009
011820     ACCEPT FS-NOTA01                                             01182009
011830     ACCEPT FS-NOTA02                                             01183009
011840     ACCEPT FS-NOTA03                                             01184009
011850     ACCEPT FS-NOTA04                                             01185009
011860     ACCEPT FS-NOTA05                                             01186009
011870     ACCEPT FS-MEDIA                                              01187009
011900                                                                  01190008
           IF FS-MATRICULA NOT NUMERIC
             DISPLAY 'FS-MATRICULA  = ' FS-MATRICULA
             MOVE    "INFORMADO NAO NUMERICO"
                  TO WSS-MESSAGE
             MOVE 301          TO  RETURN-CODE
             PERFORM ROT-ABEND
           END-IF.

           IF FS-MATRICULA EQUAL ZEROES
             DISPLAY 'FS-MATRICULA  = ' FS-MATRICULA
             MOVE    "ZERADO                "
                  TO WSS-MESSAGE
             MOVE 302          TO  RETURN-CODE
             PERFORM ROT-ABEND
           END-IF.

012000     DISPLAY FS-MATRICULA      ' - '                              01200009
012100             FS-NOME           ' - '                              01210009
012200             FS-SEXO           ' - '                              01220009
012300             FS-NOTA01         ' - '                              01230009
012310             FS-NOTA02         ' - '                              01231009
012320             FS-NOTA03         ' - '                              01232009
012330             FS-NOTA04         ' - '                              01233009
012340             FS-NOTA05         ' - '                              01234009
012350             FS-MEDIA          ' - '                              01235009
012400                                                                  01240008
012500     PERFORM ROT-WRITE-FILE                                       01250008
012600        THRU ROT-WRITE-FILE-EXIT.                                 01260008
012700                                                                  01270008
012800 ROT-RECEBE-SYSIN-EXIT.                                           01280008
012900     EXIT.                                                        01290008
013000                                                                  01300008
013100 ROT-WRITE-FILE.                                                  01310008
013200* GRAVA O REGISTRO NO ARQUIVO                                     01320008
013300                                                                  01330008
013400     DISPLAY 'ROT-WRITE-FILE'.                                    01340008
013500                                                                  01350008
013600     INITIALIZE  WSS-REG-GRAVADOS.                                01360008
013700                                                                  01370008
013800     DISPLAY ALUFILE-RECORD.                                      01380008
013900                                                                  01390008
014000     WRITE ALUFILE-RECORD.                                        01400008
014100                                                                  01410008
014200     IF FILE-STATUS EQUAL ZEROES                                  01420008
014300        DISPLAY 'REGISTRO INSERIDO COM SUCESSO'                   01430008
014400        ADD  01      TO    WSS-REG-GRAVADOS                       01440008
014500     ELSE                                                         01450008
014600        MOVE    "RECORD INSERTION FAILED"                         01460008
014700           TO WSS-MESSAGE                                         01470008
014800       MOVE FILE-STATUS  TO  RETURN-CODE                          01480008
014900       PERFORM ROT-ABEND                                          01490008
015000     END-IF.                                                      01500008
015010                                                                  01501008
015100 ROT-WRITE-FILE-EXIT.                                             01510008
016700     EXIT.                                                        01670008
016710                                                                  01671008
016720 ROT-CLOSE-FILE.                                                  01672008
016730                                                                  01673008
016740      DISPLAY 'ROT-CLOSE-FILE'.                                   01674008
016750                                                                  01675008
016760      CLOSE ALUFILE.                                              01676008
016770                                                                  01677008
016780      IF FILE-STATUS > 0                                          01678008
016790         MOVE 'ERRO NO FECHAMENTO DO ARQUIVO ALUFILE '            01679008
016791           TO WSS-MESSAGE                                         01679108
016792       MOVE FILE-STATUS  TO  RETURN-CODE                          01679208
016793       PERFORM ROT-ABEND                                          01679308
016794     END-IF.                                                      01679408
016795 ROT-CLOSE-FILE-EXIT.                                             01679508
016796     EXIT.                                                        01679608
016797                                                                  01679708
016798 ROT-ESTATISTIC.                                                  01679808
016799                                                                  01679908
016800     DISPLAY ' '.                                                 01680008
016801     DISPLAY '*******************************************'.       01680108
016802     DISPLAY '*** PROGRAMA CBVSAM13                   ***'.       01680208
016803     DISPLAY '*******************************************'.       01680308
016804     DISPLAY '* TERMINO DE PROCESSAMENTO: OK            *'.       01680408
016805     DISPLAY '* REGISTROS GRAVADOS     : '                        01680508
016806                WSS-REG-GRAVADOS.                                 01680608
016807     DISPLAY '*******************************************'.       01680708
016808                                                                  01680808
016809 ROT-ESTATISTIC-EXIT.                                             01680908
016810     EXIT.                                                        01681008
016811                                                                  01681109
016812 ROT-ABEND.                                                       01681208
016813                                                                  01681308
016814     DISPLAY ' '.                                                 01681408
016815     DISPLAY '*******************************************'.       01681508
016816     DISPLAY ' ABEND PROGRAMADO '.                                01681608
016817     DISPLAY ' ERRO ENCONTRADO : '  RETURN-CODE.                  01681708
016818     DISPLAY ' WSS-MESSAGE     : '  WSS-MESSAGE.                  01681808
016819     DISPLAY ' FAVOR AVISAR O ANALISTA RESPONSAVEL'.              01681908
016820     DISPLAY '*******************************************'.       01682008
016821                                                                  01682108
016822     PERFORM VSAM-CODE-DISPLAY.                                   01682208
016830                                                                  01683008
016900     STOP RUN.                                                    01690008
017000                                                                  01700008
017100 ROT-ABEND-EXIT.                                                  01710008
017200     EXIT.                                                        01720008
017210                                                                  01721009
017300 VSAM-CODE-DISPLAY.                                               01730008
017400*                                                                 01740008
017500     DISPLAY "VSAM-CODE ==>"                                      01750008
017600             " RETURN: "  VSAM-RETURN-CODE,                       01760008
017700             " COMPONENT: "  VSAM-COMPONENT-CODE,                 01770008
017800             " REASON: "  VSAM-REASON-CODE.                       01780008
017900                                                                  01790008
018000 VSAM-CODE-DISPLAY-EXIT.                                          01800008
018100     EXIT.                                                        01810008
018200                                                                  01820008
018300 END PROGRAM CBVSAM13.                                            01830008
018400********************** FIM PROGRAMA   **********************      01840008

000100******************************************************      ******00010007
000200* DATA     :  30/10/2023                                          00020007
000300* AUTOR    : VAGNER RENATO BELLACOSA                              00030007
000400* OBJETIVO : PROGRAMA EXEMPLO VSAM KSDS                           00040007
000500*            REGRAVA REGISTRO VIA CHAVE                           00050007
000600* CPD      : INEFE                                                00060007
000700******************************************************      ******00070007
000800 IDENTIFICATION DIVISION.                                         00080007
000900*************************                                         00090007
001000 PROGRAM-ID. CBVSAM04.                                            00100007
001100 AUTHOR. VAGNER BELLACOSA.                                        00110007
001200 DATE-WRITTEN. 30/10/23 @ 22:40:00.                               00120007
001300 DATE-COMPILED. 2023-10-30.                                       00130007
       INSTALLATION. INEFE.
       SECURITY. NORMAL.
001400                                                                  00140007
001500**********************                                            00150007
001600 ENVIRONMENT DIVISION.                                            00160007
001700**********************                                            00170007
001800 INPUT-OUTPUT SECTION.                                            00180007
001900*                                                                 00190008
002000 FILE-CONTROL.                                                    00200008
002100     SELECT EMPFILE ASSIGN TO EMPFILE                             00210008
002200     ORGANIZATION IS INDEXED                                      00220008
002300     ACCESS MODE  IS DYNAMIC                                      00230008
002400     RECORD KEY   IS FS-EMP-ID                                    00240010
002500     FILE STATUS  IS FILE-STATUS  VSAM-CODE.                      00250008
002600*                                                                 00260008
002700***************                                                   00270008
002800 DATA DIVISION.                                                   00280008
002900***************                                                   00290008
003000*                                                                 00300008
003100 FILE SECTION.                                                    00310008
003200*                                                                 00320008
003300 FD EMPFILE                                                       00330008
003400     RECORD CONTAINS 80  CHARACTERS                               00340008
003500     BLOCK  CONTAINS 800 CHARACTERS                               00350008
003600     DATA RECORD     IS EMPFILE-RECORD.                           00360008
003700*                                                                 00370008
003800 01 EMPFILE-RECORD.                                               00380008
003900   05 FS-EMP-ID         PIC X(11).                                00390010
004000   05 FILLER            PIC X(01).                                00400010
004100   05 FS-EMP-ORDEM      PIC 99.                                   00410010
004200   05 FILLER            PIC X(01).                                00420010
004300   05 FS-EMP-NAME       PIC X(22).                                00430010
004310   05 FS-EMP-TESTE      PIC 9(06).                                00431010
004320   05 FS-EMP-SEPARADOR  PIC X(01).                                00432010
004330   05 FS-EMP-FLAG       PIC 9.                                    00433010
004340   05 FS-EMP-LOGRADOURO PIC X(16).                                00434010
004350   05 FS-EMP-CIDADE     PIC X(08).                                00435010
004360   05 FS-EMP-UF         PIC XX.                                   00436010
004370   05 FS-EMP-CEP        PIC X(09).                                00437010
004400*                                                                 00440008
004500 WORKING-STORAGE SECTION.                                         00450008
004600*                                                                 00460008
004700 01 WS-VAR.                                                       00470008
004800    05 FILE-STATUS PIC 9(02).                                     00480008
004900    05 WSS-EOF-SW    PIC X(01).                                   00490008
005000       88 WSS-EOF              VALUE 'S'.                         00500008
005100       88 WS-NOT-EOF           VALUE 'N'.                         00510008
005200    05 VSAM-CODE.                                                 00520008
005300       10 VSAM-RETURN-CODE      PIC S9(2) USAGE BINARY.           00530008
005400       10 VSAM-COMPONENT-CODE   PIC S9(1) USAGE BINARY.           00540008
005500       10 VSAM-REASON-CODE      PIC S9(3) USAGE BINARY.           00550008
005600*                                                                 00560008
005700 77  WSS-MESSAGE               PIC X(99).                         00570008
005800 77  WSS-REG-LIDOS             PIC 9(10).                         00580008
005900 77  WSS-REG-ATUALIZADOS       PIC 9(10).                         00590008
006000 77  WSS-DATA-COMPIL           PIC X(16).                         00600008
006100 77  WSS-TAMANHO               PIC X(04).                         00610008
006200*                                                                 00620008
006300 LINKAGE SECTION.                                                 00630008
006400*                                                                 00640008
006500 01  JCLPARM.                                                     00650008
006600   02  JCLPARM-LENGTH   PIC S9(4) BINARY.                         00660010
006700   02  JCLPARM-CHAVE    PIC X(11).                                00670010
006800*                                                                 00680008
007000***********************************                               00700010
007100 PROCEDURE DIVISION USING JCLPARM.                                00710008
007200***********************************                               00720010
007300                                                                  00730007
007400     DISPLAY 'CBVSAM04'.                                          00740008
007500     DISPLAY 'REGRAVA REGISTROS ATUALIZANDO SALARIO'.             00750008
007600                                                                  00760007
007700     MOVE  FUNCTION WHEN-COMPILED  TO WSS-DATA-COMPIL.            00770008
007710                                                                  00771010
007800     DISPLAY ' WSS-DATA-COMPIL = ' WSS-DATA-COMPIL.               00780008
007900     DISPLAY ' '.                                                 00790008
008000                                                                  00800007
008100     IF JCLPARM-LENGTH = 0                                        00810008
008200        MOVE 'PARAMETRO INVALIDO '                                00820008
008300             TO WSS-MESSAGE                                       00830008
008400        MOVE 113          TO  RETURN-CODE                         00840008
008500        PERFORM ROT-ABEND                                         00850008
008600     END-IF.                                                      00860008
008700                                                                  00870007
008800     IF JCLPARM-LENGTH > 11                                       00880009
008900        MOVE  JCLPARM-LENGTH      TO WSS-TAMANHO                  00890008
009000        STRING 'PARAMETRO MAIOR DO QUE O ESPERADO '               00900008
009100                              DELIMITED BY SIZE                   00910008
009200               WSS-TAMANHO    DELIMITED BY SIZE                   00920008
009300               ' BYTES. '     DELIMITED BY SIZE                   00930008
009400           INTO WSS-MESSAGE                                       00940008
009500        END-STRING                                                00950008
009600        MOVE 123          TO  RETURN-CODE                         00960008
009700        PERFORM ROT-ABEND                                         00970008
009800     ELSE                                                         00980008
009900        DISPLAY 'CHAVE-ID NESTE PROCESSAMENTO = ' JCLPARM-CHAVE   00990010
010000        DISPLAY ' '                                               01000008
010100     END-IF.                                                      01010008
010200                                                                  01020007
010600     PERFORM ROT-OPEN-FILE                                        01060008
010700        THRU ROT-OPEN-FILE-EXIT.                                  01070008
010800                                                                  01080007
010900     PERFORM ROT-READ-FILE                                        01090008
011000        THRU ROT-READ-FILE-EXIT.                                  01100008
011010                                                                  01101007
011100     PERFORM ROT-CLOSE-FILE                                       01110008
011200        THRU ROT-CLOSE-FILE-EXIT.                                 01120008
011300                                                                  01130007
011400     PERFORM ROT-ESTATISTIC                                       01140008
011500        THRU ROT-ESTATISTIC-EXIT.                                 01150008
011600                                                                  01160007
011700     STOP RUN.                                                    01170008
011800                                                                  01180007
011900************************************************************  ****01190008
012000* SECAO TRATA ARQUIVOS *************************************  ****01200008
012100************************************************************  ****01210008
012200 ROT-OPEN-FILE.                                                   01220008
012210                                                                  01221010
012300     DISPLAY 'ROT-OPEN-FILE'.                                     01230008
012400                                                                  01240007
012500*    OPEN INPUT EMPFILE.                                          01250008
012600     OPEN I-O   EMPFILE.                                          01260008
012700                                                                  01270007
012800     IF FILE-STATUS > 0                                           01280008
012900        MOVE 'ERRO NA ABERTURA DO ARQUIVO EMPFILE '               01290008
013000             TO WSS-MESSAGE                                       01300008
013100        MOVE FILE-STATUS  TO  RETURN-CODE                         01310008
013200        PERFORM ROT-ABEND                                         01320008
013300     END-IF.                                                      01330008
013400                                                                  01340007
013500 ROT-OPEN-FILE-EXIT.                                              01350008
013600     EXIT.                                                        01360008
013700                                                                  01370007
013800 ROT-READ-FILE.                                                   01380008
013810                                                                  01381010
013900* LE O REGISTRO QUE NECESSITA SER ATUALIZADO                      01390008
014000     DISPLAY 'ROT-READ-FILE'.                                     01400008
014100                                                                  01410007
014200* READING THE RECORD THAT NEED TO UPDATE                          01420008
014300     MOVE JCLPARM-CHAVE  TO FS-EMP-ID.                            01430010
014310                                                                  01431010
014400     ADD 1               TO  WSS-REG-LIDOS.                       01440008
014500                                                                  01450007
014600     READ EMPFILE                                                 01460010
014700          KEY IS FS-EMP-ID                                        01470010
014800              INVALID KEY MOVE    'REGISTRO NAO EXISTE'           01480008
014900                        TO WSS-MESSAGE                            01490008
                    DISPLAY ' FS-EMP-ID = ' FS-EMP-ID
008400              MOVE 651          TO  RETURN-CODE                         08
015000                        PERFORM ROT-ABEND                         01500008
015100          NOT INVALID KEY PERFORM ROT-REWRITE-REC                 01510008
015200                             THRU ROT-REWRITE-REC-EXIT            01520008
015300     END-READ.                                                    01530008
015310                                                                  01531010
015400 ROT-READ-FILE-EXIT.                                              01540008
015500     EXIT.                                                        01550008
015600                                                                  01560008
015700 ROT-REWRITE-REC.                                                 01570008
015800                                                                  01580008
015900     DISPLAY 'ROT-REWRITE-REC'.                                   01590008
015910     DISPLAY ' FS-EMP-FLAG  = ' FS-EMP-FLAG                       01591010
015920     DISPLAY ' FS-EMP-TESTE = ' FS-EMP-TESTE                      01592010
016000                                                                  01600008
016100* AUMENTA O SALARIO EM 5123                                       01610008
016200     ADD 1                TO   WSS-REG-ATUALIZADOS.               01620008

016210     MOVE 9               TO   FS-EMP-FLAG.                       01621010
           MOVE 88              TO   FS-EMP-TESTE
           MOVE ';'             TO   FS-EMP-SEPARADOR
           MOVE 'RUA TESTE 001' TO   FS-EMP-LOGRADOURO
           MOVE 'PIRACICABA'    TO   FS-EMP-CIDADE
           MOVE 'SP'            TO   FS-EMP-UF
           MOVE '13991-100'     TO   FS-EMP-CEP.
016300                                                                  01630008
016400     COMPUTE FS-EMP-TESTE = FS-EMP-TESTE + 5123                   01640010
016500                                                                  01650008
016600* REGRAVA O REGISTRO COM O SALARIO AUMENTADO                      01660008
016700     REWRITE EMPFILE-RECORD                                       01670010
016800                 INVALID KEY MOVE    "REGISTRO NAO ATUALIZADO"    01680009
016900                           TO WSS-MESSAGE                         01690008
008400                 MOVE 699          TO  RETURN-CODE                      08
017000                           PERFORM ROT-ABEND                      01700008
017100             NOT INVALID KEY MOVE    "REGISTRO ATUALIZADO"        01710008
017200                           TO WSS-MESSAGE                         01720008
017300                           PERFORM ROT-DISPLAY                    01730010
017400     END-REWRITE.                                                 01740008
017500                                                                  01750008
017530                                                                  01753010
017600 ROT-REWRITE-REC-EXIT.                                            01760008
017700      EXIT.                                                       01770008
017800                                                                  01780008
017900 ROT-CLOSE-FILE.                                                  01790008
018000                                                                  01800008
018100      DISPLAY 'ROT-CLOSE-FILE'.                                   01810008
018200                                                                  01820008
018300      CLOSE EMPFILE.                                              01830008
018400                                                                  01840008
018500      IF FILE-STATUS > 0                                          01850008
018600         MOVE 'ERRO NO FECHAMENTO DO ARQUIVO EMPFILE '            01860008
018700           TO WSS-MESSAGE                                         01870008
018800       MOVE FILE-STATUS  TO  RETURN-CODE                          01880008
018900       PERFORM ROT-ABEND                                          01890008
019000     END-IF.                                                      01900008
019100                                                                  01910008
019200 ROT-CLOSE-FILE-EXIT.                                             01920008
019300     EXIT.                                                        01930008
019400                                                                  01940008
019500 ROT-ESTATISTIC.                                                  01950008
019600                                                                  01960008
019700     DISPLAY ' '.                                                 01970008
019800     DISPLAY '*******************************************'.       01980008
019900     DISPLAY '*** PROGRAMA CBVSAM04                   ***'.       01990008
020000     DISPLAY '*******************************************'.       02000008
020100     DISPLAY '* TERMINO DE PROCESSAMENTO: OK            *'.       02010008
020200     DISPLAY '* REGISTROS LIDOS        : '                        02020008
020300                WSS-REG-LIDOS.                                    02030008
020400     DISPLAY '* REGISTROS ATUALIZADOS  : '                        02040008
020500                WSS-REG-ATUALIZADOS.                              02050008
020600     DISPLAY '*******************************************'.       02060008
020610                                                                  02061008
020620 ROT-ESTATISTIC-EXIT.                                             02062008
020630     EXIT.                                                        02063008
020640                                                                  02064008
020641 ROT-DISPLAY.                                                     02064110
020642     DISPLAY ' '                                                  02064210
020643     DISPLAY ' SITUACAO APOS REGRAVACAO'                          02064310
020644     DISPLAY ' FS-EMP-FLAG  = ' FS-EMP-FLAG                       02064410
020645     DISPLAY ' FS-EMP-TESTE = ' FS-EMP-TESTE.                     02064510
020646                                                                  02064610
020647 ROT-DISPLAY-EXIT.                                                02064710
020648     EXIT.                                                        02064810
020649                                                                  02064910
020650 ROT-ABEND.                                                       02065008
020660                                                                  02066008
020670     EVALUATE WSS-MESSAGE                                         02067008
020680       WHEN "REGISTRO NAO EXISTE"                                 02068008
020690          MOVE 156 TO  RETURN-CODE                                02069008
020691       WHEN "REGISTRO NAO ATUALIZADO"                             02069108
020692          MOVE 166 TO  RETURN-CODE                                02069208
020693       WHEN OTHER                                                 02069308
020694          DISPLAY WSS-MESSAGE                                     02069408
020697     END-EVALUATE.                                                02069708
020698                                                                  02069808
020699     DISPLAY ' '.                                                 02069908
020700     DISPLAY '*******************************************'.       02070008
020701     DISPLAY ' ABEND PROGRAMADO '.                                02070108
020702     DISPLAY ' ERRO ENCONTRADO : '  RETURN-CODE.                  02070208
020703     DISPLAY ' WSS-MESSAGE     : '  WSS-MESSAGE.                  02070308
020704     DISPLAY ' FAVOR AVISAR O ANALISTA RESPONSAVEL'.              02070408
020705     DISPLAY '*******************************************'.       02070508
020706                                                                  02070608
020707     PERFORM VSAM-CODE-DISPLAY.                                   02070708
020708                                                                  02070808
020709     STOP RUN.                                                    02070908
020710                                                                  02071008
020711 ROT-ABEND-EXIT.                                                  02071108
020712     EXIT.                                                        02071208
020713                                                                  02071308
020720 VSAM-CODE-DISPLAY.                                               02072008
020800     DISPLAY "VSAM-CODE ==>"                                      02080008
020900             " RETURN: "  VSAM-RETURN-CODE,                       02090008
021000             " COMPONENT: "  VSAM-COMPONENT-CODE,                 02100008
021100             " REASON: "  VSAM-REASON-CODE.                       02110008
021200                                                                  02120008
021300 VSAM-CODE-DISPLAY-EXIT.                                          02130008
021400     EXIT.                                                        02140008
021410                                                                  02141010
021500 END PROGRAM CBVSAM04.                                            02150008
021600********************** FIM PROGRAMA   **********************      02160008

//JCLEASMF  JOB    ('00'),TSO.&SYSUID,                                  JOB53930
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//********************************************************************  PDB2E036
//* BELLACOSA MAINFRAME
//********************************************************************  PDB2E036
//* PASSO QUE MEDE OCUPACAO DE SYS1.MANX
//*            SE PASSOU DE 80%, RODA IFASMFDP AUTOMATICAMENTE
//* LIMPA O SPOOL SO SE JES2 ESTIVER ACIMA DE X%
//* GERA LOG BONITO E MENSAGEM ESTILO OPERADOR
//* LIMPA E VERIFICA STATUS DO SMF PARA EVITAR ABEND POR AMBIENTE FULL
//********************************************************************  PDB2E036
//* -------------------------------------------------------------
//* PASSO 1 - MEDIR OCUPAÇÃO DOS DATASETS SMF (SYS1.MANX)
//* -------------------------------------------------------------
//CHKMANX EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  LISTCAT ENT('SYS1.MAN1') ALL
  LISTCAT ENT('SYS1.MAN2') ALL
  LISTCAT ENT('SYS1.MAN3') ALL
/*
//* -------------------------------------------------------------
//* PASSO 2 - DESCARREGAR SMF PARA UM DATASET TEMPORARIO
//* -------------------------------------------------------------
//STEP2    EXEC PGM=IFASMFDP
//SYSPRINT DD SYSOUT=*
//DUMPIN   DD DSN=SYS1.MAN1,DISP=SHR
//DUMPOUT  DD DSN=&&SMFDUMP,
//            DISP=(NEW,PASS,DELETE),
//            UNIT=SYSDA,SPACE=(CYL,(5,5)),
//            DCB=(RECFM=VB,LRECL=32760,BLKSIZE=0)
/* -------------------------------------------------------------
//* PASSO 3 - APAGAR SYSOUT ANTIGO VIA SDSF BATCH
//* -------------------------------------------------------------
//STEP3    EXEC PGM=ISFAFD,PARM='(DEL)'
//ISFIN    DD *
  SET DELAY 0
  OWNER *
  PREFIX *
  ST
  FILTER (DEST EQ LOCAL)
  ++
  DEL ALL
/*
//ISFOUT   DD SYSOUT=*
//ISFLOG   DD SYSOUT=*
//ISFSTAT  DD SYSOUT=*
//* -------------------------------------------------------------
//* PASSO 4 - VERIFICAR OUTROS DATASETS CRITICOS
//* -------------------------------------------------------------
//CHKDS   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  LISTCAT ENT('SYS1.*') ALL
  LISTCAT ENT('SPOOL.*') ALL
  LISTCAT ENT('LOG.*') ALL
/*
//* -------------------------------------------------------------
//* PASSO 5 - LOG BONITO ESTILO OPERADOR
//* -------------------------------------------------------------
//LOGMSG  EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  EX 'IBMUSER.WORKBOOK.REXX(LOGANTI)'
/*
//SYSEXEC DD DSN=IBMUSER.WORKBOOK.REXX,DISP=SHR
//*
//************************** FIM DO JCL     ****************************

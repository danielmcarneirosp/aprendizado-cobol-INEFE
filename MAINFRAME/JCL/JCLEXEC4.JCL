//CATPGM1   JOB ('00'),TSO.&SYSUID,                                     JOB00138
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//* LEITURA DE ARQUIVO DUMMY VAZIO                                   *
//*------------------------------------------------------------------*
//STEP01  EXEC PGM=COBOL028
//INPUTFL DD  DSN=IBMUSER.FILE001.TESTE,DISP=SHR
//*INPUTFL DD  DUMMY
//SYSOUT  DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*
//*------------------------* FIM DO JCL     *------------------------*

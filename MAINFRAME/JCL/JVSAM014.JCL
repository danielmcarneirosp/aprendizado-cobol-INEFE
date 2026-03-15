//CAVSAM05  JOB ('00'),TSO.&SYSUID,                                     JOB00262
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//* DELETA REGISTRO EM DATASET VSAM                                  *
//*------------------------------------------------------------------*
//STEP01  EXEC PGM=CBVSAM03,PARM='           '
//EMPFILE  DD  DSN=INEFE01.VSAM.KSDS,DISP=SHR
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*
//*------------------------* FIM DO JCL     *------------------------*

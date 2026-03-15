//CATEXCHW  JOB ('00'),TSO.&SYSUID,
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//* HELLO WORLD!
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//* EXEMPLOS DE NUMERICO COMPUTACIONAL
//*------------------------------------------------------------------*
//EXEC001  EXEC PGM=COBOL004
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*------------------------------------------------------------------*
//* HELLO WORLD
//*------------------------------------------------------------------*
//EXEC002  EXEC PGM=COBOL004
//STEPLIB  DD DSN=IBMUSER.WORKBOOK.COBOL,DISP=SHR
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*------------------------* FIM DO JCL     *------------------------*

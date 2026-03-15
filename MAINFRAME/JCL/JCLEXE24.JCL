//EXECPGM1  JOB ('00'),TSO.&SYSUID,
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//* PROGRAMA COBOL009 RECEBE PARAMETROS VIA PARM
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//* EXEMPLOS DE NUMERICO COMPUTACIONAL
//*------------------------------------------------------------------*
//EXEC001  EXEC PGM=COBOL009,PARM='MARIA1979/10/23F'
//*STEPLIB DD DSN=IBMUSER.WORKBOOK.COBOL,DISP=SHR
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*------------------------* FIM DO JCL     *------------------------*

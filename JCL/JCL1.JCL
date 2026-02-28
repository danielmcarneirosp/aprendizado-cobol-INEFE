//EXECPGM   JOB ('00'),TSO.&SYSUID,
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A,TIME=(0,20),PRTY=9,
//          LINES=1000
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=KC02745.LIB.CBLPDSE,DISP=SHR
//STEP01  EXEC PGM=COBOL119,PARM='+1000'
//SYSOUT  DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*
//*------------------------* FIM DO JCL     *------------------------*

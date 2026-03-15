//EXECPG61  JOB ('00'),TSO.&SYSUID,
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//JOBLIB   DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//**********************************************************************
//*             CRIA ARQUIVO DE SAIDA FB 80                            *
//**********************************************************************
//STEP01   EXEC PGM=COBOL061
//************* ENTRADA
//INPUTFL  DD  DSN=IBMUSER.ALUNOS.NOTAS,
//             DISP=SHR
//**INPUTFL  DD  DUMMY
//************* SAIDA 001
//OUTPTFL  DD  DSN=IBMUSER.ALUNOS.OUTPUT,
//             DISP=(NEW,CATLG,CATLG),
//             LRECL=80,
//             SPACE=(10,(10,10)),
//             RECFM=FB
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*
//*------------------------* FIM DO JCL     *------------------------*

//CATSAM06 JOB ('00'),TSO.&SYSUID,                                      JOB00050
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//JOBLIB   DD DSNAME=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//*---- NAO ACEITA ERROS                           ------------------*
//*---- CASO O ARQUIVO ESTEJA EM CREATE MODE       ------------------*
//*---- RODAR O PROGRAMA BACALHAU CBVSAM06         ------------------*
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//STEP1    EXEC PGM=CBVSAM06
//SYSPRINT DD  SYSOUT=*
//EMPFILE  DD DSNAME=IBMUSER.VSAM.DATASET.KSDS,
//       DISP=SHR,DCB=(BUFNO=6)
/*
//*------------------------* FIM DO JCL     *------------------------*

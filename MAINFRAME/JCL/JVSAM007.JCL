//CATREP1   JOB ('00'),TSO.&SYSUID,                                     JOB00050
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//*---- REPRO POPULA ARQUIVO VSAM VIA IDCAMS        -----------------*
//*---- CLAUSULA ERRORLIMIT ACEITA ERROS ATE LIMITE -----------------*
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//STEP1    EXEC PGM=IDCAMS
//INPUT    DD DSNAME=IBMUSER.CPF.TESTE,
//       DISP=SHR,DCB=(BUFNO=6)
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD *
   REPRO                               -
   INFILE(INPUT)                       -
   OUTDATASET(IBMUSER.VSAM.DATASET.KSDS) -
   ERRORLIMIT(6)
/*
//*------------------------* FIM DO JCL     *------------------------*

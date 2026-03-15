//CATPGM1   JOB ('00'),TSO.&SYSUID,                                     JOB00214
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//*---- CLASSIFICA UM ARQUIVO VIA SORT                ---------------*
//*------------------------------------------------------------------*
//*------------------------------------------------------------------*
//STEP01    EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*
//SORTIN    DD DSN=IBMUSER.FUNCI.PRINT.IN,DISP=SHR     ---> INPUT FILE
//SORTOUT   DD DSN=IBMUSER.FUNCI.PRINT.TEMP,           ---> OUTPUT FILE
//       DISP=(OLD,CATLG,DELETE),UNIT=SYSDA,
//       SPACE=(CYL,(1,4),RLSE),
//       DCB=(RECFM=FB,LRECL=80,BLKSIZE=0)
//SYSIN     DD *
  SORT FIELDS=(65,5,CH,A,9,40,CH,A)                 ---> SORT STATEMENTS
/*
//*------------------------------------------------------------------*
//* IMPRIME RELATORIO EM 80 COLUNAS COM CARACTER ASA                 *
//* COM QUEBRA DE PAGINA COM 60 LINHAS OU NOVO DEPARTAMENTO          *
//*------------------------------------------------------------------*
//STEP02  EXEC PGM=COBOL093
//FUNCI    DD DSN=IBMUSER.FUNCI.PRINT.TEMP,DISP=SHR
//RLATFUN  DD DSN=IBMUSER.FUNCI.CSV,
//            DISP=(NEW,CATLG,DELETE),SPACE=(CYL,(03,01),RLSE),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=0),UNIT=SYSDA
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//*
//*------------------------* FIM DO JCL     *------------------------*

//CBADBEXE  JOB    ('00'),TSO.&SYSUID,                                  00010002
//CBADBEXE  JOB    ('00'),TSO.&SYSUID,                                  00011002
//          REGION=0M,NOTIFY=&SYSUID,                                   00012001
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A                               00013001
//*                                                                     00014001
//*------------------------------------------------------------------*  00015001
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR                           00016001
//*------------------------------------------------------------------*  00017001
//* PROGRAMA LE QSAM E INSERE TABELAS DB2                               00018001
//*------------------------------------------------------------------*  00019001
//EXECDB2  EXEC PGM=IKJEFT01,DYNAMNBR=20                                00019101
//STEPLIB  DD   DSN=DSN910.SDSNLOAD,DISP=SHR                            00019201
//*LSTCOPAC DD   DSN=INEFE00.COPA.MUNDO,DISP=SHR                        00019301
//*ALUNOS   DD   DSN=IBMUSER.ALUNOS.DB2.CBA.NOTAS,DISP=SHR              00019402
//ALUNOS   DD   DSN=IBMUSER.ALUNOS.NOTAS,DISP=SHR                       00019501
//SYSTSPRT DD   SYSOUT=*                                                00019601
//SYSOUT   DD   SYSOUT=*                                                00019701
//SYSTSIN  DD   *                                                       00019801
  DSN SYSTEM (DB9G)                                                     00019901
      RUN  PROGRAM(COBCBAX1) PLAN(HERP0001) -                           00020002
      LIB('ADCD.Z112.USERLOAD')                                         00020101
/*                                                                      00020201
//          REGION=0M,NOTIFY=&SYSUID,                                   00021000
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A                               00030000
//*                                                                     00040000
//*------------------------------------------------------------------*  00050000
//JOBLIB  DD DSN=IBMUSER.CBL.LOADLIB,DISP=SHR                           00060000
//*------------------------------------------------------------------*  00070000
//* PROGRAMA LE QSAM E INSERE TABELAS DB2                               00080000
//*------------------------------------------------------------------*  00090000
//EXECDB2  EXEC PGM=IKJEFT01,DYNAMNBR=20                                00100000
//STEPLIB  DD   DSN=DSN910.SDSNLOAD,DISP=SHR                            00110000
//*LSTCOPAC DD   DSN=INEFE00.COPA.MUNDO,DISP=SHR                        00120000
//*ALUNOS   DD   DSN=IBMUSER.ALUNOS.DB2.CBA.NOTAS,DISP=SHR              00130002
//ALUNOS   DD   DSN=IBMUSER.ALUNOS.NOTAS,DISP=SHR                       00140000
//SYSTSPRT DD   SYSOUT=*                                                00150000
//SYSOUT   DD   SYSOUT=*                                                00160000
//SYSTSIN  DD   *                                                       00170000
  DSN SYSTEM (DB9G)                                                     00180000
      RUN  PROGRAM(COBCBAX1) PLAN(HERP0001) -                           00190002
      LIB('ADCD.Z112.USERLOAD')                                         00200000
/*                                                                      00210000

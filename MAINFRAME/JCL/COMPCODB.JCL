//CATDCOB   JOB    ('00'),TSO.&SYSUID,                                  JOB53930
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//********************************************************************  PDB2E036
//*PGM = COBDB502                         ****************************  PDB2E036
//********************************************************************  PDB2E036
//JOBLIB     DD  DSN=DSN910.SDSNLOAD,DISP=SHR
//PC         EXEC  PGM=DSNHPC,                                          PDB2E036
//           PARM='HOST(COB2),APOST,SOURCE,XREF'                        PDB2E036
//STEPLIB    DD  DSN=DSN910.SDSNLOAD,DISP=SHR
//DBRMLIB    DD    DSN=&&DBRMDB2(COBDB502),SPACE=(TRK,(3,,1)),          PDB2E036
//           UNIT=SYSDA,DISP=(,PASS),                                   PDB2E036
//           DCB=(DSORG=PO,LRECL=80,RECFM=FB)                           PDB2E036
//SYSCIN     DD    DSN=&&COBPG,DISP=(,PASS),UNIT=SYSDA,                 PDB2E036
//           SPACE=(800,(500,500))                                      PDB2E036
//SYSIN      DD    DSN=IBMUSER.WORKBOOK.COBOL(COBDB502),DISP=SHR        PDB2E036
//SYSPRINT   DD    SYSOUT=*                                             *VRS014*
//SYSTERM    DD    SYSOUT=*                                             *VRS014*
//SYSUT1     DD    SPACE=(800,(500,500),,,ROUND),UNIT=SYSDA             PDB2E036
//SYSUT2     DD  SPACE=(CYL,(5,5)),
//           UNIT=SYSDA,
//           BLKSIZE=27920,LRECL=80,RECFM=FB,DSORG=PS
//********************************************************************  PDB2E036
//PRINTPC    EXEC  PGM=IEBGENER,COND=(4,LT,PC)                          PDB2E036
//SYSUT1     DD    DSN=&&COBPG,DISP=(OLD,PASS)                          PDB2E036
//SYSPRINT   DD    SYSOUT=*                                             *VRS014*
//SYSUT2     DD    SYSOUT=*                                             *VRS014*
//SYSIN      DD    DUMMY                                                PDB2E036
//*******************************************************************
//COB    EXEC PGM=IGYCRCTL,REGION=2M,
//  PARM='BUFSIZE(32760),EXIT(NOPRTEXIT)'
//STEPLIB  DD DISP=SHR,DSN=IGY420.SIGYCOMP
//SYSLIB   DD DSN=DFH320.CICS.SDFHSAMP,DISP=SHR
//         DD DSN=DFH320.CICS.SDFHCOB,DISP=SHR
//         DD DSN=IBMUSER.WORKBOOK.COBOL,DISP=SHR
//         DD DSN=IBMUSER.WORKBOOK.COPY,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DSN=&&COBPG,DISP=(OLD,PASS)
//SYSLIN   DD DSN=&&LOADSET,DISP=(,PASS),
//         UNIT=SYSDA,SPACE=(180,(250,100))
//SYSUT1   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT2   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT3   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT4   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT5   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT6   DD UNIT=SYSDA,SPACE=(960,(550,100))
//SYSUT7   DD UNIT=SYSDA,SPACE=(960,(550,100))
//********************************************************************
//LKED   EXEC PGM=IEWL,REGION=2M,
//            PARM='XREF',COND=(5,LT,COB)
//SYSLIB   DD DSN=DSN910.SDSNLOAD,DISP=SHR
//         DD DSN=SYS1.SIEALNKE,DISP=SHR
//         DD DSN=CEE.SCEELKED,DISP=SHR
//         DD DSN=ADCD.Z112.USERLOAD,DISP=SHR
//SYSLMOD  DD DSN=ADCD.Z112.USERLOAD(COBDB502),DISP=SHR
//SYSUT1   DD UNIT=SYSDA,DCB=BLKSIZE=1024,
//            SPACE=(1024,(200,20))
//SYSPRINT DD SYSOUT=*
//SYSLIN   DD DSN=&&LOADSET,DISP=(OLD,DELETE)
//*****************************************************************
//BINDPK03   EXEC  PGM=IKJEFT01,COND=(4,LT,COB),
//           DYNAMNBR=20
//DBRMLIB    DD    DSN=&&DBRMDB2(COBDB502),DISP=(OLD,DELETE)
//SYSUDUMP   DD    SYSOUT=*
//SYSTSPRT   DD    SYSOUT=*
//SYSPRINT   DD    SYSOUT=*
//SYSTSIN    DD    *

DSN SYSTEM(DB9G)
BIND PACKAGE (HERPACK) OWNER(IBMUSER) MEMBER(COBDB501) -
ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) DEGREE(1) ISO(UR) -
ENABLE(*) ENCODING(EBCDIC)
BIND PLAN(HERP0001)                          -
PKLIST(HERPACK.*,HERPACK.COBDB502)      -
ACTION(REP) ISO(UR) ENCODING(EBCDIC)
/*

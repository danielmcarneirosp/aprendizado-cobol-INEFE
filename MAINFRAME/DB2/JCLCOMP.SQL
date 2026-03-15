//CATDCOB   JOB    ('00'),TSO.&SYSUID,                                  00010000
//          REGION=0M,NOTIFY=&SYSUID,                                   00020000
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A                               00030000
//********************************************************************  00040000
//JOBLIB     DD  DSN=DSN910.SDSNLOAD,DISP=SHR                           00050000
//PC         EXEC  PGM=DSNHPC,                                          00060000
//           PARM='HOST(COB2),APOST,SOURCE,XREF'                        00070000
//STEPLIB    DD  DSN=DSN910.SDSNLOAD,DISP=SHR                           00080000
//DBRMLIB    DD    DSN=&&DBRMDB2(COBXXX1Z),SPACE=(TRK,(3,,1)),          00090000
//           UNIT=SYSDA,DISP=(,PASS),                                   00100000
//           DCB=(DSORG=PO,LRECL=80,RECFM=FB)                           00110000
//SYSCIN     DD    DSN=&&COBPG,DISP=(,PASS),UNIT=SYSDA,                 00120000
//           SPACE=(800,(500,500))                                      00130000
//SYSIN      DD    DSN=IBMUSER.WORKBOOK.DB2(COBXXX1Z),DISP=SHR          00140000
//SYSPRINT   DD    SYSOUT=*                                             00150000
//SYSTERM    DD    SYSOUT=*                                             00160000
//SYSUT1     DD    SPACE=(800,(500,500),,,ROUND),UNIT=SYSDA             00170000
//SYSUT2     DD  SPACE=(CYL,(5,5)),                                     00180000
//           UNIT=SYSDA,                                                00190000
//           BLKSIZE=27920,LRECL=80,RECFM=FB,DSORG=PS                   00200000
//********************************************************************  00210000
//PRINTPC    EXEC  PGM=IEBGENER,COND=(4,LT,PC)                          00220000
//SYSUT1     DD    DSN=&&COBPG,DISP=(OLD,PASS)                          00230000
//SYSPRINT   DD    SYSOUT=*                                             00240000
//SYSUT2     DD    SYSOUT=*                                             00250000
//SYSIN      DD    DUMMY                                                00260000
//*******************************************************************   00270000
//COB    EXEC PGM=IGYCRCTL,REGION=2M,                                   00280000
//  PARM='BUFSIZE(32760),EXIT(NOPRTEXIT)'                               00290000
//STEPLIB  DD DISP=SHR,DSN=IGY420.SIGYCOMP                              00300000
//SYSLIB   DD DSN=DFH320.CICS.SDFHSAMP,DISP=SHR                         00310000
//         DD DSN=DFH320.CICS.SDFHCOB,DISP=SHR                          00320000
//         DD DSN=IBMUSER.WORKBOOK.DB2,DISP=SHR                         00330000
//SYSPRINT DD SYSOUT=*                                                  00340000
//SYSIN    DD DSN=&&COBPG,DISP=(OLD,PASS)                               00350000
//SYSLIN   DD DSN=&&LOADSET,DISP=(,PASS),                               00360000
//         UNIT=SYSDA,SPACE=(180,(250,100))                             00370000
//SYSUT1   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00380000
//SYSUT2   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00390000
//SYSUT3   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00400000
//SYSUT4   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00410000
//SYSUT5   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00420000
//SYSUT6   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00430000
//SYSUT7   DD UNIT=SYSDA,SPACE=(960,(550,100))                          00440000
//********************************************************************  00450000
//LKED   EXEC PGM=IEWL,REGION=2M,                                       00460000
//            PARM='XREF',COND=(5,LT,COB)                               00470000
//SYSLIB   DD DSN=DSN910.SDSNLOAD,DISP=SHR                              00480000
//         DD DSN=SYS1.SIEALNKE,DISP=SHR                                00490000
//         DD DSN=CEE.SCEELKED,DISP=SHR                                 00500000
//         DD DSN=ADCD.Z112.USERLOAD,DISP=SHR                           00510000
//SYSLMOD  DD DSN=ADCD.Z112.USERLOAD(COBXXX1Z),DISP=SHR                 00520000
//SYSUT1   DD UNIT=SYSDA,DCB=BLKSIZE=1024,                              00530000
//            SPACE=(1024,(200,20))                                     00540000
//SYSPRINT DD SYSOUT=*                                                  00550000
//SYSLIN   DD DSN=&&LOADSET,DISP=(OLD,DELETE)                           00560000
//*****************************************************************     00570000
//BINDPK03   EXEC  PGM=IKJEFT01,COND=(4,LT,COB),                        00580000
//           DYNAMNBR=20                                                00590000
//DBRMLIB    DD    DSN=&&DBRMDB2(COBXXX1Z),DISP=(OLD,DELETE)            00600000
//SYSUDUMP   DD    SYSOUT=*                                             00610000
//SYSTSPRT   DD    SYSOUT=*                                             00620000
//SYSPRINT   DD    SYSOUT=*                                             00630000
//SYSTSIN    DD    *                                                    00640000
                                                                        00650000
DSN SYSTEM(DB9G)                                                        00660000
BIND PACKAGE (HERPACK) OWNER(CAZE) MEMBER(COBXXX1Z) -                   00670000
ACTION(REP) VALIDATE(BIND) EXPLAIN(NO) DEGREE(1) ISO(UR) -              00680000
ENABLE(*) ENCODING(EBCDIC)                                              00690000
BIND PLAN(HERP0001)                          -                          00700000
PKLIST(HERPACK.*,HERPACK.COBXXX1Z)      -                               00710000
ACTION(REP) ISO(UR) ENCODING(EBCDIC)                                    00720000
/*                                                                      00730000

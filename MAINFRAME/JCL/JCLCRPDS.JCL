//CRIAPDS  JOB    ('18'),TSO.&SYSUID,                                   JOB00204
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=1,CLASS=A
//********************************************************************  PDB2E036
//STEP1    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.JCL,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//SYSOUT   DD    *                                                      *VRS014*
//********************************************************************  PDB2E036
//STEP2    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.COBOL,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//********************************************************************  PDB2E036
//STEP3    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.CICS,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//********************************************************************  PDB2E036
//STEP4    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.DB2,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//********************************************************************  PDB2E036
//STEP5    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.COPY,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//********************************************************************  PDB2E036
//STEP6    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.SQL,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//********************************************************************  PDB2E036
//STEP7    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.WORKBOOK.DBRM,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//********************************************************************  PDB2E036
//STEP8    EXEC PGM=IEFBR14
//*
//PDSOUT   DD  DSN=INEFE21.CBL.LOADLIB,
//      DISP=(NEW,CATLG,DELETE),
//      UNIT=SYSDA,
//      SPACE=(CYL,(5,2,300)),
//      DCB=(DSORG=PO,RECFM=U,LRECL=0)
//SYSPRINT DD    SYSOUT=*                                               *VRS014*
//SYSTERM  DD    SYSOUT=*                                               *VRS014*
//SYSUT2   DD    SYSOUT=*                                               *VRS014*
//************************* FIM DO JCL     *****************************
//

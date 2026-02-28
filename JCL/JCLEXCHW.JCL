//CATEXCHW  JOB ('18'),TSO.&SYSUID,
//          REGION=0M,NOTIFY=&SYSUID,
//          MSGCLASS=T,MSGLEVEL=(1,1),CLASS=A
//*------------------------------------------------------------------*
//* SOMA DE 2 NUMEROS
//*------------------------------------------------------------------*
//JOBLIB  DD DSN=INEFE18.CBL.LOADLIB,DISP=SHR
//*------------------------------------------------------------------*
//* CARTAO DE EXECUCAO DO PROGRAMA
//*------------------------------------------------------------------*
//EXEC001  EXEC PGM=PGM00001
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
0001000
0000500
1
 */
//*------------------------* FIM DO JCL     *------------------------*

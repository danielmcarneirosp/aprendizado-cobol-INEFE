--------------------------------------------------------------          00010000
ALTER TABLE DB2SWF.RES_MSG_SWF_REC DROP RESTRICT ON DROP;               00020000
ALTER TABLE RES_MSG_SWF_ENV DROP RESTRICT ON DROP;                      00030000
ALTER TABLE EVT_MSG_SWF_ENV DROP RESTRICT ON DROP;                      00040000
ALTER TABLE LNH_MSG_ENV_FMTD DROP RESTRICT ON DROP;                     00050000
DROP TABLE RES_MSG_SWF_ENV;                                             00060000
DROP TABLE EVT_MSG_SWF_ENV;                                             00070000
DROP TABLE LNH_MSG_ENV_FMTD;                                            00080000
DROP DATABASE D1SWF01;                                                  00090000
COMMIT;                                                                 00100000
    DROP STOGROUP SWIFTGRP;                                             00110000
COMMIT;                                                                 00120000

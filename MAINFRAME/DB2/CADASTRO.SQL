
--- DROP TABLE   INEFE00.CURSO ;
---
--- -
--- COMMIT;
----
CREATE TABLE INEFE00.CURSO
 ( COD_CURSO                      INTEGER  NOT NULL,
   MATRICULA_ALU                  INTEGER  NOT NULL,
   NOME_CURSO                     CHAR(40) NOT NULL,
   CARGA_HORARIA_CURSO            DECIMAL(3),
   COMENTARIOS_CURSO              VARCHAR(200),
   DATA_CAD                       DATE,
   HORA_CAD                       TIME,
   LOG_CAD                        TIMESTAMP,
  PRIMARY KEY
 (  COD_CURSO
 ) );
----
COMMIT;
----
X
----
CREATE TABLE INEFE00.CADASTRO
(   CPF_CAD            NUMERIC      (   11    ) NOT NULL
,   NOME_CAD           CHAR         (   40    ) NOT NULL
,   ENDERECO_CAD       CHAR         (   50    )
,   TELEFONE_CAD       NUMERIC      (   08    )
,   EMAIL_CAD          CHAR         (   40    )
, PRIMARY KEY
(   CPF_CAD
) );

-----
CREATE TABLE INEFE00.ALUNOS
           ( MATRICULA_ALU                  INTEGER NOT NULL,
             NOME_ALU                       CHAR(40),
             SEXO_ALU                       CHAR(1),
             NOTA01_ALU                     DECIMAL(4, 2),
             NOTA02_ALU                     DECIMAL(4, 2),
             NOTA03_ALU                     DECIMAL(4, 2),
             NOTA04_ALU                     DECIMAL(4, 2),
             NOTA05_ALU                     DECIMAL(4, 2),
             MEDIA_ALU                      DECIMAL(4, 2),
             DATA_CAD                       DATE,
             HORA_CAD                       TIME,
             LOG_CAD                        TIMESTAMP,
  PRIMARY KEY
(   MATRICULA_ALU
) );
----
COMMIT;
----

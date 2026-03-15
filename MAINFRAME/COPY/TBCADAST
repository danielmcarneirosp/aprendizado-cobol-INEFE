      ******************************************************************
      * DCLGEN TABLE(INEFE00.CADASTRO)                                 *
      *        LIBRARY(IBMUSER.WORKBOOK.COPY(TBCADAST))                *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE INEFE00.CADASTRO TABLE
           ( CPF_CAD                        DECIMAL(11, 0) NOT NULL,
             NOME_CAD                       CHAR(40) NOT NULL,
             ENDERECO_CAD                   CHAR(50),
             TELEFONE_CAD                   DECIMAL(8, 0),
             EMAIL_CAD                      CHAR(40)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE INEFE00.CADASTRO                   *
      ******************************************************************
       01  DCLCADASTRO.
           10 CPF-CAD              PIC S9(11)V USAGE COMP-3.
           10 NOME-CAD             PIC X(40).
           10 ENDERECO-CAD         PIC X(50).
           10 TELEFONE-CAD         PIC S9(8)V USAGE COMP-3.
           10 EMAIL-CAD            PIC X(40).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************

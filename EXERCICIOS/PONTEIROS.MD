# PRONTEIROS

## Relebrando conceitos
    SET - O comando SET designa um valor para uma referência COBOL.

    ADDRESS - Método simples de obter capacidade de endereçamento para áreas de dados de memoria definidas na LINKAGE SECTION usando variáveis de ponteiro e o registro especial ADDRESS

    Programa COBOL120.
    O programa COBOL120 é bem interessante, no DATA DIVISION teremos duas áreas de memórias distintas:

    Working Storage Section
    Linkage Section

    As variáveis na Working são do gênero Grupo com 4 variáveis do tipo string e inicializadas com valores. Um ponteiro de memória e um índice contador.

    Na Linkage temos uma Tabela interna com string de 4 bytes e com 4 ocorrências. 

    Processamento 
    O código é simples, contem alguns displays, dois laço Perform Varying e comandos SET e Address of, para capturar o endereço da memória e alocar na nova variáveis. Ao final faço novo display mostrando a tabela inicializada sem MOVE/ACCEPT/REDEFINES.
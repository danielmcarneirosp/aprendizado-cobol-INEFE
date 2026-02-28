# COMANDOS DO EDITOR DE PRORGRAMAS DO ISPF.


## COMANDO             DESCRIÇÃO
SAVE	            Salva as alterações feitas no arquivo.
CANCEL	            Sai do modo de edição sem salvar as alterações.
END	                Salva as alterações e sai do modo de edição (mesmo que SAVE + F3).
FIND string	        Procura pela próxima ocorrência da "string" especificada no arquivo.
RFIND	            Repete o último comando FIND.
CHANGE str1 str2	Substitui a "string1" pela "string2" na linha atual ou em um bloco selecionado.
RCHANGE	            Repete o último comando CHANGE.
COLS	            Exibe as réguas de coluna, úteis para respeitar as áreas do COBOL
                    (colunas 1-6, 7-11, 12-72, 73-80).
CAPS ON/OFF	        Define se o texto digitado será automaticamente convertido para maiúsculas (ON)
                    ou não (OFF).
NUM ON/OFF	        Controla a numeração automática das linhas.
TABS ON/OFF	        Ativa ou desativa o uso de tabulações.
SUBMIT	            Envia o JCL (Job Control Language) ou o programa para compilação/execução 
                    (se o arquivo for um JCL).

## COMANDOS DE LINHAS ESPECÍFICOS PARA EDIÇÃO
Estes comandos são inseridos na área de comando lateral, ao lado de números de linha específicos:

## COMANDOS 	DESCRIÇÃO
I ou I#	        Insere uma ou # linhas em branco abaixo da linha atual.
D ou D#	        Exclui uma ou # linhas.
DD	            Marca um bloco de linhas para exclusão (usado com outro DD no final do bloco).
C ou C#	        Copia uma ou # linhas para a área de clipboard temporária.
CC	            Marca um bloco de linhas para cópia (usado com outro CC no final do bloco).
M ou M#	        Move uma ou # linhas para a área de clipboard.
MM	            Marca um bloco de linhas para mover.
A	            Cola as linhas copiadas/movidas após a linha marcada.
B	            Cola as linhas copiadas/movidas antes da linha marcada.
R ou R#	        Repete (duplica) uma ou # linhas. RR marca um bloco para repetição.

## TECLAS DE FUNÇÃO (PF KEYS) PADRÃO
As teclas de função, ou PF keys (Program Function keys), são usadas para ações rápidas. Embora possam ser redefinidas, as configurações padrão são amplamente utilizadas: 

## Tecla (PF) 	    Ação Padrão
F1	                Ajuda (Help).
F3	Fim/Sair (End)  Salva e sai do editor.
F7 / PAGE UP	    Rola a tela para cima (Backward).
F8 / PAGE DOWN	    Rola a tela para baixo (Forward).
F9	                Troca de comando/linha de comando.
F10	                Rola para a esquerda (Left).
F11	                Rola para a direita (Right).
F12 / CANCEL	    Cancela a ação atual ou a entrada (semelhante a CANCEL na linha de comando).

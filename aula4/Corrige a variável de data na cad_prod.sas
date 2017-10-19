/*
 * CHECAR E CORRIGIR A VARIÁVEL DE DATA
 */

/* Checa se existem datas não preenchidas */
PROC FREQ
	data=alura.cadastro_produto_v2;
	table data /missing;
RUN;

/* Checa quais jogos não possuem data preenchida */
DATA teste1;
set alura.cadastro_produto_v2;

WHERE data = .;

RUN;

/* Confere preenchimento das datas nas demais cópias dos jogos */
PROC FREQ
	data=alura.cadastro_produto_v2
		(where=(nome in ("Soccer" "Forgotten Echo" "Fireshock")));
	table nome*data
		/list missing;
RUN;

/* Corrige a data */
DATA teste2;
set alura.cadastro_produto_v2;

IF data = . THEN DO;
	SELECT(nome);
		WHEN ("Fireshock")		data = 201706;
		WHEN ("Forgotten Echo")	data = 201411;
		WHEN ("Soccer")			data = 201709;
		OTHERWISE;
	END;
END;

RUN;

/* Salva uma nova versão da base de cadastro produto */
DATA alura.cadastro_produto_v3;
set teste2;

* Cria a flag de lançamento ;
IF data > 201606
	THEN flag_lancamento = 1;
	ELSE flag_lancamento = 0;

* Marca o rótulo da flag ;
label lancamento = "Marca 1 para jogos que são lançamento e 0 caso contrário";

RUN;

/* Checa se todas as datas estão preenchidas */
PROC FREQ
	data=alura.cadastro_produto_v3
		(where=(nome in ("Soccer" "Forgotten Echo" "Fireshock")));
	table nome*data
		/list missing;
RUN;

/* Compara flags de lançamento entre as versões 2 e 3 */
PROC FREQ
	data=alura.cadastro_produto_v2;
	table flag_lancamento;
RUN;

PROC FREQ
	data=alura.cadastro_produto_v3;
	table flag_lancamento;
RUN;














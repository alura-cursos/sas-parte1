/*
 * PROGRAMA QUE CHECA A MINHA BASE DE CADASTRO PRODUTO
 */

/* Declara o atalho para a minha pasta da AluraPlay */
LIBNAME alura "/folders/myfolders/AluraPlay";

* Vou checar o meu diretório da Alura ;
PROC DATASETS
	lib=alura details;
RUN;

* Checa o conteúdo da minha base de cadastro produto ;
PROC CONTENTS
	data=alura.cadastro_produto;
RUN;

* Imprime a minha base de cadastro produto ;
PROC PRINT
	data=alura.cadastro_produto;
RUN;

* Gera as frquencias das variáveis Gênero, Plataforma e Nome ;
PROC FREQ
	data=alura.cadastro_produto nlevels;
	table genero plataforma nome;
RUN;

/* Cria uma nova base com a variável de flag de lançamento */
DATA teste;
set alura.cadastro_produto;

LENGTH lancamento 3;

IF data > 201606
	THEN lancamento = 1;
	ELSE lancamento = 0;

RUN;

* Imprime minha nova base ;
PROC PRINT
	data=teste;
RUN;

* Gera a tabela de frequência da minha variável de laçamento ;
PROC FREQ
	data=teste;
	table lancamento;
RUN;

* Gera a frequencia cruzada das variáveis Gênero e Lançamento ;
PROC FREQ
	data=teste;
	table genero*lancamento
	/norow nocol nopercent;
RUN;

* Gera a lista cruzada das variáveis Nome e Gênero ;
PROC FREQ
	data=alura.cadastro_produto nlevels;
	*table nome;
	table nome*genero
	/ list;
RUN;

/* Salva a minha base intermendiária no diretório da AluraPlay */
DATA alura.cadastro_produto_v2;
set teste;
rename lancamento = flag_lancamento;
label Genero = "Gênero"
	lancamento = "Marca 1 para jogos que são lançamento e 0 caso contrário";
RUN;

* Checar se minha base 'cadastro_produto_v2' foi criada corretamente ;
PROC CONTENTS
	data=alura.cadastro_produto_v2;
RUN;



















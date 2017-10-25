LIBNAME alura "/folders/myfolders/AluraPlay";

PROC DATASETS
	lib=alura details;
RUN;

PROC CONTENTS
	data=alura.cadastro_produto;
RUN;

PROC PRINT
	data=alura.cadastro_produto;
RUN;

PROC FREQ
	data=alura.cadastro_produto nlevels;
	table genero plataforma nome;
RUN;

DATA teste;
set alura.cadastro_produto;

IF data > 201606
	THEN lancamento = 1;
	ELSE lancamento = 0;

RUN;

PROC PRINT
	data=teste;
RUN;

PROC FREQ
	data=teste;
	table lancamento;
RUN;







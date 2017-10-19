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
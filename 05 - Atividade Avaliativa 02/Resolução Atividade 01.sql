CREATE TABLE "aldeias" (
	"FID" VARCHAR(50),
	"cod_aldeia" SMALLINT,
	"nome_aldeia" VARCHAR(50),
	"cod_ti" INTEGER,
	"cod_municipio" INTEGER,
	"data_cadastro" VARCHAR(10),
	"flag_ativo" VARCHAR(10),
	"nome_cr" VARCHAR(60),
	"the_geom" VARCHAR(50),
	"nommunic" VARCHAR(30),
	"nomuf" VARCHAR(20),
	"undadm_codigo" BIGINT,
	"coord_lat" BIGINT,
	"coord_long" BIGINT);

COPY aldeias
FROM 'C:\Users\RPA\Downloads\aldeias.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE "terras" (
	"gid" VARCHAR(10),
	"terrai_codigo" VARCHAR(10),
	"terrai_nome" VARCHAR(40),
	"etnia_nome" VARCHAR(140),
	"municipio_nome" VARCHAR(190),
	"uf_sigla" VARCHAR(10),
	"superficie_perimetro_ha" BIGINT,
	"fase_ti" VARCHAR(20),
	"modalidade_ti" VARCHAR(30),
	"reestudo_ti" VARCHAR(10),
	"cr" VARCHAR(60),
	"faixa_fronteira" VARCHAR(10),
	"undadm_codigo" BIGINT,
	"undadm_nome" VARCHAR(60),
	"undadm_sigla" VARCHAR(10),
	"dominio_uniao" VARCHAR(10),
	"data_atualizacao" VARCHAR(10),
	"epsg" SMALLINT);

COPY terras
FROM 'C:\Users\RPA\Desktop\terras.txt'
DELIMITER ','
CSV HEADER;

SELECT * FROM terras;
SELECT * FROM terras;

SELECT uf_sigla, COUNT(terras.terrai_codigo) AS contterras, COUNT(aldeias.cod_aldeia) AS contaldeias
FROM aldeias
FULL JOIN terras
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY uf_sigla
ORDER BY uf_sigla DESC;

--Q1 - REPOSTA 
SELECT nomuf AS estado, COUNT(distinct terras.terrai_codigo) AS terras, COUNT(distinct aldeias.cod_aldeia) AS aldeias
FROM aldeias
FULL JOIN terras
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY nomuf
HAVING nomuf NOTNULL
ORDER BY nomuf;


-- Q2 - Quantas aldeias indíginas existem por cada etnia/povo?
-- REPOSTA
SELECT * FROM public.aldeias;
SELECT * FROM public.terras;

SELECT COUNT(distinct aldeias.cod_aldeia) FROM aldeias;
SELECT COUNT(distinct terras.etnia_nome) FROM terras;


SELECT terras.etnia_nome AS etnia, COUNT(distinct aldeias.cod_aldeia) AS aldeias
FROM aldeias
FULL JOIN terras
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY terras.etnia_nome
HAVING terras.etnia_nome NOTNULL
ORDER BY aldeias DESC ;
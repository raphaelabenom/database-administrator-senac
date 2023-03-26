#Atividade avaliativa 04


#1) Baixe o conjunto de dados (dataset) disponível no Google Classroom.
#DONE!

#2)  Crie uma tabela no database “bebes” que represente este dataset.
CREATE TABLE dataset 
(id varchar, 
idademae int,
estadocivilmae varchar(20),
catprenatal varchar(20),
qtdsemanas int,
tipoparto varchar(20),
peso int,
malformacao varchar(3),
sexo char(1),
apgar1 int,
apgar5 int,
obito int
);

#import data
COPY dataset
FROM 'C:\dataset.csv'
DELIMITER ','
CSV HEADER;

#3) Elimine a coluna “sexo”, que representa o sexo do bebê.
ALTER TABLE dataset DROP sexo;

#4) Mostre a quantidade de registros existentes nesta tabela.
SELECT COUNT(*)
FROM dataset;
# Resultset: Quantidade total 11389


#5) Mostre os registros cujo campo “malformação” é igual a 1.
SELECT *
FROM dataset WHERE malformacao = 'sim';

#6) Selecione somente os registros dos casos em que o bebê foi a óbito.
#Registros que o bebê foi a óbito
SELECT * 
FROM dataset
WHERE obito = 1;
#Total de registros
SELECT count(*) 
FROM dataset
WHERE obito = 1;

#7) Conte quantos bebês nasceram de parto normal e quantos bebês nasceram de parto cesáreo.
#Cesareo
SELECT count(tipoparto)
FROM dataset
WHERE tipoparto = 'cesareo';
#Resultset = 7378

#Vaginal
SELECT count(tipoparto)
FROM dataset
WHERE tipoparto = 'vaginal';
#Resultset 4006

#8) Verifique, dentre os bebês que vieram a óbito, quantos bebês nasceram com menos de 36 semanas de gestação. 
#Eles representam qual percentual do total de bebês que vieram a óbito?
# Quantidades < 36 semanas
SELECT count(*) as qtdsemanas
FROM dataset
WHERE obito = 1 AND qtdsemanas < 36;
#Resultset = 1701

#Porcentagem
SELECT obito, (COUNT(obito)*100 / (SELECT COUNT(qtdsemanas) FROM dataset)) as Porcetagem
FROM dataset WHERE obito = 1 AND qtdsemanas < 36
GROUP BY obito;
#Resultset = 15%

#9) Calcule a média de semanas de uma gestação.
SELECT AVG(qtdsemanas)
FROM dataset;

#10) Calcule quantos bebês vieram a óbito filhos de mães solteiras e filhos de mães casadas. De acordo com este resultado, você diria que o estado civil da mãe influencia na probabilidade de sobrevivência da criança?
#Mae solteira
SELECT COUNT(*) 
FROM dataset
WHERE estadocivilmae = 'solteira' AND obito = 1;
#Resultset = 1159
#Mae casada
SELECT COUNT(*) 
FROM dataset
WHERE estadocivilmae = 'casada' AND obito = 1;
#Resultset = 808

#A partir da análise dos dados fornecido e tempo proposto a estimativa e a probabilidade de sobrevivência da criança deve levar em consideração outros fatores para a tomada de decisão;


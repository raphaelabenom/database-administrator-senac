-- Questão 01
SELECT malformacao, COUNT(*) AS total 
FROM bebes GROUP BY malformacao;

-- Questão 02
SELECT estadocivilmae, AVG(idademae) AS idade 
FROM bebes GROUP BY estadocivilmae;

-- Questão 03
SELECT tipoparto, AVG(qtdsemanas) AS semanas 
FROM bebes GROUP BY tipoparto;

-- Questão 04
SELECT obito, COUNT(*) AS total 
FROM bebes WHERE qtdsemanas < 36
GROUP BY obito;

-- Questão 05
SELECT estadocivilmae, COUNT(*) AS totalobitos
FROM bebes WHERE obito = 1
GROUP BY estadocivilmae;

-- Questão 06
SELECT estadocivilmae, 
MIN(idademae)::INTEGER AS minimo, 
MAX(idademae)::INTEGER AS maximo,
AVG(idademae)::INTEGER AS media
FROM bebes
GROUP BY estadocivilmae
HAVING estadocivilmae NOTNULL
ORDER BY minimo;

-- Questão 07
SELECT malformacao, COUNT(*) AS total
FROM bebes WHERE obito = 1
GROUP BY malformacao;

SELECT
	malformacoes,
	obitos,
	ROUND((malformacoes*100)/obitos,2) AS percentual
FROM (
	SELECT
	(SELECT COUNT(*) FROM bebes WHERE obito = 1) AS obitos,
	(SELECT COUNT(*) FROM bebes WHERE obito = 1 AND malformacao = 'sim') AS malformacoes
) AS teste
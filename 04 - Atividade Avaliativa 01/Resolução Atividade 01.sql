--1) Conte os recém-nascidos agrupados pelo critério de malformação (conte quantos têm malformação e não têm).
	SELECT malformacao, COUNT(malformacao) 
	FROM dataset
	GROUP BY malformacao
	HAVING malformacao NOTNULL;
--2) Calcule a idade media da mãe agrupado pelo estado civil da mãe.
	SELECT estadocivilmae, ROUND(AVG(idademae),0) AS mediaidade 
	FROM dataset
	GROUP BY estadocivilmae
	HAVING estadocivilmae NOTNULL
	ORDER BY mediaidade DESC;
--3) Calcule a média de semanas de gestação de acordo com o tipo de parto.
	SELECT tipoparto, ROUND(AVG(qtdsemanas),0) AS mediagestsemanas 
	FROM dataset
	GROUP BY tipoparto
	HAVING tipoparto NOTNULL
	ORDER BY mediagestsemanas DESC;
--4) Dos partos prematuros (inferiores a 36 semanas), conte quantos vieram a óbito e quantos sobreviveram.
	SELECT qtdsemanas, obito, COUNT(obito) AS resultado 
	FROM dataset
	GROUP BY qtdsemanas, obito
	HAVING qtdsemanas < 36
	ORDER BY qtdsemanas DESC;
--5) Calcule quantos bebês vieram a óbito por estado civil da mãe utilizando o group by.
	SELECT estadocivilmae, obito, COUNT(obito) as mortesbebes 
	FROM dataset
	GROUP BY estadocivilmae, obito
	HAVING estadocivilmae NOTNULL
	ORDER BY estadocivilmae;
--6) Mostre a idade da mãe mais jovem e da mãe mais velha, agrupado por estado civil.
SELECT estadocivilmae, MIN(idademae), MAX(idademae)  
	FROM dataset
	GROUP BY estadocivilmae
	HAVING estadocivilmae NOTNULL
	ORDER BY estadocivilmae asc;
--7) Dos bebês que vieram a óbito, quantos tinham malformacao? Isso representa qual percentual do total de bebês falecidos?
SELECT malformacao, obito, COUNT(obito) as resultado, (COUNT(obito)*100 / (SELECT COUNT(qtdsemanas) 
FROM dataset))::numeric(30,2) as percents
FROM dataset
GROUP BY malformacao, obito
-- HAVING malformacao NOTNULL
ORDER BY resultado;
-- Questão 1
SELECT nome, sobrenome
FROM funcionarios
WHERE cargo LIKE 'Programador%';

-- Questão 2
SELECT nome, sobrenome, temposervico, salario
FROM funcionarios
WHERE salario >= 5000 AND salario <= 20000
ORDER BY temposervico, salario DESC

-- A ordenação por tempo de serviço e salário de modo decrescente permite ver primeiro os funcionários
-- com mais tempo de casa e mais bem remunerados. É uma visualização interessante para quem busca
-- candidatos a promoções, incentivos ou demissões.

-- Questão 3
SELECT nome, sobrenome, temposervico
FROM funcionarios
WHERE salario = 
	(SELECT MAX(salario) FROM funcionarios)
ORDER BY nome, sobrenome;

-- Questão 4
CREATE VIEW idade_funcionarios AS
SELECT *, 
	(CURRENT_DATE - dataNasc)/365::INTEGER 
	as idade
FROM funcionarios;

-- Questão 5
SELECT * FROM idade_funcionarios
WHERE idade = 
	(SELECT MIN(idade) FROM idade_funcionarios);

-- Questão 6
SELECT ROUND(AVG(salario),2) FROM  funcionarios;

-- Questão 7
SELECT nome, sobrenome, salario, cargo
FROM funcionarios
WHERE salario > 
	(SELECT AVG(salario) FROM funcionarios);

-- Questão 8
ALTER TABLE funcionarios ADD COLUMN nivel;

-- Questão 9

-- Cálculo da Média Salarial por nível de senioridade

SELECT AVG(salario) FROM funcionarios GROUP BY nivel;

CREATE VIEW medias_por_nivel AS
SELECT
	(SELECT AVG(salario) FROM funcionarios WHERE nivel = 'Junior') AS mediaJunior,
	(SELECT AVG(salario) FROM funcionarios WHERE nivel = 'Pleno') AS mediaPleno,
	(SELECT AVG(salario) FROM funcionarios WHERE nivel = 'Senior') AS mediaSenior,

--	mediaJunior | mediaPleno | mediaSenior
--	   3717			8333		 12000	

-- Contagem dos funcionários com salário acima da média por nível de senioridade
SELECT
	(SELECT COUNT(*) AS totalJunior
	FROM funcionarios 
	WHERE nivel = 'Junior' AND salario > (SELECT mediaJunior FROM medias_por_nivel),
	),
	(SELECT COUNT(*) AS totalPleno
	FROM funcionarios 
	WHERE nivel = 'Pleno' AND salario > (SELECT mediaPleno FROM medias_por_nivel),
	),
	(SELECT COUNT(*) AS totalSenior
	FROM funcionarios 
	WHERE nivel = 'Senior' AND salario > (SELECT mediaPleno FROM medias_por_nivel),
	);

--	totalJunior | totalPleno | totalSenior
--	    1			  1		       0	


-- Questão 10

-- Calcule quantos funcionários ganham acima da média do mercado em cada nível.

CREATE VIEW salarios_mercado_por_nivel AS
SELECT
	(SELECT COUNT(*) FROM funcionarios 
	WHERE nivel = 'Junior') AS totalFuncJunior,
	(SELECT COUNT(*) FROM funcionarios 
	WHERE nivel = 'Junior' AND salario > 3500) AS totalAcimaJunior,
	(SELECT COUNT(*) FROM funcionarios 
	WHERE nivel = 'Pleno') AS totalFuncPleno,
	(SELECT COUNT(*) FROM funcionarios 
	WHERE nivel = 'Pleno' AND salario > 7000) AS totalAcimaPleno,
	(SELECT COUNT(*) FROM funcionarios 
	WHERE nivel = 'Senior') AS totalFuncSenior,
	(SELECT COUNT(*) FROM funcionarios 
	WHERE nivel = 'Senior' AND salario > 12000) AS totalAcimaSenior;

--	totalFuncJunior | totalAcimaJunior | totalFuncPleno | totalAcimaPleno | totalFuncSenior | totalAcimaSenior
--	       8 			     1		           5	             2                 1                 0

-- Em seguida, conte quantos funcionários a empresa tem, bem como o percentual 
-- de funcionários que ganha acima da média em cada nível.

SELECT 
	(SELECT (totalAcimaJunior/totalFuncJunior) * 100 
	FROM salarios_mercado_por_nivel) AS percentJunior,
	(SELECT (totalAcimaPleno/totalFuncPleno) * 100 
	FROM salarios_mercado_por_nivel) AS percentPleno,
	(SELECT (totalAcimaSenior/totalFuncSenior) * 100 
	FROM salarios_mercado_por_nivel) AS percentSenior;

--	percentJunior | percentPleno | percentSenior
--	    12,5			 40	             0	
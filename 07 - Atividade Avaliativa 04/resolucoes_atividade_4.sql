-- Questão 01 --
-- Crie uma consulta que mostre a quantidade de alunos por curso. Ordene o Result Set de maneira descrescente.
SELECT COUNT(*) AS totalalunos, cursos.descricao AS curso
FROM alunos FULL JOIN cursos ON alunos.fkcurso = cursos.id
GROUP BY curso
ORDER BY totalalunos DESC

-- Questão 02 --
-- Crie uma consulta que mostre o total de alunos por segmento. Ordene o Result Set de maneira descrescente.
SELECT COUNT(*) AS totalalunos, cursos.segmento AS segmento
FROM alunos FULL JOIN cursos ON alunos.fkcurso = cursos.id
GROUP BY segmento
ORDER BY totalalunos DESC

-- Questão 03 --
-- Calcule a idade dos alunos e acrescente uma coluna com esta informação à tabela original.
ALTER TABLE alunos ADD COLUMN idade integer;
UPDATE alunos SET idade = (CURRENT_DATE - dataNasc)/365::INTEGER;

-- Questão 04 --
-- Conte quantos estudantes existem em cada uma das seguintes faixas etárias:
-- 12 a 18 anos
-- 19 a 24 anos
-- 25 a 42 anos
-- 43 anos ou mais

-- Forma Nº 1: Crie um campo calculado na tabela alunos chamado faixaetaria para guardar esta informação.
-- Depois preencha este campo com os valores corretos.

ALTER TABLE alunos ADD COLUMN faixaetaria VARCHAR;

UPDATE alunos SET faixaetaria = '12 a 18 anos'
WHERE idade BETWEEN 12 AND 18;
UPDATE alunos SET faixaetaria = '19 a 24 anos'
WHERE idade BETWEEN 19 AND 24;
UPDATE alunos SET faixaetaria = '25 a 42 anos'
WHERE idade BETWEEN 25 AND 42;
UPDATE alunos SET faixaetaria = '43 anos ou mais'
WHERE idade >= 43;

SELECT 
	COUNT(*) AS total,
	faixaetaria 
FROM alunos
GROUP BY faixaetaria;

-- Forma Nº 2: Crie uma subconsulta.

SELECT
	(SELECT COUNT(*) FROM alunos WHERE idade BETWEEN 12 AND 18) AS faixaetaria12a18,
	(SELECT COUNT(*) FROM alunos WHERE idade BETWEEN 19 AND 24) AS faixaetaria19a24,
	(SELECT COUNT(*) FROM alunos WHERE idade BETWEEN 25 AND 42) AS faixaetaria25a42,
	(SELECT COUNT(*) FROM alunos WHERE idade >= 43) AS faixaetariamaiorque42;

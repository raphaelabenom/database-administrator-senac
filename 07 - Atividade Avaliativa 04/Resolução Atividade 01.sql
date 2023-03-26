-- CRIAR TABELAS
CREATE TABLE alunos(
	id varchar NOT NULL, 
	nome varchar,
	datanasc date,
	cidade varchar,
	fkcursos varchar,
      FOREIGN KEY(fkcursos) 
      REFERENCES cursos(id),
    PRIMARY KEY (id)
);

CREATE TABLE cursos(
	id varchar NOT NULL,
	descricao varchar,
	segmento varchar,
	unidade varchar,
	PRIMARY KEY (id)
);


-- INSERIR OS DADOS NA TABELA
INSERT INTO alunos (id,nome,datanasc,cidade,fkcursos) 
VALUES 
('1','Van Diesel','1990-03-01','Aparecida de Goiânia','11'),
('2','John Wick','1992-05-25','Trindade','22'),
('3','Wandinha','1998-04-19','Rio das Almas','11'),
('4','Kaynã Pilot','1992-02-10','Cidade Goiás','11');

INSERT INTO cursos (id,descricao,segmento,unidade)
VALUES
('11','Cursos de Redes','TI','Cora Coralina'),
('22','Curso programador de sistemas','TI','Cora Coralina');


--QD 1. Crie uma consulta que mostre a quantidade de alunos por curso. Ordene o resultset de modo descrescente;

SELECT descricao, COUNT(*) as alunos 
FROM alunos
FULL JOIN cursos
ON alunos.fkcursos = cursos.id
GROUP BY descricao
ORDER BY descricao;


--QD 2. Crie uma consulta que mostre o total de alunos por segmento. Ordene o result set de modo decrescente.

SELECT COUNT(*) AS total, segmento
FROM alunos
FULL JOIN cursos
ON alunos.fkcursos = cursos.id
GROUP by cursos.segmento
ORDER BY total DESC;


1/n = LETF / RIGHT

--QD 3. Calcule a idade dos alunos e acrescente uma coluna com esta informação à tabela original.

	-- Converter para idade
	SELECT EXTRACT(YEAR FROM age(datanasc)) FROM alunos;

	-- Incluir um campo idade na tabela alunos
	ALTER TABLE alunos ADD COLUMN idade int

	-- Incluir a idade no registro do campo idade na tabela alunos
	UPDATE alunos SET idade = (CURRENT_DATE - datanasc)/365::integer;
	UPDATE alunos SET idade = EXTRACT(YEAR FROM age(datanasc));


--QD 4. Conte quantos estudantes existem em cada uma das seguintes faixas etárias:

--12 a 18 anos
--19 a 24 anos
--25 a 42 anos
--43 anos ou mais

SELECT idade,COUNT(alunos.id)
FROM alunos
WHERE 
(idade BETWEEN 12 AND 18) AS "12 a 18 ano" OR
(idade BETWEEN 19 AND 24) AS "19 a 24 anos" OR
(idade BETWEEN 25 AND 42) AS "43 anos ou mais" OR
(idade > 43)
GROUP BY idade;


	ALTER TABLE alunos ADD COLUMN faixaetaria int;
	UPDATE alunos SET idade = WHERE 
(idade BETWEEN 12 AND 18) AS "12 a 18 ano" OR
(idade BETWEEN 19 AND 24) AS "19 a 24 anos" OR
(idade BETWEEN 25 AND 42) AS "43 anos ou mais" OR
(idade > 43);



--Dicionario
ALTER TABLE alunos ADD COLUMN faixaetaria VARCHAR;

ALTER TABLE alunos ALTER COLUMN faixaetaria TYPE varchar USING faixaetaria::varchar;

alter table alunos DROP COLUMN faixaetaria;
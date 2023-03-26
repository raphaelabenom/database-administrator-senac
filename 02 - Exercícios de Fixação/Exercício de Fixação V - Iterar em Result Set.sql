
-- 1) Crie o banco de dados escola, nesse BD a tabela representada pelo esquema
-- Alunos(nome,curso,nota,situacao)
-- Popule esta tabela com 4 registros em todos eles
--- Deixe o campo "situacao" em branco em todos os registros e mostre apenas os alunos com maior nota ou igual a 7

CREATE TABLE alunos (
	nome varchar,
	curso varchar,
	nota numeric,
	situacao varchar
);

INSERT INTO alunos VALUES 
('Mariano Santos', 'Diretio', 6.5),
('Sandrona Marques', 'Administração', 7),
('Malton Sales', 'Fármacia', 7.5),
('Bilinho Mane', 'Relações Internacionais', 8);


DO 
$$
DECLARE
	registro RECORD;
BEGIN
	FOR registro IN SELECT * FROM alunos WHERE nota >= 7
	LOOP
		RAISE NOTICE 'alunos %', registro.nome;
	END LOOP;
END; 
$$
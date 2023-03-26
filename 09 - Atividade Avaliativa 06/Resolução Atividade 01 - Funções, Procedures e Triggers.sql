
-- 2) Crie o banco de dados escola, nesse BD a tabela representada pelo esquema
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

-- 3) Atualizam a tabela alunos através de uma procedure, atribuindo para cada aluno uma situação de acordo com a sua nota.
-- Aprovado: Nota >= 7;
-- Recuperação: Nota >= 6 E NOTA =< 7;
-- Reprovado: Nota < 6;
DO 
$$
DECLARE
registro RECORD;
BEGIN
	FOR registro IN (SELECT * FROM alunos)
	LOOP
		IF (registro.nota >= 7) THEN 
-- 			RAISE NOTICE '%', registro.nota;
			UPDATE alunos SET situacao = 'aprovado' WHERE nome = registro.nome;
		ELSIF (registro.nota > 6 AND registro.nota < 7)THEN
-- 			RAISE NOTICE '%', registro.nota;
			UPDATE alunos SET situacao = 'Recuperação' WHERE nome = registro.nome;
		ELSE
			RAISE NOTICE '%', registro.nota;
			UPDATE alunos SET situacao = 'Reprovado' WHERE nome = registro.nome;
		END IF;
	END LOOP;
END; 
$$

-- 4) Transforme a procedure em uma função;

CREATE FUNCTION ajustenota(nota numeric)
RETURNS numeric LANGUAGE PLPGSQL AS $$

DECLARE

registro RECORD;

BEGIN
	FOR registro IN (SELECT * FROM alunos)
	LOOP
		IF (registro.nota >= 7) THEN 
			UPDATE alunos SET situacao = 'aprovado' WHERE nome = registro.nome;
		ELSIF (registro.nota > 6 AND registro.nota < 7)THEN
			UPDATE alunos SET situacao = 'Recuperação' WHERE nome = registro.nome;
		ELSE
			UPDATE alunos SET situacao = 'Reprovado' WHERE nome = registro.nome;
		END IF;
	END LOOP;
RETURN NEW;
END; 
$$

-- 5) Crie uma trigger que execute a função cada vez que um novo aluno for cadastrado.

CREATE FUNCTION cadastroaluno()
RETURNS TRIGGER LANGUAGE PLPGSQL AS $$

DECLARE
registro RECORD;

BEGIN
	FOR registro IN (SELECT * FROM alunos)
	LOOP
		IF (registro.nota >= 7) THEN 

			UPDATE alunos SET situacao = 'aprovado' WHERE nota >= 7;
		ELSIF (registro.nota > 6 AND registro.nota < 7)THEN

			UPDATE alunos SET situacao = 'Recuperação' WHERE nota > 6 AND nota < 7;
		ELSE
			UPDATE alunos SET situacao = 'Reprovado' WHERE nota < 6;
		END IF;
	END LOOP;
	RETURN NEW;
END; 
$$

CREATE TRIGGER cadastro_alunos
AFTER INSERT ON alunos
FOR EACH ROW
EXECUTE PROCEDURE cadastroaluno();


-- 6) Modifique a tabela alunos, adicionando o campo id como pk.

ALTER TABLE alunos ADD COLUMN id varchar;
SELECT * FROM alunos;

UPDATE alunos SET id = '4' WHERE nota = 8;

-- 7) Modifique a tabela alunos, de modo que o valor padrão da coluna 'situacao' seja 'cursando' e o valor padrão da nota seja 0.0.

ALTER TABLE alunos ALTER COLUMN situacao SET DEFAULT 'cursando';
ALTER TABLE alunos ALTER COLUMN nota SET DEFAULT 0;

INSERT INTO alunos(nome,curso,id)
VALUES 
('Estelar','Teatro','6');



-- 8) modifique a trigger para que execute após uma atualização na tabela alunos.

CREATE FUNCTION cadastroaluno()
RETURNS TRIGGER LANGUAGE PLPGSQL AS $$

DECLARE
registro RECORD;

BEGIN
	FOR registro IN (SELECT * FROM alunos)
	LOOP
		IF (registro.nota >= 7) THEN 

			UPDATE alunos SET situacao = 'aprovado' WHERE nota >= 7;
		ELSIF (registro.nota > 6 AND registro.nota < 7)THEN

			UPDATE alunos SET situacao = 'Recuperação' WHERE nota > 6 AND nota < 7;
		ELSE
			UPDATE alunos SET situacao = 'Reprovado' WHERE nota < 6;
		END IF;
	END LOOP;
	RETURN NEW;
END; 
$$

CREATE TRIGGER cadastro_alunos
AFTER UPDATE ON alunos
FOR EACH ROW
EXECUTE PROCEDURE cadastroaluno();
--1) Crie e popule as tabelas do banco de dados conforme atividade 5 - UC2.

	-- R: Tabela acrescentada conforme a atividade 5 - UC2 realizada e entregue.

--2) Acrescentar o campo "dataprevista" à tabela emprestimo.
	ALTER TABLE emprestimo ADD COLUMN dataprevista DATE;
	
	SELECT * FROM emprestimo;

--3) Crie uma trigger + função que verifique, antes de um empréstimo ocorrer, se há exemplares disponíveis. Se não houver o usuário deverá receber uma mensagem de erro. Caso haja, o empréstimo deverá ser cadastrado e a quantidade de livros disponíveis deverá ser atualizado.

CREATE OR REPLACE FUNCTION baixaexemplares()
  RETURNS TRIGGER AS $$
DECLARE
    qtde_exemplares INTEGER := 0;
BEGIN
    SELECT exemplares
    FROM livro
    WHERE id = NEW.fklivro INTO qtde_exemplares;
		
    IF qtde_exemplares < 0 THEN
        RAISE EXCEPTION 'Não há exemplares disponíveis para este livro';
    ELSE
        UPDATE livro SET exemplares = qtde_exemplares - 1 WHERE id = NEW.fklivro;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER baixaexemplares
BEFORE INSERT ON emprestimo
FOR EACH ROW
EXECUTE PROCEDURE baixaexemplares();

-- SELECIONAR A TABELA
SELECT * FROM emprestimo;
SELECT * FROM livro;

-- INSERIR DADOS NA TABELA PARA TESTAR
INSERT INTO emprestimo(dataretirada, datadevolucao, multa, fklivro,fkusuario, dataprevista) VALUES
('2023-03-01', '2023-03-06', 0,9,1,'2023-03-07'); 

INSERT INTO emprestimo(dataretirada, datadevolucao, multa, fklivro,fkusuario, dataprevista) VALUES
('2023-03-02', '2023-03-08', 0,10,4,'2023-03-09'); 

--4) Crie outra trigger + função para registrar a devolução de um livro. Se a data atual for maior do que a data prevista para a devolução calcule o valor da multa em 1 real por dia de atraso. Em seguida, altere a quantidade de exemplares disponíveis


CREATE OR REPLACE FUNCTION registrar_devolucao()
RETURNS TRIGGER AS $$
DECLARE
    qtde_exemplares INTEGER;
    dias_atraso INTEGER;
		data_prevista DATE;
BEGIN
    -- Obter quantidade de exemplares na tabela livro
    SELECT exemplares
    FROM livro
    WHERE id = NEW.fklivro
    INTO qtde_exemplares;
		
		-- Obter a dataprevista da tabela emprestimo
		SELECT dataprevista
		FROM emprestimo
		WHERE id = new.id into data_prevista;
   
    -- Calcular dias de atraso entre datas
    dias_atraso := new.datadevolucao - data_prevista;
   
    -- Calcular multa
    IF dias_atraso > 0 THEN
        NEW.multa := dias_atraso * 1;
    END IF;
   
    -- Atualizar quantidade de exemplares disponíveis na tabela livro
    UPDATE livro SET exemplares = qtde_exemplares + 1 WHERE id = NEW.fklivro;
   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--- Trigger
CREATE TRIGGER registrar_devolucao_trigger
BEFORE UPDATE ON emprestimo
FOR EACH ROW
EXECUTE PROCEDURE registrar_devolucao();

-- TESTE
SELECT * from emprestimo;
UPDATE emprestimo SET datadevolucao = '2023-02-20' WHERE id = 1;


--5) Crie uma trigger + procedure que popule uma tabela chamada "emprestimos_bk" com os mesmos dados que forem inseridos na tabela empréstimo.


-- Criar a tabela "emprestimos_bk"

CREATE TABLE IF NOT EXISTS emprestimos_bk (
    id SERIAL PRIMARY KEY,
    fklivro INTEGER NOT NULL,
    fkusuario INTEGER NOT NULL,
		dataretirada DATE NOT NULL,
    dataprevista DATE NOT NULL,
    datadevolucao DATE,
    multa NUMERIC(10,2)
);

-- Procedure
CREATE OR REPLACE FUNCTION emprestimo_backup()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO emprestimos_bk (fklivro, fkusuario, dataretirada, dataprevista, datadevolucao, multa)
    VALUES (NEW.fklivro, NEW.fkusuario, NEW.dataretirada, NEW.dataprevista, NEW.datadevolucao, NEW.multa);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER emprestimo_backup_trigger AFTER INSERT ON emprestimo
FOR EACH ROW EXECUTE FUNCTION emprestimo_backup();

-- Teste
INSERT INTO emprestimo(dataretirada, datadevolucao, multa, fklivro,fkusuario, dataprevista) VALUES
('2023-03-01', '2023-03-06',0,1,5,'2023-03-05');

SELECT * 
FROM emprestimo 
ORDER BY id;

SELECT * 
FROM emprestimos_bk;
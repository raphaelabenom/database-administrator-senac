-- Para o sistema de uma Biblioteca, projetado conforme documentação da Atividade Avaliativa 5, você deverá criar duas triggers:

--1) Decrementar em 1 a quantidade de exemplares sempre que um livro for emprestado, ou seja, sempre que o usuário inserir um registro na tabela Empréstimo.

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

--2) Incrementar em 1 a quantidade de exemplares sempre que um livro for devolvido, ou seja, sempre que o usuário atualizar um registro na tabela empréstimo (lançando a data de devolução).

CREATE OR REPLACE FUNCTION devolucaoexemplares()
  RETURNS TRIGGER AS $$
BEGIN
  IF NEW.datadevolucao IS NOT NULL THEN
    UPDATE livro SET exemplares = exemplares + 1 WHERE id = NEW.fklivro;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER devolucaoexemplares
AFTER UPDATE ON emprestimo
FOR EACH ROW
EXECUTE FUNCTION devolucaoexemplares();

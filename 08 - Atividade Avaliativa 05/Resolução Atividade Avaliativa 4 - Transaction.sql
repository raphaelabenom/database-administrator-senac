-- CRIAR TABELA AUDITORIA
CREATE TABLE biblioteca_auditoria
(
id_log serial PRIMARY KEY,
id_livro INTEGER REFERENCES livro(id),
id_usuario INTEGER REFERENCES usuario(id),
operacao VARCHAR,
datahora TIMESTAMP
);

-- CRIAR UMA FUNCTION
CREATE OR REPLACE FUNCTION log_auditoria()
RETURNS TRIGGER AS $$
DECLARE
id_livro INTEGER;
BEGIN
  SELECT ID
  FROM livro
  WHERE id = new.id
   INTO id_livro;

 INSERT INTO biblioteca_auditoria (id_livro, operacao, datahora,)
 VALUES (id_livro, TG_OP, CURRENT_TIMESTAMP);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- CRIAR TRIGGER
CREATE OR REPLACE TRIGGER log_auditoria
AFTER INSERT OR UPDATE OR DELETE ON livro
FOR EACH ROW EXECUTE PROCEDURE log_auditoria()


------------

UPDATE livro SET exemplares = exemplares - 1 WHERE id = 4;
INSERT INTO livro VALUES ()

SELECT * FROM livro;
SELECT * FROM emprestimo;
SELECT * FROM biblioteca_auditoria;

DROP TABLE biblioteca_auditoria;
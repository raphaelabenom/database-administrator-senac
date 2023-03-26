-- 1) Crie uma função que retorne uma trigger para dar baixa no estoque do sistema de uma loja quando uma venda acontecer. Os esquemas/modelos do Banco de Dados são os seguintes:

-- Produto
--     cod_produto: varchar
--     descricao: varchar
--     qtde_disponivel: integer

-- ItensVenda
--     cod_venda: varchar
--     fk_produto: varchar FK
--     qtde_vendida: integer



-- 1) CRIAR AS TABELAS

CREATE TABLE produtos (
	cod_produto VARCHAR PRIMARY KEY,
	descricao VARCHAR NOT NULL,
	qtde_disponivel INTEGER DEFAULT 0
);

CREATE TABLE itens_vendas (
	cod_venda VARCHAR PRIMARY KEY,
	fk_produto VARCHAR REFERENCES produtos(cod_produto),
	qtde_vendida INTEGER NOT NULL
);

-- 2) POPULAR A TABELA PRODUTOS

INSERT INTO produtos(qtde_disponivel, descricao, cod_produto) VALUES
	(10, 'Coca-cola', 'XPTO'),
	(8, 'Guaraná Antártica', 'ABCD'),
	(2, 'Fanta Uva', 'WXYZ');

-- 3) CRIAR UMA FUNÇÃO

CREATE FUNCTION baixa_estoque()     
RETURNS TRIGGER LANGUAGE plpgsql AS $$    
DECLARE    
	qtde_em_estoque INTEGER = 0;
BEGIN 
	-- Captura o valor no Result Set da consulta e atribui a uma variável
	SELECT qtde_disponivel FROM produto 
	WHERE cod_produto = NEW.fk_produto
	INTO qtde_em_estoque;
	-- Verifica se a quantidade a ser vendida é superior à quantidade disponível em estoque
	IF ( NEW.qtde_vendida > qtde_em_estoque ) THEN
		RAISE EXCEPTION 'Quantidade indisponível no estoque';
	ELSE
		-- Lança a venda na tabela itens_vendas
		-- INSERT INTO itens_vendas VALUES NEW.cod_venda, NEW.fk_produto, NEW.qtde_vendida
		-- Dar a baixa no estoque
		UPDATE produtos 
		SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
		WHERE cod_produto = NEW.fk_produto;
	END IF;
RETURN NEW;
END;   
$$  

-- 4) CRIAR UMA TRIGGER QUE CHAME A FUNÇÃO

CREATE TRIGGER trigger_baixa_estoque()
BEFORE INSERT ON itens_vendas
FOR EACH ROW
EXECUTE PROCEDURE baixa_estoque();

-- 5) POPULAR A TABELA ITENS_VENDAS E VER A MÁGICA ACONTECER
INSERT INTO itens_vendas VALUES 
	('1001', 'WXYZ', 3);




-- ADMINISTRADOR DE BANCO DE DADOS


CREATE TABLE produtos (
	id_produto VARCHAR PRIMARY KEY,
	descricao VARCHAR,
	valor_unitario VARCHAR,
	categoria VARCHAR,
	qtde_estoque VARCHAR
);

CREATE TABLE funcionarios (
	id_funcionario VARCHAR PRIMARY KEY,
	cpf_funcionario VARCHAR,
	nome_funcionario VARCHAR,
	cargo VARCHAR,
	departamento VARCHAR,
	salario VARCHAR
);

CREATE TABLE clientes (
	id_cliente VARCHAR PRIMARY KEY,
	cpf_cliente VARCHAR,
	nome_cliente VARCHAR
);

CREATE TABLE vendas (
	id_venda VARCHAR PRIMARY KEY,
	dataehora VARCHAR,
	valor_total VARCHAR,
	forma_pgto VARCHAR,
	fk_cliente VARCHAR REFERENCES clientes (id_cliente),
	fk_funcionario VARCHAR REFERENCES funcionarios (id_funcionario)
);

CREATE TABLE produtos_vendas (
	fk_venda VARCHAR REFERENCES vendas (id_venda),
	fk_produto VARCHAR REFERENCES produtos (id_produto),
	qtde_adquirida VARCHAR
);


CREATE TABLE produtos_auditoria 
(
id_log SERIAL PRIMARY KEY,
operacao VARCHAR,
dataehora VARCHAR,
fk_produto VARCHAR REFERENCES produtos (id_produto),
fk_funcionario VARCHAR REFERENCES funcionarios (id_funcionario)
);



--- POPULAR


INSERT INTO produtos (id_produto, descricao , valor_unitario, categoria, qtde_estoque) VALUES
	('54298', 'iPhone 6s 32 GB - Rosé', '4499,00', 'Celular', '10'),
	('53195', 'Smartphone Caterpillar S41', '4999,99', 'Celular', '20'),
	('34281', 'Câmera Bullet Varifocal', '999,99', 'Câmera de segurança', '5'),
	('27624', 'Microfone Sem Fio', '149,99', 'Microfone', '10'),
	('97974', 'Subwoofer Bose 700 + Soundbar Bose 700 Wi-Fi Bluetooth', '559,90', 'Soundbar', '5'),
	('96776', 'Smart TV LED Samsung 50', '3999,99', 'TV', '15'),
	('96552', 'Caixa de Som Portátil', '119,99', 'Caixa de som', '5'),
	('27354', 'Pedestal para TV', '87,99', 'Pedestal para TV', '10'),
	('71425', 'Headset Htu-310 USB com Tubo de Voz Removível', '189,99', 'Headset', '8'),
	('63157', 'Arranhador casa com rede', '59,99', 'Antipulgas', '10'),
	('66982', 'Cama Suspensa Mec Dreams Tamanho GG Cor Azul Mec G', '99,99', 'Cama para pet', '5'),
	('17498', 'Chocadeira Automática Chocmais 220V 56 Ovos Com Ovoscópio', '89,99', 'Chocadeira', '3'),
	('50248', 'Coleira Seresto Cães e Gatos até 8 Kg', '10,79', 'Coleira', '2'),
	('96441', 'Kit Coleira Antipulgas Seresto Com 2 Acima De 8 kg Bayer', '55,55', 'Coleira', '5'),
	('95582', 'Gaiola para Calopsita Maritaca Papagaio Viveiro', '110,10', 'Gaiola', '3'),
	('17272', 'Ração Carpa Poytara Premium Mix 6 Sticks 6kg', '59,99', 'Ração', '5'),
	('09900', 'Ração Royal Canin Shih Tzu 24 Adulto 7,5 kg', '59,78', 'Ração', '3'),
	('92839', 'Ração Royal Canin Medium Junior Filhote 15 kg', '55,87', 'Ração', '4'),
	('53195', 'Escova Modeladora Faet Pronto 110 V', '69,70', 'Escova modeladora', '3'),
	('54298', 'Cinta Modeladora Abdominal Vibratória Ajustável Tonificador', '79,99', 'Cinta vibratória', '4'),
	('65548', 'Blancy TX Gel Creme Clareador 30g', '150,99', 'Gel', '5'),
	('28006', 'Máquina de Corte Bordado - Hair Trimmer Bivolt', '499,99', 'Máquina de cortar cabelo', '1'),
	('99646', 'Adipômetro Clínico Preto + Trena Corporal Avaliação Física', '155,99', 'Adipômetro', '23'),
	('75402', 'Water Pulse - Irrigador Oral Dental W300g Bivolt - Higiene Bucal', '45,78', 'Irrigador oral', '12'),
	('04719', 'Shampoo Wella - Brilliance Invigo 1 L', '28,90', 'Shampoo', '3'),
	('13985', 'Cosmelan Pack | Kit Para Tratamento de Melasma', '63,99', 'Kit de tratamento facial', '9'),
	('99768', 'Nano Sérum Immortalité-C 50 ml - Tulípia', '9,99', 'Sérum', '7'),
	('93250', 'Ração Royal Canin Feline Veterinary Renal Gatos 7,5 kg', '110,55', 'Ração', '5'),
	('59298', 'iPhone 10 PRO 1 TB - Black', '14990,90', 'Celular', '10'),
	('54105', 'Smartphone S20 Samsung', '5909,99', 'Celular', '15');

INSERT INTO clientes (id_cliente, cpf_cliente, nome_cliente) VALUES 
    ('001', '123.456.789-10', 'João Silva'),
    ('002', '987.654.321-00', 'Maria Souza'),
    ('003', '456.789.123-11', 'Pedro Andrade'),
    ('004', '222.333.444-55', 'Juliana Santos'),
    ('005', '111.222.333-44', 'Fernando Oliveira'),
    ('006', '555.666.777-88', 'Isabela Rocha'),
    ('007', '666.777.888-99', 'Ricardo Pereira'),
    ('008', '999.888.777.66', 'Amanda Costa'),
    ('009', '777.888.999-10', 'Lucas Souza'),
    ('010', '222.555.888-33', 'Carla Gonçalves');

INSERT INTO funcionarios (id_funcionario, cpf_funcionario, nome_funcionario, cargo, departamento, salario) VALUES 
    ('001', '123.456.789-10', 'João Silva', 'Analista de Sistemas', 'TI', '5000.00'),
    ('002', '987.654.321-00', 'Maria Souza', 'Gerente de Vendas', 'Comercial', '8000.00'),
    ('003', '456.789.123-11', 'Pedro Andrade', 'Assistente Administrativo', 'Administração', '3000.00'),
    ('004', '222.333.444-55', 'Juliana Santos', 'Analista de Marketing', 'Marketing', '5500.00');


INSERT INTO vendas (id_venda, dataehora, valor_total, forma_pgto, fk_cliente, fk_funcionario)
VALUES 
	('001', '2022-01-01 10:00:00', '100.00', 'Cartão de crédito', '001', '001'),
	('002', '2022-01-01 11:00:00', '50.00', 'Dinheiro', '002', '001'),
	('003', '2022-01-01 12:00:00', '75.50', 'Cartão de débito', '003', '002'),
	('004', '2022-01-02 13:00:00', '30.00', 'Dinheiro', '004', '002'),
	('005', '2022-01-02 14:00:00', '200.00', 'Transferência bancária', '001', '003'),
	('006', '2022-01-02 15:00:00', '150.00', 'Cartão de crédito', '002', '003'),
	('007', '2022-01-03 16:00:00', '80.00', 'Dinheiro', '003', '004'),
	('008', '2022-01-03 17:00:00', '120.00', 'Cartão de débito', '004', '004'),
	('009', '2022-01-04 18:00:00', '90.00', 'Dinheiro', '001', '004'),
	('010', '2022-01-04 19:00:00', '50.00', 'Cartão de crédito', '002', '001'),
	('011', '2022-01-05 20:00:00', '25.00', 'Transferência bancária', '003', '004'),
	('012', '2022-01-05 21:00:00', '60.00', 'Dinheiro', '004', '003'),
	('013', '2022-01-06 22:00:00', '95.00', 'Cartão de débito', '001', '002'),
	('014', '2022-01-06 23:00:00', '75.00', 'Dinheiro', '002', '004'),
	('015', '2022-01-07 10:00:00', '200.00', 'Cartão de crédito', '003', '002');

-- DELETAR O CAMPO VALOR_TOTAL
ALTER TABLE vendas DROP COLUMN valor_total;

-----> 

INSERT INTO produtos_vendas (fk_venda, fk_produto, qtde_adquirida) VALUES 
('001', '54298', '2'),
('001', '54298', '3'),
('001', '53195', '1'),
('002', '54298', '4'),
('002', '65548', '2'),
('003', '65548', '3'),
('003', '28006', '1'),
('003', '50248', '2'),
('004', '66982', '1'),
('004', '54298', '5'),
('004', '99646', '2'),
('004', '99646', '2'),
('005', '54105', '3'),
('006', '97974', '2'),
('007', '97974', '1');

-- 9)

CREATE OR REPLACE FUNCTION log_auditoria_produto() 
RETURNS TRIGGER AS $$


BEGIN

	INSERT INTO produtos_auditoria  (operacao, dataehora, fk_produto)
	VALUES
		(TG_OP, CURRENT_TIMESTAMP, new.id_produto);

RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER auditoria_produto
AFTER INSERT OR UPDATE OR DELETE
ON produtos
FOR EACH ROW
EXECUTE PROCEDURE log_auditoria_produto() ;

-- 10)

-- FUNCTION
CREATE OR REPLACE FUNCTION registrarVenda ()
RETURNS TRIGGER AS $$

DECLARE
	qtd_estoque int;

BEGIN
	SELECT 
		qtde_estoque
	FROM produtos
	WHERE id_produto = TG_ARGV[0]
	INTO qtd_estoque;

	IF (TG_ARGV[1]::int > qtd_estoque) THEN
		RAISE NOTICE 'Quantidade indisponível no momento!!';
	ELSE 
		INSERT INTO produtos_vendas VALUES
		(NEW.id_venda, TG_ARGV[0], TG_ARGV[1]::int);
		
		select baixaEstoque(TG_ARGV[1]::int, TG_ARGV[0]);
	END IF;
	
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE OR REPLACE TRIGGER novaVenda
AFTER INSERT ON vendas
FOR EACH ROW
EXECUTE PROCEDURE registrarVenda('1', 5);

-- FUNCTION
CREATE OR REPLACE FUNCTION baixaEstoque (qtde_comprada int, produto varchar)
RETURNS VOID AS $$

BEGIN
	
	UPDATE produtos SET qtde_estoque = qtde_estoque - qtde_comprada
	WHERE id_produto = produto;

END;
$$ LANGUAGE plpgsql;


-- TESTE

select * from produtos

ALTER TABLE produtos
ALTER COLUMN qtde_estoque TYPE INTEGER USING qtde_estoque::integer

ALTER TABLE produtos_vendas
ALTER COLUMN qtde_adquirida TYPE INTEGER USING qtde_adquirida::integer

select * from funcionarios

INSERT INTO vendas VALUES
('1', '21/03/2023', 'pix', '001', '001');




-- VIEW

-- Total de produtos por categoria
CREATE VIEW totalcategoria AS
SELECT categoria, 
		COUNT(categoria) AS totalcategoria
FROM produtos
GROUP BY categoria
ORDER BY totalcategoria desc;


-- Produtos mais vendidos (Maior/Menor)
CREATE VIEW maisvendidos AS
SELECT produtos.descricao, 
		fk_produto, SUM(qtde_adquirida) AS total
FROM produtos_vendas
INNER JOIN produtos 
ON 
	produtos.id_produto = 
	produtos_vendas.fk_produto
GROUP BY 
		produtos.descricao, 
		fk_produto
ORDER BY total DESC;

ALTER TABLE produtos_vendas ALTER COLUMN qtde_adquirida TYPE INTEGER using qtde_adquirida::INT;


-- Vendas por funcionário
CREATE VIEW vendas_funcionario AS
SELECT nome_funcionario, 
		count(fk_funcionario) as vendas_funcionario
FROM vendas
JOIN funcionarios
ON 
	vendas.fk_funcionario = 
	funcionarios.id_funcionario
GROUP BY nome_funcionario
ORDER BY vendas_funcionario DESC;

-- Criar permissões de acesso (roles)

-- Funcionario (FUNÇOES)
CREATE ROLE funcionario WITH
LOGIN ENCRYPTED PASSWORD 'internet'
CONNECTION LIMIT 5; -- -1 É ILIMITADO

GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO funcionario;

GRANT SELECT, UPDATE, DELETE ON IN SCHEMA public TO funcionario;

-- Gerente (VIEW)
CREATE ROLE gerente WITH
LOGIN ENCRYPTED PASSWORD 'internetvida'
CONNECTION LIMIT 5; -- -1 É ILIMITADO

GRANT SELECT ON 
	maisvendidos, 
	totalcategoria, vendas_funcionario 
TO gerente;

-- Remover a permissão de edição (update e delete) das tabelas vendas e produto_vendas
REVOKE UPDATE, DELETE ON vendas FROM funcionario;
REVOKE UPDATE, DELETE ON produtos_vendas FROM funcionario;

REVOKE UPDATE, DELETE ON vendas FROM gerente;
REVOKE UPDATE, DELETE ON produtos_vendas FROM gerente;
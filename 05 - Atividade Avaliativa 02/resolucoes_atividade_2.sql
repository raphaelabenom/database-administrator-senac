-- Questão 01
-- Quantas aldeias e quantas terras indígenas existem em cada UF (Unidade da Federação)?

CREATE VIEW qtde_terras_aldeias_uf AS
SELECT nomuf AS estado,
COUNT (distinct terrai_codigo) AS terras,
COUNT (distinct cod_aldeia) AS aldeias
FROM aldeias FULL JOIN terras 
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY nomuf
ORDER BY nomuf;

-- Questão 02
-- Quantas aldeias existem para cada etnia indígena?
CREATE VIEW qtde_aldeias_etnia AS
SELECT etnia_nome AS etnia,
COUNT (distinct cod_aldeia) AS aldeias
FROM aldeias FULL JOIN terras 
ON aldeias.cod_ti = terras.terrai_codigo
GROUP BY etnia
ORDER BY aldeias DESC;

-- Questão 03
-- Qual etnia indígena possui mais aldeias?

-- Proposta 1: Obtenha o valor máximo de aldeias numa subconsulta e filtre a aldeia correspondente.
SELECT etnia FROM qtde_aldeias_etnia
WHERE aldeias = (SELECT MAX(aldeias) FROM qtde_aldeias_etnia);

-- Proposta 2: Como o Result Set já está ordenado de maneira decrescente, basta buscar o primeiro registro.
SELECT * FROM qtde_aldeias_etnia LIMIT 1;

-- Questão 04
-- Mostre as etnias cuja quantidade de aldeias seja superior à media.
SELECT * FROM qtde_aldeias_etnia
WHERE aldeias > (SELECT AVG(aldeias) FROM qtde_aldeias_etnia)



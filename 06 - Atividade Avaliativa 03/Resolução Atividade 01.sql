CREATE TABLE funcionarios (
id char(8),
nome varchar,
sobrenome varchar,
cargo varchar,
datanascimento date,
salario numeric,
temposervico int,
nivel varchar
);

INSERT INTO funcionarios (
      id,
      nome,
      sobrenome,
      cargo,
      datanascimento,
      salario,
      temposervico,
      nivel
      ) 
VALUES 
(1, 'Maggie','Simpson','Telemarketing','2010-04-19',3000,2,'J'),
(2, 'Maria', 'Santos','Operadora de caixa','2000-08-25',4500,5,'J'),
(3, 'João', 'Sempron','Coordenador','1996-04-19',9200,10,'P'),
(4, 'Mario', 'Mustan','Diretor','1990-03-01',22000,12,'S');

SELECT id,
nome,
sobrenome,
cargo,
datanascimento,
salario,
temposervico
FROM funcionarios;

DROP TABLE 

--Calcular a idade em anos
CREATE VIEW funcionarioatuais AS
      SELECT id,
      nome,
      sobrenome,
      cargo,
      datanascimento,
      salario,
      temposervico, 
      senioridade, 
EXTRACT(YEAR FROM age(datanascimento)) AS idadeanos 
      FROM funcionarios;

--Questão 1
--Liste o nome e sobrenome de todos os funcionários que são programadores. Como você faria para que o resultado dessa busca também funcionasse caso a descrição do cargo fosse "programadora"? 

SELECT 
      nome, 
      sobrenome
FROM funcionarios
      WHERE cargo 
      LIKE "%programador%";

--Questão 2
--Liste o nome, sobrenome e tempo de serviço dos funcionários que ganham entre 5 mil reais e 20 mil reais. Na sua opinião, qual seria um bom critério de ordenação para este Result Set? Justifique sua resposta.

SELECT 
      nome,
      sobrenome, 
      temposervico
FROM funcionarios
WHERE salario BETWEEN 5000 AND 20000;

--Questão 3 
--Liste nome, sobrenome e tempo de serviço do funcionário com o maior salário.
SELECT 
      nome,
      sobrenome,
      cargo, 
      temposervico
FROM funcionarios
WHERE salario = (SELECT MAX(salario) FROM funcionario);

--Questão 4
--Crie uma view que possua um campo calculado chamado "idade" que armazene a idade do funcionário em anos em relação à data atual.
CREATE VIEW funcionarioatuais AS
SELECT 
      id,
      nome,
      sobrenome,
      cargo,
      datanascimento,
      salario,
      temposervico,
      senioridade, 
      EXTRACT(YEAR FROM age(datanascimento)) AS idadeanos 
FROM funcionarios;

--Questão 5
--Liste todos os dados dos funcionários mais jovens, ordenado pelo salário.

SELECT 
      id,
      nome,
      sobrenome,
      cargo,
      datanascimento,
      salario,
      temposervico,
      idadeanos
FROM funcionariosemanos
WHERE 
      idadeanos = (
      SELECT MIN(idadeanos) AS idademenor 
      FROM funcionariosemanos)
ORDER BY salario;

--6. Qual é a média salarial dos funcionarios desta empresa.
CREATE VIEW funcionariosmedia AS
SELECT
      id,
      nome,
      sobrenome,
      cargo,
      datanascimento,
      salario,
      temposervico,
      idadeanos,
      senioridade,
      AVG(salario)::integer AS mediasalario
FROM funcionarioS;


--7. Exiba o nome completo, cargo e salário de todos os funcionários que ganham acima da média.
SELECT 
      nome,
      sobrenome,
      cargo,
      salario
FROM funcionariosemanos
WHERE 
      salario >= (SELECT 
      AVG(salario)::integer AS mediasalario
FROM funcionariosemanos);


--8. Acrescente à está tabela a coluna 'Nível' onde irá constar a informação do nível de senioridade do funcionário no cargo ocupado.
ALTER TABLE funcionarios ADD COLUMN senioridade varchar;

UPDATE funcionarios SET salario=10000 WHERE id='3';

UPDATE funcionarios SET salario=3500 WHERE ID='1';

SELECT * FROM funcionarios;

--9. Calcule a média salarial por nível de senioridade e conte quantos funcionários recebem valor acima da média em cada nível no mesmo resultset.

SELECT 
      senioridade,
      AVG(salario)::integer AS mediasalario, 
      COUNT(senioridade) as senioridadecontar
FROM funcionarioatuais
GROUP BY 
      senioridade, 
      salario
HAVING salario >= (SELECT 
      AVG(salario)::integer 
      FROM funcionarioatuais);

--10 Suponhamos que a média salarial por nível de senioridade praticada no mercado seja:
--Junior - 3.5 mil
--Pleno - 7 mil
--Senior - 12 mil

--Calcule quantos funcionarios ganham acima da média do mercado em cada nível.
CREATE TABLE mediamercado (
id varchar,
senioridade varchar,
mediamercado numeric
);

ALTER TABLE mediamercado ADD COLUMN id varchar;

DELETE 

INSERT INTO mediamercado (ID, senioridade, mediamercado) 
VALUES 
('1','J',3500),
('2','P',7000),
('3','S',12000);

SELECT * FROM mediamercado;

drop table mediamercado

SELECT 
      senioridade,
      AVG(salario)::integer AS mediasalario, 
      COUNT(senioridade) AS senioridadecontar
FROM funcionarioatuais
GROUP BY senioridade, salario
HAVING salario >= (SELECT AVG(salario)::integer FROM funcionarioatuais);

SELECT *
FROM funcionarios
FULL JOIN mediamercado
ON funcionarios.id = mediamercado.id;

--Média salarial de todos os funcionários
SELECT 
      AVG(salario)::INTEGER FROM funcionarios;

SELECT * FROM funcionarios;

-- Valores individuais
SELECT 
      nivel, 
      COUNT(salario) as salariomaiormedia
FROM funcionarios
WHERE nivel = 'S' AND salario >= 12000
GROUP BY nivel;

SELECT 
      nivel, 
      COUNT(salario) as salariomaiormedia
FROM funcionarios
WHERE nivel = 'P' AND salario >= 7000
GROUP BY nivel;

SELECT nivel, COUNT(salario) as salariomaiormedia
FROM funcionarios
WHERE nivel = 'J' AND salario >= 1200
GROUP BY nivel;


---Resposta 
SELECT 
      nivel, 
      COUNT(salario) as qtdsalariomaiormedia
FROM funcionarios
WHERE (nivel = 'J' AND salario >= 3500) OR
      (nivel = 'P' AND salario >= 7000) OR
      (nivel = 'S' AND salario >= 12000)
GROUP BY nivel;
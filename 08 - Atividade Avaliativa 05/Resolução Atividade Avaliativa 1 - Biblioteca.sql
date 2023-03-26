-- Reposta da QUESTÃO 1
-- Todos os campos selecionados para receber as constraints NOT NULL e/ou UNIQUE foram escolhidas levando em consideração a importância daquela informação na tabela e na regra de negócio da livraria;
-- Identifique nas tabelas acima quais campos devem receber as constraints NOT NULL e/ou UNIQUE. Justifique as suas escolhas.

-- TABELA LIVRO
-- id: NOTNULL UNIQUE - Por padrão a chave primária é configurada com as duas configurações garantindo sua unicidade e identificação.
-- titulo: NOTNULL- este campo é importante para identificar o nome do livro, por isso não pode ser nulo.
-- genero: NOTNULL- este campo é importante para agrupar os livros pelo os seus respectivos gêneros, por isso não pode ser nulo.
-- exemplares: NOTNULL - este campo é importante para identificar a quantidade de livros na biblioteca, é uma métricas de aquisição, locação e controle da biblioteca por isso não pode ser nulo.
-- anopubli: NOT NULL - este campo é importante para organizar/consultar os livros por ordem cronológica, período, por isso não pode ser nulo.
-- fkautor: NOTNULL - Chave estrangeira da tabela AUTOR.
-- fkeditora: NOTNULL - Chave estrangeira da tabela EDITORA.

-- TABELA EDITORA
-- id: NOTNULL UNIQUE - Por padrão a chave primária é configurada com as duas configurações garantindo sua unicidade e identificação
-- nome: NOT NULL - Sem um nome, a editora não pode ser identificada.
-- localização: NOT NULL - Embora não seja obrigatório, é importante para identificar a localização da editora.
-- fone: NOT NULL - É importante ter um número de telefone para contatar a editora.
-- email: UNIQUE - É importante identificar a editora por seu endereço de email único.

-- TABELA AUTOR
-- id: NOTNULL UNIQUE - Por padrão a chave primária é configurada com as duas configurações garantindo sua unicidade e identificação
-- Nome: NOTNULL- este campo é importante para identificar o autor do livro, por isso não pode ser nulo.
-- Nacionalidade: este campo não é importante, mas serve para segregação por país de cada autor, para criar filtros.

-- TABELA USUARIO
-- id: NOTNULL UNIQUE - Por padrão a chave primária é configurada com as duas configurações garantindo sua unicidade e identificação
-- cpf: NOTNULL UNIQUE - para garantir que cada usuário tenha um CPF único e para identificar o usuário da biblioteca, por isso não pode ser nulo.
-- nome: NOTNULL- este campo é importante para identificar o usuário, por isso não pode ser nulo.
-- fone: NOT NULL - É importante ter um número de telefone para contatar a usuário caso ocorra atraso na entrega do livro, pode se criar um automatização para envio de SMS/Whatsapp para envio da data de entrega.
-- email: UNIQUE - para garantir que cada usuário tenha um e-mail único.
-- datanasc: NOT NULL - este campo é importante para identificar a idade (métrica) de cada usuário, por isso não pode ser nulo.

-- Reposta da QUESTÃO 2 - Está na própria construção das tabelas, SQL;

-- Reposta da QUESTÃO 3
-- Quais tabelas devem ser criadas e populadas primeiro? Por quê?
-- A regra é que as tabelas que são referenciadas por outras tabelas, devem sempre ser criadas primeiro. Isso se deve ao fato de que, para criar uma chave estrangeira em uma tabela, é necessário que a tabela referenciada já exista para se criar uma relação.

--   Assim as tabelas (core) que serão criadas primeiro serão:
--   CREATE TABLE autor
--   CREATE TABLE editora
--   CREATE TABLE usuario

-- Reposta da QUESTÃO 4

-- TABELA AUTOR
CREATE TABLE autor (
    id serial,
    nome varchar NOT NULL,
    nacionalidade varchar NOT NULL,
    nobel boolean,
    PRIMARY KEY(id)
)

-- POPULAÇÃO AUTOR
INSERT INTO autor (nome, nacionalidade, nobel)
VALUES 
('Machado de Assis', 'Brasileiro', FALSE),
('José de Alencar', 'Brasileiro', FALSE),
('Lima Barreto', 'Brasileiro', FALSE),
('Joaquim Manuel de Macedo', 'Brasileiro', FALSE),
('João Cabral de Melo Neto', 'Brasileiro', FALSE),
('Euclides da Cunha', 'Brasileiro', FALSE),
('Graciliano Ramos', 'Brasileiro', FALSE),
('José Lins do Rêgo', 'Brasileiro', FALSE),
('Cecília Meireles', 'Brasileiro', FALSE),
('Lygia Fagundes Telles', 'Brasileiro', FALSE),
('Clarice Lispector', 'Ucraniana', TRUE),
('Érico Veríssimo', 'Brasileiro', FALSE),
('Manuel Antônio de Almeida', 'Brasileiro', FALSE),
('Pablo Neruda', 'Chileno', TRUE),
('Gabriel Garcia Márquez', 'Colonbiano', TRUE),
('Carlos Ruiz Zafón', 'Espanhou', FALSE);

-- POPULAÇÃO EDITORA
CREATE TABLE editora (
    id serial,
    nome varchar NOT NULL,
    fone varchar NOT NULL,
    email varchar UNIQUE,
    localizacao varchar,
    PRIMARY KEY(id)
)

-- POPULAÇÃO EDITORA
INSERT INTO editora (nome,fone,email,localizacao)
VALUES
('Editora Globo','35372840','editoraglobo@outlook.com','São Paulo'),
('Editora Aleph','9291421326','editoraaleph@outlook.com','Rio janeiro'),
('Editora 34','92914112','editora34@outlook.com','Parana'),
('Editora Rocco','39405219','editorarocco@outlook.com','Belo Horizonte'),
('Companhia das Letras','39292637','companhiadasletras@outlook.com','Espirito Santo');

-- TABELA USUARIO
CREATE TABLE usuario (
    id serial,
    cpf char(11) UNIQUE NOT NULL,
    nome varchar NOT NULL,
    fone varchar NOT NULL,
    email varchar UNIQUE,
    datanasc date NOT NULL,
    PRIMARY KEY (id)
)

-- POPULAÇÃO USUARIO
INSERT INTO usuario (cpf, nome, fone, email, datanasc)
VALUES
('51603254170', 'Jose da Silva', '6284900139', 'josesilva@outlook.com', '1995-03-31'),
('61703254190', 'Joao da Silva', '6285103923', 'joaosilva@outlook.com', '1980-04-01'),
('55131646391', 'Ana da Silva', '1193991457', 'anasilva@gmail.com', '1984-02-04'),
('12699635626', 'Maria Aparecida', '2732087266', 'mariaaparecida@hotmail.com', '1996-04-01'),
('77760782470', 'Maria das Gracas', '6285103923', 'mariadasgracas@outlook.com', '1971-05-12'),
('51816654620', 'Maria Jose', '9993046622', 'mariajose@outlook.com', '1959-06-06'),
('46441343339', 'Joana Pereira', '6285103923', 'mariasilveiradasgracas@outlook.com', '2001-05-12'),
('02111503630', 'Ana Pereira', '6283012450', 'anapereira@hotmail.com', '2007-06-08'),
('72746429527', 'Bento Ferreira', '6235325729', 'bentoferreira@outlook.com', '2004-11-10'),
('97688175690', 'Claudio Ferreira', '6294801125', 'claudioferreira@gmail.com', '2009-09-17');

-- TABELA LIVRO
CREATE TABLE livro (
    id serial,
    titulo varchar NOT NULL,
    genero varchar NOT NULL,
    faixaetaria varchar,
    exemplares integer NOT NULL,
    anopubli integer NOT NULL,
    bestseller boolean,
    fkautor integer NOT NULL,
    fkeditora integer NOT NULL,
    FOREIGN KEY(fkautor) REFERENCES autor(id),
    FOREIGN KEY(fkeditora) REFERENCES editora(id),
    PRIMARY KEY(id)
)

-- Reposta da QUESTÃO 5

-- POPULAÇÃO LIVRO
INSERT INTO livro (titulo, genero, faixaetaria, exemplares, anopubli, bestseller, fkautor, fkeditora)
VALUES
('Dom Casmurro','Romance','16',10,1899,TRUE,1,1),
('Iracema','Romance','18',4,1865,TRUE,1,1),
('O Guarani','Romance','17',8,1857,TRUE,2,1),
('Senhora','Romance','14',3,1875,TRUE,2,1),
('Triste Fim de Policarpo Quaresma','Romance','18',5,1915,TRUE,3,1),
('A Moreninha','Romance','16',5,1865,TRUE,4,1),
('Morte e Vida Severina','Poesia','14',2,1955,TRUE,5,2),
('Os Sertões','Reportagem','16',3,1902,TRUE,6,2),
('Memórias Póstumas de Brás Cubas','Romance','12',8,1865,TRUE,1,2),
('Vidas Secas','Novela','14',4,1938,TRUE,7,3),
('Menino de Engenho','Novela','16',7,1966,TRUE,8,3),
('Romanceiro da Inconfidência','Poema','17',1,1953,TRUE,9,3),
('Ciranda de Pedra','Ficção','16',10,1965,TRUE,11,3),
('Perto do Coração Selvagem','Novela','18',6,1944,TRUE,12,3),
('A Hora da Estrela','Romance','16',6,1977,TRUE,12,3),
('O tempo e o vento – O continente – Volume 1','Romance','16',4,1977,TRUE,12,4),
('O tempo e o vento – O continente – Volume 2','Romance','16',4,1977,TRUE,12,4),
('O tempo e o vento – O retrato – Volume 1','Romance','16',4,1977,TRUE,12,4),
('O tempo e o vento – O retrato – Volume 2','Romance','16',4,1977,TRUE,12,4),
('O tempo e o vento – O arquipélago – Volume 1','Romance','16',2,1977,TRUE,12,4),
('O tempo e o vento – O arquipélago – Volume 2','Romance','16',2,1977,TRUE,12,4),
('O tempo e o vento – O arquipélago – Volume 3','Romance','16',2,1977,FALSE,12,4),
('Memórias de um Sargento de Milícias','Romance','17',15,1854,FALSE,14,4),
('Cem Sonetos de Amor','Poema','14',15,1904,FALSE,14,4),
('Crepusculário','Poema','12',7,1931,FALSE,14,4),
('Cem Anos de Solidão','Novela','17',12,1967,FALSE,15,5),
('A sombra do vento','Novela','16',3,2001,FALSE,16,5),
('O jogo do anjo','Novela','14',3,2008,FALSE,16,5),
('O prisioneiro do céu','Novela','18',3,2011,FALSE,16,5),
('O labirinto dos espíritos','Novela','18',1,2016,FALSE,16,5);

-- TABELA EMPRESTIMO
CREATE TABLE emprestimo (
    id serial,
    dataretirada date NOT NULL,
    datadevolucao date NOT NULL,
    multa numeric(10,2),
    fklivro integer,
    fkusuario integer,
    PRIMARY KEY(id),
    FOREIGN KEY(fklivro) REFERENCES livro(id),
    FOREIGN KEY(fkusuario) REFERENCES usuario(id)  
)

-- Reposta da QUESTÃO 6
-- POPULAÇÃO EMPRESTIMO
INSERT INTO emprestimo(dataretirada, datadevolucao, multa, fklivro,fkusuario) VALUES
('2023-02-10', '2023-02-17', 0,1,1), 
('2023-02-08', '2023-02-15', 0,15,4), 
('2023-02-08', '2023-02-15', 0,14,4), 
('2023-02-02', '2023-02-09', 1.00,13,5), 
('2023-01-30', '2023-02-06', 0.00,27,9),
('2023-02-06', '2023-02-13', 0.00,28,9),
('2023-02-13', '2023-02-20', 1.00,29,9),
('2023-02-20', '2023-02-27', 1.00,30,9);


-- Reposta da QUESTÃO 7 - Altere a quantidade de exemplares disponíveis de cada livro de acordo com os eventos do
exercício anterior.
UPDATE livro 
SET exemplares = 9
WHERE id = 1;

UPDATE livro 
SET exemplares = 4
WHERE id IN(14,15);

UPDATE livro 
SET exemplares = 4
WHERE id = 6;

UPDATE livro 
SET exemplares = 9
WHERE id = 13;

UPDATE livro 
SET exemplares = 2
WHERE id IN(27,28,29);

UPDATE livro 
SET exemplares = 0
WHERE id = 30;

-- Reposta da QUESTÃO 8
--A) Exclua a coluna “nobel” da tabela AUTOR.

ALTER TABLE autor DROP COLUMN nobel;

--B) Acrescente a coluna sexo do tipo char(1) na tabela AUTOR e na tabela USUARIO. Na
--mesma instrução, insira uma constraint que restrinja os valores possíveis para este
--campo às opções M ou F - M para o sexo masculino e F para o sexo feminino.
--Respostas:

ALTER TABLE usuario ADD COLUMN sexo char(1);
ALTER TABLE usuario ADD CONSTRAINT sexo CHECK (sexo = 'M' OR sexo = 'F');

ALTER TABLE autor ADD COLUMN sexo char(1);
ALTER TABLE autor ADD CONSTRAINT sexo CHECK (sexo = 'M' OR sexo = 'F');

--C) Atualize os registros já existentes em cada uma das tabelas com a informação correta
--para o campo sexo, isto é, informe os autores e usuários do sexo masculino e feminino.
--Respostas:

SELECT * FROM usuario
SELECT * FROM autor
ORDER by ID;

UPDATE autor SET sexo = 'M'
UPDATE autor
SET sexo = 'F'
WHERE id IN (11, 9, 10);

UPDATE usuario SET sexo = 'F'
UPDATE usuario
SET sexo = 'M'
WHERE id IN (1, 2, 9, 10);

-- Questão 9
-- a) Mostre a quantidade de livros por autor.
SELECT autor.nome, count(livro.id) AS qtd_livros
FROM livro
inner join autor
on autor.id = livro.fkautor
GROUP by fkautor, autor.nome
ORDER BY qtd_livros DESC;

-- b) Mostre a quantidade de livros por gênero literário.
SELECT genero, COUNT(id) AS qtd_livros
FROM livro
GROUP BY genero
ORDER BY qtd_livros DESC;

-- c) Mostre a quantidade de autores por nacionalidade.
SELECT nacionalidade, COUNT(id) AS qtd_autores
FROM autor
GROUP BY nacionalidade
ORDER by qtd_autores DESC;

-- d) Mostre a quantidade de autores por sexo.
-- Inserindo campo --SEXO-- e atualizando 
-- os dados no campo
alter TABLE autor
ADD column sexo CHAR(1);
----------------------------------------------
UPDATE autor SET sexo = 'M' ;
UPDATE autor SET sexo = 'F' WHERE id = 11
or id = 9
or id = 10;
----------------------------------------------
SELECT sexo, count(id) as qtd_autores from autor
GROUP by sexo
ORDER by qtd_autores asc;

-- e) Liste apenas os livros best-sellers.
SELECT * FROM livro
WHERE bestseller = TRUE
ORDER BY exemplares desc;

-- f) Exiba todos os livros escritos por José de Alencar.
select * from livro
WHERE fkautor = 
	(select id from autor WHERE nome = 'José de Alencar');
    
-- g) Exiba todos os livros da série “O tempo e o vento”.
SELECT * from livro
WHERE titulo LIKE '%O tempo e o vento%';

-- h) Liste todos os usuários cujo nome termine em “Silva”.
SELECT * from usuario
WHERE nome LIKE '%Silva';

-- i) Liste todos os usuários cujo nome comece com “Maria”.
select * from usuario
WHERE nome LIKE 'Maria%';

-- j) Liste todos os usuários cujo nome termine em “eira”.
SELECT * FROM usuario WHERE nome LIKE '%eira';

-- k) Liste todos os usuários cujo nome possua a sequencia de caracteres “ana”, seja no início, no meio ou no final.
SELECT * FROM usuario WHERE nome ~* 'ana';

-- l) Liste apenas os livros do gênero literário predominante.

SELECT * FROM livro
WHERE genero = 
(SELECT genero 
 FROM livro         
 GROUP BY genero 
 ORDER BY COUNT(*) 
 DESC LIMIT 1)

-- m) Calcule o total de exemplares existentes nesta biblioteca.
    SELECT SUM(exemplares) as totalexemplares FROM livro;
    
-- n) Mostre o total de exemplares disponíveis por livro – exiba apenas o título da obra e a
-- quantidade. O result set deve estar em ordem alfabética.
SELECT titulo, exemplares FROM livro
ORDER BY titulo asc;

-- o) Mostre o total de usuários adultos (maiores de 18 anos) e adolescentes (entre 12 e 16
-- anos) cadastrados no sistema.
SELECT
  (SELECT COUNT(*) FROM usuario WHERE EXTRACT(YEAR FROM age(datanasc)) >= 18) AS adultos,
  (SELECT COUNT(*) FROM usuario WHERE EXTRACT(YEAR FROM age(datanasc)) BETWEEN 12 AND 16) AS adolescentes
FROM usuario
LIMIT 1;

-- p) Mostre quantos livros foram publicados no século passado e quantos foram publicados
-- neste século.
SELECT
titulo, 
CASE
	WHEN anopubli < 2001 THEN 'Século XX'
		ELSE 'Século XXI'
END AS século FROM livro;

-- q) Quais usuários ainda não realizaram nenhum empréstimo?
SELECT * from usuario
WHERE id not in ((SELECT fkusuario from emprestimo));

-- r) Qual usuário realizou mais empréstimos?
SELECT usuario.nome, fkusuario, count(emprestimo.id) AS qtd_emprestimo
from emprestimo
inner join usuario
on emprestimo.fkusuario = usuario.id
group by fkusuario, usuario.nome
order by qtd_emprestimo DESC
limit 1;

-- s) Quantos usuários atrasaram a devolução? 
SELECT * from emprestimo
WHERE multa > 0;

-- t) Dos autores brasileiros, quantos são mulheres e quantos são homens? 
SELECT sexo, count(*) AS qtd_autores from autor
WHERE nacionalidade LIKE 'Brasil%'
GROUP BY sexo;

-- u) Qual a editora com menos livros publicados? 
SELECT nome FROM editora
WHERE id = (SELECT fkeditora FROM (SELECT fkeditora, COUNT(*) AS qtd_livros_publicados FROM livro GROUP BY fkeditora) AS subconsulta
ORDER BY qtd_livros_publicados LIMIT 1);

-- v) Liste apenas os livros da editora com mais livros publicados.

-- Mostrar a editora com maior numero de publicações
SELECT  editora.nome, COUNT(livro.fkeditora) as qtdpublicacoes
FROM editora
JOIN livro ON editora.id = livro.fkeditora
GROUP BY editora.nome
ORDER BY COUNT(livro.fkeditora) DESC;

SELECT nome, id FROM editora
WHERE id = (SELECT fkeditora FROM (SELECT fkeditora, COUNT(*) AS qtd_livros_publicados FROM livro GROUP BY fkeditora) AS subconsulta
ORDER BY qtd_livros_publicados DESC LIMIT 1);

-- Mostrar somente os livros da editora com maior quantidade de publicações
SELECT * FROM livro
WHERE fkeditora = 4;

-- w) Qual a média de livros escritos por autores do sexo masculino?
SELECT AVG(qtd_livros)::INTEGER AS livroautormasculino
FROM (
  SELECT count(*) AS qtd_livros
  FROM livro
  INNER JOIN autor ON livro.fkautor = autor.id
  WHERE autor.sexo = 'M'
  GROUP BY autor.id
) AS livros_por_autor;

-- VERIFICADOR
SELECT * FROM livro
FULL JOIN autor
on livro.fkautor = autor.ID;

-- x) Qual a média de livros escritos por autores do sexo feminino?
SELECT AVG(qtd_livros)::INTEGER AS livroautorfeminino
FROM (
  SELECT count(*) AS qtd_livros
  FROM livro
  INNER JOIN autor ON livro.fkautor = autor.id
  WHERE autor.sexo = 'F'
  GROUP BY autor.id
) AS livros_por_autor;

-- VERIFICADOR
SELECT * FROM livro
FULL JOIN autor
on livro.fkautor = autor.ID;

-- y) Dos livros emprestados, quantos são de autores brasileiros?
SELECT COUNT(*) 
FROM emprestimo
INNER JOIN livro ON emprestimo.fklivro = livro.id
INNER JOIN autor ON livro.fkautor = autor.id
WHERE autor.nacionalidade ~* 'Brasileiro';

-- z) Dos livros emprestados, quantos são best-sellers?
SELECT COUNT(*) bestselleremprestado
FROM emprestimo
INNER JOIN livro ON emprestimo.fklivro = livro.id
WHERE livro.bestseller = TRUE;


--10) QUESTÃO BONUS 
--O que o sistema deveria fazer caso um usuário tente emprestar um livro que não possui
--exemplares disponíveis? E o que ele deveria fazer caso um usuário tente emprestar um livro que
--não é adequado para sua faixa etária? Existe algum recurso na linguagem SQL que permita
--implementar tais restrições?

-- Minha função

CREATE FUNCTION verificarexemplares() 
RETURNS TRIGGER 
LANGUAGE PLPGSQL
AS $$
BEGIN
    IF (
        SELECT exemplares 
        FROM livro
        WHERE id = NEW.fklivro
        ) = 0
        THEN
        RAISE EXCEPTION 'Não há exemplares disponíveis para este livro';
    END IF;

    IF (
        SELECT faixaetaria 
        FROM livro 
        WHERE id = NEW.fklivro
        ) > (
        SELECT EXTRACT(YEAR FROM age(datanasc)) 
        FROM usuario 
        WHERE id = NEW.fkusuario
        ) THEN
        RAISE EXCEPTION 'Este livro não é adequado para sua faixa etária';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER verificarexemplarestrigger
BEFORE INSERT ON emprestimo
FOR EACH ROW
EXECUTE FUNCTION verificarexemplares();

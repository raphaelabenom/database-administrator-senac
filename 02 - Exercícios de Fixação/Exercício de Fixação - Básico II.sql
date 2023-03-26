-- Atividade em Sala
-- 13/01/2023 - Individual

-- 1)
-- Utilize o comando ALTER para acrescentar um campo em cada tabela-entidade (livros, categorias e autores). Em seguida, utilize o comando UPDATE para preencher o campo adicionado nos registros já existentes.

-- 2)
-- Crie uma consulta para cada uma das tabelas entidade (livros, categoria e autores) que mostre no Result Set apenas o campo que você criou + outro campo da sua escolha. Em seguida ordene os registros de maneira decrescente utilizando o comando ORDER BY.

SELECT * from autores, categorias, livros, livrosautores


/* TABELA ENTIDADE (N:N) */
SELECT * from autores; 
SELECT * from categorias; 
SELECT * from livros; 

/* TABELA RELACIONAMENTO (N:N) */
SELECT * from livrosautores;



/* ******************************************* */

/* ATIVIDADE 01 */

/* TABELA livros*/
SELECT * from livros;
ALTER TABLE livros ADD isbn varchar;
alter TABLE livros DROP isbn;

ALTER TABLE livros ADD isbn varchar;

UPDATE livros SET isbn = '6693' WHERE idlivro = 1;
UPDATE livros SET isbn = '6692' WHERE idlivro = 2;
UPDATE livros SET isbn = '6691' WHERE idlivro = 3;
UPDATE livros SET isbn = '6694' WHERE idlivro = 4;
UPDATE livros SET isbn = '6695' WHERE idlivro = 5;
UPDATE livros SET isbn = '6696' WHERE idlivro = 6;

/* TABELA autores*/
SELECT * from autores;

ALTER TABLE autores ADD movimentoliterario varchar;

UPDATE autores SET movimentoliterario = 'Romantismo' WHERE idautor = 1 or idautor = 2 or idautor = 4;
UPDATE autores SET movimentoliterario = 'Ficção científica' WHERE idautor = 3 or idautor = 5 or idautor = 6;

/* TABELA categorias*/
SELECT * from categorias; 

alter TABLE categorias DROP mediadeavaliacao;
ALTER TABLE categorias ADD mediadeavaliacao float;

UPDATE categorias SET mediadeavaliacao = 4.5 WHERE idcategoria = 1 or idcategoria = 2;

UPDATE categorias SET mediadeavaliacao = 0;

DELETE FROM categorias
WHERE mediadeavaliacao > 0;


/* ATIVIDADE 02 */
/* Crie uma consulta para cada uma das tabelas entidade que mostre no result set apenas o campo que você criou mais outro campo de sua escola. Em seguida ordene os registros de maneira descrecente utilizando o coamando ORDER BY */
/* TABELA livros*/
SELECT isbn, ano from livros
ORDER BY ano DESC;
/* TABELA categorias*/
SELECT mediadeavaliacao, descricao from categorias
ORDER BY mediadeavaliacao DESC;
/* TABELA autores*/
SELECT movimentoliterario, nacionalidade from autores
ORDER BY nacionalidade DESC;


-- Crie 2 consultas SQL para cada tabela do Banco de Dados, utilizando a cláusula WHERE junto ao comando SELECT para criar:

-- 1 filtro simples

-- 1 filtro composto

/* Exercício de fixação: Criar 8 consultas SQL sendo 1 Filtros simples E 1 Filtros compostos para cada Tabela*/
 
 /* ALL TABLES */
SELECT * from autores, categorias, livros, livrosautores

SELECT * from autores /* DONE! */
SELECT * from categorias /* DONE! */
SELECT * from livros /* DONE! */
SELECT * from livrosautores /* DONE! */

/* TABLE Tabela livros */
/* Simples */
SELECT * FROM livros WHERE ano > 2010;
/* Composto */
SELECT * FROM livros WHERE editora LIKE 'L%';

/* TABLE Autores */
/* Simples */
SELECT * FROM autores WHERE idautor = 3;
/* Composto */
SELECT * FROM autores WHERE nacionalidade LIKE 'N%' AND nacionalidade LIKE '%meric%';;

/* TABLE categorias */
/* Simples */
SELECT * FROM categorias WHERE NOT descricao = 'Romance';
/* Composto */
SELECT * FROM categorias WHERE idcategoria BETWEEN 0 AND 3;

/* TABLE livrosautores */

/* Simples */
SELECT * FROM livrosautores WHERE idautor <> 3;
/* Composto */
SELECT * FROM livrosautores WHERE idautor <> 2 AND idlivro BETWEEN 1 and 4;

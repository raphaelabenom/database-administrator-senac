
-- 1) Transforme os exercícios a seguir em funções SQL.
    
-- a)     Calcular reajuste do salário
--         Até 1500 reais - 15% de reajuste
--         De 1500 a 4000 reais - 10% de reajuste
--         A partir de 4000 reais - 5% de reajuste


-- b)     Classificar atletas por categoria
--         De 5 a 9 anos - Infantil
--         De 10 a 13 anos - Infanto-Juvenil
--         De 14 a 17 anos - Adolescentes
--         De 18 a 24 anos - Jovens
--         A partir de 25 anos - Adultos


-- c) Determinar situação do aluno a partir da nota
-- Nota >= 6.0 - Aprovado
-- Nota < 6.0 - Reprovado


-- d) Determinar situação do aluno a partir da nota
-- Nota >= 7.0 - Aprovado
-- Nota entre 6.0 e 6.9 - Em recuperação
-- Nota < 6.0 - Reprovado


-- 1. Transforme os exercícios a seguir em funções SQL.
-- a) Calcular reajuste do salário até:
-- Até 1.500 reais - 15% de reajuste
-- De 1.500 a 4.000 reais - 10% de reajuste
-- A partir de 4.000 reais - 5% de reajuste
CREATE FUNCTION reajusteSalarial ( salario NUMERIC ) 
RETURNS NUMERIC LANGUAGE PLPGSQL AS $$ 


DECLARE
reajuste NUMERIC := 0;
BEGIN
	IF
		salario < 1500 THEN
			reajuste = salario * 1.15;
		ELSIF salario > 4000 THEN
			reajuste = salario * 1.10;
			ELSE reajuste = salario * 1.05 
	END IF;
		RETURN reajuste;
		
END;
	$$;

-- b) Classificar atletas por categoria:
-- De 5 a 9 anos - Infantil
-- De 10 a 13 anos - Infanto-Juvenil
-- De 14 a 17 anos - Adolescentes
-- De 18 a 24 anos - Jovens
-- A partir de 25 anos - Adultos

CREATE FUNCTION atletasclassifica(idade integer) 
RETURNS integer
AS $$

DECLARE
	categoria varchar:='';

BEGIN
	CASE
			WHEN 
				idade BETWEEN 5 AND 9
				THEN categoria = 'infantil';
			WHEN
				idade BETWEEN 10 AND 13
				THEN categoria = 'infantojuvenil';		
			WHEN
				idade BETWEEN 14 AND 17
				THEN categoria = 'adolescentes';	
			WHEN
				idade BETWEEN 18 AND 24
				THEN categoria = 'Jovens';
			WHEN
				idade > 25
				THEN categoria = 'adultos';
			ELSE categoria :='N/D';
	END CASE;
END;
$$
LANGUAGE plpgsql;

-- c) Determinar situação do aluno a partir da nota
-- Nota >= 6.0 - Aprovado
-- Nota < 6.0 - Reprovado

CREATE FUNCTION mediafinal(mediafinal NUMERIC, frequencia NUMERIC) 
RETURNS NUMERIC
AS $$
BEGIN
IF mediafinal >= 6.0 THEN
	situacao = 'Nota igual ou superior 6.0 - Aprovado';
ELSE
	situacao = 'REPROVADO - VÁ ESTUDAR';
END IF;
END;

$$ LANGUAGE plpgsql;

-- d) Determinar situação do aluno a partir da nota
-- Nota >= 7.0 - Aprovado
-- Nota entre 6.0 e 6.9 - Em recuperação
-- Nota < 6.0 - Reprovado


CREATE FUNCTION mediafinal(mediafinal NUMERIC, frequencia NUMERIC) 
RETURNS NUMERIC
AS $$

BEGIN
IF mediafinal >= 7.0 THEN
	situacao = 'Aprovado';
ELSE IF mediafinal >= 6 OR mediafinal < 7 THEN
situacao = 'Em recuperação';
ELSE
	situacao = 'REPROVADO - VÁ ESTUDAR';

END IF;
END;
$$ LANGUAGE plpgsql;
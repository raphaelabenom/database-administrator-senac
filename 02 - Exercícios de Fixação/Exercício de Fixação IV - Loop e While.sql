-- Atividade em sala 01/03/2023
-- EXERCÍCIO 1: Mostre os números de 1 a 15
-- a) usando FOR
-- b) usando WHILE
-- c) usando LOOP

-- EXERCÍCIO 2: Faça a mesma coisa que o exercício anterior, porém desta vez mostrando os números em ordem decrescente.


-- 1) Mostre os números de 1 a 15;
--a) Usando FOR

DO 
$$ 
BEGIN
	FOR contador IN 1..15 LOOP
		RAISE NOTICE '%', contador;
	END LOOP;
END; 
$$

--a) Usando WHILE

DO
$$
DECLARE
contador integer:= 0;
BEGIN	
	WHILE contador < 15 LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
	END LOOP;
END; 
$$

--a) Usando LOOP

DO
$$
DECLARE
CONT integer:= 0;
BEGIN	
	LOOP
		CONT := CONT + 1;
		EXIT WHEN CONT > 15;
		RAISE NOTICE '%', CONT;
	END LOOP;
END; 
$$


-- 2) Decremente os números de 15 a 1 ;
--a) Usando FOR

DO 
$$ 
BEGIN
	FOR contador IN REVERSE 15..1 LOOP
		RAISE NOTICE '%', contador;
	END LOOP;
END; 
$$

--a) Usando WHILE

DO
$$
DECLARE
contador integer:= 15;
BEGIN	
	WHILE contador > 0 LOOP
		RAISE NOTICE '%', contador;
		contador := contador - 1;
	END LOOP;
END; 
$$

--a) Usando LOOP

DO
$$
DECLARE
CONT integer:= 15;
BEGIN	
	LOOP
		CONT := CONT - 1;
		EXIT WHEN CONT < 0;
		RAISE NOTICE '%', CONT;
	END LOOP;
END; 
$$

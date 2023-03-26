-- Atividade em sala - 27/02/2023 e 28/02/2023
-- Crie procedures para resolver às seguintes questões:
-- 1) Mostrar os anos bissextos existentes entre 2000 e 2100.
-- 2) Mostrar os números pertencentes à sequência Fibonacci existentes entre 1 e 100.
-- 3) Mostrar os números múltiplos de 2 e 3 existentes entre 1 e 500. Em seguida, some todos estes números e mostre o resultado da soma.



--1) Mostrar os anos bissextos existentes entre 2000 e 2100. 
DO 
$$ 
BEGIN
	FOR bissexto IN 2000..2100 LOOP
		IF ((MOD(bissexto, 4)= 0) OR (MOD(bissexto, 100) != 0) AND (MOD(bissexto, 400)= 0))
				THEN RAISE NOTICE '%', bissexto;
		END IF;
	END LOOP;
END; 
$$
--2) Mostrar os números pertencentes à sequência Fibonacci existentes entre 1 e 100. 
DO 
$$ 
DECLARE
  x NUMERIC := 0;
  y NUMERIC := 1;
  prox NUMERIC := 0;
	
BEGIN
  FOR fibonacci IN 1..100 LOOP
    prox := x + y;
    IF (prox < 100) THEN 
      RAISE NOTICE '%', prox;
    END IF;
    x := y;
    y := prox;
  END LOOP;
END; 
$$
--3)Mostrar os números múltiplos de 2 e 3 existentes entre 1 e 500. Em seguida, some todos estes números e mostre o resultado da soma.
-- R1 1 maneira de responder
DO 
$$ 
BEGIN
	FOR multiplos IN 1..500 LOOP
		IF (multiplos%2 = 0) AND (multiplos%3 = 0)
				THEN RAISE NOTICE '%', multiplos;
		END IF;
	END LOOP;
END; 
$$
--R2 2 maneira de responder
DO 
$$ 
BEGIN
	FOR multiplos IN 1..500 LOOP
		IF ((MOD(multiplos, 2) = 0) AND (MOD(multiplos, 3) = 0)
				THEN RAISE NOTICE '%', multiplos;
		END IF;
	END LOOP;
END; 
$$

-- B) Some todos estes números e mostre o resultado da soma.

DO
$$
DECLARE
somar INTEGER := 0;
BEGIN
	FOR multiplos IN 1..500 LOOP
		IF (multiplos%2 = 0) AND (multiplos%3 = 0) THEN
			somar := somar + multiplos;
			RAISE NOTICE '%', multiplos;
		END IF; 
	END LOOP;
	RAISE NOTICE 'O total de Multiplos é %', somar;
END; 
$$



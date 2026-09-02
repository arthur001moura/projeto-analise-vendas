-- Expansão do schema: adiciona categoria e estoque na tabela produtos
ALTER TABLE produtos ADD COLUMN categoria VARCHAR;
ALTER TABLE produtos ADD COLUMN estoque INTEGER;
 
-- Preenchendo os dados que já existiam (ficaram NULL após o ALTER TABLE)
UPDATE produtos SET categoria = 'eletronico' WHERE id > 0;
 
UPDATE produtos SET estoque = 6  WHERE id = 1;
UPDATE produtos SET estoque = 9  WHERE id = 2;
UPDATE produtos SET estoque = 9  WHERE id = 3;
UPDATE produtos SET estoque = 34 WHERE id = 4;
UPDATE produtos SET estoque = 1  WHERE id = 5;
 

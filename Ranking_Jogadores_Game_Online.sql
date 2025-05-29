-- Criar o banco de dados com comandos SQL. 
CREATE DATABASE Jogo;

USE Jogo;

CREATE TABLE Jogadores(
id INT PRIMARY KEY,
nome VARCHAR(100)
);

CREATE TABLE Missoes(
id INT PRIMARY KEY,
nome VARCHAR(100),
descricao VARCHAR(300),
pontos INT
);

CREATE TABLE Conclusoes_Missoes(
id INT PRIMARY KEY,
jogador_id INT, FOREIGN KEY (jogador_id) REFERENCES Jogadores(id),
missoes_id INT, FOREIGN KEY (missoes_id) REFERENCES Missoes(id),
data_conclusao DATE
);

-- Inserir pelo menos 3 jogadores e 3 missões. 
INSERT INTO Jogadores (id, nome)
VALUES
(1, 'Zero'),
(2, 'Megaman'),
(3, 'Eggman');

INSERT INTO MISSOES (id, nome, descricao, pontos)
VALUES
(1, 'Lava Stage', 'Fase com lava, muito original', 90),
(2, 'Water Temple', 'Melhor que blightown', 120),
(3, 'Vlad Tepes Castle', 'Castlevania yay', 250);


-- Registrar 4 conclusões de missão (quem fez o quê e quando).
INSERT INTO Conclusoes_Missoes(id, jogador_id, missoes_id, data_conclusao)
VALUES
(1, 1, 2, '2025-05-22'),
(2, 3, 1, '2025-05-23'),
(3, 2, 3, '2025-05-24'),
(4, 2, 2, '2025-05-25');


-- Consultar o ranking dos jogadores, somando os pontos de todas as missões completadas. 
SELECT j.id, j.nome AS Jogador, SUM(m.pontos) AS Pontos FROM Conclusoes_Missoes cm
JOIN Jogadores j ON cm.jogador_id = j.id
JOIN Missoes m ON cm.missoes_id = m.id
GROUP BY j.id, j.nome
ORDER BY Pontos DESC;

--  Atualizar os pontos de uma missão (por exemplo, corrigir uma missão que dava muitos pontos). 
UPDATE Missoes SET pontos = 200 WHERE id = 3;

SELECT * FROM Missoes;

SELECT j.id, j.nome AS Jogador, SUM(m.pontos) AS Pontos FROM Conclusoes_Missoes cm
JOIN Jogadores j ON cm.jogador_id = j.id
JOIN Missoes m ON cm.missoes_id = m.id
GROUP BY j.id, j.nome
ORDER BY Pontos DESC;

-- Deletar uma missão (e as conclusões relacionadas). 

-- Neste caso, buscamos incluir "ON DELETE CASCADE" logo na definição das Foreign Keys da tabela auxiliar

-- Primeiramente, renomeamos a tabela "Conclusoes_Missoes" para "Conclusoes_Missoes_Old"
ALTER TABLE Conclusoes_Missoes RENAME TO Conclusoes_Missoes_Old;

-- Em seguida, criamos uma tabela identica com o nome original, mas inserindo "ON DELETE CASCADE" na definição das Foreign Keys.
CREATE TABLE Conclusoes_Missoes(
id INT PRIMARY KEY,
jogador_id INT, FOREIGN KEY (jogador_id) REFERENCES Jogadores(id) ON DELETE CASCADE,
missoes_id INT, FOREIGN KEY (missoes_id) REFERENCES Missoes(id) ON DELETE CASCADE,
data_conclusao DATE
);

-- Tendo as duas tabelas, inserimos os valores da tabela antiga na tabela nova, preservando os dados anteriores
INSERT INTO Conclusoes_Missoes (id, jogador_id, missoes_id, data_conclusao)
SELECT id, jogador_id, missoes_id, data_conclusao FROM Conclusoes_Missoes_Old;

-- Aqui, já não há mais necessidade de manter a tabela antiga, então a deleteamos.
DROP TABLE Conclusoes_Missoes_Old;

-- Conferimos a tabela missões, que ainda não foi alterada
SELECT * FROM Missoes;

-- Fazemos a mudança que queremos: deletamos a missão de com o id = 3
DELETE FROM Missoes WHERE id = 3;

-- Verificamos que a missão foi, de fato, deletada
SELECT * FROM Missoes;

-- E verificamos a tabela auxiliar, mesclando os jogados com as missões para verificar sua pontuação.

SELECT j.id, j.nome AS Jogador, SUM(m.pontos) AS Pontos FROM Conclusoes_Missoes cm
JOIN Jogadores j ON cm.jogador_id = j.id
JOIN Missoes m ON cm.missoes_id = m.id
GROUP BY j.id, j.nome
ORDER BY Pontos DESC;








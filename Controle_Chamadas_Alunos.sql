CREATE DATABASE Controle_Chamada;
USE Controle_Chamada;
 
-- criar tabelas
 
CREATE TABLE Alunos (
  id INT PRIMARY KEY,
  nome VARCHAR(100)
);
 
CREATE TABLE Chamadas (
  id INT PRIMARY KEY,
  aluno_id INT, FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
  data_aula DATE,
  presente BOOLEAN -- TRUE = presente, FALSE = faltou
);
 
-- inserindo dados
 
INSERT INTO Alunos (id, nome) VALUES
(1, 'Ana Paula'),
(2, 'Bruno Silva'),
(3, 'Clara Mendes');
 
INSERT INTO Chamadas (id, aluno_id, data_aula, presente) VALUES
(1, 1, '2025-05-20', TRUE),   -- Ana presente
(2, 1, '2025-05-21', FALSE),  -- Ana faltou
(3, 1, '2025-05-22', TRUE),   -- Ana presente
 
(4, 2, '2025-05-20', FALSE),  -- Bruno faltou
(5, 2, '2025-05-21', FALSE),  -- Bruno faltou
(6, 2, '2025-05-22', TRUE),   -- Bruno presente
 
(7, 3, '2025-05-20', TRUE),   -- Clara presente
(8, 3, '2025-05-21', TRUE),   -- Clara presente
(9, 3, '2025-05-22', TRUE);   -- Clara presente
 
-- buscar todos os dias um aluno que faltou
 
SELECT a.nome AS Aluno, c.data_aula AS Data_Falta FROM Chamadas c
JOIN Alunos a ON c.aluno_id = a.id
WHERE a.nome = 'Bruno Silva' AND c.presente = FALSE;
 
-- atualizar chamada de faltou para presente
 
UPDATE Chamadas SET presente = TRUE WHERE aluno_id = 2 AND data_aula = '2025-05-02';
 
-- ver a lista completa
 
SELECT a.nome AS Aluno, c.data_aula, CASE WHEN c.presente
THEN 'Presente'
ELSE 'Faltou' END AS Status
FROM Chamadas c
JOIN Alunos a ON c.aluno_id = a.id
ORDER BY c.data_aula, a.nome;
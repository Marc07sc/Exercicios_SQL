CREATE DATABASE Lanches;
USE Lanches;
 
-- Criar as tabelas. 
 
CREATE TABLE Alunos (
  id INT PRIMARY KEY,
  nome VARCHAR(100)
);
 
CREATE TABLE Itens (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  preco FLOAT,
  categoria VARCHAR(100)
);
 
CREATE TABLE Vendas (
  id INT PRIMARY KEY,
  aluno_id INT, FOREIGN KEY (aluno_id) REFERENCES Alunos(id) ON DELETE CASCADE,
  item_id INT, FOREIGN KEY (item_id) REFERENCES Itens(id) ON DELETE CASCADE,
  quantidade INT,
  data_venda DATE
);
 
-- Inserir alguns produtos, alunos e vendas. 
 
INSERT INTO Alunos (id, nome)
VALUES
(1, 'Rafael'),
(2, 'Michelangelo'),
(3, 'Donatello');
 
INSERT INTO Itens (id, nome, preco, categoria)
VALUES
(1, 'Pizza', 18.00, 'Salgado'),
(2, 'Refrigerante', 6.99, 'Bebida'),
(3, 'Salsicha', 8.00, 'Salgado'),
(4, 'Suco de Fruta', 5.25, 'Bebida');
 
INSERT INTO Vendas (id, aluno_id, item_id, quantidade, data_venda)
VALUES
(1, 1, 1, 2, '2025-05-20'),
(2, 1, 2, 1, '2025-05-20'),
(3, 2, 3, 2, '2025-05-21'), 
(4, 2, 4, 1, '2025-05-21'); 
 
-- Consultar quanto cada aluno gastou no total.

SELECT a.nome AS Aluno, SUM(v.quantidade * i.preco) AS Total_Gasto FROM Alunos a
JOIN Vendas v ON a.id = v.aluno_id
JOIN Itens i ON v.item_id = i.id
GROUP BY a.nome
ORDER BY Total_Gasto DESC;
 
-- Atualizar o preço de um item.
UPDATE Itens SET preco = 5.00 WHERE id = 1;
 
-- Deletar uma venda (e seus itens associados).
DELETE FROM Vendas WHERE id = 2;
 
-- Consulta
SELECT * FROM Alunos;
SELECT * FROM Itens;
SELECT * FROM Vendas;

SELECT a.nome AS Aluno, SUM(v.quantidade * i.preco) AS Total_Gasto FROM Alunos a
JOIN Vendas v ON a.id = v.aluno_id
JOIN Itens i ON v.item_id = i.id
GROUP BY a.nome
ORDER BY Total_Gasto DESC;
 
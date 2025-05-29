CREATE DATABASE Plataforma_Cursos;
USE Plataforma_Cursos;
 
-- Criar as tabelas.
 
CREATE TABLE Professores (
  id INT PRIMARY KEY,
  nome VARCHAR(100)
);
 
CREATE TABLE Alunos (
  id INT PRIMARY KEY,
  nome VARCHAR(100)
);
 
CREATE TABLE Cursos (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  carga_horaria INT,
  professor_id INT, FOREIGN KEY (professor_id) REFERENCES Professores(id) ON DELETE CASCADE
);
 
CREATE TABLE Inscricoes (
  id INT PRIMARY KEY,
  aluno_id INT, FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
  curso_id INT, FOREIGN KEY (curso_id) REFERENCES Cursos(id)  
);
 
-- Inserir dados
 
INSERT INTO Professores (id, nome) VALUES
(1, 'Profa. Mariana'),
(2, 'Prof. Eduardo');
 
INSERT INTO Alunos (id, nome) VALUES
(1, 'Ana Clara'),
(2, 'João Pedro'),
(3, 'Lucas Lima');
 
INSERT INTO Cursos (id, nome, carga_horaria, professor_id) VALUES
(1, 'Programação em Python', 40, 1),
(2, 'Design Gráfico', 30, 2);
 
INSERT INTO Inscricoes (id, aluno_id, curso_id) VALUES
(1, 1, 1), -- Ana Clara em Python
(2, 1, 2), -- Ana Clara em Design
(3, 2, 1), -- João Pedro em Python
(4, 3, 2); -- Lucas Lima em Design
 
-- consulta 1 aluno específico por ID
 
SELECT a.nome AS Aluno, c.nome AS Curso, c.carga_horaria, p.nome AS Professor FROM Inscricoes i
JOIN Alunos a ON i.aluno_id = a.id
JOIN Cursos c ON i.curso_id = c.id
JOIN Professores p ON c.professor_id = p.id
WHERE a.nome = 'Ana Clara';
 
-- alunos de um curso específico
SELECT c.nome AS Curso, a.nome AS Aluno FROM Inscricoes i
JOIN Alunos a ON i.aluno_id = a.id
JOIN Cursos c ON i.curso_id = c.id
WHERE c.nome = 'Programação em Python';
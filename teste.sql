DROP TABLE Aluno;
DROP TABLE Monitoria;

CREATE TABLE Aluno(
	id_aluno INT AUTO_INCREMENT,
    nome VARCHAR(50),
    curso VARCHAR(50),
    semestre INT,
    PRIMARY KEY (id_aluno));
    
INSERT INTO Aluno (nome, curso, semestre)
VALUES ('João', 'Sistemas da Informação', 5),
	   ('Maria', 'Administração', 3);
       
SELECT * FROM Aluno;

CREATE TABLE Monitoria (
	id_disciplina INT,
    id_aluno INT,
    orientador VARCHAR(50),
    PRIMARY KEY (id_disciplina, id_aluno),
    FOREIGN KEY (id_aluno) REFERENCES Aluno (id_aluno)
		ON DELETE CASCADE
        ON UPDATE CASCADE);
    
INSERT INTO Monitoria (id_disciplina, id_aluno, orientador)
VALUES (1, 1, 'Hugo');

INSERT INTO Monitoria (id_disciplina, id_aluno, orientador)
VALUES (1, 2, 'Hugo');

SELECT * FROM Monitoria;

DELETE FROM Aluno
WHERE Aluno.id_aluno = 1;

UPDATE Aluno
SET id_aluno = 99 
WHERE id_aluno = 2
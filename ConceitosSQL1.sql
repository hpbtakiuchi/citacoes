DROP TABLE alunos;
SELECT * FROM alunos;

#=================
#=== DEFAULT =====
#=================
CREATE TABLE Alunos (
	#O nome terá valor Placeholder caso não seja
    #Declarado um valor para este campo
	Nome VARCHAR(50) DEFAULT 'Placeholder',
    CPF char(11),
    PRIMARY KEY (CPF)
);

#Inserção apenas do CPF, "esquecendo" de colocar o nome
INSERT INTO Alunos (CPF)
VALUES ('12312312323');

DROP TABLE alunos;
SELECT * FROM alunos;

#====================
#=== CHECK ==========
#====================
CREATE TABLE Alunos (
	#O nome terá valor Placeholder caso não seja
    #Declarado um valor para este campo
	Nome VARCHAR(50) DEFAULT 'Placeholder',
    CPF char(11),
    idade INT CHECK (idade >= 15 AND idade <= 18),
    PRIMARY KEY (CPF)
);

#Inserção uma tupla com idade correta
INSERT INTO Alunos (nome, CPF, idade)
VALUES ('Joao', '12312312323', 16);

#Inserção uma tupla com idade incorreta
INSERT INTO Alunos (nome, CPF, idade)
VALUES ('Maria', '14442312323', 30);

DROP TABLE alunos;
SELECT * FROM alunos;

#====================
#=== UNIQUE =========
#====================
CREATE TABLE Alunos (
	id_aluno INT AUTO_INCREMENT, #surrogate key
	Nome VARCHAR(50) DEFAULT 'Placeholder',
    CPF char(11),
    idade INT CHECK (idade >= 15 AND idade <= 18),
    email VARCHAR(30) UNIQUE, #Declaração de uma chave candidata
    CONSTRAINT PK_Aluno PRIMARY KEY (CPF)
);

#inserção de uma tupla com dados corretos
INSERT INTO Alunos (nome, CPF, idade, email)
VALUES ('Maria', '14442312323', 16, "maria@email.com");

#inserção de uma tupla com o mesmo email da anterior
INSERT INTO Alunos (nome, CPF, idade, email)
VALUES ('Maria', '1445355355', 16, "maria@email.com");

DROP TABLE alunos;
SELECT * FROM alunos;

#====================
#=== CONSTRAINT =====
#====================
CREATE TABLE Alunos (
	id_aluno INT AUTO_INCREMENT,
	Nome VARCHAR(50) DEFAULT 'Placeholder',
    CPF char(11),
    idade INT CHECK (idade >= 15 AND idade <= 18),
    email VARCHAR(30) UNIQUE, #Declaração de uma chave candidata
    CONSTRAINT PK_Aluno PRIMARY KEY (id_aluno)
);

CREATE TABLE Disciplinas (
	id_disciplina INT AUTO_INCREMENT,
    nome VARCHAR(40),
    Professor VARCHAR(40),
    CONSTRAINT PK_Disciplina PRIMARY KEY(id_disciplina)
);

CREATE TABLE Monitorias (
	id_aluno INT,
	id_disciplina INT,
    carga_horaria INT,
    CONSTRAINT PK_Monitoria PRIMARY KEY(id_aluno, id_disciplina),
    CONSTRAINT FK_aluno FOREIGN KEY (id_aluno)
		REFERENCES Alunos(id_aluno)
        ON DELETE CASCADE,
	CONSTRAINT FK_Disciplina FOREIGN KEY(id_disciplina)
		REFERENCES Disciplinas(id_disciplina)
        ON UPDATE CASCADE
);

INSERT INTO Alunos (nome, CPF, idade, email)
VALUES ('Maria', '14442312323', 16, "maria@email.com"),
	   ('João', '14444412328', 17, "joao@email.com");
       
INSERT INTO Disciplinas (nome, professor)
VALUES ('Banco de Dados', "Hugo"),
	   ('Programação Orientada a Objetos', "Jeferson");
       
INSERT INTO Monitorias (id_aluno, id_disciplina, carga_horaria)
VALUES (1, 1, 4),
	   (2, 2, 8);
       
SELECT * FROM Alunos;
SELECT * FROM Disciplinas;
SELECT * FROM Monitorias;
       
#====================
#=== SELECT =========
#====================

#Mostre a combinação das tuplas das três tabelas
#Em uma única tupla
SELECT *
FROM Alunos as A, Disciplinas as D, Monitorias as M
WHERE A.id_aluno = M.id_aluno AND
	  D.id_disciplina = M.id_disciplina;

#Mostre a carga horária da disciplina de Banco de dados
#Monitorada por Maria
SELECT carga_horaria
FROM Alunos as A, Disciplinas as D, Monitorias as M
WHERE A.id_aluno = M.id_aluno AND
	  D.id_disciplina = M.id_disciplina AND
      A.nome = 'Maria' AND
      D.nome = 'Banco de Dados';
      
#Apelido para os atributos (nome do aluno e nome da disciplina)
SELECT A.nome as nome_aluno,
	   D.nome as nome_disciplina
FROM Alunos as A, Disciplinas as D, Monitorias as M
WHERE A.id_aluno = M.id_aluno AND
	  D.id_disciplina = M.id_disciplina;

#Produto Cartesiano entre duas ou mais tabelas
SELECT *
FROM Alunos, Disciplinas; #Omissão da cláusula WHERE

SELECT *
FROM Alunos, Disciplinas, Monitorias;

#DISCTINCT Pode ser usado para eliminar valores duplicados
#Na relação resultante

SELECT Alunos.nome
FROM Alunos, Disciplinas, Monitorias;

#LIKE é usado para buscar padrões de Strings
SELECT * 
FROM Alunos	
WHERE nome LIKE '_ari_';

SELECT *
FROM Alunos
WHERE email LIKE '%email%';

#Usar um caractere '/' antes de '%' ou '_'
#Caso eles apareçam no resultado

#ORDER BY pode ser usado para ordenar uma relação resultante
SELECT DISTINCT A.nome, A.cpf, D.nome
FROM Alunos as A, Disciplinas as D
ORDER BY A.nome DESC, D.nome ASC;
#Ordem na sequência da esquerda para direita
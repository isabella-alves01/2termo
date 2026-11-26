
CREATE DATABASE centro_de_treinamentos_desafio;
CREATE DATABASE centro_de_treinamentos_desafio;
USE centro_de_treinamentos_desafio ;

CREATE TABLE Instrutores (
cargo varchar(20) not null,
cpf_instrutor varchar(14) unique not null,
frequencia_trabalhados_por_semana varchar (50)not null,
telefone_instrutor vachar(15) not null,
id_instrutores int auto increment primary key PRIMARY KEY,
nome_instrutor varchar(80) not null,
carga_horaria_instrutor int not null
)

CREATE TABLE Gestão (
id_gestao int auto_increment primary key  PRIMARY KEY,
valor_mensalidade int not null,
matricula_aluno varchar(1000) not null,
nome_responsavel vachar(30) not null,
cpf_responsavel varchar (15) unique not null,
id_aluno int auto increment primary key 
)

CREATE TABLE Turmas (
horario_inicio_aula time not null,
sala varchar(20) not null,
nome_turma varchar(30) not null,
id_turma int auto_increment primary key  PRIMARY KEY,
frequencia_por_semana varchar(40) not null,
turno varchar(20) not null,
ano_conclusao int not null,
quantidade_vagas int not null,
id_instrutores int auto increment primary key,
id_cursos int auto_increment primary key ,
FOREIGN KEY(id_instrutores) REFERENCES Instrutores (id_instrutores)
)

CREATE TABLE Alunos  (
email_aluno varchar (100) not null,
id_aluno int auto increment primary key  PRIMARY KEY,
telefone_aluno varchar(15) not null,
cpf_aluno varchar(14) unique not null,
nome_aluno varchar (100) not null,
idade_aluno int not null,
ano_escolar varchar(20) not null
)

CREATE TABLE Cursos (
id_cursos int auto_increment primary key  PRIMARY KEY,
categoria_curso varchar(20) not null,
nome_curso varchar(20) not null,
carga_horaria_curso int not null,
descricao_curso varchar(500) not null,
status_cursos time not null
)

CREATE TABLE Participa (
id_aluno int auto increment primary key ,
id_turma int auto_increment primary key ,
FOREIGN KEY(id_aluno) REFERENCES Alunos  (id_aluno),
FOREIGN KEY(id_turma) REFERENCES Turmas (id_turma)
)

ALTER TABLE Gestão ADD FOREIGN KEY(id_aluno) REFERENCES Alunos  (id_aluno)
ALTER TABLE Turmas ADD FOREIGN KEY(id_cursos) REFERENCES Cursos (id_cursos)




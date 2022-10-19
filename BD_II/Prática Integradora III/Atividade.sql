create database db2_pi3;
use db2_pi3;

create table livro (idLivro int auto_increment,
                    titulo varchar(100) not null,
                    editora varchar(100) not null,
                    area varchar(100),
                    primary key(idLivro));

create table autor (idAutor int auto_increment,
					nome varchar(200) not null,
                    nacionalidade varchar(80) not null,
                    primary key(idAutor));
                    
create table livro_autor (idLivro int not null,
					  	  idAutor int not null,
                          key livro_autor_idLivro_foreign (idLivro),
                          key livro_autor_idAutor_foreign (idAutor),
                          constraint livro_autor_idLivro_foreign foreign key (idLivro) references livro(idLivro),
                          constraint livro_autor_idAutor_foreign foreign key (idAutor) references autor(idAutor),
                          primary key (idLivro, idAutor));

create table aluno (idAluno int auto_increment,
					nome varchar(100) not null,
                    sobrenome varchar(100) not null,
                    endereco varchar(200) not null,
                    carreira varchar(100) null,
                    idade int not null,
                    primary key(idAluno));
                    
create table emprestimo(idLeitor int not null,
						idLivro int not null,
                        data_emprestimo timestamp not null,
                        data_devolucao timestamp null,
                        retornou boolean default false,
						key emprestimo_idLeitor_foreign (idLeitor),
                        key emprestimo_idLivro_foreign (idLivro),
                        constraint emprestimo_idLeitor_foreign foreign key(idLeitor) references aluno(idAluno),
                        constraint emprestimo_idLivro_foreign foreign key(idLivro) references livro(idLivro));
                        
insert into autor
values 	(null, 'John Green', 'Americana'),
		(null, 'Antoine de Saint-Exupéry', 'Francesa'),
		(null, 'Aluisio Azevedo', 'Brasileira'),
		(null, 'Robert C. Martin', 'Americana'),
		(null, 'Emily Bronte', 'Britânica');
        
insert into livro
values	(null, 'A Culpa É das Estrelas', 'Intrinseca', 'Romance'),
		(null, 'O Pequeno Príncipe', 'HarperCollins', 'Literatura infantil'),
		(null, 'O Cortiço', 'Salamandra', 'Romance'),
		(null, 'Clean Code', 'Alta Books', 'Informática/Internet'),
		(null, 'O Morro dos Ventos Uivantes', 'Lafonte', 'Romance');
        
insert into livro_autor
values 	(1, 1),
		(2, 2),
        (3, 3),
        (4, 4),
        (5 ,5);
        
insert into aluno
values	(null, 'Maria', 'Silva', 'Rua A', 'Informática', 17),
		(null, 'José', 'Gomes', 'Rua B', 'Professor', 34),
        (null, 'Heitor', 'Rocha', 'Rua C', 'Informática', 14),
        (null, 'Laura', 'Santos', 'Rua D', 'Médica', 41),
        (null, 'Denise', 'Lima', 'Rua E', null, 28);        

insert into emprestimo
values	(3, 1, '2022-07-01', '2022-08-01', true),
		(5, 2, '2021-10-01', '2021-11-01', false),
		(1, 3, '2021-05-13', '2021-06-13', false),
		(2, 4, '2022-09-15', '2022-10-15', true),
		(4, 5, '2021-04-10', '2021-05-10', true);

-- 1. Listar os dados dos autores.
select * 
from autor;

-- 2. Listar nome e idade dos alunos
select concat(nome, ' ', sobrenome) nome, idade 
from aluno;

-- 3. Quais alunos pertencem à carreira de informática?
select * 
from aluno where carreira = 'Informática';

-- 4. Quais autores são de nacionalidade francesa ou italiana?
select * 
from autor where nacionalidade in ('Francesa','Italiana');

-- 5. Que livros não são da área da internet?
select * 
from livro 
where area not like '%Internet%';

-- 6. Listar os livros da editora Salamandra.
select * 
from livro where editora = 'Salamandra';

-- 7. Listar os dados dos alunos cuja idade é maior que a média.
select concat(nome, ' ', sobrenome) nome, idade
from aluno  
where idade > (select avg(idade) from aluno);

-- 8. Listar os nomes dos alunos cujo sobrenome começa com a letra G.
select nome, sobrenome
from aluno
where sobrenome like 'G%';

-- 9. Listar os autores do livro "O Universo: Guia de Viagem". (Apenas nomes devem ser listados.)
select autor.nome 
from livro_autor inner join livro on livro.idLivro = livro_autor.idLivro
				 inner join autor on autor.idAutor = livro_autor.idAutor
where livro.titulo = 'O Universo: Guia de Viagem';

-- 10. Listar autores que tenham nacionalidade italiana ou argentina.
select *
from autor
where nacionalidade in ('Italiana', 'Argentina');

-- 11. Que livros foram emprestados ao leitor “Filippo Galli”?
select *
from emprestimo inner join aluno on aluno.idAluno = emprestimo.idLeitor
				inner join livro on livro.idLivro = emprestimo.idLivro
where concat(aluno.nome, ' ', aluno.sobrenome) = 'Filippo Galli';

-- 12. Listar o nome do aluno mais novo.
select nome, idade
from aluno
order by idade
limit 1;

-- 13. Listar os nomes dos alunos a quem os livros de Banco de Dados foram emprestados.
select aluno.nome 
from emprestimo inner join aluno on aluno.idAluno = emprestimo.idLeitor
				inner join livro on livro.idLivro = emprestimo.idLivro
where livro.area = 'Banco de Dados';

-- 14. Listar os livros que pertencem ao autor J.K. Rowling.
select * 
from livro inner join livro_autor on livro_autor.idLivro = livro.idLivro
		   inner join autor on autor.idAutor = livro_autor.idAutor
where autor.nome = 'J.K. Rowling';

-- 15. Listar os títulos dos livros que deveriam ser devolvidos até 16/07/2021.
select *
from emprestimo inner join livro on livro.idLivro = emprestimo.idLivro
where emprestimo.data_devolucao < '2021-07-16' and retornou = false;
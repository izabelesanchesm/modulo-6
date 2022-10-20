-- Tendo o banco de dados movies_db.sql, faça:
use movies_db;

/* 1. Adicione um filme à tabela de filmes.*/
insert into movies
values(null, null, null, 'Kung Fu Panda', 9.5, 1, '2008-07-04', 132, 10);

/* 2. Adicione um gênero à tabela de gêneros.*/
insert into genres
values(null, now(), null, 'Romantic Comedy', 14, 1);

/* 3. Associe o filme do ponto 1. com o gênero criado no ponto 2.*/
SELECT @id_movie := id FROM movies WHERE title = 'Kung Fu Panda';
update movies
set genre_id = (select id from genres where name = 'Romantic Comedy')
where id = @id_movie; 

/* 4. Modifique a tabela de atores para que pelo menos um ator tenha o filme adicionado no ponto 1 como favorito.*/
update actors
set favorite_movie_id = @id_movie
where id = 7;

/* 5. Crie uma tabela temporária da tabela filmes.*/
create temporary table movies_temp
select * 
from movies;

select * from movies_temp;

/* 6. Elimine dessa tabela temporária todos os filmes que ganharam menos de 5 prêmios.*/
delete 
from movies_temp where id in (select id from movies where awards < 5);

/* 7. Obtenha a lista de todos os gêneros que possuem pelo menos um filme.*/
select *
from genres
where exists (select 1 from movies where movies.genre_id = genres.id);

/* 8. Obtenha a lista de atores cujo filme favorito ganhou mais de 3 prêmios.*/
select first_name, last_name, movies.awards
from actors inner join movies
			on movies.id = actors.favorite_movie_id
where movies.awards > 3;

/* 9. Crie um índice no nome na tabela de filmes.*/
create index index_nome
on movies(title);

/* 10. Verifique se o índice foi criado corretamente.*/
show index from movies;

/* 11. No banco de dados movies, haveria uma melhoria notável na criação de índices? Analise e justifique a resposta.*/
-- Pensando em um cenário com muitos filmes cadastrados o índice irá resultar em uma melhoria, já que
-- também não é uma tabela que terá muita exclusão de dados, assim não irá ter incovenientes quanto a performance em 
-- incluir/deletar dados.

/* 12. Em que outra tabela você criaria um índice e por quê? Justifique a resposta*/
-- A de series, pensando que assim como a tabela de movies, pode ter muitos dados, e que também serão dados que não serão
-- frequentemente deletados, então seria uma boa alternativa a criação de índice.
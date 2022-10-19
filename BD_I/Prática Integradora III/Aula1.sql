use movies_db;

-- Mostrar todos os registros da tabela de filmes
select * from movies;

-- Mostrar o nome, sobrenome e classificação de todos os atores
select first_name, last_name, rating 
from actors;

-- Mostrar o título de todas as séries e usar alias para que tanto o nome da tabela 
-- quanto o campo estejam em português
select title 'Título' 
from series serie;

-- Mostrar nome e sobrenome dos atores cuja classificação é superior a 7,5
select first_name, last_name, rating
from actors
where rating > 7.5;

-- Mostrar o título dos filmes, a classificação e os prêmios dos filmes com classificação
-- superior a 7,5 e com mais de dois prêmios
select title, rating, awards
from movies
where rating > 7.5
and awards > 2;

-- Mostrar o título dos filmes e a classificação ordenados por classificação em ordem crescente
select title, rating
from movies
order by rating asc;

-- Mostrar os títulos dos três primeiros filmes no banco de dados
select title
from movies
limit 3;

-- Mostrar os títulos dos três primeiros filmes com maior rating
-- upper ou lower
select upper(title)
from movies
order by rating desc
limit 3;

-- Títulos de filmes que contenham Toy Story
select title, rating
from movies
where title like '%toy story%';

-- Mostrar todos os atores cujos nomes começam com Sam
select * 
from actors
where first_name like 'Sam%';

-- Mostrar o título dos filmes que saíram entre 2004 e 2008
select title
from movies
where year(release_date) between 2004 and 2008;

-- Mostrar título dos filmes com classificação superior a 3, com mais de 1 prêmio e
-- com data de lançamento entre 1988 e 2009. Ordenar por classificação
select title, rating, awards, release_date
from movies
where rating > 3
and awards > 1
and year(release_date) between 1988 and 2009
order by rating;

-- insere um novo registro no bd na tabela de actors
insert into actors values(null, null, null, 'Daniel', 'Santos', 8.5, 1);
insert into actors values(null, null, null, 'Carlos', 'Silva', 8.5, 1);

-- atualiza o ator 51 para o nome Mauri
update actors set first_name = 'Mauri' where id = 51;
select * from actors where id = 51;

-- apaga o registro de id 51
delete from actors where id = 51;

-- quantas series tem cadastradas
select count(1) quantidade
from series;

-- qual a média de notas dos atores
select round(avg(rating),2) media from actors;

-- qual a quantidade de episódios que cada ator atuou
select actor_id, count(episode_id) quantidade_episodio 
from actor_episode 
group by actor_id;

-- atores que atuaram em pelo menos 10 episódios
select actor_id, count(episode_id) quantidade_episodio 
from actor_episode 
group by actor_id
having quantidade_episodio >= 10;
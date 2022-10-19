create database empresa_internet;
use empresa_internet;

create table clientes(id int auto_increment unique,
					  nome varchar(50) not null,
                      sobrenome varchar(80) not null,
                      data_nasc datetime not null,
                      cidade varchar(80) not null,
                      estado char(2) not null,
                      primary key(id)
                      )engine=InnoDB default charset=utf8 collate=utf8_unicode_ci;
                      
create table planos(id int auto_increment unique,
					velocidade int not null,
                    preco numeric(6,2) not null,
                    desconto double null,
                    id_cliente int not null,
                    primary key(id),
                    key planos_id_cliente_foreign (id_cliente),
                    constraint planos_id_cliente_foreign foreign key (id_cliente) references clientes(id)
                    )engine=InnoDB default charset=utf8 collate=utf8_unicode_ci;
                    
insert into clientes
values (null, 'Cliente 1', 'Sobrenome 1', '20000101', 'Piraju', 'SP'),
      (null, 'Cliente 2',  'Sobrenome 2',  '19940503', 'Piraju', 'SP'),
      (null, 'Cliente 3',  'Sobrenome 3',  '19980705', 'Piraju', 'SP'),
      (null, 'Cliente 4',  'Sobrenome 4',  '19950215', 'Piraju', 'SP'),
      (null, 'Cliente 5',  'Sobrenome 5',  '19901208', 'Piraju', 'SP'),
      (null, 'Cliente 6',  'Sobrenome 6',  '19940908', 'Piraju', 'SP'),
      (null, 'Cliente 7',  'Sobrenome 7',  '19961025', 'Piraju', 'SP'),
      (null, 'Cliente 8',  'Sobrenome 8',  '19970109', 'Piraju', 'SP'),
      (null, 'Cliente 9',  'Sobrenome 9',  '19991115', 'Piraju', 'SP'),
      (null, 'Cliente 10', 'Sobrenome 10', '19960912', 'Piraju', 'SP');

select * from clientes;

insert into planos
values (null, 500, 150.00, 15, 1),
	   (null ,250, 80.00 , 15, 5),
	   (null, 500, 150.00, 15, 6),
	   (null, 500, 150.00, 15, 8),
	   (null, 250, 150.00, 15, 10);
       
select * from planos;

-- Consultas

-- 1- Todos os clientes
select * from clientes;

-- 2- Todos os planos
select * from planos;

-- 3- Todos planos e seus clientes:
select c.nome, p.velocidade, p.preco
from planos p inner join clientes c
on c.id = p.id_cliente;

-- 4- Valor com desconto
select c.nome, p.preco, p.desconto, p.preco - (p.preco * (p.desconto/100)) 'Valor com desconto'
from planos p inner join clientes c
on c.id = p.id_cliente;    

-- 5- Todos clientes acima de 24 anos
select * from clientes where timestampdiff(year, clientes.data_nasc, now()) > 24; 

-- 6- Clientes nascidos entre 1999 e 2000
select * from clientes where year(data_nasc) between 1999 and 2000;

-- 7- Planos com velocidade superior a 200
select * from planos where velocidade > 200;

-- 8- Clientes sem plano
select * from clientes left join planos 
on planos.id_cliente = clientes.id
where planos.id is null;

-- 9- Plano com preço acima de 100
select * from planos where preco > 100;

-- 10- Plano do cliente de id = 1
select * from planos where id_cliente = 1;

create database bd2_pi2;
use bd2_pi2;
	  
create table departamento(depto_nro char(7) primary key,
						  nome_depto varchar(50),
                          localizacao varchar(100));
                          
create table funcionario(cod_fuc char(6) primary key,
						 nome varchar(100),
                         sobrenome varchar(100),
                         cargo varchar(30),
                         data_alta datetime,
                         salario numeric(8,2),
                         comissao numeric(8,2),
                         depto_nro char(7),
                         key funcionario_departamento_depto_nro_foreign(depto_nro),
                         constraint funcionario_departamento_depto_nro_foreign foreign key(depto_nro) references departamento(depto_nro)
                         );
                         

insert into departamento
values
('D-000-1', 'Software', 'Los Tigres'),
('D-000-2', 'Sistemas', 'Guadalupe'),
('D-000-3', 'Contabilidade', 'La Roca'),
('D-000-4', 'Vendas', 'Plata');

insert into funcionario
values
('E-0001', 'César', 'Piñero', 'Vendedor', '2018-05-12', 80000, 15000, 'D-000-4'),
('E-0002', 'Yosep', 'Kowaleski', 'Analista', '2015-07-14', 140000, 0, 'D-000-2'),
('E-0003', 'Mariela', 'Barrios', 'Diretor', '2014-06-05', 185000, 0, 'D-000-3'),
('E-0004', 'Jonathan', 'Aguilera', 'Vendedor', '2015-06-03', 85000, 10000, 'D-000-4'),
('E-0005', 'Daniel', 'Brezezicki', 'Vendedor', '2018-03-03', 83000, 10000, 'D-000-4'),
('E-0006', 'Mito', 'Barchuk', 'Presidente', '2014-06-05', 190000, 0, 'D-000-3'),
('E-0007', 'Emilio', 'Galarza', 'Desenvolvedor', '2014-08-02', 60000, 0, 'D-000-1');

-- 1. Selecione o nome, cargo e localização dos departamentos onde os vendedores trabalham.
select nome, cargo, localizacao
from funcionario inner join departamento;

-- 2. Visualize departamentos com mais de cinco funcionários.
select funcionario.depto_nro, count(*) qtd, nome_depto
from departamento inner join funcionario on funcionario.depto_nro = departamento.depto_nro
group by funcionario.depto_nro
having qtd > 5;

-- 3. Exiba o nome, salário e nome do departamento dos funcionários que têm o mesmo cargo que 'Mito Barchuk'.
-- update funcionario set cargo = 'Presidente' where cod_fuc = 'E-0003';
select concat(f.nome, ' ', f.sobrenome), f.salario, d.nome_depto
from funcionario f inner join departamento d on d.depto_nro = f.depto_nro
where f.cargo = (select cargo from funcionario where concat(funcionario.nome, ' ', funcionario.sobrenome) = 'Mito Barchuk')
  and f.nome <> 'Mito' 
  and f.sobrenome <> 'Barchuk';

-- 4. Mostre os dados dos funcionários que trabalham no departamento de contabilidade, ordenados por nome.
select * 
from funcionario f
where f.depto_nro = (select depto_nro from departamento d where d.nome_depto = 'Contabilidade')
order by f.nome;

-- 5. Mostre o nome do funcionário que tem o menor salário.
select concat(f.nome, ' ', f.sobrenome) nome, f.salario
from funcionario f
order by f.salario
limit 1;

-- 6. Mostre os dados do funcionário que tem o maior salário no departamento 'Vendas'.
select *
from funcionario f
where depto_nro = (select depto_nro from departamento where nome_depto = 'Vendas')
order by f.salario desc
limit 1;
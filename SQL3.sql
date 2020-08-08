use master;
create database N_UNIVER;

use N_UNIVER
create table STUDENT
( [Номер зачетки] int primary key,
Фамилия nvarchar(20),
[Номер группы] int
);

use N_UNIVER
alter table STUDENT add [Дата поступления] date;

alter table STUDENT drop column [Дата поступления];

insert into STUDENT([Номер зачетки], Фамилия, [Номер группы])
values	(71181097, 'Невар', 4),
		(71181456,'Ожередова',5),
		(71182054,'Шестовец',10);

select * from STUDENT;

select Фамилия, [Номер группы] from STUDENT;

select count(*) from STUDENT;

select Фамилия from STUDENT where [Номер группы]>8;

update STUDENT set [Номер группы]=5;

delete from STUDENT where [Номер зачетки] = 71182054;

drop table STUDENT;

create table results
(ID int primary key identity(1,1),
STUDENT_NAME nvarchar(20),
OOP_EXAM int,
DB_EXAM int,
MATH_EXAM int,
KSIS_EXAM int,
ENGLISH_EXAM int,
AVER_VALUE as (OOP_EXAM+MATH_EXAM+DB_EXAM+KSIS_EXAM+ENGLISH_EXAM)/5
);

insert into results(STUDENT_NAME, OOP_EXAM, DB_EXAM, MATH_EXAM,KSIS_EXAM,ENGLISH_EXAM)
values	('Невар',6,8,9,8,9),
		('Кравцова',7,8,9,8,7),
		('Ожередова',9,6,7,8,9);

use N_UNIVER;
select * from results;

create table STUDENT
( [Номер зачетки] int primary key,
Фамилия nvarchar(20),
Имя nvarchar(20),
Отчество nvarchar(20),
[Дата рождения] date,
Пол nchar(1) default 'м' check (Пол in ('м','ж')),
[Дата поступления] date
);

insert into STUDENT([Номер зачетки],Фамилия,Имя,Отчество,[Дата рождения],Пол,[Дата поступления])
values	(71181097,'Невар', 'Юлия', 'Валерьевна', '2001-01-10','ж', '2018-09-01'),
		(70045068,'Селицкий', 'Данил','Евгеньевич', '2001-01-04','м','2018-09-01'),
		(85245632,'Ожередова','Полина','Андреевна', '2000-02-23','ж','2018-09-01');

		select * from STUDENT;

		select Фамилия, Имя, Отчество from STUDENT where [Дата рождения]<'2000-09-01' and Пол='ж';
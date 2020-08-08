use master;
create database N_UNIVER;

use N_UNIVER
create table STUDENT
( [����� �������] int primary key,
������� nvarchar(20),
[����� ������] int
);

use N_UNIVER
alter table STUDENT add [���� �����������] date;

alter table STUDENT drop column [���� �����������];

insert into STUDENT([����� �������], �������, [����� ������])
values	(71181097, '�����', 4),
		(71181456,'���������',5),
		(71182054,'��������',10);

select * from STUDENT;

select �������, [����� ������] from STUDENT;

select count(*) from STUDENT;

select ������� from STUDENT where [����� ������]>8;

update STUDENT set [����� ������]=5;

delete from STUDENT where [����� �������] = 71182054;

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
values	('�����',6,8,9,8,9),
		('��������',7,8,9,8,7),
		('���������',9,6,7,8,9);

use N_UNIVER;
select * from results;

create table STUDENT
( [����� �������] int primary key,
������� nvarchar(20),
��� nvarchar(20),
�������� nvarchar(20),
[���� ��������] date,
��� nchar(1) default '�' check (��� in ('�','�')),
[���� �����������] date
);

insert into STUDENT([����� �������],�������,���,��������,[���� ��������],���,[���� �����������])
values	(71181097,'�����', '����', '����������', '2001-01-10','�', '2018-09-01'),
		(70045068,'��������', '�����','����������', '2001-01-04','�','2018-09-01'),
		(85245632,'���������','������','���������', '2000-02-23','�','2018-09-01');

		select * from STUDENT;

		select �������, ���, �������� from STUDENT where [���� ��������]<'2000-09-01' and ���='�';
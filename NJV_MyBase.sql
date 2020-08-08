use master;
create database NJV_MyBase;

use NJV_MyBase;

create table GENRE
(	
	IDGENRE int primary key,
	GENRE nvarchar(20)
)



create table FILMS
(
	IDFILM int primary key,
	[NAME] nvarchar(50),
	[YEAR] int,
	IDGENRE  int foreign key references GENRE(IDGENRE),
	RATING real
)


create table ACTOR
(
	IDACTOR int primary key,
	[NAME] nvarchar(50)
)

create table FILM_ACTOR
(
	ID int primary key,
	IDFILM int foreign key references FILMS(IDFILM),
	IDACTOR int foreign key references ACTOR(IDACTOR)
)


insert into GENRE([IDGENRE],[GENRE])
		values (1,'���������'),
			   (2,'������'),
			   (3,'�������'),
			   (4,'��������'),
			   (5,'�����'),
			   (6,'�������'),
			   (7,'���������'),
			   (8,'����������'),
			   (9,'�����������'),
			   (10,'�������'),
			   (11,'�����'),
			   (12,'����������');


insert into ACTOR([IDACTOR],[NAME])
		values(1,'��������� �������'),
			  (2,'���� ���������'),
			  (3,'���� ��������'),
			  (4,'���� ����������'),
			  (5,'�������� �����'),
			  (6,'��� ������'),
			  (7,'������� ���������'),
			  (8,'������ �����'),
			  (9,'����� ������');


insert into FILMS([IDFILM],[NAME],[YEAR],[IDGENRE],[RATING])
		values(1,'�������� ����',2012,12,7.3),
			  (2,'�������� ���� 2',2013,12,7.5),
			  (3,'�������� ���� 3',2014,12,6.3),
			  (4,'�������� ���� 4',2015,12,6.5);

insert into FILM_ACTOR([ID],[IDFILM],[IDACTOR])
		values (1,1,1),
			   (2,1,2),
			   (3,1,3),
			   (4,2,1),
			   (5,2,4);

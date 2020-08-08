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
		values (1,'биография'),
			   (2,'биевик'),
			   (3,'военный'),
			   (4,'детектив'),
			   (5,'драма'),
			   (6,'комедия'),
			   (7,'мелодрама'),
			   (8,'мультфильм'),
			   (9,'приключения'),
			   (10,'триллер'),
			   (11,'ужасы'),
			   (12,'фантастика');


insert into ACTOR([IDACTOR],[NAME])
		values(1,'Дженнифер Лоуренс'),
			  (2,'Джош Хатчерсон'),
			  (3,'Лиам Хемсворт'),
			  (4,'Вуди Харрельсон'),
			  (5,'Элизабет Бэнкс'),
			  (6,'Уэс Бентли'),
			  (7,'Дональд Сазерленд'),
			  (8,'Стэнли Туччи'),
			  (9,'Ленни Кравиц');


insert into FILMS([IDFILM],[NAME],[YEAR],[IDGENRE],[RATING])
		values(1,'Голодные игры',2012,12,7.3),
			  (2,'Голодные игры 2',2013,12,7.5),
			  (3,'Голодные игры 3',2014,12,6.3),
			  (4,'Голодные игры 4',2015,12,6.5);

insert into FILM_ACTOR([ID],[IDFILM],[IDACTOR])
		values (1,1,1),
			   (2,1,2),
			   (3,1,3),
			   (4,2,1),
			   (5,2,4);

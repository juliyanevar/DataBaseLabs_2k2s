use NJV_MyBase

create view [Фильмы]
	as select [NAME][Название],
			  [YEAR][Год выхода]
	from FILMS


create view [Актеры](Имя)
	as select [NAME]
	from ACTOR

	create view [Фильмы 2012 года]
	as select top 10 [NAME][Название],
			  [YEAR][Год выхода]
	from FILMS where [year]=2012
		order by [name]
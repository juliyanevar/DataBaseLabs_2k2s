use NJV_MyBase

create view [������]
	as select [NAME][��������],
			  [YEAR][��� ������]
	from FILMS


create view [������](���)
	as select [NAME]
	from ACTOR

	create view [������ 2012 ����]
	as select top 10 [NAME][��������],
			  [YEAR][��� ������]
	from FILMS where [year]=2012
		order by [name]
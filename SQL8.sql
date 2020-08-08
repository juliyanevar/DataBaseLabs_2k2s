use TMPN_UNIVER;

create view [Преподаватель]
	as select TEACHER [код], 
	   TEACHER_NAME [имя преподавателя], 
	   GENDER [пол], 
	   PULPIT[код кафедры]
	from TEACHER;


create view [Количество кафедр]
	as select FACULTY.FACULTY_NAME [факультет],
			  count(PULPIT) [количество кафедр]
		from FACULTY join PULPIT
			on FACULTY.FACULTY=PULPIT.FACULTY
			group by FACULTY.FACULTY_NAME




create view [Аудитории](код,[наименование аудитории])
	as select AUDITORIUM [код],
			  AUDITORIUM_NAME [наименование аудитории]
		from AUDITORIUM
			where AUDITORIUM_TYPE like 'лк%'


create view [Лекционные аудитории](код,[наименование аудитории])
	as select AUDITORIUM,
			  AUDITORIUM_NAME
		from AUDITORIUM
			where AUDITORIUM_TYPE like 'лк%' with check option

			


create view [Дисциплины](код, [наименование дисциплины], [код кафедры])
	as select top 100 [SUBJECT],
			  SUBJECT_NAME,
			  PULPIT
	from [SUBJECT]
	order by [SUBJECT]


	alter view [Количество кафедр] with schemabinding
		as select f.FACULTY_NAME [факультет],
			  count(PULPIT) [количество кафедр]
		from dbo.FACULTY f join dbo.PULPIT p
			on f.FACULTY=p.FACULTY
			group by f.FACULTY_NAME 
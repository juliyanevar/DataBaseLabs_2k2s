use TMPN_UNIVER;

create view [�������������]
	as select TEACHER [���], 
	   TEACHER_NAME [��� �������������], 
	   GENDER [���], 
	   PULPIT[��� �������]
	from TEACHER;


create view [���������� ������]
	as select FACULTY.FACULTY_NAME [���������],
			  count(PULPIT) [���������� ������]
		from FACULTY join PULPIT
			on FACULTY.FACULTY=PULPIT.FACULTY
			group by FACULTY.FACULTY_NAME




create view [���������](���,[������������ ���������])
	as select AUDITORIUM [���],
			  AUDITORIUM_NAME [������������ ���������]
		from AUDITORIUM
			where AUDITORIUM_TYPE like '��%'


create view [���������� ���������](���,[������������ ���������])
	as select AUDITORIUM,
			  AUDITORIUM_NAME
		from AUDITORIUM
			where AUDITORIUM_TYPE like '��%' with check option

			


create view [����������](���, [������������ ����������], [��� �������])
	as select top 100 [SUBJECT],
			  SUBJECT_NAME,
			  PULPIT
	from [SUBJECT]
	order by [SUBJECT]


	alter view [���������� ������] with schemabinding
		as select f.FACULTY_NAME [���������],
			  count(PULPIT) [���������� ������]
		from dbo.FACULTY f join dbo.PULPIT p
			on f.FACULTY=p.FACULTY
			group by f.FACULTY_NAME 
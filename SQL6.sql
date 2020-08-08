use TMPN_UNIVER;

select PULPIT.PULPIT_NAME,FACULTY.FACULTY
	from PULPIT,FACULTY
	where PULPIT.FACULTY=FACULTY.FACULTY 
	and 
	FACULTY.FACULTY in (select PROFESSION.FACULTY
				from PROFESSION
				where (PROFESSION_NAME like '%����������%') or (PROFESSION_NAME like '%����������%'))


select PULPIT.PULPIT_NAME, FACULTY.FACULTY
	from PULPIT inner join FACULTY
	on PULPIT.FACULTY=FACULTY.FACULTY
	where FACULTY.FACULTY in (select PROFESSION.FACULTY
				from PROFESSION
				where (PROFESSION_NAME like '%����������%') or (PROFESSION_NAME like '%����������%'))


select distinct PULPIT.PULPIT_NAME, FACULTY.FACULTY
	from PULPIT inner join FACULTY
	on PULPIT.FACULTY=FACULTY.FACULTY
	inner join PROFESSION 
	on  PROFESSION.FACULTY=FACULTY.FACULTY
				where (PROFESSION_NAME like '%����������%') or (PROFESSION_NAME like '%����������%')


select  AUDITORIUM_TYPE, AUDITORIUM_CAPACITY
	from AUDITORIUM a
	where AUDITORIUM=(select top(1) AUDITORIUM
							from AUDITORIUM aa
							where aa.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE)
								order by AUDITORIUM_CAPACITY desc


select FACULTY.FACULTY_NAME 
	from FACULTY
	where not exists (select * from PULPIT
								where PULPIT.FACULTY=FACULTY.FACULTY)

select top 1
	(select avg(NOTE) from PROGRESS
			where [SUBJECT] like '����')[����],
	(select avg(NOTE) from PROGRESS
			where [SUBJECT] like '��')[��],
	(select avg(NOTE) from PROGRESS
			where [SUBJECT] like '����')[����]
from PROGRESS


select AUDITORIUM_TYPE,AUDITORIUM_CAPACITY
		from AUDITORIUM
		where AUDITORIUM_CAPACITY>=all(select AUDITORIUM_CAPACITY
											from AUDITORIUM
											where AUDITORIUM_TYPE like '��')



select AUDITORIUM_TYPE,AUDITORIUM_CAPACITY
		from AUDITORIUM
		where AUDITORIUM_CAPACITY>=any(select AUDITORIUM_CAPACITY
											from AUDITORIUM
											where AUDITORIUM_TYPE like '��')








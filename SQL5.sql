use TMPN_UNIVER;

select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
		from AUDITORIUM inner join AUDITORIUM_TYPE
		on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE

select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
		from AUDITORIUM inner join AUDITORIUM_TYPE
		on AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE  and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%'

select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
		from AUDITORIUM, AUDITORIUM_TYPE
		where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE

		
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
		from AUDITORIUM, AUDITORIUM_TYPE
		where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%'

select FACULTY.FACULTY,PULPIT.PULPIT,PROFESSION.PROFESSION,[SUBJECT].[SUBJECT],STUDENT.NAME,PROGRESS.NOTE,
			case 
			when(PROGRESS.NOTE = 6) then '�����'
			when (PROGRESS.NOTE = 7) then '����'
			when (PROGRESS.NOTE = 8) then '������'
			end [������]
		from FACULTY, PULPIT, PROFESSION, [SUBJECT], PROGRESS inner join STUDENT
		on PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT and (PROGRESS.NOTE between 6 and 8)
			order by FACULTY.FACULTY, PULPIT.PULPIT,PROFESSION.PROFESSION, STUDENT.NAME


select FACULTY.FACULTY,PULPIT.PULPIT,PROFESSION.PROFESSION,[SUBJECT].[SUBJECT],STUDENT.NAME,PROGRESS.NOTE,
			case 
			when(PROGRESS.NOTE = 6) then '�����'
			when (PROGRESS.NOTE = 7) then '����'
			when (PROGRESS.NOTE = 8) then '������'
			end [������]
		from FACULTY, PULPIT, PROFESSION, SUBJECT, PROGRESS inner join STUDENT
		on PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT and (PROGRESS.NOTE between 6 and 8)
			order by 
			(case 
					when(PROGRESS.NOTE = 6) then 3
					when (PROGRESS.NOTE = 7) then 1
					when (PROGRESS.NOTE = 8) then 2
				end
			)


		select PULPIT.PULPIT_NAME,isnull(TEACHER.TEACHER_NAME, '***')[TEACHER]
				from PULPIT left outer join TEACHER
				on PULPIT.PULPIT=TEACHER.PULPIT

        select PULPIT.PULPIT_NAME,isnull(TEACHER.TEACHER_NAME, '***')[TEACHER]
				from TEACHER left outer join PULPIT
				on PULPIT.PULPIT=TEACHER.PULPIT


		select PULPIT.PULPIT_NAME,isnull(TEACHER.TEACHER_NAME, '***')[TEACHER]
				from PULPIT right outer join TEACHER
				on PULPIT.PULPIT=TEACHER.PULPIT


				use TMPN_UNIVER;


select * from STUDENT at full outer join PROGRESS aa
	on aa.IDSTUDENT=at.IDSTUDENT
	where aa.IDSTUDENT is not null
	order by aa.IDSTUDENT, at.IDSTUDENT;
			



select count(*)from STUDENT at full outer join PROGRESS aa
	on aa.IDSTUDENT=at.IDSTUDENT
	where aa.IDSTUDENT is not null;


select one.* from STUDENT one full outer join PROGRESS two
	on two.IDSTUDENT=one.IDSTUDENT
	where two.IDSTUDENT is not null
	order by two.IDSTUDENT, one.IDSTUDENT;
	

select two.* from STUDENT one full outer join PROGRESS two
	on two.IDSTUDENT=one.IDSTUDENT
	where two.IDSTUDENT is not null
	order by two.IDSTUDENT, one.IDSTUDENT;



select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
		from AUDITORIUM cross join AUDITORIUM_TYPE
		where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
		order by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
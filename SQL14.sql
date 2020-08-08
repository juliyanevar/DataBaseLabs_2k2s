use TMPN_UNIVER

--------------------------------------
--1
go

create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as begin declare @rc int =0;
set @rc=(select count(s.IDSTUDENT) from FACULTY f join GROUPS g 
									on f.FACULTY=g.FACULTY
									join STUDENT s 
									on g.IDGROUP=s.IDGROUP
									where g.FACULTY=@faculty);
return @rc;
end;


select * from FACULTY


declare @faculty int =dbo.COUNT_STUDENTS('ПиМ', null);
print 'Количество студентов='+ cast(@faculty as varchar(4));

select * from GROUPS



select distinct faculty,profession, dbo.COUNT_STUDENTS(faculty,profession )
			from groups 
			where dbo.COUNT_STUDENTS(faculty,profession )<>0--???


------------------------------------------
--2

create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as 
begin
declare @tv char(20);
declare @t varchar(300)='Дисциплины: ';
declare subj cursor local static
for select [SUBJECT] from [SUBJECT]
					where PULPIT=@p;
open subj;
fetch subj into @tv;
while @@FETCH_STATUS = 0
begin
	set @t=@t+','+rtrim(@tv);
	fetch subj into @tv;
end;
return @t;
end;


select PULPIT, dbo.FSUBJECTS(PULPIT) from PULPIT 




---------------------------------------------
--3

create function FFACPUL(@f varchar(20),@p varchar(20)) returns table
as return
select f.FACULTY, p.PULPIT 
	from FACULTY f left outer join PULPIT p 
	on f.FACULTY=p.FACULTY
	where f.FACULTY=isnull(@f, f.faculty)
	and p.PULPIT=isnull(@p, p.pulpit);



	select* from PULPIT	



select * from dbo.FFACPUL(null,null);
select * from dbo.FFACPUL('ИТ',null);
select * from dbo.FFACPUL(null,'ЛМиЛЗ');
select * from dbo.FFACPUL('ХТиТ','БФ');






-----------------------------------------------
--4

create function FCTEACHER(@p varchar(20)) returns int
as
begin
	declare @rc int = (select count(*) from teacher
						where PULPIT=isnull(@p,pulpit));
	return @rc;
end;
go

select pulpit, dbo.FCTEACHER(pulpit)[Количество преподавателей]
	from pulpit

select dbo.FCTEACHER(null)[Всего преподавателей]



----------------------------------------------------
--6	


		create function FACULTY_REPORT(@c int) returns @fr table
	                        ( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
	                                                                 [Количество студентов] int, [Количество специальностей] int )
		as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  (select count(PULPIT) from PULPIT where FACULTY = @f),
	            (select count(IDGROUP) from GROUPS where FACULTY = @f),   dbo.COUNT_STUDENTS(@f, default),
	            (select count(PROFESSION) from PROFESSION where FACULTY = @f)   ); 
	            fetch cc into @f;  
	       end;   
		   close cc;
		   deallocate cc;
                 return; 
	end;



	select * from dbo.FACULTY_REPORT(0)


	create function count_pulpit(@faculty varchar(20)) returns int
	as begin
		declare @rc int = 0;
		set @rc=(select count(pulpit)from pulpit where faculty=@faculty);
		return @rc;
	end;

	create function count_group(@faculty varchar(20)) returns int
	as begin
		declare @rc int = 0;
		set @rc=(select count(idgroup)from groups where faculty=@faculty);
		return @rc;
	end;

	create function count_profession(@faculty varchar(20)) returns int
	as begin
		declare @rc int = 0;
		set @rc=(select count(profession)from profession where faculty=@faculty);
		return @rc;
	end;

	
	create function FACULTY_REPORT1(@c int) returns @fr table
	                        ( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
	                                                                 [Количество студентов] int, [Количество специальностей] int )
		as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  dbo.count_pulpit(@f),dbo.count_group(@f),   dbo.COUNT_STUDENTS(@f, default),
	            dbo.count_profession(@f)); 
	            fetch cc into @f;  
	       end;   
		   close cc;
		   deallocate cc;
                 return; 
	end;


	select * from dbo.faculty_report1(10)
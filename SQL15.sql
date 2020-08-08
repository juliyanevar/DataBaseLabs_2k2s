use TMPN_UNIVER;

----------------------------------
--1


create table TR_AUDIT
(
	id int identity, --номер
	stmt varchar(20) check (stmt in('ins','del','upd')), --DML-оператор
	trname varchar(50), --имя триггера
	cc varchar(300) --комментарий
)

select * from teacher

create trigger tr_teacher_ins 
			on teacher after insert
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10) ,@in varchar(300);
print 'Операция вставки';
set @a1=(select TEACHER from inserted);
set @a2=(select teacher_name from inserted);
set @a3=(select gender from inserted);
set @a4=(select pulpit from inserted);
set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
insert into tr_audit(stmt,trname,cc) values('ins','tr_teacher_ins',@in);
return;

insert into teacher values ('СВРНЧК','Северинчик Никита Александрович','м','ИСиТ');

select * from TR_AUDIT

--------------------------------------------
--2

create trigger tr_teacher_del 
			on teacher after delete
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10) ,@in varchar(300);
print 'Операция удаления';
set @a1=(select teacher from deleted);
set @a2=(select teacher_name from deleted);
set @a3=(select gender from deleted);
set @a4=(select pulpit from deleted);
set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
insert into tr_audit(stmt,trname,cc) values('del','tr_teacher_del',@in);
return;

delete from teacher where teacher='СВРНЧК'

select * from TR_AUDIT


--------------------------------------
--3


create trigger tr_teacher_upd
			on teacher after update
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10),@a5 varchar(20), @a6 varchar(100), @a7 char(1),@a8 varchar(10) ,@in varchar(300);
print 'Операция обновления';
set @a1=(select TEACHER from inserted);
set @a2=(select teacher_name from inserted);
set @a3=(select gender from inserted);
set @a4=(select pulpit from inserted);
set @a5=(select teacher from deleted);
set @a6=(select teacher_name from deleted);
set @a7=(select gender from deleted);
set @a8=(select pulpit from deleted);
set @in=@a1+' '+@a2+' '+@a3+' '+@a4+' '+@a5+' '+@a6+' '+@a7+' '+@a8;
insert into tr_audit(stmt,trname,cc) values('upd','tr_teacher_upd',@in);
return;


insert into teacher values ('СВРНЧК','Северинчик Никита Александрович','м','ИСиТ');
update teacher set teacher='СВР' where teacher='СВРНЧК'

delete from teacher where teacher='СВР'
select * from TR_AUDIT
select * from teacher

---------------------------------------
--4


create trigger tr_teacher
			on teacher after insert,delete,update
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10), @in varchar(300);
declare @ins int = (select count(*) from inserted),
        @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
     set @a1=(select teacher from inserted);
	 set @a2=(select teacher_name from inserted);
	 set @a3=(select gender from inserted);
	 set @a4=(select pulpit from inserted);
	 set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
     insert into TR_AUDIT(stmt,trname,cc)  values('ins', 'tr_teacher', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
	 print 'Событие: DELETE';
	 set @a1=(select teacher from deleted);
	 set @a2=(select teacher_name from deleted);
	 set @a3=(select gender from deleted);
	 set @a4=(select pulpit from deleted);
	 set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
     insert into TR_AUDIT(stmt,trname,cc)  values('del', 'tr_teacher', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
     print 'Событие: UPDATE'; 
	 set @a1=(select teacher from inserted);
	 set @a2=(select teacher_name from inserted);
	 set @a3=(select gender from inserted);
	 set @a4=(select pulpit from inserted);
	 set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
	 set @a1=(select teacher from deleted);
	 set @a2=(select teacher_name from deleted);
	 set @a3=(select gender from deleted);
	 set @a4=(select pulpit from deleted);
	 set @in=@a1+' '+@a2+' '+@a3+' '+@a4+' '+@in;
     insert into TR_AUDIT(stmt,trname,cc)  values('upd', 'tr_teacher', @in);
end;  
return;  


insert into teacher values ('СВРНЧК','Северинчик Никита Александрович','м','ИСиТ');
update teacher set teacher='СВР' where teacher='СВРНЧК'
delete from teacher where teacher='СВР'

select * from TR_AUDIT



---------------------------------------------
--5
select * from teacher

update teacher set gender='f' where gender='м'


----------------------------------------------
--6

create trigger tr_teacher_del1
			on teacher after delete
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10) ,@in varchar(300);
print 'Операция удаления1';
set @a1=(select teacher from deleted);
set @a2=(select teacher_name from deleted);
set @a3=(select gender from deleted);
set @a4=(select pulpit from deleted);
set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
insert into tr_audit(stmt,trname,cc) values('del','tr_teacher_del1',@in);
return;


create trigger tr_teacher_del2 
			on teacher after delete
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10) ,@in varchar(300);
print 'Операция удаления2';
set @a1=(select teacher from deleted);
set @a2=(select teacher_name from deleted);
set @a3=(select gender from deleted);
set @a4=(select pulpit from deleted);
set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
insert into tr_audit(stmt,trname,cc) values('del','tr_teacher_del2',@in);
return;



create trigger tr_teacher_del3
			on teacher after delete
as declare @a1 varchar(20), @a2 varchar(100), @a3 char(1),@a4 varchar(10) ,@in varchar(300);
print 'Операция удаления3';
set @a1=(select teacher from deleted);
set @a2=(select teacher_name from deleted);
set @a3=(select gender from deleted);
set @a4=(select pulpit from deleted);
set @in=@a1+' '+@a2+' '+@a3+' '+@a4;
insert into tr_audit(stmt,trname,cc) values('del','tr_teacher_del3',@in);
return;


select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
	                                                  e.type_desc = 'DELETE' ;  


exec  SP_SETTRIGGERORDER @triggername = 'tr_teacher_del3', 
	                        @order = 'First', @stmttype = 'DELETE'

exec  SP_SETTRIGGERORDER @triggername = 'tr_teacher_del2', 
	                        @order = 'Last', @stmttype = 'DELETE'


insert into teacher values ('СВРНЧК','Северинчик Никита Александрович','м','ИСиТ');
delete from teacher where teacher='СВРНЧК'

select * from TR_AUDIT


------------------------------------------
--7
select * from AUDITORIUM
select sum(auditorium_capacity) from auditorium --590

create trigger tr_aud 
			on auditorium after insert,delete,update
as declare @c int=(select sum(auditorium_capacity) from auditorium);
if(@c>700)
begin
 raiserror('Общая вместимость аудиторий не может быть больше 700',10,1);
 rollback;
end;
return;

update AUDITORIUM set AUDITORIUM_CAPACITY=200 where AUDITORIUM='112-3'


-----------------------------------------
--8

create trigger tr_faculty 
			on faculty instead of delete
				as raiserror(N'Удаление запрещено',10,1);
return;

select * from FACULTY

delete from faculty where FACULTY='ТОВ'
select * from FACULTY


drop trigger tr_teacher_ins
drop trigger tr_teacher_del
drop trigger tr_teacher_upd
drop trigger tr_teacher
drop trigger tr_teacher_del1
drop trigger tr_teacher_del2
drop trigger tr_teacher_del3
drop trigger tr_aud
drop trigger tr_faculty


---------------------------------------------
--9

drop trigger DDL_UNIVER on database 


create  trigger DDL_UNIVER on database 
                          for DDL_DATABASE_LEVEL_EVENTS  
as   
  declare @t varchar(100) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)');
  declare @t1 varchar(100) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)');
  declare @t2 varchar(100) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(100)'); 
  if @t1 = 'AUDITORIUM' 
  begin
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'операции с таблицей AUDITORIUM запрещены', 16, 1);  
       rollback; 
   end;

   select * from AUDITORIUM


   alter table AUDITORIUM drop column AUDITORIUM_NAME

